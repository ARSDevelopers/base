#!/bin/bash

source "$(dirname "$0")/lib.sh"

NAME_KEYS="localhost"
DESTINO="../certs/dev/tls"
ARCHIVO_IPS="ips.txt"
GENERAR_P12=true

# MEJORA: dependencias explícitas
if ! command_exists mkcert; then
    echo "[ERROR] mkcert no está instalado"
    exit 1
fi

if ! command_exists openssl; then
    echo "[ERROR] openssl no está instalado"
    exit 1
fi

# Leer IPs
IPS=($(read_lines "$ARCHIVO_IPS"))

if [ ${#IPS[@]} -eq 0 ]; then
    echo "[ERROR] No hay IPs válidas"
    exit 1
fi

mkdir -p "$DESTINO"
cd "$DESTINO" || exit 1

echo "[INFO] Generando certificado para:"
printf ' - %s\n' "${IPS[@]}"

mkcert \
    -cert-file "${NAME_KEYS}-cert.pem" \
    -key-file "${NAME_KEYS}-key.pem" \
    "${IPS[@]}"

# MEJORA: salida controlada
if [ "$GENERAR_P12" = true ]; then
    echo "[INFO] Generando .p12 para Spring"

    openssl pkcs12 -export \
        -in "${NAME_KEYS}-cert.pem" \
        -inkey "${NAME_KEYS}-key.pem" \
        -out "../spring/${NAME_KEYS}.p12" \
        -name "myalias" \
        -password pass:changeit
fi

echo "[INFO] SSL generado correctamente"
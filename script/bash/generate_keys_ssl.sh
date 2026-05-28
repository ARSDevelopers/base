#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

# Conf de variables
NAME_KEYS="localhost"
DESTINO="$PROJECT_ROOT/certs/dev/tls"
ARCHIVO_IPS="$PROJECT_ROOT/script/ips.txt"
GENERAR_P12=true

# Verificamos que el archivo exista
if [ ! -f "$ARCHIVO_IPS" ]; then
    echo "[ERROR] No existe el archivo $ARCHIVO_IPS"
    exit 1
fi

# Leer ips del fichero 'ips.txt'
IPS=()

while IFS= read -r linea || [ -n "$linea" ]; do
    # Ignorar líneas vacías o comentarios
    if [[ -z "$linea" || "$linea" =~ ^# ]]; then
        continue
    fi

    IPS+=("$linea")
done < "$ARCHIVO_IPS"

# Creamos carpeta destino
mkdir -p "$PROJECT_ROOT/certs"
mkdir -p "$DESTINO" || exit 1
cd "$DESTINO" || exit 1

# Generamos certificado ssl con mkcert
echo "[INFO] - Generando certificado para:"
for ip in "${IPS[@]}"; do
    echo " - $ip"
done

echo "[INFO] - ==============="

mkcert -cert-file "${NAME_KEYS}-cert.pem" \
        -key-file "${NAME_KEYS}-key.pem" \
        "${IPS[@]}"

# Genera certificado .p12 para spring
if [ "$GENERAR_P12" = true ]; then
    echo "[INFO] - Generando archivo PKCS12 (.p12)..."

    mkdir -p "../spring"

    openssl pkcs12 -export \
        -in "${NAME_KEYS}-cert.pem" \
        -inkey "${NAME_KEYS}-key.pem" \
        -out "../spring/${NAME_KEYS}.p12" \
        -name "myalias" \
        -password pass:changeit
fi

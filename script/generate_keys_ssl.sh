#!/bin/bash

# Conf de variables
NAME_KEYS="localhost"
DESTINO="certs/dev/tls"
ARCHIVO_IPS="script/ips.txt"

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
mkdir -p "$DESTINO" || exit 1
cd "$DESTINO" || exit 1

# Generamos certificado ssl con mkcert
echo "[INFO] - Generando certificado para:"
for ip in "${IPS[@]}"; do
    echo " - $ip"
done

echo "[INFO] - ==============="

mkcert -cert-file "${NAME_KEYS}-cert.pem" \
        -key-file "${NAME_KEYS}-key.key" \
        "${IPS[@]}"
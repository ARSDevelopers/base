#!/bin/bash

# Carga utilidades
source "$(dirname "$0")/lib.sh"

ARCHIVO="repos.txt"

# Validación de dependencia
if ! command_exists git; then
    echo "[ERROR] git no está instalado"
    exit 1
fi

echo "[INFO] Iniciando clonación..."

for REPO in $(read_lines "$ARCHIVO"); do
    DIR_NAME=$(basename "$REPO" .git)

    # Idempotencia básica
    if [ -d "$DIR_NAME" ]; then
        echo "[SKIP] Ya existe $DIR_NAME"
        continue
    fi

    echo "[INFO] Clonando $REPO"
    git clone "$REPO"
done

echo "[INFO] Proceso finalizado"
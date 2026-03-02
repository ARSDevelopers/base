#!/bin/bash

ARCHIVO="script/repos.txt"

if [ ! -f "$ARCHIVO" ]; then
    echo "[ERROR] No existe el archivo $ARCHIVO"
    exit 1
fi

while IFS= read -r REPO || [ -n "$REPO" ]; do
    # Ignorar líneas vacías o comentarios
    if [[ -z "$REPO" || "$REPO" =~ ^# ]]; then
        continue
    fi

    echo "[INFO] - Clonando $REPO ..."
    git clone "$REPO"

done < "$ARCHIVO"

echo "[INFO] - Proceso finalizado."
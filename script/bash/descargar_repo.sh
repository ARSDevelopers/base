#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
ARCHIVO="$PROJECT_ROOT/script/repos.txt"

if [ ! -f "$ARCHIVO" ]; then
    echo "[ERROR] No existe el archivo $ARCHIVO"
    exit 1
fi

cd "$PROJECT_ROOT" || exit 1

while IFS= read -r REPO || [ -n "$REPO" ]; do
    # Ignorar líneas vacías o comentarios
    if [[ -z "$REPO" || "$REPO" =~ ^# ]]; then
        continue
    fi

    echo "[INFO] - Clonando $REPO ..."
    git clone "$REPO"

done < "$ARCHIVO"

echo "[INFO] - Proceso finalizado."

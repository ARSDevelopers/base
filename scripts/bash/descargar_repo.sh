#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
ARCHIVO="$PROJECT_ROOT/scripts/repos.txt"

if [ ! -f "$ARCHIVO" ]; then
    echo "[ERROR] No existe el archivo $ARCHIVO"
    exit 1
fi

mkdir -p "$PROJECT_ROOT/frontend"
mkdir -p "$PROJECT_ROOT/backend"
mkdir -p "$PROJECT_ROOT/orm"

while IFS= read -r REPO || [ -n "$REPO" ]; do
    # Ignorar líneas vacías o comentarios
    if [[ -z "$REPO" || "$REPO" =~ ^# ]]; then
        continue
    fi

    REPO_NAME=$(basename "$REPO" .git)
    
    # Determinar ruta y nombre destino
    if [ "$REPO_NAME" = "service-odoo-sembrem" ]; then
        TARGET_PATH="$PROJECT_ROOT/orm/service-odoo-sembrem"
        NAME_DESC="orm/service-odoo-sembrem"
    elif [ "$REPO_NAME" = "back-springboot-arsdev" ]; then
        TARGET_PATH="$PROJECT_ROOT/backend/back-springboot-arsdev"
        NAME_DESC="backend/back-springboot-arsdev"
    else
        TARGET_PATH="$PROJECT_ROOT/frontend/$REPO_NAME"
        NAME_DESC="frontend/$REPO_NAME"
    fi

    # Verificar si ya existe
    if [ -d "$TARGET_PATH" ]; then
        echo "[INFO] - El repositorio $REPO_NAME ya existe en $NAME_DESC. Omitiendo clone."
        continue
    fi

    echo "[INFO] - Clonando $REPO en $NAME_DESC ..."
    git clone "$REPO" "$TARGET_PATH"

done < "$ARCHIVO"

echo "[INFO] - Proceso finalizado."

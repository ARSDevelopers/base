#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

update_git_repo() {
    local repo_dir="$1"
    if [ -d "$repo_dir/.git" ]; then
        echo "----------------------------------------"
        echo "[INFO] Actualizando repositorio en: $repo_dir"
        cd "$repo_dir" || return
        git pull
    fi
}

# 1. Actualizar directorios raíz que contienen .git
for dir in "$PROJECT_ROOT"/*; do
    if [ -d "$dir" ]; then
        update_git_repo "$dir"
    fi
done

# 2. Actualizar módulos propios de Odoo que contienen .git
ODOO_PROPIOS="$PROJECT_ROOT/service-odoo-sembrem/extra-addons/activos/propios"
if [ -d "$ODOO_PROPIOS" ]; then
    for dir in "$ODOO_PROPIOS"/*; do
        if [ -d "$dir" ]; then
            update_git_repo "$dir"
        fi
    fi
fi

echo "----------------------------------------"
echo "[INFO] Proceso de actualización finalizado."

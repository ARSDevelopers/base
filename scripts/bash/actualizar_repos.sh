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

# 0. Actualizar el propio repositorio base (proyecto principal)
update_git_repo "$PROJECT_ROOT"

# 1. Actualizar repositorios en frontend
for dir in "$PROJECT_ROOT"/frontend/*; do
    if [ -d "$dir" ]; then
        update_git_repo "$dir"
    fi
done

# 2. Actualizar repositorios en backend
for dir in "$PROJECT_ROOT"/backend/*; do
    if [ -d "$dir" ]; then
        update_git_repo "$dir"
    fi
done

# 3.5. Actualizar plan de empresa en la raíz
update_git_repo "$PROJECT_ROOT/plan_de_empresa"

echo "----------------------------------------"
echo "[INFO] Proceso de actualización finalizado."

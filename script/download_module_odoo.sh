#!/bin/bash

ARCHIVO="script/repos_module_odoo.txt"
NAME_ODOO="service-odoo-sembrem"
DESTINO="${NAME_ODOO}/extra-addons/activos/propios"

# Verificar que el archivo exista
if [ ! -f "$ARCHIVO" ]; then
    echo "[ERROR] No existe el archivo $ARCHIVO"
    exit 1
fi

# Crear directorio destino si no existe
mkdir -p "$DESTINO" || exit 1

echo "[INFO] - Descargando repos en: $DESTINO"
echo "----------------------------------------"

while IFS= read -r REPO || [ -n "$REPO" ]; do
    # Ignorar líneas vacías o comentarios
    if [[ -z "$REPO" || "$REPO" =~ ^# ]]; then
        continue
    fi

    echo "[INFO] - Clonando $REPO ..."
    git clone "$REPO" "$DESTINO/$(basename "$REPO" .git)"

done < "$ARCHIVO"

echo "[INFO] - Proceso finalizado."
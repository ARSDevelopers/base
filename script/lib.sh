# Utilidades básicas reutilizables

read_lines() {
    local file="$1"

    if [ ! -f "$file" ]; then
        echo "[ERROR] No existe: $file"
        exit 1
    fi

    grep -vE '^#|^$' "$file"
}

command_exists() {
    command -v "$1" >/dev/null 2>&1
}
# Uso de script

## `descargar_repo.sh`

Script para poder descarga los repositorios de la organización
Por el momento se tiene **2** pero se espera amplicar

### Datos a tener en cuenta

Mirar el fichero `repos.txt` situado en la carpeta `script`. En ella se deberá de poner tanto repos para poder iniciar los programas

### Ejecución

```bash
# Desde 'base'
./script/descargar_repo.sh
```

## generate_keys_ssl.sh

Script para generar certificado ssl para el entorno de `nginx`

### Datos a tener en cuenta

Mirar el fichero `ips.txt` para poner las ips que se necesita el entorno de desarrollo.

Herramientas necesarias

* mkdir

### Ejecución

```bash
# Desde 'base'
./script/generate_keys_ssl.sh
```

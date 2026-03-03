# Uso de script

## Para descargar repositorios desde git repo / modulos

Script para poder descarga los repositorios de la organización
Por el momento se tiene **2** pero se espera amplicar

### Datos a tener en cuenta

Mira los ficheros que relacionado

* `repos.txt`
* `repos_moodule_odoo.txt`

### Ejecución

```bash
# Desde 'base'
## Descargar servicio / repo
./script/descargar_repo.sh
## Descargar los módulos de Odoo
./script/download_module_odoo.sh
```

## `generate_keys_ssl.sh`

Script para generar certificado ssl para el entorno de `nginx`

### Datos a tener en cuenta

Mirar el fichero `ips.txt` para poner las ips que se necesita el entorno de desarrollo.
Por defecto, esta activo el `.p12` para poder genera para Spring

Herramientas necesarias

* mkdir

### Ejecución

```bash
# Desde 'base'
./script/generate_keys_ssl.sh
```

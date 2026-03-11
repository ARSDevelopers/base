# 1. Uso de script

## 1.1. Para descargar repositorios desde git repo / modulos

Script para poder descarga los repositorios de la organización
Por el momento se tiene **2** pero se espera amplicar

### 1.1.1. Datos a tener en cuenta

Mira los ficheros relacionados

* `repos.txt`
* `repos_moodule_odoo.txt`

### 1.1.2. Ejecución

```bash
# Desde 'base'
## Descargar servicio / repo
./script/descargar_repo.shtodos los conta
## Descargar los módulos de Odoo
./script/download_module_odoo.sh
```

## 1.2. `generate_keys_ssl.sh`

Script para generar certificado ssl para el entorno de `nginx`

### 1.2.1. Datos a tener en cuenta

Mirar el fichero `ips.txt` para poner las ips que se necesita el entorno de desarrollo.
Por defecto, esta activo el `.p12` para poder genera para Spring

Herramientas necesarias

* mkdir

### 1.2.2. Ejecución

```bash
# Desde 'base'
./script/generate_keys_ssl.sh
```

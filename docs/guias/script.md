# Uso de scripts de automatización

## 1. Para descargar/actualizar repositorios y módulos

Scripts para automatizar la descarga y actualización de los repositorios y módulos del proyecto.

### 1.1. Archivos de configuración asociados

Encuentra estos archivos en la carpeta `scripts/`:

* `repos.txt`: Contiene los repositorios principales a clonar.
* `ips.txt`: Contiene las direcciones IP para las cuales se generarán los certificados SSL.

### 1.2. Ejecución

Puedes ejecutar los scripts correspondientes desde la raíz del proyecto (`Proyecto-base`):

#### En Linux / Bash:
```bash
# Descargar repositorios principales (se clonarán en backend/ y frontend/)
./scripts/bash/descargar_repo.sh

# Actualizar todos los repositorios locales a la última versión
./scripts/bash/actualizar_repos.sh
```

#### En Windows / PowerShell:
```powershell
# Descargar repositorios principales
.\scripts\powershell\descargar_repo.ps1

# Actualizar todos los repositorios locales
.\scripts\powershell\actualizar_repos.ps1
```

---

## 2. Generación de certificados SSL (`generate_keys_ssl`)

Script para generar certificados de desarrollo autofirmados con `mkcert` y exportar el almacén de claves `.p12` necesario para Spring Boot.

### 2.1. Requisitos
- Tener instalado `mkcert` y `openssl` (el script de PowerShell intentará usar el openssl de Git para Windows si no está en el PATH).

### 2.2. Ejecución

Ejecuta desde la raíz del proyecto:

#### En Linux / Bash:
```bash
./scripts/bash/generate_keys_ssl.sh
```

#### En Windows / PowerShell:
```powershell
.\scripts\powershell\generate_keys_ssl.ps1
```

Los certificados se generarán y guardarán en `config/certs/dev/tls/` y el archivo PKCS12 para Spring en `config/certs/dev/spring/`.

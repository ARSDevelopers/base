$ProjectRoot = Split-Path (Split-Path $PSScriptRoot -Parent) -Parent

# Conf de variables
$NameKeys = "localhost"
$Destino = Join-Path $ProjectRoot "certs/dev/tls"
$ArchivoIps = Join-Path $ProjectRoot "script/ips.txt"
$GenerarP12 = $true

# Verificamos que el archivo exista
if (-not (Test-Path -Path $ArchivoIps -PathType Leaf)) {
    Write-Error "[ERROR] No existe el archivo $ArchivoIps"
    Exit 1
}

# Verificar prerrequisitos
$MissingPrereqs = $false
if (-not (Get-Command "mkcert" -ErrorAction SilentlyContinue)) {
    Write-Error "[ERROR] El comando 'mkcert' no está instalado o no está en el PATH."
    Write-Host "[CONSEJO] Puedes instalarlo usando Chocolatey ('choco install mkcert') o Winget ('winget install FiloSottile.mkcert')." -ForegroundColor Yellow
    $MissingPrereqs = $true
}

if (-not (Get-Command "openssl" -ErrorAction SilentlyContinue)) {
    # Comprobar si está en la instalación de Git típica de Windows
    $GitOpenssl = "C:\Program Files\Git\usr\bin\openssl.exe"
    if (Test-Path $GitOpenssl) {
        # Agregar temporalmente al PATH para esta sesión
        $env:PATH += ";C:\Program Files\Git\usr\bin"
    }
    else {
        Write-Error "[ERROR] El comando 'openssl' no está instalado o no está en el PATH."
        Write-Host "[CONSEJO] Si tienes Git para Windows, suele estar en 'C:\Program Files\Git\usr\bin'. Puedes añadir esa ruta al PATH de tu sistema." -ForegroundColor Yellow
        $MissingPrereqs = $true
    }
}

if ($MissingPrereqs) {
    Exit 1
}

# Leer ips del fichero 'ips.txt'
$Ips = @()
Get-Content $ArchivoIps | ForEach-Object {
    $Linea = $_.Trim()
    # Ignorar líneas vacías o comentarios
    if ($Linea -and -not $Linea.StartsWith("#")) {
        $Ips += $Linea
    }
}

# Creamos carpeta destino
$CertsRoot = Join-Path $ProjectRoot "certs"
if (-not (Test-Path -Path $CertsRoot -PathType Container)) {
    New-Item -ItemType Directory -Force -Path $CertsRoot | Out-Null
}

if (-not (Test-Path -Path $Destino -PathType Container)) {
    New-Item -ItemType Directory -Force -Path $Destino | Out-Null
}

$CurrentDir = Get-Location
Set-Location $Destino

# Generamos certificado ssl con mkcert
Write-Host "[INFO] - Generando certificado para:"
foreach ($Ip in $Ips) {
    Write-Host " - $Ip"
}

Write-Host "[INFO] - ==============="

# En PowerShell, pasar arrays a comandos externos:
mkcert -cert-file "${NameKeys}-cert.pem" -key-file "${NameKeys}-key.pem" $Ips

# Genera certificado .p12 para spring
if ($GenerarP12) {
    Write-Host "[INFO] - Generando archivo PKCS12 (.p12)..."

    if (-not (Test-Path -Path "../spring" -PathType Container)) {
        New-Item -ItemType Directory -Force -Path "../spring" | Out-Null
    }

    openssl pkcs12 -export `
        -in "${NameKeys}-cert.pem" `
        -inkey "${NameKeys}-key.pem" `
        -out "../spring/${NameKeys}.p12" `
        -name "myalias" `
        -password pass:changeit
}

Set-Location $CurrentDir

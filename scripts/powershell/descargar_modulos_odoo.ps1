$ProjectRoot = Split-Path (Split-Path $PSScriptRoot -Parent) -Parent
$Archivo = Join-Path $ProjectRoot "scripts/repos_module_odoo.txt"
$Destino = Join-Path $ProjectRoot "orm/service-odoo-sembrem/extra-addons/activos/propios"

# Verificar que el archivo exista
if (-not (Test-Path -Path $Archivo -PathType Leaf)) {
    Write-Error "[ERROR] No existe el archivo $Archivo"
    Exit 1
}

# Crear directorio destino si no existe
if (-not (Test-Path -Path $Destino -PathType Container)) {
    New-Item -ItemType Directory -Force -Path $Destino | Out-Null
}

Write-Host "[INFO] - Descargando repos en: $Destino"
Write-Host "----------------------------------------"

$OriginalDir = Get-Location
Set-Location $ProjectRoot

Get-Content $Archivo | ForEach-Object {
    $Repo = $_.Trim()
    # Ignorar líneas vacías o comentarios
    if (-not $Repo -or $Repo.StartsWith("#")) {
        return
    }

    Write-Host "[INFO] - Clonando $Repo ..."
    $RepoName = [System.IO.Path]::GetFileNameWithoutExtension($Repo)
    $DestPath = Join-Path $Destino $RepoName
    git clone $Repo $DestPath
}

Set-Location $OriginalDir
Write-Host "[INFO] - Proceso finalizado."

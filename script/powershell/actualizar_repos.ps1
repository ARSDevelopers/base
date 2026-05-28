$ProjectRoot = Split-Path (Split-Path $PSScriptRoot -Parent) -Parent
$OriginalDir = Get-Location

function Update-GitRepo {
    param (
        [string]$RepoPath
    )
    $GitPath = Join-Path $RepoPath ".git"
    if (Test-Path -Path $GitPath -PathType Container) {
        Write-Host "----------------------------------------"
        Write-Host "[INFO] Actualizando repositorio en: $RepoPath" -ForegroundColor Cyan
        Set-Location $RepoPath
        git pull
    }
}

# 1. Actualizar directorios raíz que contienen .git
Get-ChildItem -Path $ProjectRoot -Directory | ForEach-Object {
    Update-GitRepo $_.FullName
}

# 2. Actualizar módulos propios de Odoo que contienen .git
$OdooPropios = Join-Path $ProjectRoot "service-odoo-sembrem/extra-addons/activos/propios"
if (Test-Path -Path $OdooPropios -PathType Container) {
    Get-ChildItem -Path $OdooPropios -Directory | ForEach-Object {
        Update-GitRepo $_.FullName
    }
}

Set-Location $OriginalDir
Write-Host "----------------------------------------"
Write-Host "[INFO] Proceso de actualización finalizado." -ForegroundColor Green

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

# 1. Actualizar repositorios en frontend que contienen .git
$FrontendDir = Join-Path $ProjectRoot "frontend"
if (Test-Path -Path $FrontendDir -PathType Container) {
    Get-ChildItem -Path $FrontendDir -Directory | ForEach-Object {
        Update-GitRepo $_.FullName
    }
}

# 2. Actualizar repositorios en backend que contienen .git
$BackendDir = Join-Path $ProjectRoot "backend"
if (Test-Path -Path $BackendDir -PathType Container) {
    Get-ChildItem -Path $BackendDir -Directory | ForEach-Object {
        Update-GitRepo $_.FullName
    }
}

# 3. Actualizar repositorios en orm que contienen .git
$OrmDir = Join-Path $ProjectRoot "orm"
if (Test-Path -Path $OrmDir -PathType Container) {
    Get-ChildItem -Path $OrmDir -Directory | ForEach-Object {
        Update-GitRepo $_.FullName
    }
}

# 4. Actualizar módulos propios de Odoo que contienen .git
$OdooPropios = Join-Path $OrmDir "service-odoo-sembrem/extra-addons/activos/propios"
if (Test-Path -Path $OdooPropios -PathType Container) {
    Get-ChildItem -Path $OdooPropios -Directory | ForEach-Object {
        Update-GitRepo $_.FullName
    }
}

Set-Location $OriginalDir
Write-Host "----------------------------------------"
Write-Host "[INFO] Proceso de actualización finalizado." -ForegroundColor Green

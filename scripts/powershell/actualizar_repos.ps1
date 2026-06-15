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

# 0. Actualizar el propio repositorio base (proyecto principal)
Update-GitRepo $ProjectRoot

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

# 3.5. Actualizar plan de empresa en la raíz
$PlanEmpresaDir = Join-Path $ProjectRoot "plan_de_empresa"
if (Test-Path -Path $PlanEmpresaDir -PathType Container) {
    Update-GitRepo $PlanEmpresaDir
}

Set-Location $OriginalDir
Write-Host "----------------------------------------"
Write-Host "[INFO] Proceso de actualización finalizado." -ForegroundColor Green

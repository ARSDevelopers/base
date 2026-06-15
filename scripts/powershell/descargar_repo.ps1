$ProjectRoot = Split-Path (Split-Path $PSScriptRoot -Parent) -Parent
$Archivo = Join-Path $ProjectRoot "scripts/repos.txt"

if (-not (Test-Path -Path $Archivo -PathType Leaf)) {
    Write-Error "[ERROR] No existe el archivo $Archivo"
    Exit 1
}

$OriginalDir = Get-Location

# Crear directorios si no existen
$FrontendDir = Join-Path $ProjectRoot "frontend"
$BackendDir = Join-Path $ProjectRoot "backend"

if (-not (Test-Path -Path $FrontendDir -PathType Container)) {
    New-Item -ItemType Directory -Force -Path $FrontendDir | Out-Null
}
if (-not (Test-Path -Path $BackendDir -PathType Container)) {
    New-Item -ItemType Directory -Force -Path $BackendDir | Out-Null
}

Get-Content $Archivo | ForEach-Object {
    $Repo = $_.Trim()
    # Ignorar líneas vacías o comentarios
    if (-not $Repo -or $Repo.StartsWith("#")) {
        return
    }

    $RepoName = [System.IO.Path]::GetFileNameWithoutExtension($Repo)
    if ($RepoName -eq "back-springboot-arsdev") {
        $TargetPath = Join-Path $BackendDir "back-springboot-arsdev"
        $NameDesc = "backend/back-springboot-arsdev"
    } elseif ($RepoName -eq "plan_de_empresa") {
        $TargetPath = Join-Path $ProjectRoot "plan_de_empresa"
        $NameDesc = "plan_de_empresa"
    } else {
        $TargetPath = Join-Path $FrontendDir $RepoName
        $NameDesc = "frontend/$RepoName"
    }

    # Verificar si ya existe
    if (Test-Path -Path $TargetPath -PathType Container) {
        Write-Host "[INFO] - El repositorio $RepoName ya existe en $NameDesc. Omitiendo clone." -ForegroundColor Yellow
        return
    }

    Write-Host "[INFO] - Clonando $Repo en $NameDesc ..." -ForegroundColor Cyan
    git clone $Repo $TargetPath
}

Set-Location $OriginalDir
Write-Host "[INFO] - Proceso finalizado."

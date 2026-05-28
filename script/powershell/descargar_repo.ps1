$ProjectRoot = Split-Path (Split-Path $PSScriptRoot -Parent) -Parent
$Archivo = Join-Path $ProjectRoot "script/repos.txt"

if (-not (Test-Path -Path $Archivo -PathType Leaf)) {
    Write-Error "[ERROR] No existe el archivo $Archivo"
    Exit 1
}

$OriginalDir = Get-Location
Set-Location $ProjectRoot

Get-Content $Archivo | ForEach-Object {
    $Repo = $_.Trim()
    # Ignorar líneas vacías o comentarios
    if (-not $Repo -or $Repo.StartsWith("#")) {
        return
    }

    Write-Host "[INFO] - Clonando $Repo ..."
    git clone $Repo
}

Set-Location $OriginalDir
Write-Host "[INFO] - Proceso finalizado."

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$MediaRoot = "D:\Media"
$TorrentRoot = "D:\Torrents"

Write-Host "Validating system..."

if (-not (Get-Command docker -ErrorAction SilentlyContinue)) {
    throw "Docker not found"
}

if (-not (Get-Command java -ErrorAction SilentlyContinue)) {
    throw "Java not found"
}

$FileBot = "$env:USERPROFILE\Tools\FileBot\FileBot.jar"
if (-not (Test-Path $FileBot)) {
    throw "FileBot.jar missing"
}

$paths = @(
    "$MediaRoot\Movies",
    "$MediaRoot\TV",
    "$MediaRoot\Anime",
    "$TorrentRoot\Active",
    "$TorrentRoot\Completed"
)

foreach ($p in $paths) {
    New-Item -ItemType Directory -Force -Path $p | Out-Null
}

Write-Host "Install validation complete"

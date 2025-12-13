param (
    [Parameter(Mandatory)]
    [string]$TorrentPath
)

Start-Sleep -Seconds 15

if (-not (Test-Path $TorrentPath)) {
    exit 1
}

& "$PSScriptRoot\filebot.ps1" -InputPath $TorrentPath

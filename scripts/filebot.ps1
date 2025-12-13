param (
    [Parameter(Mandatory)]
    [string]$InputPath
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$FileBot = "$env:USERPROFILE\Tools\FileBot\FileBot.jar"
$MediaRoot = "D:\Media"
$LogFile = "$PSScriptRoot\filebot.log"

if (-not (Test-Path $InputPath)) {
    throw "Input path not found"
}

java -jar $FileBot `
    -script fn:amc `
    -non-strict `
    --output $MediaRoot `
    --action copy `
    --conflict override `
    --log-file $LogFile `
    --def `
        movieFormat='{n} ({y})/{n} ({y})' `
        seriesFormat='{n}/Season {s}/{n} - S{s.pad(2)}E{e.pad(2)} - {t}' `
        animeFormat='{n}/Season {s}/{n} - {absolute.pad(3)} - {t}' `
        clean=y `
        unsorted=y `
    -- $InputPath

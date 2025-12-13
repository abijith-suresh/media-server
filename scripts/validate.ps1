Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$FileBot = "$env:USERPROFILE\Tools\FileBot\FileBot.jar"

Write-Host "Java version:"
java -version

Write-Host "FileBot version:"
java -jar $FileBot --version

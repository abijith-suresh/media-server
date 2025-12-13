Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$FileBot = "$env:USERPROFILE\Tools\FileBot\FileBot.jar"

Write-Host "Java version:"
java -version

Write-Host "Validating FileBot execution..."
java -jar $FileBot -help | Out-Null

Write-Host "FileBot validation successful"

#Requires -RunAsAdministrator

<#
.SYNOPSIS
    Automatically updates Windows hosts file with current WSL2 IP
.DESCRIPTION
    Run this script on Windows startup to ensure .local domains always work
    Creates a scheduled task if -Install flag is used
#>

param(
    [switch]$Install,
    [switch]$Uninstall
)

$hostsFile = "C:\Windows\System32\drivers\etc\hosts"
$taskName = "WSL2-Hosts-Updater"

# Domains to map
$domains = @(
    "jellyfin.local",
    "radarr.local",
    "sonarr.local",
    "prowlarr.local",
    "qbittorrent.local",
    "traefik.local"
)

function Get-WSL2IP {
    $ip = wsl hostname -I 2>$null
    if ($ip) {
        return $ip.Trim().Split()[0]
    }
    return $null
}

function Update-HostsFile {
    param([string]$IP)
    
    if (-not $IP) {
        Write-Host "❌ Could not get WSL2 IP. Is WSL2 running?" -ForegroundColor Red
        exit 1
    }
    
    Write-Host "✓ Found WSL2 IP: $IP" -ForegroundColor Green
    
    # Read current hosts file
    $content = Get-Content $hostsFile -ErrorAction SilentlyContinue
    
    # Remove old entries for our domains
    $content = $content | Where-Object { 
        $line = $_
        $isOurDomain = $false
        foreach ($domain in $domains) {
            if ($line -match $domain) {
                $isOurDomain = $true
                break
            }
        }
        -not $isOurDomain
    }
    
    # Add new entries
    $newEntries = $domains | ForEach-Object { "$IP $_" }
    $content += $newEntries
    
    # Write back
    $content | Set-Content $hostsFile
    
    Write-Host "✓ Updated hosts file with WSL2 IP: $IP" -ForegroundColor Green
    
    # Flush DNS cache
    ipconfig /flushdns | Out-Null
    Write-Host "✓ Flushed DNS cache" -ForegroundColor Green
    
    Write-Host "`n🎉 All .local domains are now accessible!" -ForegroundColor Cyan
    Write-Host "   Test: http://jellyfin.local" -ForegroundColor Gray
}

function Install-ScheduledTask {
    $action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-ExecutionPolicy Bypass -File `"$PSCommandPath`""
    $trigger = New-ScheduledTaskTrigger -AtLogOn
    $settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -StartWhenAvailable
    $principal = New-ScheduledTaskPrincipal -UserId "$env:USERNAME" -RunLevel Highest
    
    Register-ScheduledTask -TaskName $taskName -Action $action -Trigger $trigger -Settings $settings -Principal $principal -Force
    
    Write-Host "✓ Installed scheduled task: $taskName" -ForegroundColor Green
    Write-Host "  This will run automatically on Windows login" -ForegroundColor Gray
}

function Uninstall-ScheduledTask {
    Unregister-ScheduledTask -TaskName $taskName -Confirm:$false -ErrorAction SilentlyContinue
    Write-Host "✓ Removed scheduled task: $taskName" -ForegroundColor Green
}

# Main execution
if ($Uninstall) {
    Uninstall-ScheduledTask
    exit
}

if ($Install) {
    Update-HostsFile -IP (Get-WSL2IP)
    Install-ScheduledTask
    exit
}

# Normal run - just update hosts file
$wslIP = Get-WSL2IP
Update-HostsFile -IP $wslIP

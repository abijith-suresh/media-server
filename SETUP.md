# One-Click Setup Instructions

## Windows Setup (One-Time)

### Step 1: Enable WSL2 Mirrored Networking

1. Open PowerShell as Administrator
2. Run: `wsl --shutdown`
3. WSL2 will restart automatically with mirrored networking on next start

### Step 2: Add Static Hosts Entries (One-Time)

Open PowerShell as Administrator and run:

```powershell
$hostsFile = "C:\Windows\System32\drivers\etc\hosts"

# Remove any old entries first
(Get-Content $hostsFile) | Where-Object { $_ -notmatch "\.local" } | Set-Content $hostsFile

# Add new entries pointing to localhost
Add-Content $hostsFile "127.0.0.1 jellyfin.local"
Add-Content $hostsFile "127.0.0.1 radarr.local"
Add-Content $hostsFile "127.0.0.1 sonarr.local"
Add-Content $hostsFile "127.0.0.1 prowlarr.local"
Add-Content $hostsFile "127.0.0.1 qbittorrent.local"
Add-Content $hostsFile "127.0.0.1 traefik.local"
```

Or manually edit `C:\Windows\System32\drivers\etc\hosts` and add:
```
127.0.0.1 jellyfin.local
127.0.0.1 radarr.local
127.0.0.1 sonarr.local
127.0.0.1 prowlarr.local
127.0.0.1 qbittorrent.local
127.0.0.1 traefik.local
```

### Step 3: Flush DNS Cache

```powershell
ipconfig /flushdns
```

## Done! 

Now all domains work permanently:
- http://jellyfin.local
- http://radarr.local  
- http://sonarr.local
- http://prowlarr.local
- http://qbittorrent.local
- http://traefik.local

The IP will never change because:
- WSL2 uses mirrored networking (shares Windows IP)
- Hosts file points to 127.0.0.1 (localhost)
- Traefik listens on port 80

## Alternative: If Mirrored Mode Not Available

If you're on Windows 10 or older WSL2 version, use the automatic script instead:

Run `setup-windows.ps1` (included in this repo) as Administrator on Windows startup.

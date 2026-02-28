# Quick Start Guide

Get your media server running in 5 minutes.

## Prerequisites

- Windows 10/11 with WSL2 enabled
- Docker Desktop installed
- Git installed

## Step 1: Clone Repository

```bash
git clone https://github.com/abijith-suresh/media-server.git
cd media-server
```

## Step 2: Configure Environment

```bash
# Copy example environment file
cp .env.example .env

# Edit .env with your settings
nano .env
```

Update these values:
- `DATA_PATH` - Where to store media (default: `/home/YOUR_USERNAME/data`)
- `TZ` - Your timezone (default: `Asia/Kolkata`)

## Step 3: Create Data Directory

```bash
mkdir -p ~/data/{torrents/{movies,tv},media/{movies,tv},config}
```

## Step 4: Configure WSL2 Mirrored Mode

Create `.wslconfig` in your Windows user directory (`C:\Users\YOUR_USERNAME\.wslconfig`):

```ini
[wsl2]
networkingMode=mirrored
```

Then restart WSL2:
```powershell
wsl --shutdown
```

## Step 5: Start Services

```bash
docker compose up -d
```

## Step 6: Configure Windows Hosts File

Run PowerShell as Administrator:

```powershell
$hostsFile = "C:\Windows\System32\drivers\etc\hosts"

# Add entries
Add-Content $hostsFile "127.0.0.1 jellyfin.local"
Add-Content $hostsFile "127.0.0.1 radarr.local"
Add-Content $hostsFile "127.0.0.1 sonarr.local"
Add-Content $hostsFile "127.0.0.1 prowlarr.local"
Add-Content $hostsFile "127.0.0.1 qbittorrent.local"
Add-Content $hostsFile "127.0.0.1 bazarr.local"
Add-Content $hostsFile "127.0.0.1 overseerr.local"
Add-Content $hostsFile "127.0.0.1 portainer.local"
Add-Content $hostsFile "127.0.0.1 traefik.local"

# Flush DNS
ipconfig /flushdns
```

## Step 7: Access Services

Open your browser:
- http://jellyfin.local - Complete Jellyfin setup
- http://radarr.local - Configure Radarr
- http://sonarr.local - Configure Sonarr
- http://prowlarr.local - Add indexers

## Next Steps

Follow the configuration guides:
1. [qBittorrent Setup](./configuration/qbittorrent.md)
2. [Prowlarr Indexers](./configuration/prowlarr-indexers.md)
3. [Radarr TRaSH Profiles](./configuration/radarr-profiles.md)
4. [Sonarr TRaSH Profiles](./configuration/sonarr-profiles.md)

## Verification

Check all containers are running:
```bash
docker compose ps
```

View logs:
```bash
docker compose logs -f
```

## Troubleshooting

If services don't load:
1. Check Docker is running: `docker ps`
2. Verify WSL2: `wsl --status`
3. Check hosts file is correct
4. See [Common Issues](../troubleshooting/common-issues.md)

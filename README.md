# Media Server

A complete WSL2-based home media server setup following TRaSH Guides best practices.

## Features

- **One-Command Deploy**: `docker compose up -d`
- **Custom Domains**: Access all services via `.local` domains (jellyfin.local, radarr.local, etc.)
- **TRaSH Guides Compliant**: Quality profiles, custom formats, and folder structure per TRaSH Guides
- **Reverse Proxy**: Traefik handles all routing automatically
- **Complete Stack**: Movies, TV shows, subtitles, requests, and management

## Services Included

### Core Media Stack
| Service | Purpose | Domain |
|---------|---------|--------|
| Jellyfin | Media streaming | http://jellyfin.local |
| Radarr | Movie management | http://radarr.local |
| Sonarr | TV show management | http://sonarr.local |
| Prowlarr | Indexer management | http://prowlarr.local |
| qBittorrent | Download client | http://qbittorrent.local |

### Add-ons
| Service | Purpose | Domain |
|---------|---------|--------|
| Bazarr | Subtitle management | http://bazarr.local |
| Overseerr | Request system | http://overseerr.local |
| Portainer | Docker management | http://portainer.local |
| Watchtower | Auto-updates | - |
| qBit Manage | qBittorrent automation | - |

## Quick Start

### Prerequisites

- Windows 10/11 with WSL2
- Docker Desktop

### 1. Clone and Configure

```bash
git clone https://github.com/abijith-suresh/media-server.git
cd media-server
cp .env.example .env
# Edit .env with your settings
```

### 2. Create Data Directory

```bash
mkdir -p ~/data/{torrents/{movies,tv},media/{movies,tv},config}
```

### 3. Enable WSL2 Mirrored Mode

Create `C:\Users\YOUR_USERNAME\.wslconfig`:
```ini
[wsl2]
networkingMode=mirrored
```

Then restart WSL2:
```powershell
wsl --shutdown
```

### 4. Start Services

```bash
docker compose up -d
```

### 5. Configure Windows Hosts

Run PowerShell as Administrator:
```powershell
$hosts = "C:\Windows\System32\drivers\etc\hosts"
Add-Content $hosts "127.0.0.1 jellyfin.local"
Add-Content $hosts "127.0.0.1 radarr.local"
Add-Content $hosts "127.0.0.1 sonarr.local"
Add-Content $hosts "127.0.0.1 prowlarr.local"
Add-Content $hosts "127.0.0.1 qbittorrent.local"
Add-Content $hosts "127.0.0.1 bazarr.local"
Add-Content $hosts "127.0.0.1 overseerr.local"
Add-Content $hosts "127.0.0.1 portainer.local"
Add-Content $hosts "127.0.0.1 traefik.local"
ipconfig /flushdns
```

### 6. Configure Services

Follow the [documentation](./docs/) to configure:
1. [qBittorrent](./docs/configuration/qbittorrent.md) - Set categories
2. [Prowlarr](./docs/configuration/prowlarr-indexers.md) - Add indexers
3. [Radarr](./docs/configuration/radarr-profiles.md) - Import TRaSH formats
4. [Sonarr](./docs/configuration/sonarr-profiles.md) - Import TRaSH formats
5. [Bazarr](./docs/services/addons/bazarr.md) - Connect to *arr apps

## Documentation

- [Full Documentation](./docs/index.md)
- [Quick Start Guide](./docs/setup/quickstart.md)
- [Configuration Guides](./docs/configuration/)

## Architecture

```
Windows Host
└── WSL2
    └── Docker
        ├── Traefik (Reverse Proxy)
        ├── Jellyfin (Media Server)
        ├── Radarr (Movies)
        ├── Sonarr (TV)
        ├── Prowlarr (Indexers)
        ├── qBittorrent (Downloads)
        ├── Bazarr (Subtitles)
        ├── Overseerr (Requests)
        └── Portainer (Management)
```

## Data Flow

1. **Request**: Overseerr → Radarr/Sonarr
2. **Search**: Prowlarr searches indexers
3. **Download**: qBittorrent downloads to `/data/torrents`
4. **Import**: Radarr/Sonarr hardlinks to `/data/media`
5. **Subtitles**: Bazarr downloads subtitles
6. **Stream**: Jellyfin serves media

## Maintenance

```bash
# Update all containers
docker compose pull && docker compose up -d

# View logs
docker compose logs -f [service-name]

# Restart service
docker compose restart [service-name]
```

## Support

- Check [Troubleshooting Guide](./docs/troubleshooting/common-issues.md)
- Review service logs: `docker logs [container-name]`
- TRaSH Guides: https://trash-guides.info/

## License

MIT

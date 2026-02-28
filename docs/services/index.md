# Services Overview

All services are accessible via custom `.local` domains.

## Core Services

### Jellyfin (Media Server)
- **URL**: http://jellyfin.local
- **Purpose**: Stream movies and TV shows
- **Config**: Add libraries pointing to `/data/media`

### Radarr (Movie Manager)
- **URL**: http://radarr.local
- **Purpose**: Download and organize movies
- **Config**: TRaSH quality profiles, custom formats

### Sonarr (TV Manager)
- **URL**: http://sonarr.local
- **Purpose**: Download and organize TV shows
- **Config**: TRaSH quality profiles, custom formats

### Prowlarr (Indexer Manager)
- **URL**: http://prowlarr.local
- **Purpose**: Manage torrent indexers
- **Config**: Add public indexers, sync to *arr apps

### qBittorrent (Download Client)
- **URL**: http://qbittorrent.local
- **Purpose**: Download torrents
- **Config**: Categories for Radarr/Sonarr

## Add-on Services

### Bazarr (Subtitles)
- **URL**: http://bazarr.local
- **Purpose**: Download subtitles automatically
- **Config**: Connect to Radarr/Sonarr

### Overseerr (Requests)
- **URL**: http://overseerr.local
- **Purpose**: Request movies/shows
- **Config**: Connect to Radarr/Sonarr

### Portainer (Docker Management)
- **URL**: http://portainer.local
- **Purpose**: Manage Docker containers
- **Config**: Create admin account on first run

### Traefik Dashboard
- **URL**: http://traefik.local
- **Purpose**: Monitor reverse proxy routes
- **No config needed**

## Service Ports

| Service | Port | Domain |
|---------|------|--------|
| Jellyfin | 8096 | jellyfin.local |
| Radarr | 7878 | radarr.local |
| Sonarr | 8989 | sonarr.local |
| Prowlarr | 9696 | prowlarr.local |
| qBittorrent | 8080 | qbittorrent.local |
| Bazarr | 6767 | bazarr.local |
| Overseerr | 5055 | overseerr.local |
| Portainer | 9000 | portainer.local |
| Traefik | 8081 | traefik.local |

## Data Flow

```
User Request → Overseerr
     ↓
Radarr/Sonarr (monitors)
     ↓
Prowlarr (searches indexers)
     ↓
qBittorrent (downloads)
     ↓
Radarr/Sonarr (imports to library)
     ↓
Bazarr (downloads subtitles)
     ↓
Jellyfin (serves media)
```

## First-Time Setup Order

1. **qBittorrent** - Set categories
2. **Prowlarr** - Add indexers
3. **Radarr** - Import custom formats, set quality profile
4. **Sonarr** - Import custom formats, set quality profile
5. **Bazarr** - Connect to *arr apps
6. **Overseerr** - Connect to *arr apps
7. **Jellyfin** - Add libraries
8. **Portainer** - Create admin (optional)

## Maintenance

**Update containers:**
```bash
docker compose pull
docker compose up -d
```

**View logs:**
```bash
docker compose logs -f [service-name]
```

**Restart service:**
```bash
docker compose restart [service-name]
```

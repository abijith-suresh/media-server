# Media Server Documentation

Complete documentation for the WSL2-based media server setup following TRaSH Guides best practices.

## Table of Contents

### Setup Guides
- [Quick Start](./setup/quickstart.md) - Get running in 5 minutes
- [Prerequisites](./setup/prerequisites.md) - System requirements
- [Windows Setup](./setup/windows.md) - One-time Windows configuration
- [WSL2 Configuration](./setup/wsl2.md) - WSL2 mirrored networking

### Service Configuration

#### Core Services
- [Jellyfin](./services/core/jellyfin.md) - Media server
- [Radarr](./services/core/radarr.md) - Movie management
- [Sonarr](./services/core/sonarr.md) - TV show management
- [Prowlarr](./services/core/prowlarr.md) - Indexer management
- [qBittorrent](./services/core/qbittorrent.md) - Download client

#### Add-on Services
- [Bazarr](./services/addons/bazarr.md) - Subtitle management
- [Overseerr](./services/addons/overseerr.md) - Request management
- [Portainer](./services/addons/portainer.md) - Docker management
- [Watchtower](./services/addons/watchtower.md) - Auto-updates
- [qBit Manage](./services/addons/qbitmanage.md) - qBittorrent automation

### Configuration Guides
- [qBittorrent Setup](./configuration/qbittorrent.md) - Categories and settings
- [Prowlarr Indexers](./configuration/prowlarr-indexers.md) - Adding indexers
- [Radarr TRaSH Profiles](./configuration/radarr-profiles.md) - Quality profiles
- [Sonarr TRaSH Profiles](./configuration/sonarr-profiles.md) - Quality profiles
- [Jellyfin Libraries](./configuration/jellyfin-libraries.md) - Library setup

### Maintenance
- [Troubleshooting](./troubleshooting/common-issues.md)
- [Migration to Hardware](./migration/to-hardware.md)

## Quick Access

All services are available at:
- http://jellyfin.local - Media server
- http://radarr.local - Movies
- http://sonarr.local - TV shows
- http://prowlarr.local - Indexers
- http://qbittorrent.local - Downloads
- http://bazarr.local - Subtitles
- http://overseerr.local - Requests
- http://portainer.local - Docker management
- http://traefik.local - Reverse proxy dashboard

## Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                        Windows Host                          │
│                     (Your Windows Machine)                   │
├─────────────────────────────────────────────────────────────┤
│                        WSL2 Instance                         │
│  ┌────────────────────────────────────────────────────────┐ │
│  │                    Docker Network                       │ │
│  │  ┌──────────┐ ┌──────────┐ ┌──────────┐ ┌──────────┐  │ │
│  │  │ Traefik  │ │ Jellyfin │ │  Radarr  │ │  Sonarr  │  │ │
│  │  │ (Proxy)  │ │ (Media)  │ │ (Movies) │ │   (TV)   │  │ │
│  │  └──────────┘ └──────────┘ └──────────┘ └──────────┘  │ │
│  │  ┌──────────┐ ┌──────────┐ ┌──────────┐ ┌──────────┐  │ │
│  │  │Prowlarr  │ │qBittorrent│ │  Bazarr  │ │Overseerr │  │ │
│  │  │(Indexers)│ │(Download)│ │(Subtitles)│ │(Requests)│  │ │
│  │  └──────────┘ └──────────┘ └──────────┘ └──────────┘  │ │
│  └────────────────────────────────────────────────────────┘ │
└─────────────────────────────────────────────────────────────┘
```

## Support

If you encounter issues:
1. Check the [Troubleshooting Guide](./troubleshooting/common-issues.md)
2. Review service-specific documentation
3. Check container logs: `docker logs <container-name>`

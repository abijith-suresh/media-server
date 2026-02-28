# qBittorrent Configuration

Configure qBittorrent per TRaSH Guides.

## Initial Access

- URL: http://qbittorrent.local
- Default credentials:
  - Username: `admin`
  - Password: Check logs: `docker logs qbittorrent | grep password`

## Required Configuration

### 1. Categories (Essential for *arr apps)

Go to **Tools** → **Options** → **Downloads**

Under "Default Save Path": `/data/torrents`

Enable "Use Subcategories" → Check the box

Then add these categories:

| Category | Save Path |
|----------|-----------|
| `radarr` | `/data/torrents/movies` |
| `sonarr` | `/data/torrents/tv` |

**How to add:**
1. In qBittorrent, go to **View** → **Top Toolbar** (enable if not visible)
2. Right-click in torrent list → **Category** → **New** → Enter name and path

### 2. Connection Settings

**Tools** → **Options** → **Connection**

- Protocol: TCP (for best performance)
- Port: Use the forwarded port from your VPN/provider
- UPnP/NAT-PMP: Disabled (for security)

### 3. Speed Limits

**Tools** → **Options** → **Speed**

Set to 70-80% of your connection:
- Global Rate Limits: Set your max upload/download
- Alternative Rate Limits: Optional schedule

### 4. Privacy Settings

**Tools** → **Options** → **BitTorrent**

- DHT: Enabled (for public trackers)
- PeX: Enabled (for public trackers)
- LPD: Disabled
- Encryption: Allow encryption
- Anonymous Mode: Disabled

### 5. Seeding Limits

**Tools** → **Options** → **BitTorrent**

- Max ratio: Disabled (let *arr apps handle this)
- Max seeding time: Disabled
- When limits reached: Pause

## TRaSH Guide Reference

For complete settings, see: https://trash-guides.info/Downloaders/qBittorrent/Basic-Setup/

## Testing

After configuration:
1. Add a test torrent manually
2. Verify it downloads to `/data/torrents/movies` or `/data/torrents/tv`
3. Check Radarr/Sonarr can see completed downloads

## Troubleshooting

**Issue:** Downloads not moving to media folder
- Check categories are set correctly
- Verify *arr apps have correct download client settings
- Check logs: `docker logs qbittorrent`

**Issue:** Cannot access Web UI
- Check container is running: `docker ps | grep qbittorrent`
- Check port mapping: Should be 8080
- Check Traefik routing: http://qbittorrent.local

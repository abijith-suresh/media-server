# Prowlarr Indexer Configuration

Add public indexers and sync to Radarr/Sonarr.

## Initial Setup

1. Access: http://prowlarr.local
2. Complete authentication setup
3. Get API key from **Settings** → **General**

## Step 1: Add Indexers

**Indexers** → **Add Indexer** (+ button)

### Recommended Public Indexers

Add these (no API keys needed):

1. **1337x**
   - Categories: Movies, TV
   - Priority: 25

2. **TorrentGalaxy**
   - Categories: Movies, TV
   - Priority: 25

3. **EZTV** (TV only)
   - Categories: TV
   - Priority: 25

4. **Nyaa** (Anime)
   - Categories: TV/Anime
   - Priority: 25
   - Only if you download anime

5. **YTS** (Movies only, small files)
   - Categories: Movies
   - Priority: 10 (lower priority)
   - Note: Lower quality, smaller files

### Indexer Settings

For each indexer:
- **Enable**: ✓
- **Sync Profile**: Standard (default)
- **Priority**: 25 (lower = higher priority)
- **Grab Limit**: 0 (unlimited)
- **Query Limit**: 0 (unlimited)

## Step 2: Configure Apps (Radarr/Sonarr)

**Settings** → **Apps** → **Add Application**

### Add Radarr

- **Application**: Radarr
- **Name**: Radarr
- **Sync Level**: Add and Remove Only (recommended)
- **Tags**: (leave empty)
- **Prowlarr Server**: http://prowlarr:9696
- **Radarr Server**: http://radarr:7878
- **API Key**: (from Radarr)
- **Sync Categories**: Movies

Test and save.

### Add Sonarr

- **Application**: Sonarr
- **Name**: Sonarr
- **Sync Level**: Add and Remove Only
- **Tags**: (leave empty)
- **Prowlarr Server**: http://prowlarr:9696
- **Sonarr Server**: http://sonarr:8989
- **API Key**: (from Sonarr)
- **Sync Categories**: TV

Test and save.

## Step 3: Sync Indexers

1. Go to **Indexers** page
2. Click **Sync App Indexers** button
3. Verify indexers appear in Radarr/Sonarr

## Verification

1. In Radarr: **Settings** → **Indexers** - should see synced indexers
2. In Sonarr: **Settings** → **Indexers** - should see synced indexers
3. Test search in Radarr/Sonarr

## Troubleshooting

**Issue:** Indexers not syncing
- Check API keys are correct
- Verify apps are running
- Check Prowlarr logs

**Issue:** Searches returning no results
- Test each indexer in Prowlarr
- Check if indexer is up
- Verify categories are correct

## Optional: FlareSolverr

For indexers protected by Cloudflare:

Add to docker-compose.yml:
```yaml
  flaresolverr:
    image: ghcr.io/flaresolverr/flaresolverr:latest
    container_name: flaresolverr
    environment:
      - LOG_LEVEL=info
    ports:
      - "8191:8191"
    networks:
      - media-net
    restart: unless-stopped
```

Then in Prowlarr:
**Settings** → **FlareSolverr** → Add with URL: http://flaresolverr:8191

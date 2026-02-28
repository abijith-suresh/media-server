# Radarr TRaSH Configuration

Configure Radarr with TRaSH Guides quality profiles.

## Initial Setup

1. Access: http://radarr.local
2. Complete initial wizard:
   - Authentication: Set username/password
   - Root Folder: `/data/media/movies`
3. Get API key: **Settings** → **General** → API Key (save this)

## Step 1: Import Custom Formats

### Method 1: Manual Import (Recommended for learning)

1. Go to **Settings** → **Custom Formats**
2. Click **+** to add each format from TRaSH Guides
3. Use the scores from: https://trash-guides.info/Radarr/radarr-setup-quality-profiles/

**Essential Custom Formats:**

| Format | Score | Purpose |
|--------|-------|---------|
| BR-DISK | -10000 | Block BR-DISK |
| LQ | -10000 | Block low quality |
| LQ (Release Title) | -10000 | Block low quality titles |
| x265 (HD) | -10000 | Block x265 in 1080p |
| Repack/Proper | 5 | Prefer repacks |
| AMZN/ATVP/DSNP/etc | 75 | Prefer streaming sources |
| WEB Tier 01 | 1700 | Best web groups |
| WEB Tier 02 | 1650 | Good web groups |
| WEB Tier 03 | 1600 | Okay web groups |

### Method 2: Guide Sync Tool

Use Notifiarr or TRaSH sync tools for automatic updates.

## Step 2: Create Quality Profile

**Settings** → **Profiles** → **Quality Profiles** → **+**

Create "TRaSH - HD Bluray + WEB":

**Qualities (in order):**
1. Bluray-1080p ✓
2. WEBDL-1080p ✓
3. WEBRip-1080p ✓
4. Bluray-720p ✓
5. WEBDL-720p ✓
6. WEBRip-720p ✓

**Settings:**
- Upgrade Until: WEBDL-1080p (or Bluray-1080p if you prefer)
- Minimum Custom Format Score: 0
- Upgrade Until Custom Format Score: 10000

**Custom Formats to Add:**
- Add all the formats you imported above
- Use scores from TRaSH guide table

## Step 3: Configure Download Client

**Settings** → **Download Clients** → **+** → **qBittorrent**

- Name: qBittorrent
- Host: qbittorrent
- Port: 8080
- Username: admin
- Password: (your password)
- Category: radarr
- Recent Priority: Last
- Older Priority: Last

Test and save.

## Step 4: Set Root Folder

**Settings** → **Media Management** → **Root Folders**

Add: `/data/media/movies`

## Step 5: Configure Naming

**Settings** → **Media Management** → **Movie Naming**

Enable: **Rename Movies**

Standard Movie Format:
```
{Movie Title} ({Release Year}) {Edition Tags} {Quality Full} {MediaInfo VideoCodec} {MediaInfo AudioCodec}-{Release Group}
```

Movie Folder Format:
```
{Movie Title} ({Release Year}) {Edition Tags}
```

## Step 6: Add Indexers

Wait for Prowlarr sync, or add manually:
**Settings** → **Indexers** → **+**

## Verification

1. Add a test movie
2. Search for it
3. Verify quality profile is applied
4. Check download starts in qBittorrent
5. Verify import to `/data/media/movies`

## TRaSH Guide Reference

- Quality Profiles: https://trash-guides.info/Radarr/radarr-setup-quality-profiles/
- Custom Formats: https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/
- Import Guide: https://trash-guides.info/Radarr/Radarr-import-custom-formats/

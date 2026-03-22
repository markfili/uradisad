# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands

```bash
# Run the app
flutter run

# Run tests
flutter test

# Run a single test file
flutter test test/widget_test.dart

# Get dependencies
flutter pub get

# Analyze code
flutter analyze
```

## Data Pipeline Scripts

Shell scripts live in `scripts/` and data files in `data/`. Run scripts from within `scripts/`:

```bash
cd scripts
bash update.sh   # full pipeline: fetch OG → screenshots → merge
```

Individual scripts:
1. **`scripts/fetch_og_data.sh`** — Reads URLs from `data/sources.yaml`, fetches Open Graph metadata, writes `data/og_metadata.json`. Requires: `yq`, `curl`, `jq`.
2. **`scripts/capture_screenshots.sh`** — Reads URLs from `data/og_metadata.json`, captures screenshots via Puppeteer (auto-installed), saves to `assets/screenshots/` with MD5-hashed filenames, writes `data/url_mapping.txt`. Requires: `jq`, `node`, `npm`, `md5`.
3. **`scripts/merge_sources.sh`** — Merges `data/sources.yaml` + `data/og_metadata.json` into `assets/sources.json`. Requires: `yq`, `jq`.

## Architecture

This is a single-screen Flutter app ("HR AKTIVIZAM") — a directory of Croatian civic activism organizations and resources.

**Data flow:**
- `data/sources.yaml` — curated list of source URLs (human-edited master list)
- `data/og_metadata.json` — auto-fetched Open Graph metadata cache
- `assets/sources.json` — app data file loaded at runtime; each entry has `url`, `title`, `description`, `image` (MD5 filename), `image_og`, `site_name`, `categories` (array of category IDs)
- `assets/categories.json` — predefined category definitions
- `assets/screenshots/` — website screenshots named by MD5 hash of the URL

**Key data models (`lib/data/`):**
- `ActivismSource` — represents one activism resource; fetched from GitHub at runtime (fallback: bundled `assets/sources.json`)
- `ActivismCategory` / `ActivismCategories` — fetched from GitHub at runtime (fallback: bundled `assets/categories.json`)

**Adding a new source:** Add the URL to `data/sources.yaml`, run `cd scripts && bash update.sh` to populate metadata/screenshots and regenerate `assets/sources.json`.

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

The `assets/` directory contains two shell scripts for populating app data (run from within `assets/`):

1. **`fetch_og_data.sh`** — Reads URLs from `sources.yaml`, fetches Open Graph metadata, and writes `og_metadata.json`. Requires: `yq`, `curl`, `jq`.
2. **`capture_screenshots.sh`** — Reads URLs from `og_metadata.json`, captures screenshots via Puppeteer (auto-installed), and saves them to `assets/screenshots/` with MD5-hashed filenames. Requires: `jq`, `node`, `npm`, `md5`.

## Architecture

This is a single-screen Flutter app ("HR AKTIVIZAM") — a directory of Croatian civic activism organizations and resources.

**Data flow:**
- `assets/sources.yaml` — curated list of source URLs (human-edited master list)
- `assets/sources.json` — app data file loaded at runtime; each entry has `url`, `title`, `description`, `image` (MD5 filename), `image_og`, `site_name`, `categories` (array of category IDs)
- `assets/screenshots/` — website screenshots named by MD5 hash of the URL

**Key data models (`lib/data/`):**
- `ActivismSource` — represents one activism resource; parsed from `sources.json`; resolves category IDs to `ActivismCategory` objects via `ActivismCategories.getCategoriesByIds()`
- `ActivismCategory` / `ActivismCategories` — static list of ~50 predefined categories with bilingual names (`nameEn`, `nameHr`) and IDs (e.g. `"social_media"`, `"lobbying"`)

**UI (`lib/main.dart`):**
- Single `StatefulWidget` (`_MyHomePageState`) loads `sources.json` in `initState` and renders a responsive grid (2 columns on mobile, 4 on wide screens ≥1024px)
- `ExpansionTile` at the top allows filtering by category using `FilterChip` widgets; active filters are tracked in a local `List<ActivismCategory> filters`
- Grid cards show the screenshot image (or a letter placeholder), title, description, and category chips
- The `Metadata` class at the bottom of `main.dart` is an older model not currently used by the grid — `ActivismSource` is the active model

**Adding a new source:** Add the URL to `sources.yaml`, re-run `fetch_og_data.sh` and `capture_screenshots.sh` to populate metadata/screenshots, then manually copy the entry into `sources.json` and assign appropriate category IDs.

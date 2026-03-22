#!/bin/zsh

# Full data update pipeline. Run this after adding new entries to sources.yaml.
#
# Steps:
#   1. fetch_og_data.sh  — fetch OG metadata for any URLs not yet cached
#   2. capture_screenshots.sh — capture screenshots for any URLs not yet cached
#   3. merge_sources.sh  — regenerate sources.json from sources.yaml + og_metadata.json
#
# All scripts are cache-aware: already-processed URLs are skipped.

set -e

SCRIPT_DIR="${0:A:h}"
cd "$SCRIPT_DIR"

echo "=== Step 1: Fetch OG metadata ==="
./fetch_og_data.sh

echo ""
echo "=== Step 2: Capture screenshots ==="
./capture_screenshots.sh

echo ""
echo "=== Step 3: Merge into sources.json ==="
./merge_sources.sh

echo ""
echo "All done. Commit data/sources.yaml, data/og_metadata.json, assets/screenshots/, and assets/sources.json."

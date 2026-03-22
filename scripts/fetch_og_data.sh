#!/bin/zsh

# Script to download Open Graph data from links in sources.yaml
# Dependencies: yq, curl, jq

# Check dependencies
for cmd in yq curl jq; do
  if ! command -v $cmd &> /dev/null; then
    echo "Error: $cmd is required but not installed."
    echo "Install with: brew install $cmd"
    exit 1
  fi
done

# Configuration
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
SOURCES_FILE="${SCRIPT_DIR}/../data/sources.yaml"
OUTPUT_FILE="${SCRIPT_DIR}/../data/og_metadata.json"
TEMP_DIR="/tmp/og_data"
USER_AGENT="Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.114 Safari/537.36"

# Create temp directory
mkdir -p $TEMP_DIR

# Initialize output file if it doesn't exist
if [[ ! -f $OUTPUT_FILE ]]; then
  echo "{}" > $OUTPUT_FILE
fi

# Function to extract OG metadata from HTML
extract_og_data() {
  local url=$1
  local domain=$(echo $url | awk -F/ '{print $3}')
  local html_file="$TEMP_DIR/${domain//[^a-zA-Z0-9]/_}.html"

  echo "Fetching $url..."

  # Download the HTML
  curl -s -A "$USER_AGENT" -L "$url" -o "$html_file"

  # Extract OG data
  local title=$(grep -o '<meta property="og:title" content="[^"]*"' "$html_file" | sed 's/.*content="\([^"]*\)".*/\1/')
  local description=$(grep -o '<meta property="og:description" content="[^"]*"' "$html_file" | sed 's/.*content="\([^"]*\)".*/\1/')
  local image_og=$(grep -o '<meta property="og:image" content="[^"]*"' "$html_file" | sed 's/.*content="\([^"]*\)".*/\1/')
  local image="$(echo "$url" | md5).jpg"
  local site_name=$(grep -o '<meta property="og:site_name" content="[^"]*"' "$html_file" | sed 's/.*content="\([^"]*\)".*/\1/')

  # If OG data not found, try standard meta tags
  if [[ -z "$title" ]]; then
    title=$(grep -o '<title>[^<]*</title>' "$html_file" | sed 's/<title>\(.*\)<\/title>/\1/')
  fi

  if [[ -z "$description" ]]; then
    description=$(grep -o '<meta name="description" content="[^"]*"' "$html_file" | sed 's/.*content="\([^"]*\)".*/\1/')
  fi

  # Build JSON entry and merge into URL-keyed output file
  local json=$(jq -n \
    --arg title "$title" \
    --arg description "$description" \
    --arg image "$image" \
    --arg image_og "$image_og" \
    --arg site_name "$site_name" \
    '{title: $title, description: $description, image: $image, image_og: $image_og, site_name: $site_name}')

  jq --arg url "$url" --argjson data "$json" '. + {($url): $data}' $OUTPUT_FILE > "${OUTPUT_FILE}.tmp" && mv "${OUTPUT_FILE}.tmp" $OUTPUT_FILE

  echo "Processed $url"
}

# Main process
echo "Reading sources from $SOURCES_FILE..."

# Extract all URLs from sources.yaml
urls=($(yq eval '.sources[].url' $SOURCES_FILE))

# Process each URL, skipping ones already cached
for url in "${urls[@]}"; do
  already_fetched=$(jq --arg url "$url" 'has($url)' $OUTPUT_FILE)
  if [[ "$already_fetched" == "true" ]]; then
    echo "Skipping (cached): $url"
    continue
  fi

  extract_og_data $url
  sleep 1
done

# Clean up
rm -rf $TEMP_DIR

echo "Done! Open Graph data saved to $OUTPUT_FILE"
echo "Total cached entries: $(jq 'keys | length' $OUTPUT_FILE)"

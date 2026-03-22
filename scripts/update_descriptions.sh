#!/bin/zsh

# Patches only the 'description' field in assets/sources.json.
# Run this after re-fetching OG metadata or editing descriptions in sources.yaml,
# without needing to rebuild all other fields via merge_sources.sh.
#
# Precedence: OG description wins; editorial (sources.yaml) is fallback.
# Dependencies: yq, jq

# Check dependencies
for cmd in yq jq; do
  if ! command -v $cmd &> /dev/null; then
    echo "Error: $cmd is required but not installed."
    echo "Install with: brew install $cmd"
    exit 1
  fi
done

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
SOURCES_FILE="${SCRIPT_DIR}/../assets/sources.json"
METADATA_FILE="${SCRIPT_DIR}/../data/og_metadata.json"
YAML_FILE="${SCRIPT_DIR}/../data/sources.yaml"
MANIFEST_FILE="${SCRIPT_DIR}/../assets/manifest.json"

if [[ ! -f $SOURCES_FILE ]]; then
  echo "Error: $SOURCES_FILE not found. Run merge_sources.sh first."
  exit 1
fi

if [[ ! -f $METADATA_FILE ]]; then
  echo "Warning: $METADATA_FILE not found. Using editorial descriptions only."
  echo "{}" > $METADATA_FILE
fi

count=$(jq 'length' $SOURCES_FILE)
echo "Updating descriptions for $count entries in $SOURCES_FILE..."

result=$(cat $SOURCES_FILE)

for (( i=0; i<count; i++ )); do
  url=$(echo "$result" | jq -r ".[$i].url")

  og_description=$(jq -r --arg url "$url" '.[$url].description // ""' $METADATA_FILE)
  editorial=$(yq eval ".sources[] | select(.url == \"$url\") | .description // \"\"" $YAML_FILE)
  description_source=$(yq eval ".sources[] | select(.url == \"$url\") | .description_source // \"\"" $YAML_FILE)

  # Resolve description: per-entry override takes precedence over global rule
  if [[ "$description_source" == "editorial" ]]; then
    final_description="$editorial"
  elif [[ "$description_source" == "og" ]]; then
    final_description="$og_description"
  else
    # default: OG wins, editorial fallback
    final_description="$og_description"
    if [[ -z "$final_description" || "$final_description" == "null" ]]; then
      final_description="$editorial"
    fi
  fi

  result=$(echo "$result" | jq --argjson i "$i" --arg desc "$final_description" '.[$i].description = $desc')
done

echo "$result" | jq '.' > $SOURCES_FILE
echo "Done! Descriptions updated in $SOURCES_FILE"

# Refresh manifest timestamp
echo "{\"generated_at\": \"$(date -u +"%Y-%m-%dT%H:%M:%SZ")\"}" > $MANIFEST_FILE
echo "Manifest written to $MANIFEST_FILE"

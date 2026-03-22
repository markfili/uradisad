#!/bin/zsh

# Script to merge sources.yaml (editorial) + og_metadata.json (auto-fetched)
# into sources.json (runtime file consumed by the Flutter app).
#
# Editorial fields from sources.yaml always win over auto-fetched fallbacks.
# Dependencies: yq, jq

# Check dependencies
for cmd in yq jq; do
  if ! command -v $cmd &> /dev/null; then
    echo "Error: $cmd is required but not installed."
    echo "Install with: brew install $cmd"
    exit 1
  fi
done

SCRIPT_DIR="${0:A:h}"
SOURCES_FILE="${SCRIPT_DIR}/../data/sources.yaml"
METADATA_FILE="${SCRIPT_DIR}/../data/og_metadata.json"
OUTPUT_FILE="${SCRIPT_DIR}/../assets/sources.json"

if [[ ! -f $SOURCES_FILE ]]; then
  echo "Error: $SOURCES_FILE not found."
  exit 1
fi

if [[ ! -f $METADATA_FILE ]]; then
  echo "Warning: $METADATA_FILE not found. Run fetch_og_data.sh first for images."
  echo "{}" > $METADATA_FILE
fi

echo "Merging $SOURCES_FILE + $METADATA_FILE -> $OUTPUT_FILE..."

# Read the number of sources
count=$(yq eval '.sources | length' $SOURCES_FILE)
echo "Found $count entries in $SOURCES_FILE"

# Build output array by iterating over each source entry
result="[]"

for (( i=0; i<count; i++ )); do
  url=$(yq eval ".sources[$i].url" $SOURCES_FILE)

  # Read editorial fields
  title=$(yq eval ".sources[$i].title" $SOURCES_FILE)
  description=$(yq eval ".sources[$i].description // \"\"" $SOURCES_FILE)
  group=$(yq eval ".sources[$i].group // null" $SOURCES_FILE)
  type=$(yq eval ".sources[$i].type // null" $SOURCES_FILE)
  language=$(yq eval ".sources[$i].language // null" $SOURCES_FILE)
  region=$(yq eval ".sources[$i].region // null" $SOURCES_FILE)
  categories=$(yq eval -o=json ".sources[$i].categories // []" $SOURCES_FILE)
  by=$(yq eval -o=json ".sources[$i].by // null" $SOURCES_FILE)
  socials=$(yq eval -o=json ".sources[$i].socials // null" $SOURCES_FILE)

  # Read auto-fetched fields from og_metadata.json (fallback only)
  og_title=$(jq -r --arg url "$url" '.[$url].title // ""' $METADATA_FILE)
  og_description=$(jq -r --arg url "$url" '.[$url].description // ""' $METADATA_FILE)
  og_image=$(jq -r --arg url "$url" '.[$url].image // ""' $METADATA_FILE)
  og_image_og=$(jq -r --arg url "$url" '.[$url].image_og // ""' $METADATA_FILE)
  og_site_name=$(jq -r --arg url "$url" '.[$url].site_name // ""' $METADATA_FILE)

  # Editorial description wins; fall back to auto-fetched
  final_description="$description"
  if [[ -z "$final_description" || "$final_description" == "null" ]]; then
    final_description="$og_description"
  fi

  # Build the JSON entry
  entry=$(jq -n \
    --arg url "$url" \
    --arg title "$title" \
    --arg description "$final_description" \
    --arg image "$og_image" \
    --arg image_og "$og_image_og" \
    --arg site_name "$og_site_name" \
    --argjson categories "$categories" \
    --argjson by "$by" \
    --argjson socials "$socials" \
    --arg group "$group" \
    --arg type "$type" \
    --arg language "$language" \
    --arg region "$region" \
    '{
      url: $url,
      title: $title,
      description: $description,
      image: $image,
      image_og: $image_og,
      site_name: $site_name,
      categories: $categories,
      by: $by,
      socials: $socials,
      group: (if $group == "null" then null else $group end),
      type: (if $type == "null" then null else $type end),
      language: (if $language == "null" then null else $language end),
      region: (if $region == "null" then null else $region end)
    }')

  result=$(echo "$result" | jq --argjson entry "$entry" '. + [$entry]')
done

echo "$result" | jq '.' > $OUTPUT_FILE

echo "Done! $OUTPUT_FILE written with $(jq 'length' $OUTPUT_FILE) entries."

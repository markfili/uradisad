#!/bin/zsh

# Script to capture screenshots of websites from og_metadata.json
# Dependencies: jq, node, npm, md5

# Check dependencies
for cmd in jq node npm md5; do
  if ! command -v $cmd &> /dev/null; then
    echo "Error: $cmd is required but not installed."
    if [[ $cmd == "md5" ]]; then
      echo "Install with: brew install md5sha1sum"
    elif [[ $cmd == "node" || $cmd == "npm" ]]; then
      echo "Install Node.js from https://nodejs.org/"
    else
      echo "Install with: brew install $cmd"
    fi
    exit 1
  fi
done

# Configuration
SCRIPT_DIR="${0:A:h}"
METADATA_FILE="${SCRIPT_DIR}/../data/og_metadata.json"
OUTPUT_DIR="${SCRIPT_DIR}/../assets/screenshots"
URL_MAPPING="${SCRIPT_DIR}/../data/url_mapping.txt"
TEMP_DIR="/tmp/screenshot_script"
VIEWPORT_WIDTH=1280
VIEWPORT_HEIGHT=800
TIMEOUT=30000  # 30 seconds timeout for loading each page

# Create output and temp directories
mkdir -p $OUTPUT_DIR
mkdir -p $TEMP_DIR

# Create Node.js script for capturing screenshots
cat > $TEMP_DIR/capture.js << 'EOL'
const puppeteer = require('puppeteer');
const fs = require('fs');
const path = require('path');

async function captureScreenshot(url, outputPath, viewportWidth, viewportHeight, timeout) {
  console.log(`Capturing screenshot of ${url}`);

  let browser;
  try {
    // Launch browser
    browser = await puppeteer.launch({
      headless: 'new',
      args: ['--no-sandbox', '--disable-setuid-sandbox', '--disable-dev-shm-usage']
    });

    // Create new page
    const page = await browser.newPage();

    // Set viewport
    await page.setViewport({
      width: viewportWidth,
      height: viewportHeight
    });

    // Set user agent to avoid bot detection
    await page.setUserAgent('Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36');

    // Navigate to URL with timeout
    await page.goto(url, {
      waitUntil: 'networkidle2',
      timeout: timeout
    });

    // Wait a bit for any animations or lazy-loaded content
    await new Promise(r => setTimeout(r, 3000));

    // Take screenshot
    await page.screenshot({
      path: outputPath,
      fullPage: false,
      type: 'jpeg',
      quality: 80
    });

    console.log(`Screenshot saved to ${outputPath}`);
    return true;
  } catch (error) {
    console.error(`Error capturing ${url}: ${error.message}`);
    return false;
  } finally {
    if (browser) {
      await browser.close();
    }
  }
}

// Main function
async function main() {
  const args = process.argv.slice(2);
  if (args.length < 4) {
    console.error('Usage: node capture.js <url> <outputPath> <viewportWidth> <viewportHeight> <timeout>');
    process.exit(1);
  }

  const url = args[0];
  const outputPath = args[1];
  const viewportWidth = parseInt(args[2], 10);
  const viewportHeight = parseInt(args[3], 10);
  const timeout = parseInt(args[4], 10);

  const success = await captureScreenshot(url, outputPath, viewportWidth, viewportHeight, timeout);
  process.exit(success ? 0 : 1);
}

main();
EOL

# Install Puppeteer in the temp directory
echo "Installing Puppeteer (this may take a moment)..."
cd $TEMP_DIR
npm init -y > /dev/null
npm install puppeteer > /dev/null

# Create a mapping file
echo "# URL -> Screenshot Mapping" > "$URL_MAPPING"
echo "# Generated on $(date)" >> "$URL_MAPPING"
echo "-----------------------------------" >> "$URL_MAPPING"

# Extract all URLs from the JSON file (URL-keyed object format)
echo "Reading URLs from $METADATA_FILE..."
urls_raw=$(jq -r 'keys[]' $METADATA_FILE)
urls=($(echo $urls_raw | tr "\n" "\n"))

# Process each URL
for url in "${urls[@]}"; do
  # Skip empty URLs
  if [[ -z $url || $url == "null" ]]; then
    echo "Skipping empty URL"
    continue
  fi

  # Create a hash of the URL for the filename
  hash=$(echo $url | md5)
  filename="${OUTPUT_DIR}/${hash}.jpg"

  echo "Processing $url"

  # Capture screenshot
  node $TEMP_DIR/capture.js "$url" "$filename" $VIEWPORT_WIDTH $VIEWPORT_HEIGHT $TIMEOUT

  # Check if screenshot was captured successfully
  if [[ -f "$filename" ]]; then
    echo "$url -> $filename" >> "$URL_MAPPING"
    echo "✅ Screenshot saved for $url"
  else
    echo "❌ Failed to capture screenshot for $url"
  fi

  # Add a small delay between captures
  sleep 1
done

# Clean up
echo "Cleaning up temporary files..."
rm -rf $TEMP_DIR

echo "Done! Screenshots saved to $OUTPUT_DIR"
echo "Created mapping file at $URL_MAPPING"
echo "Total screenshots: $(ls -1 $OUTPUT_DIR | grep -v "url_mapping.txt" | wc -l | tr -d ' ')"

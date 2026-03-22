#!/usr/bin/env python3
"""
Uses Claude API to suggest path and category assignments for every source.

Reads:  assets/sources.json, assets/categories.json
Writes: data/sources.yaml (updates `paths` and `categories` on each entry)

Requirements:
  pip install anthropic pyyaml
  export ANTHROPIC_API_KEY=...
"""

import json
import os
import sys
import time

import anthropic
import yaml

SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
SOURCES_JSON = os.path.join(SCRIPT_DIR, "../../assets/sources.json")
CATEGORIES_JSON = os.path.join(SCRIPT_DIR, "../../assets/categories.json")
SOURCES_YAML = os.path.join(SCRIPT_DIR, "../../data/sources.yaml")

PATHS = [
    {"id": "vlast",     "desc": "Government monitoring, transparency, elections, conflict of interest, accountability"},
    {"id": "okolis",    "desc": "Environment, climate action, cycling, sustainable living, pollution, conservation"},
    {"id": "grad",      "desc": "Urban mobility, city infrastructure, public transport, geographic data, city services"},
    {"id": "digitalno", "desc": "Open source, digital rights, civic tech, app development, open data, internet freedoms"},
    {"id": "prava",     "desc": "Human rights, civil liberties, minority rights, peace, anti-discrimination, refugees"},
]


def build_prompt(source: dict, category_ids: list[str]) -> str:
    paths_text = "\n".join(f"  {p['id']:12s} – {p['desc']}" for p in PATHS)
    cats_text = ", ".join(category_ids)
    return f"""You are categorising Croatian civic activism resources for a directory app.

Source:
  title:       {source.get('title', '')}
  url:         {source.get('url', '')}
  description: {source.get('description', '')}

Available paths (assign 0–3 that genuinely fit):
{paths_text}

Available category IDs (assign all that genuinely apply):
{cats_text}

Respond ONLY with valid JSON, no explanation, no markdown:
{{"paths": ["id", ...], "categories": ["id", ...]}}"""


def call_claude(client: anthropic.Anthropic, prompt: str) -> dict:
    message = client.messages.create(
        model="claude-haiku-4-5-20251001",
        max_tokens=256,
        messages=[{"role": "user", "content": prompt}],
    )
    text = message.content[0].text.strip()
    # Strip any accidental markdown fences
    if text.startswith("```"):
        text = text.split("```")[1]
        if text.startswith("json"):
            text = text[4:]
    return json.loads(text.strip())


def main():
    api_key = os.environ.get("ANTHROPIC_API_KEY")
    if not api_key:
        print("Error: ANTHROPIC_API_KEY environment variable not set.")
        sys.exit(1)

    with open(SOURCES_JSON) as f:
        sources = json.load(f)

    with open(CATEGORIES_JSON) as f:
        categories = json.load(f)
    category_ids = [c["id"] for c in categories]

    with open(SOURCES_YAML) as f:
        yaml_data = yaml.safe_load(f)

    # Build a URL → yaml entry index for fast lookup
    url_to_idx = {entry["url"]: i for i, entry in enumerate(yaml_data["sources"])}

    client = anthropic.Anthropic(api_key=api_key)

    print(f"Processing {len(sources)} sources...\n")

    for i, source in enumerate(sources):
        url = source.get("url", "")
        title = source.get("title", url)
        print(f"[{i+1}/{len(sources)}] {title}")

        prompt = build_prompt(source, category_ids)

        try:
            result = call_claude(client, prompt)
        except Exception as e:
            print(f"  ⚠ API error: {e} — skipping")
            time.sleep(2)
            continue

        suggested_paths = [p for p in result.get("paths", []) if p in [x["id"] for x in PATHS]]
        suggested_cats  = [c for c in result.get("categories", []) if c in category_ids]

        print(f"  paths: {suggested_paths}")
        print(f"  categories: {suggested_cats}")

        if url in url_to_idx:
            idx = url_to_idx[url]
            yaml_data["sources"][idx]["paths"] = suggested_paths
            yaml_data["sources"][idx]["categories"] = suggested_cats
        else:
            print(f"  ⚠ URL not found in sources.yaml — skipping write")

        # Respect rate limits
        time.sleep(0.3)

    with open(SOURCES_YAML, "w") as f:
        yaml.dump(yaml_data, f, allow_unicode=True, default_flow_style=False, sort_keys=False)

    print(f"\nDone. Updated {SOURCES_YAML}")
    print("Review the changes, then run: cd scripts && bash merge_sources.sh")


if __name__ == "__main__":
    main()

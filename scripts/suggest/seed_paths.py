#!/usr/bin/env python3
"""
Seeds `paths` field in data/sources.yaml from the original hardcoded URL→path mapping.

Run this once to bootstrap path assignments so the app works immediately.
Afterwards, run suggest_assignments.py (with ANTHROPIC_API_KEY) to get
AI-improved assignments that also cover currently unassigned sources.

Usage:
    python3 seed_paths.py
"""

import os
import yaml

SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
SOURCES_YAML = os.path.join(SCRIPT_DIR, "../../data/sources.yaml")

# URL → path IDs, recovered from the original hardcoded activism_path.dart
URL_PATHS = {
    "https://gong.hr/": ["vlast", "prava"],
    "https://parlametar.hr/": ["vlast"],
    "https://www.mozaikveza.hr/": ["vlast"],
    "https://www.detektorimovine.hr/": ["vlast"],
    "https://imamopravoznati.org/": ["vlast", "digitalno", "prava"],
    "https://www.sukobinteresa.hr/": ["vlast"],
    "https://lookerstudio.google.com/u/0/reporting/cab3e2df-5406-4b30-aa84-244d60361a88/page/ssaoD": ["vlast"],
    "https://docs.google.com/spreadsheets/d/1wo_D2bJji_Sbq_tmuvOIlzbSst7Mbl5_TjoB769xVLI/edit?gid=0": ["vlast"],
    "https://izbornisimulator.azurewebsites.net/": ["vlast"],
    "https://www.portal-ostro.hr/": ["vlast"],
    "https://gong.hr/2026/02/24/prijavi-se-na-prvu-gongovu-skolu-za-lokalne-aktiviste-u-sibeniku/": ["vlast"],
    "https://www.zelena-akcija.hr/hr": ["okolis", "prava"],
    "https://zelena-akcija.hr/hr/vijesti/predstavljena-nova-aplikacija-pametni-zeleni-telefon": ["okolis"],
    "https://sindikatbiciklista.hr/": ["okolis"],
    "https://bajs.informacija.hr/": ["okolis", "grad"],
    "https://bajsanje.informacija.hr/": ["okolis"],
    "https://popravi.to/": ["grad"],
    "https://smart.zagreb.hr/": ["grad"],
    "https://geoportal.zagreb.hr/": ["grad"],
    "https://geohub-zagreb.hub.arcgis.com/": ["grad"],
    "https://zagreb.gdi.net/zg3d/": ["grad"],
    "https://zet-info.com/": ["grad"],
    "https://www.kartografija-otpora.org/hr/": ["grad", "prava"],
    "https://pmpc.hr/": ["digitalno"],
    "https://codeforcroatia.org/": ["digitalno"],
    "https://slobodnadomena.hr/": ["digitalno"],
    "https://opencode.hr/": ["digitalno"],
    "https://digital-strategy.ec.europa.eu/en/policies/regulatory-framework-ai": ["digitalno"],
    "https://myth-code.com/": ["digitalno"],
    "https://www.cms.hr/": ["prava"],
    "https://www.maz.hr/": ["prava"],
}


def main():
    with open(SOURCES_YAML) as f:
        data = yaml.safe_load(f)

    assigned = 0
    for entry in data["sources"]:
        url = entry.get("url", "")
        paths = URL_PATHS.get(url, [])
        entry["paths"] = paths
        if paths:
            assigned += 1
            print(f"  {url}")
            print(f"    → {paths}")

    with open(SOURCES_YAML, "w") as f:
        yaml.dump(data, f, allow_unicode=True, default_flow_style=False, sort_keys=False)

    total = len(data["sources"])
    print(f"\nDone. {assigned}/{total} sources assigned to paths.")
    print("Now run: cd .. && bash merge_sources.sh")


if __name__ == "__main__":
    main()

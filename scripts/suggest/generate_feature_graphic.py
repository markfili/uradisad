"""
Generates a 1024x500 Play Store feature graphic.
Run from project root:
  scripts/suggest/.venv/bin/python scripts/suggest/generate_feature_graphic.py
Output: screenshots/play_store/feature_graphic.png
"""

from PIL import Image, ImageDraw, ImageFont
import os

ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
ICON_PATH = os.path.join(ROOT, "assets", "icon", "icon.png")
OUT_PATH = os.path.join(ROOT, "screenshots", "play_store", "feature_graphic.png")

W, H = 1024, 500
BG_COLOR = (43, 75, 238)       # #2B4BEE
WHITE = (255, 255, 255)
WHITE_DIM = (200, 210, 255)    # slightly dimmed white for tagline

img = Image.new("RGB", (W, H), BG_COLOR)
draw = ImageDraw.Draw(img)

# --- Icon ---
icon_size = 280
icon = Image.open(ICON_PATH).convert("RGBA")
icon = icon.resize((icon_size, icon_size), Image.LANCZOS)
# Paste icon on left side, vertically centered
icon_x = 80
icon_y = (H - icon_size) // 2
# Composite onto RGB background
bg_patch = Image.new("RGB", (icon_size, icon_size), BG_COLOR)
bg_patch.paste(icon, mask=icon.split()[3])
img.paste(bg_patch, (icon_x, icon_y))

# --- Text ---
text_x = icon_x + icon_size + 60
text_y_title = H // 2 - 70

# Try to load a system font, fall back to default
def load_font(size, bold=False):
    candidates = [
        "/System/Library/Fonts/Helvetica.ttc",
        "/System/Library/Fonts/Arial.ttf",
        "/Library/Fonts/Arial.ttf",
    ]
    for path in candidates:
        if os.path.exists(path):
            try:
                return ImageFont.truetype(path, size)
            except Exception:
                pass
    return ImageFont.load_default()

font_title = load_font(90, bold=True)
font_tagline = load_font(36)

draw.text((text_x, text_y_title), "Uradi sad", font=font_title, fill=WHITE)
draw.text((text_x, text_y_title + 110), "Imenik hrvatskog aktivizma", font=font_tagline, fill=WHITE_DIM)

os.makedirs(os.path.dirname(OUT_PATH), exist_ok=True)
img.save(OUT_PATH, "PNG")
print(f"Saved: {OUT_PATH}")

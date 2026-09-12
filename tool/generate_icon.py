"""Draws the Courier app icon: an amber paper plane with speed lines on a
dark gradient, matching the app theme.

Writes to assets/icon/:
  icon.png             full-bleed icon (iOS, legacy Android)
  icon_foreground.png  plane only, transparent, sized for the adaptive-icon safe zone
  icon_background.png  gradient only (adaptive-icon background)

Usage: python3 tool/generate_icon.py
"""

import os

from PIL import Image, ImageDraw, ImageFilter

SS = 4096  # supersampled canvas, downscaled for anti-aliasing
OUT = 1024
OUT_DIR = os.path.join(os.path.dirname(__file__), '..', 'assets', 'icon')

BG_TOP = (46, 44, 40)
BG_BOTTOM = (18, 18, 18)
AMBER_LIGHT = (246, 196, 96)
AMBER = (229, 169, 58)
AMBER_DARK = (170, 116, 28)
GLOW = (229, 169, 58)

# Plane in unit coordinates, nose pointing up and to the right.
TIP = (0.80, 0.20)
TAIL = (0.16, 0.47)
FOLD = (0.45, 0.57)
BOTTOM = (0.57, 0.83)
FLAP = (0.47, 0.73)

SPEED_LINES = [  # (start, end), trailing behind the plane
    ((0.13, 0.66), (0.29, 0.60)),
    ((0.20, 0.79), (0.38, 0.70)),
    ((0.33, 0.89), (0.45, 0.83)),
]


def _glyph_bounds():
    points = [TIP, TAIL, FOLD, BOTTOM, FLAP] + [p for line in SPEED_LINES for p in line]
    xs, ys = [p[0] for p in points], [p[1] for p in points]
    return (min(xs) + max(xs)) / 2, (min(ys) + max(ys)) / 2


def _transform(scale):
    cx, cy = _glyph_bounds()

    def to_px(p):
        return ((0.5 + (p[0] - cx) * scale) * SS, (0.5 + (p[1] - cy) * scale) * SS)

    return to_px


def background(glow_radius=0.36):
    gradient = Image.linear_gradient('L').resize((SS * 2, SS * 2)).rotate(-45)
    offset = SS // 2
    mask = gradient.crop((offset, offset, offset + SS, offset + SS))
    img = Image.composite(Image.new('RGB', (SS, SS), BG_BOTTOM), Image.new('RGB', (SS, SS), BG_TOP), mask)

    glow_mask = Image.new('L', (SS, SS), 0)
    r = SS * glow_radius
    ImageDraw.Draw(glow_mask).ellipse((SS / 2 - r, SS / 2 - r, SS / 2 + r, SS / 2 + r), fill=48)
    glow_mask = glow_mask.filter(ImageFilter.GaussianBlur(SS * 0.09))
    return Image.composite(Image.new('RGB', (SS, SS), GLOW), img, glow_mask)


def glyph(scale):
    img = Image.new('RGBA', (SS, SS), (0, 0, 0, 0))
    draw = ImageDraw.Draw(img)
    px = _transform(scale)

    width = SS * 0.034 * scale / 0.78
    for alpha, (start, end) in zip((150, 210, 110), SPEED_LINES):
        a, b = px(start), px(end)
        color = AMBER + (alpha,)
        draw.line([a, b], fill=color, width=round(width))
        for x, y in (a, b):
            draw.ellipse((x - width / 2, y - width / 2, x + width / 2, y + width / 2), fill=color)

    draw.polygon([px(TIP), px(TAIL), px(FOLD)], fill=AMBER_LIGHT)
    draw.polygon([px(TIP), px(FOLD), px(BOTTOM)], fill=AMBER)
    draw.polygon([px(FOLD), px(FLAP), px(BOTTOM)], fill=AMBER_DARK)
    return img


def save(img, name):
    img.resize((OUT, OUT), Image.LANCZOS).save(os.path.join(OUT_DIR, name))


def main():
    os.makedirs(OUT_DIR, exist_ok=True)
    bg = background()

    full = bg.convert('RGBA')
    full.alpha_composite(glyph(scale=0.78))
    save(full.convert('RGB'), 'icon.png')

    # Adaptive icons crop to the middle ~66%, so the plane is drawn smaller.
    # flutter_launcher_icons insets the adaptive foreground by 16% per side,
    # which brings this down to the safe zone. The launcher also zooms the
    # background, so its glow is kept tighter.
    save(glyph(scale=0.74), 'icon_foreground.png')
    save(background(glow_radius=0.22), 'icon_background.png')


if __name__ == '__main__':
    main()

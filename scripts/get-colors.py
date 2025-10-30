#!/usr/bin/env python3

import argparse
import math
import json
from PIL import Image
from materialyoucolor.quantize import QuantizeCelebi
from materialyoucolor.score.score import Score
from materialyoucolor.hct import Hct
from materialyoucolor.dynamiccolor.material_dynamic_colors import MaterialDynamicColors
from materialyoucolor.utils.color_utils import rgba_from_argb, argb_from_rgb
from materialyoucolor.utils.math_utils import (
    sanitize_degrees_double,
    difference_degrees,
    rotation_direction,
)


parser = argparse.ArgumentParser(description="Color generation script")
parser.add_argument(
    "--path",
    type=str,
    required=True,
    default=None,
    help="generate colorscheme from image",
)
parser.add_argument(
    "--material",
    type=str,
    default="materical-colors.json",
    help="Path to material-colors.json",
)
parser.add_argument(
    "--terminal",
    type=str,
    default="terminal-colors.json",
    help="Path to terminal-colors.json",
)
parser.add_argument(
    "--mode",
    type=str,
    choices=["dark", "light"],
    default="dark",
    help="dark or light mode",
)
parser.add_argument(
    "--scheme", type=str, default="scheme-neutral", help="material scheme to use"
)
parser.add_argument(
    "--termscheme",
    type=str,
    required=True,
    default=None,
    help="JSON file containg the terminal scheme for generating term colors",
)
parser.add_argument(
    "--harmony", type=float, default=0.8, help="(0-1) Color hue shift towards accent"
)
parser.add_argument(
    "--harmonize_threshold",
    type=float,
    default=100,
    help="(0-180) Max threshold angle to limit color hue shift",
)
parser.add_argument(
    "--term_fg_boost",
    type=float,
    default=0.35,
    help="Make terminal foreground more different from the background",
)
parser.add_argument(
    "--blend_bg_fg",
    action="store_true",
    default=False,
    help="Shift terminal background or foreground towards accent",
)

args = parser.parse_args()

rgba_to_hex = lambda rgba: "#{:02X}{:02X}{:02X}".format(rgba[0], rgba[1], rgba[2])
argb_to_hex = lambda argb: "#{:02X}{:02X}{:02X}".format(
    *map(round, rgba_from_argb(argb))
)
hex_to_argb = lambda hex_code: argb_from_rgb(
    int(hex_code[1:3], 16), int(hex_code[3:5], 16), int(hex_code[5:], 16)
)
display_color = lambda rgba: "\x1b[38;2;{};{};{}m{}\x1b[0m".format(
    rgba[0], rgba[1], rgba[2], "\x1b[7m   \x1b[7m"
)


def calculate_optimal_size(width: int, height: int, bitmap_size: int):
    image_area = width * height
    bitmap_area = bitmap_size**2
    scale = math.sqrt(bitmap_area / image_area) if image_area > bitmap_area else 1
    new_width = round(width * scale)
    new_height = round(height * scale)
    if new_width == 0:
        new_width = 1
    if new_height == 0:
        new_height = 1
    return new_width, new_height


def harmonize(
    design_color: int, source_color: int, threshold: float = 35, harmony: float = 0.5
) -> int:
    from_hct = Hct.from_int(design_color)
    to_hct = Hct.from_int(source_color)
    difference_degrees_ = difference_degrees(from_hct.hue, to_hct.hue)
    rotation_degrees = min(difference_degrees_ * harmony, threshold)
    output_hue = sanitize_degrees_double(
        from_hct.hue + rotation_degrees * rotation_direction(from_hct.hue, to_hct.hue)
    )
    return Hct.from_hct(output_hue, from_hct.chroma, from_hct.tone).to_int()


def boost_chroma_tone(argb: int, chroma: float = 1, tone: float = 1) -> int:
    hct = Hct.from_int(argb)
    return Hct.from_hct(hct.hue, hct.chroma * chroma, hct.tone * tone).to_int()


darkmode = args.mode == "dark"
image = Image.open(args.path)
if image.format == "GIF":
    image.seek(1)
if image.mode in ["L", "P"]:
    image = image.convert("RGB")
wsize, hsize = image.size
wsize_new, hsize_new = calculate_optimal_size(wsize, hsize, 128)
if wsize_new < wsize or hsize_new < hsize:
    image = image.resize((wsize_new, hsize_new), Image.Resampling.BICUBIC)
colors = QuantizeCelebi(list(image.getdata()), 128)
argb = Score.score(colors)[0]
hct = Hct.from_int(argb)

if args.scheme == "scheme-fruit-salad":
    from materialyoucolor.scheme.scheme_fruit_salad import SchemeFruitSalad as Scheme
elif args.scheme == "scheme-expressive":
    from materialyoucolor.scheme.scheme_expressive import SchemeExpressive as Scheme
elif args.scheme == "scheme-monochrome":
    from materialyoucolor.scheme.scheme_monochrome import SchemeMonochrome as Scheme
elif args.scheme == "scheme-rainbow":
    from materialyoucolor.scheme.scheme_rainbow import SchemeRainbow as Scheme
elif args.scheme == "scheme-tonal-spot":
    from materialyoucolor.scheme.scheme_tonal_spot import SchemeTonalSpot as Scheme
elif args.scheme == "scheme-neutral":
    from materialyoucolor.scheme.scheme_neutral import SchemeNeutral as Scheme
elif args.scheme == "scheme-fidelity":
    from materialyoucolor.scheme.scheme_fidelity import SchemeFidelity as Scheme
elif args.scheme == "scheme-content":
    from materialyoucolor.scheme.scheme_content import SchemeContent as Scheme
elif args.scheme == "scheme-vibrant":
    from materialyoucolor.scheme.scheme_vibrant import SchemeVibrant as Scheme
else:
    from materialyoucolor.scheme.scheme_tonal_spot import SchemeTonalSpot as Scheme
# Generate
scheme = Scheme(hct, darkmode, 0.0)

material_colors = {}

for color in vars(MaterialDynamicColors).keys():
    color_name = getattr(MaterialDynamicColors, color)
    if hasattr(color_name, "get_hct"):
        rgba = color_name.get_hct(scheme).to_rgba()
        material_colors[color] = rgba_to_hex(rgba)

# Extended material
if darkmode == True:
    material_colors["success"] = "#B5CCBA"
    material_colors["onSuccess"] = "#213528"
    material_colors["successContainer"] = "#374B3E"
    material_colors["onSuccessContainer"] = "#D1E9D6"
else:
    material_colors["success"] = "#4F6354"
    material_colors["onSuccess"] = "#FFFFFF"
    material_colors["successContainer"] = "#D1E8D5"
    material_colors["onSuccessContainer"] = "#0C1F13"

# Extended terminal colors

term_colors = {
    "background": material_colors["surface"],
    "foreground": material_colors["onSurface"],
    "cursor": material_colors["primary"],
    "cursor_text_color": material_colors["onPrimary"],
    "selection_background": material_colors["primaryContainer"],
    "selection_foreground": material_colors["onPrimaryContainer"],
    "active_tab_background": material_colors["surfaceVariant"],
    "inactive_tab_background": material_colors["surface"],
    "active_tab_foreground": material_colors["onSurface"],
    "inactive_tab_foreground": material_colors["onSurfaceVariant"],
    "url_color": material_colors["primary"],
}

# Terminal Colors
if args.termscheme is not None:
    with open(args.termscheme, "r") as f:
        json_termscheme = f.read()
    term_source_colors = json.loads(json_termscheme)["dark" if darkmode else "light"]

    primary_color_argb = hex_to_argb(material_colors["primary_paletteKeyColor"])
    for color, val in term_source_colors.items():
        if args.scheme == "monochrome":
            term_colors[color] = val
            continue
        if args.blend_bg_fg and color == "term0":
            harmonized = boost_chroma_tone(
                hex_to_argb(material_colors["surfaceContainerLow"]), 1.2, 0.95
            )
        elif args.blend_bg_fg and color == "term15":
            harmonized = boost_chroma_tone(
                hex_to_argb(material_colors["onSurface"]), 3, 1
            )
        else:
            harmonized = harmonize(
                hex_to_argb(val),
                primary_color_argb,
                args.harmonize_threshold,
                args.harmony,
            )
            harmonized = boost_chroma_tone(
                harmonized, 1, 1 + (args.term_fg_boost * (1 if darkmode else -1))
            )
        term_colors[color] = argb_to_hex(harmonized)

# write to files
with open(args.material, "w") as f:
    json.dump(material_colors, f, indent=2)

with open(args.terminal, "w") as f:
    json.dump(term_colors, f, indent=2)

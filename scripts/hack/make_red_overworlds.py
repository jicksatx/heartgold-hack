#!/usr/bin/env python3
"""
hack: overworld sprites for Red, the Part 1 player (data/graphics/overworlds/custom/).

- walking/running: HeartGold's own Red NPC frames (0170), laid out like the player's walk+run sheet (0069); the
  run frames reuse the walk frames since the NPC has no running poses
- every other player state (bike, surf, HM, watering, fishing, ladder, Pokegear, save, heal): Ethan's sheets
  recolored to Red's colors (red/white cap, brown hair, blue jeans)

texture/palette names and dictionary values are copied from Ethan's json files so the game finds everything the
same way.  run from the repo root:  python3 scripts/hack/make_red_overworlds.py
"""
import json
import os
from PIL import Image

OW = "data/graphics/overworlds"
OUT = OW + "/custom"

# (output id, Ethan's sheet) - output ids become NEW_NPC_ENTRY 0..n in src/field/overworld_table.c
RECOLORED = [(1, "0071"), (2, "0073"), (3, "0075"), (4, "0077"), (5, "0079"), (6, "0081"), (7, "0085"), (8, "0087"), (9, "0089")]

# Ethan's colors (from his walking palette) -> Red's
ROLE_COLORS = {
    (255, 180, 32): (246, 106, 74),   # cap (yellow -> red)
    (189, 115, 32): (197, 57, 57),    # cap shade
    (74, 98, 98): (238, 238, 255),    # cap black -> white front
    (41, 41, 57): (82, 49, 24),       # hair
    (156, 148, 180): (65, 106, 139),  # shorts -> jeans
    (148, 139, 172): (49, 82, 115),
    (189, 180, 213): (98, 139, 172),
}


def read_pal(path):
    lines = open(path).read().split()
    n = int(lines[2])
    return [tuple(int(v) for v in lines[3 + i * 3: 6 + i * 3]) for i in range(n)]


def write_pal(path, cols):
    with open(path, "w", newline="\r\n") as f:
        f.write("JASC-PAL\n0100\n%d\n" % len(cols))
        for c in cols:
            f.write("%d %d %d\n" % c)


def pal_file(g):
    return [f for f in os.listdir(OW) if f.startswith(g + "-") and f.endswith(".pal")][0]


def close(a, b):
    return sum(abs(x - y) for x, y in zip(a, b)) <= 12


os.makedirs(OUT, exist_ok=True)

# --- walking / running
hero_json = json.load(open(f"{OW}/0069.json"))
red_json = json.load(open(f"{OW}/0170.json"))
red_png = Image.open(f"{OW}/0170.png")
red_frame = {int(k.split(".")[1]): v["frame"] for k, v in red_json["frames"].items()}
frame_src = {}
for name, v in hero_json["frames"].items():
    n = int(name.split(".")[1])
    src = red_frame[n if n <= 16 else n - 16]
    if frame_src.setdefault(v["frame"], src) != src:
        raise SystemExit(f"frame {v['frame']} needed for two different Red frames")
count = max(frame_src) + 1
sheet = Image.new("P", (32, 32 * count), 0)
sheet.putpalette(red_png.getpalette())
for f, src in frame_src.items():
    sheet.paste(red_png.crop((0, src * 32, 32, src * 32 + 32)), (0, f * 32))
sheet.save(f"{OUT}/0000.png")
json.dump(hero_json, open(f"{OUT}/0000.json", "w"), indent="\t")
write_pal(f"{OUT}/0000-{list(hero_json['palettes'])[0]}.pal", read_pal(f"{OW}/{pal_file('0170')}"))

# --- everything else: Ethan recolored
for out_id, g in RECOLORED:
    src_pal = read_pal(f"{OW}/{pal_file(g)}")
    new_pal = []
    for c in src_pal:
        for k, v in ROLE_COLORS.items():
            if close(c, k):
                c = v
                break
        new_pal.append(c)
    png = Image.open(f"{OW}/{g}.png")
    flat = []
    for c in new_pal:
        flat += list(c)
    png.putpalette(flat + [0] * (768 - len(flat)))
    png.save(f"{OUT}/{out_id:04d}.png")
    j = json.load(open(f"{OW}/{g}.json"))
    json.dump(j, open(f"{OUT}/{out_id:04d}.json", "w"), indent="\t")
    write_pal(f"{OUT}/{out_id:04d}-{list(j['palettes'])[0]}.pal", new_pal)  # the btx tool looks for <id>-<palette name>.pal

print("wrote", 1 + len(RECOLORED), "sheets to", OUT)

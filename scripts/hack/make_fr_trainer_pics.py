#!/usr/bin/env python3
"""
hack: HeartGold trainer pics for FireRed trainers HeartGold doesn't have (Part 1's Elite Four Lorelei and Agatha),
plus copies of Blue's and Lance's pics for Part 1's Champion Blue (140) and Elite Four Lance (141), and of
Giovanni's for Part 1's Leader Giovanni (142).

takes pokefirered's 64x64 front pic + palette, centers it at the bottom of HeartGold's 80x80 frame and writes
data/graphics/trainer_gfx/<class>.png (tiles laid out in the order of the cell's OAMs, 3 identical frames) and
<class>_enc.png (2 identical 80x80 frames side by side), reusing class 110's (Leader Blue) cell/anim/key files.

usage: python3 scripts/hack/make_fr_trainer_pics.py [path to pokefirered checkout]
"""
import json
import shutil
import sys

from PIL import Image

PFR = sys.argv[1] if len(sys.argv) > 1 else "../pfr"
OUT = "data/graphics/trainer_gfx"
PICS = {138: "elite_four_lorelei", 139: "elite_four_agatha"}
TEMPLATE = 110
SHAPES = {(0, 0): (8, 8), (0, 1): (16, 16), (0, 2): (32, 32), (0, 3): (64, 64), (1, 0): (16, 8), (1, 1): (32, 8),
          (1, 2): (32, 16), (1, 3): (64, 32), (2, 0): (8, 16), (2, 1): (8, 32), (2, 2): (16, 32), (2, 3): (32, 64)}


def read_pal(path):
    lines = open(path).read().split("\n")
    n = int(lines[2])
    return [int(c) for line in lines[3:3 + n] for c in line.split()]


def main():
    cell = json.load(open(f"{OUT}/{TEMPLATE:03d}_cell.json", encoding="latin-1"))["cells"][0]
    for cls, name in PICS.items():
        src = Image.open(f"{PFR}/graphics/trainers/front_pics/{name}_front_pic.png")
        pal = read_pal(f"{PFR}/graphics/trainers/palettes/{name}.pal")
        frame = Image.new("P", (80, 80), 0)
        frame.putpalette(pal)
        frame.paste(src, (8, 16))
        # tiles in OAM order (1D mapping, 2 tiles per char unit), 10 tiles per png row
        tiles = []
        for o in cell["OAM"]:
            w, h = SHAPES[(o["Attr0"]["Shape"], o["Attr1"]["Size"])]
            x0, y0 = o["Attr1"]["XCoordinate"] + 40, o["Attr0"]["YCoordinate"] + 40
            assert o["Attr2"]["CharName"] * 2 == len(tiles)
            for ty in range(h // 8):
                for tx in range(w // 8):
                    tiles.append(frame.crop((x0 + tx * 8, y0 + ty * 8, x0 + tx * 8 + 8, y0 + ty * 8 + 8)))
        assert len(tiles) == 100
        sheet = Image.new("P", (80, 240), 0)
        sheet.putpalette(pal)
        for f in range(3):
            for i, t in enumerate(tiles):
                sheet.paste(t, ((i % 10) * 8, f * 80 + (i // 10) * 8))
        sheet.save(f"{OUT}/{cls:03d}.png")
        enc = Image.new("P", (160, 80), 0)
        enc.putpalette(pal)
        enc.paste(frame, (0, 0))
        enc.paste(frame, (80, 0))
        enc.save(f"{OUT}/{cls:03d}_enc.png")
        for ext in ("_cell.json", "_anim.json", "_enc.png.key"):
            shutil.copy(f"{OUT}/{TEMPLATE:03d}{ext}", f"{OUT}/{cls:03d}{ext}")
        print(f"{OUT}/{cls:03d}: {name}")
    # 140: Part 1's Champion Blue (class "Champion" with Blue's own pic)
    for ext in (".png", "_enc.png", "_cell.json", "_anim.json", "_enc.png.key"):
        shutil.copy(f"{OUT}/{TEMPLATE:03d}{ext}", f"{OUT}/140{ext}")
    print(f"{OUT}/140: Leader Blue's pic")
    # 141: Part 1's Elite Four Lance (class "Elite Four" with Champion Lance's pic)
    for ext in (".png", "_enc.png", "_cell.json", "_anim.json", "_enc.png.key"):
        shutil.copy(f"{OUT}/086{ext}", f"{OUT}/141{ext}")
    print(f"{OUT}/141: Lance's pic")
    # 142: Part 1's Leader Giovanni (class "Leader" with the Rocket Boss pic)
    for ext in (".png", "_enc.png", "_cell.json", "_anim.json", "_enc.png.key"):
        shutil.copy(f"{OUT}/124{ext}", f"{OUT}/142{ext}")
    print(f"{OUT}/142: Giovanni's pic")
    # 143: Part 1's Leader Koga (class "Leader" with Elite Four Koga's pic)
    for ext in (".png", "_enc.png", "_cell.json", "_anim.json", "_enc.png.key"):
        shutil.copy(f"{OUT}/089{ext}", f"{OUT}/143{ext}")
    print(f"{OUT}/143: Koga's pic")


if __name__ == "__main__":
    main()

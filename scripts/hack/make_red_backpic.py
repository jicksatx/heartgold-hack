#!/usr/bin/env python3
"""
hack: Red's battle back sprite for Part 1 (data/graphics/trainer_back_gfx/17.*): Ethan's back sprite (00) with his
cap recolored red and his hair brown.  the game picks it in src/chapter.c (Chapter_TrainerClassToBackpic).

run from the repo root:  python3 scripts/hack/make_red_backpic.py
"""
import shutil
from PIL import Image

D = "data/graphics/trainer_back_gfx"
SRC, DST = "00", "17"
RECOLOR = {6: (246, 106, 74), 9: (197, 57, 57), 5: (82, 49, 24)}  # cap, cap shade, hair (palette indices)

for suffix in ("_anim.json", "_cell.json", "_enc.png.key"):
    shutil.copyfile(f"{D}/{SRC}{suffix}", f"{D}/{DST}{suffix}")
for suffix in (".png", "_enc.png"):
    im = Image.open(f"{D}/{SRC}{suffix}")
    pal = im.getpalette()
    for i, c in RECOLOR.items():
        pal[i * 3:i * 3 + 3] = list(c)
    im.putpalette(pal)
    im.save(f"{D}/{DST}{suffix}")
print("wrote", D + "/" + DST + ".*")

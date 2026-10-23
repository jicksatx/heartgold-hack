"""Build the Glorious Gold title logo: erase HEARTGOLD + heart ornament, draw GLORIOUS GOLD in the same style."""
import sys
from PIL import Image, ImageDraw, ImageFont

sys.path.insert(0, 'scripts/hack/title_logo')
from nitro import read_ncgr, read_nclr, read_nscr

D = 'scripts/hack/title_logo/work/'
r = lambda i: open(D + f'{i:02d}.bin', 'rb').read()

FONT = sys.argv[1] if len(sys.argv) > 1 else '/usr/share/fonts/truetype/dejavu/DejaVuSerif-Bold.ttf'
SIZE = int(sys.argv[2]) if len(sys.argv) > 2 else 30
OUT = sys.argv[3] if len(sys.argv) > 3 else D + 'new_logo.png'
TARGETW = int(sys.argv[4]) if len(sys.argv) > 4 else 210
CAP = int(sys.argv[5]) if len(sys.argv) > 5 else 24

tiles, bpp, _, _ = read_ncgr(r(3))
cols, _ = read_nclr(r(4))
w, h, ents = read_nscr(r(0))

# index image
idx = [[0] * w for _ in range(h)]
for i, e in enumerate(ents):
    t, hf, vf = e & 0x3FF, (e >> 10) & 1, (e >> 11) & 1
    bx, by = (i % (w // 8)) * 8, (i // (w // 8)) * 8
    for y in range(8):
        for x in range(8):
            sx, sy = (7 - x if hf else x), (7 - y if vf else y)
            idx[by + y][bx + x] = tiles[t][sy * 8 + sx]

# colors used by the HEARTGOLD word (for quantizing the new word)
used = set()
for y in range(112, 146):
    for x in range(31, 206):
        if idx[y][x]:
            used.add(idx[y][x])


def nearest(rgb):
    best, bd = None, 1e9
    for i in used:
        c = cols[i]
        d = (c[0] - rgb[0]) ** 2 * 3 + (c[1] - rgb[1]) ** 2 * 4 + (c[2] - rgb[2]) ** 2 * 2
        if d < bd:
            best, bd = i, d
    return best


# erase word + ornament, keep VERSION (x 66..180, y >= 145) and the Pokemon logo/TM
for y in range(110, 162):
    for x in range(w):
        keep_version = 66 <= x <= 180 and y >= 145
        if not keep_version:
            idx[y][x] = 0
for y in range(100, 110):
    for x in range(218, w):
        idx[y][x] = 0
for x in range(138, 154):
    idx[109][x] = 0

# glyph mask
text = 'GLORIOUS GOLD'
font = ImageFont.truetype(FONT, SIZE)
big = Image.new('L', (600, 120), 0)
ImageDraw.Draw(big).text((10, 10), text, font=font, fill=255)
bbox = big.getbbox()
big = big.crop(bbox)
nw = TARGETW
cap = CAP
big = big.resize((nw, cap), Image.LANCZOS)
mask = [[big.getpixel((x, y)) >= 110 for x in range(big.width)] for y in range(big.height)]
gw, gh = big.width, big.height
print('glyph size', gw, gh)

top = 116
left = (256 - gw) // 2 - 2


def M(x, y):
    return 0 <= x < gw and 0 <= y < gh and mask[y][x]


def dist(x, y, rmax):
    for rr in range(1, rmax + 1):
        for dy in range(-rr, rr + 1):
            for dx in range(-rr, rr + 1):
                if max(abs(dx), abs(dy)) == rr and M(x + dx, y + dy):
                    return rr
    return 99


# vertical gradient for the fill (sampled from the original letters)
grad = [(112, 16, 24), (152, 40, 40), (168, 48, 40), (192, 56, 48), (208, 64, 56), (240, 96, 56), (240, 96, 56),
        (240, 112, 56), (240, 136, 48), (240, 136, 48), (240, 152, 32), (248, 160, 24), (248, 160, 24), (240, 152, 32),
        (240, 136, 48), (240, 112, 56), (240, 96, 56), (208, 64, 56), (192, 56, 48), (192, 56, 48), (168, 48, 40),
        (168, 48, 40), (152, 40, 40), (128, 24, 24), (112, 16, 24), (112, 16, 24)]

pix = {}
for y in range(-3, gh + 3):
    for x in range(-3, gw + 3):
        if M(x, y):
            # edge darkening on the inside border
            edge = not (M(x - 1, y) and M(x + 1, y) and M(x, y - 1) and M(x, y + 1))
            c = grad[min(len(grad) - 1, max(0, y * len(grad) // gh))]
            if edge:
                c = (max(0, c[0] - 40), max(0, c[1] - 30), max(0, c[2] - 10))
            pix[(x, y)] = c
        else:
            d = dist(x, y, 2)
            if d == 1:
                # gold rim, lighter on the top/left, darker bottom/right
                if M(x + 1, y + 1) or M(x, y + 1) or M(x + 1, y):
                    pix[(x, y)] = (232, 200, 88)
                else:
                    pix[(x, y)] = (184, 120, 24)
            elif d == 2:
                pix[(x, y)] = (96, 56, 32)

for (x, y), c in pix.items():
    X, Y = left + x, top + y
    if 0 <= X < w and 0 <= Y < h:
        idx[Y][X] = nearest(c)

img = Image.new('RGB', (w, h))
p = img.load()
for y in range(h):
    for x in range(w):
        p[x, y] = cols[idx[y][x]]
img.save(OUT)
img.crop((0, 30, 256, 170)).resize((256 * 3, 140 * 3), Image.NEAREST).save(OUT.replace('.png', '_zoom.png'))

import pickle
pickle.dump(idx, open(D + 'new_idx.pkl', 'wb'))

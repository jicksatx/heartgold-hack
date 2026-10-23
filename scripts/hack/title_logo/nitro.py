import struct
from PIL import Image


def section(data):
    return 0x10  # first section offset


def read_nclr(d):
    o = 0x10
    bitdepth = struct.unpack_from('<I', d, o + 8)[0]
    size = struct.unpack_from('<I', d, o + 0x10)[0]
    off = struct.unpack_from('<I', d, o + 0x14)[0]
    raw = d[o + 8 + off: o + 8 + off + size]
    cols = []
    for i in range(0, len(raw), 2):
        v = struct.unpack_from('<H', raw, i)[0]
        cols.append(((v & 31) << 3, ((v >> 5) & 31) << 3, ((v >> 10) & 31) << 3))
    return cols, bitdepth


def read_ncgr(d):
    o = 0x10
    ty, tx, bd = struct.unpack_from('<HHI', d, o + 8)
    size = struct.unpack_from('<I', d, o + 0x18)[0]
    off = struct.unpack_from('<I', d, o + 0x1C)[0]
    raw = d[o + 8 + off: o + 8 + off + size]
    bpp = 4 if bd == 3 else 8
    tsize = 32 if bpp == 4 else 64
    tiles = []
    for t in range(len(raw) // tsize):
        b = raw[t * tsize:(t + 1) * tsize]
        px = []
        if bpp == 4:
            for c in b:
                px += [c & 15, c >> 4]
        else:
            px = list(b)
        tiles.append(px)
    return tiles, bpp, (ty, tx), o + 8 + off


def read_nscr(d):
    o = 0x10
    w, h = struct.unpack_from('<HH', d, o + 8)
    size = struct.unpack_from('<I', d, o + 0x10)[0]
    raw = d[o + 0x14:o + 0x14 + size]
    ents = [struct.unpack_from('<H', raw, i)[0] for i in range(0, len(raw), 2)]
    return w, h, ents


def render(ncgr, nclr, nscr, out):
    tiles, bpp, _, _ = read_ncgr(ncgr)
    cols, _ = read_nclr(nclr)
    w, h, ents = read_nscr(nscr)
    img = Image.new('RGB', (w, h))
    pix = img.load()
    tw = w // 8
    for i, e in enumerate(ents):
        t = e & 0x3FF
        hf = (e >> 10) & 1
        vf = (e >> 11) & 1
        pal = e >> 12
        if t >= len(tiles):
            continue
        tile = tiles[t]
        bx, by = (i % tw) * 8, (i // tw) * 8
        for y in range(8):
            for x in range(8):
                sx = 7 - x if hf else x
                sy = 7 - y if vf else y
                c = tile[sy * 8 + sx]
                idx = c + (pal * 16 if bpp == 4 else 0)
                pix[bx + x, by + y] = cols[idx] if idx < len(cols) else (255, 0, 255)
    img.save(out)
    return img

import sys, pickle, struct
sys.path.insert(0, 'scripts/hack/title_logo')
from nitro import read_ncgr, read_nscr
D = 'scripts/hack/title_logo/work/'
idx = pickle.load(open(D + 'new_idx.pkl', 'rb'))
ncgr = bytearray(open(D + '03.bin', 'rb').read())
nscr = bytearray(open(D + '00.bin', 'rb').read())
tiles, bpp, (ty, tx), dataoff = read_ncgr(ncgr)
w, h, ents = read_nscr(nscr)
pals = set(e >> 12 for e in ents)
print('orig tiles', len(tiles), 'pal fields', pals, 'tiles dims', ty, tx)
pal = ents[0] >> 12
newtiles = []
lookup = {}
newents = []
for ti in range(len(ents)):
    bx, by = (ti % (w // 8)) * 8, (ti // (w // 8)) * 8
    t = tuple(idx[by + y][bx + x] for y in range(8) for x in range(8))
    found = None
    for hf in (0, 1):
        for vf in (0, 1):
            v = tuple(t[(7 - y if vf else y) * 8 + (7 - x if hf else x)] for y in range(8) for x in range(8))
            if v in lookup:
                found = (lookup[v], hf, vf)
                break
        if found:
            break
    if not found:
        lookup[t] = len(newtiles)
        newtiles.append(t)
        found = (lookup[t], 0, 0)
    n, hf, vf = found
    newents.append(n | (hf << 10) | (vf << 11) | (pal << 12))
print('new tiles', len(newtiles))
assert len(newtiles) <= len(tiles)
while len(newtiles) < len(tiles):
    newtiles.append(tuple([0] * 64))
raw = bytes(b for t in newtiles for b in t)
ncgr[dataoff:dataoff + len(raw)] = raw
o = 0x10 + 0x14
for i, e in enumerate(newents):
    struct.pack_into('<H', nscr, o + i * 2, e)
open(D + 'new_03.bin', 'wb').write(ncgr)
open(D + 'new_00.bin', 'wb').write(nscr)
# verify by re-rendering
from nitro import render
render(bytes(ncgr), open(D + '04.bin', 'rb').read(), bytes(nscr), D + 'roundtrip.png')

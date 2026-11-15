"""hack (Build 77): the Options menu's TEXT SPEED (row 0) and BATTLE STYLE (row 2) rows are unused, so their choice
boxes are painted over with the plain row background in a/0/7/2 member 17 (main BG2 tilemap).  Idempotent."""
import struct, sys
import ndspy.narc

path = sys.argv[1]
narc = ndspy.narc.NARC.fromFile(path)
d = bytearray(narc.files[17])
o = d.find(b'NRCS')
w = struct.unpack_from('<H', d, o + 8)[0] // 8
base = o + 0x14
def tile(x, y):
    return struct.unpack_from('<H', d, base + 2 * (y * w + x))[0]
def put(x, y, v):
    struct.pack_into('<H', d, base + 2 * (y * w + x), v)
for rows in ((3, 4, 5), (9, 10, 11)):
    for y in rows:
        plain = tile(5, y)          # the label column's plain fill for this line of the row
        for x in range(14, 31):     # the three/two choice boxes; x 13 (label edge) and x 31 (row edge) stay
            put(x, y, plain)
narc.files[17] = bytes(d)
narc.saveToFile(path)
print('options_bg: rows 0 and 2 cleared')

#!/usr/bin/env python3
"""
hack: Part 1's Trainer Card shows Kanto's Gym Leaders.  writes the Trainer Card NARC (a/0/4/9) with one extra member,
78: HeartGold's 16-leader badge case (member 52) with its Johto band (rows 2-12) left empty, so only the Kanto Gym
Leaders show.  in Part 1 src/chapter_gfx.c reads member 78 in place of 52.

usage: python3 scripts/hack/make_kanto_trainer_card.py <a/0/4/9 in> <narc out>
(idempotent: the input may already have member 78; it is rebuilt from 51/52)
"""
import struct
import sys
import ndspy.narc

KANTO_MEMBER = 78
src, out = sys.argv[1], sys.argv[2]
narc = ndspy.narc.NARC(open(src, 'rb').read())
files = list(narc.files[:KANTO_MEMBER])
assert len(files) == KANTO_MEMBER, len(files)


def tilemap(data):
    i = data.find(b'NRCS')
    return i + 0x14


layout = bytearray(files[52])
m = tilemap(layout)
for row in range(2, 13):
    layout[m + row * 64:m + (row + 1) * 64] = bytes(64)
files.append(bytes(layout))
narc.files = files
open(out, 'wb').write(narc.save())
print('trainer card: member', KANTO_MEMBER, '= Kanto-only badge case')

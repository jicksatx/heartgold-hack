#!/usr/bin/env python3
"""hack: rename the game in the DS menu banner (all languages) and fix the banner CRC.

usage: python3 scripts/hack/patch_banner.py test.nds
"""
import struct
import sys

TITLE = "Pokémon Glorious Gold\nNintendo"


def crc16(data):
    crc = 0xFFFF
    for b in data:
        crc ^= b
        for _ in range(8):
            crc = (crc >> 1) ^ 0xA001 if crc & 1 else crc >> 1
    return crc


path = sys.argv[1]
rom = bytearray(open(path, 'rb').read())
banner = struct.unpack_from('<I', rom, 0x68)[0]
version = struct.unpack_from('<H', rom, banner)[0]
text = TITLE.encode('utf-16le').ljust(0x100, b'\x00')
for lang in range(6):
    o = banner + 0x240 + lang * 0x100
    rom[o:o + 0x100] = text
struct.pack_into('<H', rom, banner + 2, crc16(rom[banner + 0x20:banner + 0x840]))
if version >= 2:
    struct.pack_into('<H', rom, banner + 4, crc16(rom[banner + 0x20:banner + 0x940]))
if version >= 3:
    struct.pack_into('<H', rom, banner + 6, crc16(rom[banner + 0x20:banner + 0xA40]))
open(path, 'wb').write(rom)
print(f"banner title set to {TITLE!r}")

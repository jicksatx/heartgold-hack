#!/usr/bin/env python3
"""
hack (slots/): make Metrowerks (mwccarm) ELF objects link correctly with GNU ld.

  python3 mwobj_fix.py OBJ...         fix compiled slot-machine objects (in place)
  python3 mwobj_fix.py --syms OBJ     fix the assembled HeartGold symbol object (hgss_syms.s)

mwcc marks a Thumb function only with a "$t" mapping symbol, writes RELA relocations and leaves a BL's offset bits
empty; GNU ld wants STT_ARM_TFUNC for Thumb functions and reads a Thumb BL's addend from the instruction.
"""
import struct
import sys


def sections(b):
    shoff, = struct.unpack_from('<I', b, 0x20)
    shentsize, shnum, _ = struct.unpack_from('<HHH', b, 0x2E)
    return [struct.unpack_from('<IIIIIIIIII', b, shoff + i * shentsize) for i in range(shnum)]


def symbols(b, secs):
    for s in secs:
        if s[1] != 2:  # SHT_SYMTAB
            continue
        stro = secs[s[6]][4]
        for i in range(s[5] // s[9]):
            o = s[4] + i * s[9]
            st_name, st_value, _, st_info, _, st_shndx = struct.unpack_from('<IIIBBH', b, o)
            end = b.index(0, stro + st_name)
            yield o, b[stro + st_name:end].decode(), st_value, st_info, st_shndx


def fix_object(path):
    b = bytearray(open(path, 'rb').read())
    secs = sections(b)
    syms = list(symbols(b, secs))
    thumb = {(ndx, val) for _, name, val, _, ndx in syms if name == '$t'}
    # 1. Thumb functions -> STT_ARM_TFUNC
    for o, name, val, info, ndx in syms:
        if info & 0xF == 2 and name not in ('$t', '$a', '$d') and (ndx, val) in thumb:
            b[o + 12] = (info & 0xF0) | 13
    # 2. R_ARM_THM_CALL: put the -4 PC bias in the BL instruction itself
    for s in secs:
        if s[1] != 4:  # SHT_RELA
            continue
        target = secs[s[7]]
        for i in range(s[5] // 12):
            r_off, r_info, _ = struct.unpack_from('<IIi', b, s[4] + i * 12)
            if r_info & 0xFF == 10:
                struct.pack_into('<HH', b, target[4] + r_off, 0xF7FF, 0xFFFE)
    open(path, 'wb').write(b)


def fix_syms_object(path, flags=0x02100000):
    """the gas-built symbol object: mwcc's EABI flags, Thumb functions as STT_ARM_TFUNC with even addresses"""
    b = bytearray(open(path, 'rb').read())
    struct.pack_into('<I', b, 0x24, flags)
    for o, _, val, info, _ in symbols(b, sections(b)):
        if info & 0xF == 2 and val & 1:
            struct.pack_into('<I', b, o + 4, val & ~1)
            b[o + 12] = (info & 0xF0) | 13
    open(path, 'wb').write(b)


if __name__ == '__main__':
    if sys.argv[1] == '--syms':
        fix_syms_object(sys.argv[2])
    else:
        for p in sys.argv[1:]:
            fix_object(p)

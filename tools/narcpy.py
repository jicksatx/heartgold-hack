import sys
import os
import struct
import ndspy.narc


def format_int(val, narc_len):
    length = len(str(val))
    return '0'*(len(str(narc_len-1))-length) + str(val)


args = sys.argv[1:]

if args[0] == 'extract':
    narc = ndspy.narc.NARC.fromFile(args[1])
    if args[2] == '-o':
        if not os.path.isdir(args[3]):
            os.makedirs(args[3])
        for idx in range(len(narc.files)):
            name = os.path.join(args[3], '%s_%s' % (os.path.basename(args[1]), format_int(idx, len(narc.files))))
            data = narc.files[idx]
            with open(name, 'wb') as out:
                out.write(data)
elif args[0] == 'create':
    files = []
    for v in range(len(os.listdir(args[2]))):
        files.append(None)

    idx = 0
    # members are named <narc>_<index><rest> (2_0965, 4_212.NCLR, 8_346_sun-00.NCGR, 1_0000.btx0 / 2_0000.btx0 / 3_0000.btx0).
    # sort by the text before the first '_', then the index as a number (so 2_1000 comes after 2_999 and 2_965 meets
    # 2_0965), then the rest of the name: the same order as a plain name sort whenever the padding is consistent.
    # (Build 75: the Build 73 key read the index after the LAST '_', which put 8_348.NCER before the 8_346_sun pair in
    # the battle graphics narc, so the weather icon's cell bank was a palette and melonDS aborted in any weather battle.)
    import re
    member_re = re.compile(r'^([^_]*)_(\d+)(.*)$')
    def member_key(entry):
        m = member_re.match(entry)
        if not m:
            return (entry, -1, '')
        return (m.group(1) + '_', int(m.group(2)), m.group(3))

    # the same member can be there twice under different zero padding (2_965 from the build, 2_0965 extracted once
    # the narc passed 1000 members): keep the newest file for each key
    newest = {}
    for entry in os.listdir(args[2]):
        key = member_key(entry)
        path = os.path.join(args[2], entry)
        if key not in newest or os.path.getmtime(path) >= os.path.getmtime(newest[key][1]):
            newest[key] = (key, path)
    files = []
    for key, path in sorted(newest.values()):
        with open(path, 'rb') as f:
            files.append(f.read())

    narc = ndspy.narc.NARC.fromFilesAndNames(files=files)
    narc.endiannessOfBeginning = '>'
    narc.saveToFile(args[1])

    narcfile = open(args[1], 'rb+')
    narcbytes = bytearray(narcfile.read())
    narcfile.close()
    
    FNTB_offset = narcbytes.find("BTNF".encode())
    
    #narcbytes[8] = narcbytes[8] - 4
    dataoffset = struct.unpack_from("<I", narcbytes[8:12])[0] - 4
    data = (dataoffset.to_bytes(4, 'little'))
    narcbytes[8:12] = data
    
    narcbytes[FNTB_offset+4] = 0x10;
    narcbytes[FNTB_offset+8] = 0x4;
    del narcbytes[FNTB_offset+0x10:FNTB_offset+0x14]
    
    # filler bytes are 0xFF in heart gold narcs
    fileOffset = FNTB_offset + 0x18 # assume empty FNTB
    for i in range(0x1C, FNTB_offset, 8):
        currSize = struct.unpack_from("<I", narcbytes[i+4:i+8])[0]
        currMargin = currSize % 4
        if ((currMargin) != 0):
            for j in range(0, 4-currMargin):
                narcbytes[fileOffset + currSize + j] = 0xFF

    narcfile = open(args[1], 'wb')
    narcfile.write(narcbytes)
    narcfile.close()

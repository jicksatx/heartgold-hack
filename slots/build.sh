#!/bin/sh
# hack: builds Platinum's slot machine for HeartGold -> slots/slots.bin (overlay 152, loaded at 0x021E5900 like
# Voltorb Flip).  The normal hg-engine build only includes the prebuilt slots/slots.bin (src/slotmachine/), so this is
# needed only after changing slots/src or slots/include.
#
# Needs (paths through the environment):
#   PLAT  a pret/pokeplatinum checkout that has been configured (make configure) and has its generated headers
#         built (ninja in $PLAT/build on the generated/*.h targets); the slot code uses its headers
#   SDK   a NitroSDK-4.2.30001 + NitroSystem-071126.1 subprojects folder (pokeheartgold or pokeplatinum)
#   SDKGEN  folder holding the generated nitro/fx/fx_const.h (a configured decomp's build/.../NitroSDK-4.2.30001/gen)
#   MWCC  mwccarm (metroskrew's Windows build run through wibo works on Linux: wibo mwccarm.exe "$@")
#   ARM   arm-none-eabi binutils prefix (default arm-none-eabi-)
# slots/hgss_syms.s holds HeartGold's addresses for everything the slot code calls; it was generated from a matching
# pret/pokeheartgold build's main.nef with tools/gen_hgss_syms.py.
set -e
cd "$(dirname "$0")"
ARM=${ARM:-arm-none-eabi-}
OUT=build
rm -rf $OUT && mkdir -p $OUT
FLAGS="-wrap:sdk 2.0/sp2p2 -gccinc -O4,p -proc arm946e -enum int -Cpp_exceptions off -gccext,on -msgstyle gcc -ipa file
 -interworking -inline on,noauto -char signed -nosyspath -stdinc -sym on -lang c99 -thumb
 -DPM_KEEP_ASSERTS -DPOKEPLATINUM_GENERATED_ENUM -D_MSL_RESTRICT= -DGAME_VERSION=VERSION_PLATINUM -DGAME_LANGUAGE=LANGUAGE_ENGLISH
 -DPOKEPLATINUM_REVISION=0 -DSDK_ARM9 -DSDK_CODE_ARM -DSDK_FINALROM -DSDK_TS -DSDK_4M -DSDK_CW
 -DSDK_CW_FORCE_EXPORT_SUPPORT -D_NITRO -DNNS_FINALROM
 -Iinclude -I$PLAT/include -I$PLAT/build -I$PLAT/build/res -I$PLAT -I$PLAT/asm
 -I$SDK/NitroSDK-4.2.30001/include -I$SDKGEN -I$SDK/NitroSystem-071126.1/include -prefix pch/global_pch.h"
for f in src/*.c; do
    $MWCC $FLAGS -c -o $OUT/$(basename $f .c).o $f
done
python3 tools/mwobj_fix.py $OUT/*.o
${ARM}as -mcpu=arm946e-s -o $OUT/hgss_syms.o hgss_syms.s
python3 tools/mwobj_fix.py --syms $OUT/hgss_syms.o
${ARM}ld --use-blx -T slots.ld -o $OUT/slots.elf $OUT/*.o
${ARM}objcopy -O binary $OUT/slots.elf slots.bin
${ARM}nm $OUT/slots.elf | grep -E " SlotMachine_(Init|Main|Exit)$" > slots.sym
cat slots.sym
ls -l slots.bin

.include "asm/include/interop_macros.inc"

.include "asm/include/scriptmacros.inc"
.include "asm/include/flags.inc"
.include "asm/include/soundeffects.inc"
.include "asm/include/vars.inc"

.include "asm/include/maps.inc"
.include "asm/include/std_scripts.inc"
.include "asm/include/trainers.inc"

#include "constants/item.h"
#include "config.h"

// hack: Route 2 (both halves) in Part 1 (FireRed): no HeartGold trainers.  events: data/eventdata/part1/498_P1_R02.json
// and 499_P1_R02R0101.json, text: data/text/864.txt.  wired up in src/field/chapter_field.c

.data

scrdef scr_seq_P1_R02_001 // route sign
scrdef_end

scr_seq_P1_R02_001:
	direction_signpost 0, 0, 1, VAR_SPECIAL_RESULT
	scrcmd_057 3
	scrcmd_058
	scrcmd_060 VAR_SPECIAL_RESULT
	callstd std_signpost
	end

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

// hack: Route 9 in Part 1 (FireRed).  events: data/eventdata/part1/527_P1_R09.json, text: data/text/882.txt

.data

scrdef scr_seq_P1_R09_001 // route sign
scrdef_end

scr_seq_P1_R09_001:
	direction_signpost 0, 0, 1, VAR_SPECIAL_RESULT
	scrcmd_057 3
	scrcmd_058
	scrcmd_060 VAR_SPECIAL_RESULT
	callstd std_signpost
	end

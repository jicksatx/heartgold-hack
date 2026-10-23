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

// hack: Route 3 in Part 1 (FireRed): FireRed's trainers on HeartGold's spots.  events:
// data/eventdata/part1/503_P1_R03.json, text: data/text/865.txt (scripts/hack/build_part1_text.py)

.data

scrdef scr_seq_P1_R03_001 // route sign
scrdef scr_seq_P1_R03_002 // man
scrdef_end

scr_seq_P1_R03_001:
	direction_signpost 0, 0, 1, VAR_SPECIAL_RESULT
	scrcmd_057 3
	scrcmd_058
	scrcmd_060 VAR_SPECIAL_RESULT
	callstd std_signpost
	end

scr_seq_P1_R03_002:
	simple_npc_msg 1
	end

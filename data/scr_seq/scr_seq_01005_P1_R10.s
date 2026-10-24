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

// hack: Route 10 (both halves) in Part 1 (FireRed); Rock Tunnel uses this file too.  events: data/eventdata/part1/
// 528-531, text: data/text/883.txt.  the Power Plant door is closed in Part 1 for now (FireRed reaches it by Surf)

.data

scrdef scr_seq_P1_R10_001 // Power Plant sign
scrdef scr_seq_P1_R10_002 // Rock Tunnel sign
scrdef scr_seq_P1_R10_003 // detour sign
scrdef_end

scr_seq_P1_R10_001:
	scrcmd_055 2, 0
	scrcmd_057 3
	scrcmd_058
	trainer_tips 0, VAR_SPECIAL_RESULT
	callstd std_signpost
	end

scr_seq_P1_R10_002:
	scrcmd_055 2, 0
	scrcmd_057 3
	scrcmd_058
	trainer_tips 1, VAR_SPECIAL_RESULT
	callstd std_signpost
	end

scr_seq_P1_R10_003:
	scrcmd_055 2, 0
	scrcmd_057 3
	scrcmd_058
	trainer_tips 2, VAR_SPECIAL_RESULT
	callstd std_signpost
	end

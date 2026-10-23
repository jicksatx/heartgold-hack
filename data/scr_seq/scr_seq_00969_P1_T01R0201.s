.include "asm/include/interop_macros.inc"

.include "asm/include/scriptmacros.inc"
.include "asm/include/flags.inc"
.include "asm/include/soundeffects.inc"
.include "asm/include/vars.inc"

// hack: Blue's house 1F in Part 1 (FireRed).  events: data/eventdata/part1/493_P1_T01R0201.json, text:
// data/text/856.txt.  wired up in src/field/chapter_field.c

.data

scrdef scr_seq_P1_T01R0201_001 // Daisy
scrdef_end

scr_seq_P1_T01R0201_001:
	play_se SEQ_SE_DP_SELECT
	lockall
	faceplayer
	buffer_players_name 0
	compare VAR_P1_STORY, 4
	goto_if_ge _blueLeft
	npc_msg 0
	goto _done

_blueLeft:
	npc_msg 1
_done:
	wait_button
	closemsg
	releaseall
	end

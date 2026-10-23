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
	compare VAR_P1_STORY, 6
	goto_if_ge _townMap
	compare VAR_P1_STORY, 4
	goto_if_ge _blueLeft
	npc_msg 0
	goto _done

_blueLeft:
	npc_msg 1
	goto _done

// FireRed: Daisy gives Red a Town Map.  here it's the Pokegear with its map card
_townMap:
	goto_if_set FLAG_GOT_POKEGEAR, _haveMap
	npc_msg 2
	setflag FLAG_GOT_POKEGEAR
	register_pokegear_card 1
	buffer_players_name 0
	npc_msg 3
	play_fanfare SEQ_ME_KEYITEM
	wait_fanfare
	npc_msg 4
	goto _done

_haveMap:
	npc_msg 5
_done:
	wait_button
	closemsg
	releaseall
	end

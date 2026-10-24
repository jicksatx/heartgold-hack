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

// hack: Route 12 in Part 1 (FireRed): FireRed's fishermen, Rocker, Camper and the Young Couple on HeartGold's trainer
// spots; Snorlax sleeps across the way south (woken with the Poke Flute: a wild battle); the TM27 girl stands near
// Lavender (FireRed's north gatehouse isn't in HeartGold).  events: 548_P1_R12.json, text: data/text/895.txt

.equ SPECIES_SNORLAX, 143
.equ OBJ_SNORLAX, 0

.data

scrdef scr_seq_P1_R12_001 // route sign
scrdef scr_seq_P1_R12_002 // sportfishing sign
scrdef scr_seq_P1_R12_003 // Snorlax (and its four blocker tiles)
scrdef scr_seq_P1_R12_004 // little girl (TM27)
scrdef_end

scr_seq_P1_R12_001:
	simple_npc_msg 0
	end

scr_seq_P1_R12_002:
	simple_npc_msg 1
	end

scr_seq_P1_R12_003:
	play_se SEQ_SE_DP_SELECT
	lockall
	hasitem ITEM_POKE_FLUTE, 1, VAR_SPECIAL_RESULT
	compare VAR_SPECIAL_RESULT, 0
	goto_if_eq _asleep
	buffer_players_name 0
	npc_msg 3
	closemsg
	play_cry SPECIES_SNORLAX, 0
	wait_cry
	setflag FLAG_ENGAGING_STATIC_POKEMON
	wild_battle SPECIES_SNORLAX, 30, 0
	clearflag FLAG_ENGAGING_STATIC_POKEMON
	check_battle_won VAR_SPECIAL_RESULT
	compare VAR_SPECIAL_RESULT, 0
	goto_if_eq _lost
	setflag FLAG_P1_HIDE_ROUTE12_SNORLAX
	hide_person 0
	hide_person 1
	hide_person 2
	hide_person 3
	hide_person 4
	hide_person 5
	get_static_encounter_outcome VAR_TEMP_x4005
	compare VAR_TEMP_x4005, 4
	goto_if_eq _done
	npc_msg 4
	wait_button
	closemsg
_done:
	releaseall
	end

_asleep:
	npc_msg 2
	wait_button
	closemsg
	releaseall
	end

_lost:
	white_out
	releaseall
	end

scr_seq_P1_R12_004:
	play_se SEQ_SE_DP_SELECT
	lockall
	faceplayer
	goto_if_set FLAG_P1_GOT_TM27, _gotTM
	npc_msg 5
	goto_if_no_item_space ITEM_TM027, 1, _bagFull
	giveitem_no_check ITEM_TM027, 1
	setflag FLAG_P1_GOT_TM27
_gotTM:
	npc_msg 6
	wait_button
	closemsg
	releaseall
	end

_bagFull:
	callstd std_bag_is_full
	closemsg
	releaseall
	end

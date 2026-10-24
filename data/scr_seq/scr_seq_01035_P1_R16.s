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

// hack: Routes 16-18 in Part 1 (FireRed): FireRed's Cycling Road trainers (HeartGold's own gates still make you ride
// your Bicycle through), the second Snorlax across the road west of Celadon, and the Route 16 house's HM02 Fly, and Professor Oak's
// Aide (FireRed has him upstairs in the Route 16 gate; HeartGold's gate has no upper floor, so he waits outside it).
// events: 574-578, text: data/text/909.txt

.equ SPECIES_SNORLAX, 143

.data

scrdef scr_seq_P1_R16_001 // Route 16 sign
scrdef scr_seq_P1_R16_002 // Snorlax (and its blocker tiles)
scrdef scr_seq_P1_R16_003 // girl (HM02 Fly)
scrdef scr_seq_P1_R16_004 // Route 18 sign
scrdef scr_seq_P1_R16_005 // Professor Oak's Aide (Amulet Coin, 40 species), outside the Route 16 gate
scrdef_end

scr_seq_P1_R16_001:
	simple_npc_msg 0
	end

scr_seq_P1_R16_004:
	simple_npc_msg 6
	end

scr_seq_P1_R16_002:
	play_se SEQ_SE_DP_SELECT
	lockall
	hasitem ITEM_POKE_FLUTE, 1, VAR_SPECIAL_RESULT
	compare VAR_SPECIAL_RESULT, 0
	goto_if_eq _asleep
	buffer_players_name 0
	npc_msg 2
	closemsg
	play_cry SPECIES_SNORLAX, 0
	wait_cry
	setflag FLAG_ENGAGING_STATIC_POKEMON
	wild_battle SPECIES_SNORLAX, 30, 0
	clearflag FLAG_ENGAGING_STATIC_POKEMON
	check_battle_won VAR_SPECIAL_RESULT
	compare VAR_SPECIAL_RESULT, 0
	goto_if_eq _lost
	setflag FLAG_P1_HIDE_ROUTE16_SNORLAX
	setvar VAR_SPECIAL_x8004, 0
_hideLoop:
	hide_person VAR_SPECIAL_x8004
	addvar VAR_SPECIAL_x8004, 1
	compare VAR_SPECIAL_x8004, 12
	goto_if_lt _hideLoop
	get_static_encounter_outcome VAR_TEMP_x4005
	compare VAR_TEMP_x4005, 4
	goto_if_eq _done
	npc_msg 3
	wait_button
	closemsg
_done:
	releaseall
	end

_asleep:
	npc_msg 1
	wait_button
	closemsg
	releaseall
	end

_lost:
	white_out
	releaseall
	end

scr_seq_P1_R16_003:
	play_se SEQ_SE_DP_SELECT
	lockall
	faceplayer
	goto_if_set FLAG_P1_GOT_HM02, _gotHM
	npc_msg 4
	goto_if_no_item_space ITEM_HM02, 1, _bagFull
	giveitem_no_check ITEM_HM02, 1
	setflag FLAG_P1_GOT_HM02
_gotHM:
	npc_msg 5
	wait_button
	closemsg
	releaseall
	end

_bagFull:
	callstd std_bag_is_full
	closemsg
	releaseall
	end

scr_seq_P1_R16_005:
	play_se SEQ_SE_DP_SELECT
	lockall
	faceplayer
	goto_if_set FLAG_P1_GOT_AMULET_COIN, _explainCoin
	buffer_players_name 0
	npc_msg 7
	count_national_dex_owned VAR_SPECIAL_x8004
	buffer_int 1, VAR_SPECIAL_x8004
	compare VAR_SPECIAL_x8004, 40
	goto_if_lt _notEnough
	npc_msg 8
	goto_if_no_item_space ITEM_AMULET_COIN, 1, _bagFull
	giveitem_no_check ITEM_AMULET_COIN, 1
	setflag FLAG_P1_GOT_AMULET_COIN
_explainCoin:
	npc_msg 9
	goto _aideDone

_notEnough:
	npc_msg 10
_aideDone:
	wait_button
	closemsg
	releaseall
	end

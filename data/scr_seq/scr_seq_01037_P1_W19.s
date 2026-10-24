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

// hack: the Surf stretch in Part 1 (FireRed): Routes 19-21 (FireRed's swimmers, fishermen and Sis and Bro pairs), the
// Route 19 gate, Seafoam Islands (Articuno on B4F, where HeartGold keeps it) and the Power Plant (HeartGold's repaired
// plant, with FireRed's Zapdos, Electrodes and items).  events: 581-592, text: data/text/911.txt

.equ SPECIES_ARTICUNO, 144
.equ SPECIES_ZAPDOS, 145
.equ SPECIES_ELECTRODE, 101

.data

scrdef scr_seq_P1_W19_001 // Route 19 sign
scrdef scr_seq_P1_W19_002 // Seafoam Islands sign
scrdef scr_seq_P1_W19_003 // Route 19 gate guard
scrdef scr_seq_P1_W19_004 // Articuno
scrdef scr_seq_P1_W19_005 // Zapdos
scrdef scr_seq_P1_W19_006 // Electrode
scrdef scr_seq_P1_W19_007 // Electrode
scrdef scr_seq_P1_W19_008 // Power Plant items
scrdef scr_seq_P1_W19_009
scrdef scr_seq_P1_W19_010
scrdef scr_seq_P1_W19_011
scrdef scr_seq_P1_W19_012
scrdef_end

scr_seq_P1_W19_001:
	simple_npc_msg 0
	end

scr_seq_P1_W19_002:
	simple_npc_msg 1
	end

scr_seq_P1_W19_003:
	simple_npc_msg 2
	end

scr_seq_P1_W19_004: // Articuno
	play_se SEQ_SE_DP_SELECT
	lockall
	faceplayer
	play_cry SPECIES_ARTICUNO, 0
	wait_cry
	setflag FLAG_ENGAGING_STATIC_POKEMON
	wild_battle SPECIES_ARTICUNO, 50, 0
	clearflag FLAG_ENGAGING_STATIC_POKEMON
	check_battle_won VAR_SPECIAL_RESULT
	compare VAR_SPECIAL_RESULT, 0
	goto_if_eq _lost
	hide_person VAR_SPECIAL_LAST_TALKED
	setflag FLAG_P1_HIDE_ARTICUNO
	get_static_encounter_outcome VAR_TEMP_x4005
	compare VAR_TEMP_x4005, 5 // BATTLE_OUTCOME_PLAYER_FLED
	goto_if_ne _staticDone4
	clearflag FLAG_P1_HIDE_ARTICUNO // ran away: it's back next time (FireRed)
_staticDone4:
	releaseall
	end

scr_seq_P1_W19_005: // Zapdos
	play_se SEQ_SE_DP_SELECT
	lockall
	faceplayer
	play_cry SPECIES_ZAPDOS, 0
	wait_cry
	setflag FLAG_ENGAGING_STATIC_POKEMON
	wild_battle SPECIES_ZAPDOS, 50, 0
	clearflag FLAG_ENGAGING_STATIC_POKEMON
	check_battle_won VAR_SPECIAL_RESULT
	compare VAR_SPECIAL_RESULT, 0
	goto_if_eq _lost
	hide_person VAR_SPECIAL_LAST_TALKED
	setflag FLAG_P1_HIDE_ZAPDOS
	get_static_encounter_outcome VAR_TEMP_x4005
	compare VAR_TEMP_x4005, 5 // BATTLE_OUTCOME_PLAYER_FLED
	goto_if_ne _staticDone5
	clearflag FLAG_P1_HIDE_ZAPDOS // ran away: it's back next time (FireRed)
_staticDone5:
	releaseall
	end

scr_seq_P1_W19_006: // Electrode
	play_se SEQ_SE_DP_SELECT
	lockall
	faceplayer
	play_cry SPECIES_ELECTRODE, 0
	wait_cry
	setflag FLAG_ENGAGING_STATIC_POKEMON
	wild_battle SPECIES_ELECTRODE, 34, 0
	clearflag FLAG_ENGAGING_STATIC_POKEMON
	check_battle_won VAR_SPECIAL_RESULT
	compare VAR_SPECIAL_RESULT, 0
	goto_if_eq _lost
	hide_person VAR_SPECIAL_LAST_TALKED
	setflag FLAG_P1_HIDE_PP_ELECTRODE_1
	get_static_encounter_outcome VAR_TEMP_x4005
	compare VAR_TEMP_x4005, 5 // BATTLE_OUTCOME_PLAYER_FLED
	goto_if_ne _staticDone6
	clearflag FLAG_P1_HIDE_PP_ELECTRODE_1 // ran away: it's back next time (FireRed)
_staticDone6:
	releaseall
	end

scr_seq_P1_W19_007: // Electrode
	play_se SEQ_SE_DP_SELECT
	lockall
	faceplayer
	play_cry SPECIES_ELECTRODE, 0
	wait_cry
	setflag FLAG_ENGAGING_STATIC_POKEMON
	wild_battle SPECIES_ELECTRODE, 34, 0
	clearflag FLAG_ENGAGING_STATIC_POKEMON
	check_battle_won VAR_SPECIAL_RESULT
	compare VAR_SPECIAL_RESULT, 0
	goto_if_eq _lost
	hide_person VAR_SPECIAL_LAST_TALKED
	setflag FLAG_P1_HIDE_PP_ELECTRODE_2
	get_static_encounter_outcome VAR_TEMP_x4005
	compare VAR_TEMP_x4005, 5 // BATTLE_OUTCOME_PLAYER_FLED
	goto_if_ne _staticDone7
	clearflag FLAG_P1_HIDE_PP_ELECTRODE_2 // ran away: it's back next time (FireRed)
_staticDone7:
	releaseall
	end

scr_seq_P1_W19_008:
	play_se SEQ_SE_DP_SELECT
	lockall
	goto_if_no_item_space ITEM_TM025, 1, _ballFull
	hide_person VAR_SPECIAL_LAST_TALKED
	setflag FLAG_P1_ITEM_PP_TM25
	giveitem_no_check ITEM_TM025, 1
	closemsg
	releaseall
	end

scr_seq_P1_W19_009:
	play_se SEQ_SE_DP_SELECT
	lockall
	goto_if_no_item_space ITEM_TM017, 1, _ballFull
	hide_person VAR_SPECIAL_LAST_TALKED
	setflag FLAG_P1_ITEM_PP_TM17
	giveitem_no_check ITEM_TM017, 1
	closemsg
	releaseall
	end

scr_seq_P1_W19_010:
	play_se SEQ_SE_DP_SELECT
	lockall
	goto_if_no_item_space ITEM_THUNDER_STONE, 1, _ballFull
	hide_person VAR_SPECIAL_LAST_TALKED
	setflag FLAG_P1_ITEM_PP_THUNDER_STONE
	giveitem_no_check ITEM_THUNDER_STONE, 1
	closemsg
	releaseall
	end

scr_seq_P1_W19_011:
	play_se SEQ_SE_DP_SELECT
	lockall
	goto_if_no_item_space ITEM_ELIXIR, 1, _ballFull
	hide_person VAR_SPECIAL_LAST_TALKED
	setflag FLAG_P1_ITEM_PP_ELIXIR
	giveitem_no_check ITEM_ELIXIR, 1
	closemsg
	releaseall
	end

scr_seq_P1_W19_012:
	play_se SEQ_SE_DP_SELECT
	lockall
	goto_if_no_item_space ITEM_MAX_POTION, 1, _ballFull
	hide_person VAR_SPECIAL_LAST_TALKED
	setflag FLAG_P1_ITEM_PP_MAX_POTION
	giveitem_no_check ITEM_MAX_POTION, 1
	closemsg
	releaseall
	end

_ballFull:
	callstd std_bag_is_full
	closemsg
	releaseall
	end

_lost:
	white_out
	releaseall
	end

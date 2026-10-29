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
.include "asm/include/game_stats.inc"

// hack: Silph Co. in Part 1 (FireRed).  HeartGold's Silph Co. is just a lobby, so its upper floors are Goldenrod Radio
// Tower 2F-5F (whose takeover layout fits): FireRed's Rockets and Scientists, the 3F door that needs the Card Key (on
// 5F's west side), Blue by the 4F stairs, the Lapras employee, and Giovanni with the President up on 5F's east side.
// shared by events 566-570, text: data/text/906.txt

.equ OBJ_SHUTTER_1, 0
.equ OBJ_SHUTTER_2, 1
.equ OBJ_BLUE, 0
.equ OBJ_CARD_KEY, 0
.equ OBJ_GIOVANNI, 1

.data

scrdef scr_seq_P1_SILPH_001 // lobby receptionist
scrdef scr_seq_P1_SILPH_002 // 3F locked door (Card Key)
scrdef scr_seq_P1_SILPH_003 // Blue (talked to)
scrdef scr_seq_P1_SILPH_004 // employee with Lapras
scrdef scr_seq_P1_SILPH_005 // Blue (stepping toward the 4F stairs)
scrdef scr_seq_P1_SILPH_006 // Card Key
scrdef scr_seq_P1_SILPH_007 // Giovanni
scrdef scr_seq_P1_SILPH_008 // President (Master Ball)
scrdef scr_seq_P1_SILPH_009 // secretary
scrdef_end

scr_seq_P1_SILPH_001:
	simple_npc_msg 0
	end

scr_seq_P1_SILPH_002:
	play_se SEQ_SE_DP_SELECT
	lockall
	hasitem ITEM_CARD_KEY_KANTO, 1, VAR_SPECIAL_RESULT
	compare VAR_SPECIAL_RESULT, 0
	goto_if_eq _locked
	buffer_players_name 0
	npc_msg 2
	closemsg
	play_se SEQ_SE_DP_SELECT
	hide_person OBJ_SHUTTER_1
	hide_person OBJ_SHUTTER_2
	setflag FLAG_P1_SILPH_DOOR_OPEN
	releaseall
	end

_locked:
	npc_msg 1
	wait_button
	closemsg
	releaseall
	end

scr_seq_P1_SILPH_003:
scr_seq_P1_SILPH_005:
	lockall
	callstd 2031 // rival intro music
	apply_movement OBJ_BLUE, _blueNotice
	wait_movement
	buffer_players_name 0
	npc_msg 3
	npc_msg 4
	closemsg
	get_starter_choice VAR_TEMP_x4001
	compare VAR_TEMP_x4001, 152
	goto_if_eq _battleVsGrass
	compare VAR_TEMP_x4001, 155
	goto_if_eq _battleVsFire
	trainer_battle TRAINER_P1_RIVAL_SILPH_BULBASAUR, 0, 0, 0
	goto _afterBattle

_battleVsGrass:
	trainer_battle TRAINER_P1_RIVAL_SILPH_CHARMANDER, 0, 0, 0
	goto _afterBattle

_battleVsFire:
	trainer_battle TRAINER_P1_RIVAL_SILPH_SQUIRTLE, 0, 0, 0
_afterBattle:
	check_battle_won VAR_SPECIAL_RESULT
	compare VAR_SPECIAL_RESULT, 0
	goto_if_eq _lost
	callstd 2070 // rival outro music
	setvar VAR_P1_SILPH, 1
	npc_msg 5
	closemsg
	apply_movement OBJ_BLUE, _blueLeave
	wait_movement
	hide_person OBJ_BLUE
	setflag FLAG_P1_HIDE_SILPH_BLUE
	callstd 2071 // back to the map music
	releaseall
	end

_lost:
	white_out
	releaseall
	end

scr_seq_P1_SILPH_004:
	play_se SEQ_SE_DP_SELECT
	lockall
	faceplayer
	goto_if_set FLAG_P1_GOT_LAPRAS, _gotLapras
	get_party_count VAR_SPECIAL_x8005
	compare VAR_SPECIAL_x8005, 6
	goto_if_eq _partyFull
	buffer_players_name 0
	npc_msg 6
	give_mon 131, 25, 0, 0, 0, VAR_SPECIAL_RESULT
	setflag FLAG_P1_GOT_LAPRAS
	play_fanfare SEQ_ME_POKEGET
	wait_fanfare
	npc_msg 7
	goto _talkDone

_gotLapras:
	npc_msg 8
	goto _talkDone

_partyFull:
	npc_msg 9
_talkDone:
	wait_button
	closemsg
	releaseall
	end

scr_seq_P1_SILPH_006:
	play_se SEQ_SE_DP_SELECT
	lockall
	hide_person OBJ_CARD_KEY
	setflag FLAG_P1_GOT_CARD_KEY
	giveitem_no_check ITEM_CARD_KEY_KANTO, 1
	closemsg
	releaseall
	end

scr_seq_P1_SILPH_007:
	play_se SEQ_SE_DP_SELECT
	lockall
	faceplayer
	buffer_players_name 0
	npc_msg 14
	closemsg
	trainer_battle TRAINER_P1_BOSS_GIOVANNI_2, 0, 0, 0
	check_battle_won VAR_SPECIAL_RESULT
	compare VAR_SPECIAL_RESULT, 0
	goto_if_eq _lost
	buffer_players_name 0
	npc_msg 15
	closemsg
	fade_screen 6, 1, 0, 0
	wait_fade
	hide_person OBJ_GIOVANNI
	setflag FLAG_P1_HIDE_SILPH_GIOVANNI
	setvar VAR_P1_SILPH, 2
	fade_screen 6, 1, 1, 0
	wait_fade
	releaseall
	end

scr_seq_P1_SILPH_008:
	play_se SEQ_SE_DP_SELECT
	lockall
	faceplayer
	compare VAR_P1_SILPH, 2
	goto_if_lt _presidentWaits
	goto_if_set FLAG_P1_GOT_MASTER_BALL, _gotBall
	npc_msg 10
	goto_if_no_item_space ITEM_MASTER_BALL, 1, _noRoom
	giveitem_no_check ITEM_MASTER_BALL, 1
	setflag FLAG_P1_GOT_MASTER_BALL
_gotBall:
	npc_msg 11
	goto _talkDone

_noRoom:
	npc_msg 13
	goto _talkDone

_presidentWaits:
	npc_msg 17
	goto _talkDone

scr_seq_P1_SILPH_009:
	simple_npc_msg 12
	end

	.balign 4
_blueLeave: // along the corridor to the stairs down
	step 15, 6  // walk east
	step 12, 1  // walk north
	step 69, 1  // invisible
	step_end

	.balign 4
_blueNotice:
	step 75, 1
	step_end

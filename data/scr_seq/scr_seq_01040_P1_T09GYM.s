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

// hack: Cinnabar Gym in Part 1 (FireRed) = HeartGold's Seafoam Islands Gym (Blaine's home after the eruption).  HeartGold's
// gym trainers stand in the way and step aside once beaten; here they are FireRed's burglars and super nerds, and each
// has a Pokemon Quiz machine near him (FireRed's six questions): answer right and he steps aside without a battle,
// answer wrong and he battles you first.  Super Nerd Erik (no quiz in FireRed either) is an ordinary trainer.  Blaine:
// Volcano Badge, TM38.  events: 594, header: scr_seq_01041 (on resume: beaten trainers back at their side spots),
// text: data/text/914.txt

.data

scrdef scr_seq_P1_T09GYM_001 // Blaine
scrdef scr_seq_P1_T09GYM_002 // gym guide
scrdef scr_seq_P1_T09GYM_003 // quiz 1 (BURGLAR_QUINN)
scrdef scr_seq_P1_T09GYM_004 // quiz 2 (SUPER_NERD_AVERY)
scrdef scr_seq_P1_T09GYM_005 // quiz 3 (BURGLAR_RAMON)
scrdef scr_seq_P1_T09GYM_006 // quiz 4 (SUPER_NERD_DEREK)
scrdef scr_seq_P1_T09GYM_007 // quiz 5 (BURGLAR_DUSTY)
scrdef scr_seq_P1_T09GYM_008 // quiz 6 (SUPER_NERD_ZAC)
scrdef scr_seq_P1_T09GYM_009 // BURGLAR_QUINN
scrdef scr_seq_P1_T09GYM_010 // SUPER_NERD_AVERY
scrdef scr_seq_P1_T09GYM_011 // BURGLAR_RAMON
scrdef scr_seq_P1_T09GYM_012 // SUPER_NERD_DEREK
scrdef scr_seq_P1_T09GYM_013 // BURGLAR_DUSTY
scrdef scr_seq_P1_T09GYM_014 // SUPER_NERD_ZAC
scrdef scr_seq_P1_T09GYM_015 // on resume
scrdef_end

scr_seq_P1_T09GYM_001:
	play_se SEQ_SE_DP_SELECT
	lockall
	faceplayer
	check_badge BADGE_VOLCANO, VAR_SPECIAL_RESULT
	compare VAR_SPECIAL_RESULT, 1
	goto_if_eq _blaineAfter
	openmsg // trainer_message needs the window open (HeartGold's trainer scripts do the same)
	trainer_message TRAINER_P1_LEADER_BLAINE, 0
	closemsg
	trainer_battle TRAINER_P1_LEADER_BLAINE, 0, 0, 0
	check_battle_won VAR_SPECIAL_RESULT
	compare VAR_SPECIAL_RESULT, 0
	goto_if_eq _lost
	give_badge BADGE_VOLCANO
	add_special_game_stat SCORE_EVENT_BADGE_GET
	settrainerflag TRAINER_P1_BURGLAR_QUINN
	settrainerflag TRAINER_P1_SUPER_NERD_ERIK
	settrainerflag TRAINER_P1_SUPER_NERD_AVERY
	settrainerflag TRAINER_P1_BURGLAR_RAMON
	settrainerflag TRAINER_P1_SUPER_NERD_DEREK
	settrainerflag TRAINER_P1_BURGLAR_DUSTY
	settrainerflag TRAINER_P1_SUPER_NERD_ZAC
	buffer_players_name 0
	npc_msg 9
	play_fanfare SEQ_ME_BADGE
	wait_fanfare
	npc_msg 10
_giveTM:
	goto_if_no_item_space ITEM_TM038, 1, _bagFull
	giveitem_no_check ITEM_TM038, 1
	setflag FLAG_P1_GOT_TM38
	npc_msg 11
	goto _talkDone

_blaineAfter:
	goto_if_unset FLAG_P1_GOT_TM38, _giveTM
	openmsg
	trainer_message TRAINER_P1_LEADER_BLAINE, 2
	goto _talkDone

_bagFull:
	callstd std_bag_is_full
	closemsg
	releaseall
	end

_lost:
	white_out
	releaseall
	end

scr_seq_P1_T09GYM_002:
	play_se SEQ_SE_DP_SELECT
	lockall
	faceplayer
	check_badge BADGE_VOLCANO, VAR_SPECIAL_RESULT
	compare VAR_SPECIAL_RESULT, 1
	goto_if_eq _guideAfter
	npc_msg 12
	goto _talkDone

_guideAfter:
	npc_msg 13
_talkDone:
	wait_button
	closemsg
	releaseall
	end

scr_seq_P1_T09GYM_003:
	play_se SEQ_SE_DP_SELECT
	lockall
	goto_if_set FLAG_P1_GYM_ASIDE_1, _answered
	npc_msg 0
	npc_msg 1
	touchscreen_menu_hide
	getmenuchoice VAR_SPECIAL_RESULT
	touchscreen_menu_show
	compare VAR_SPECIAL_RESULT, 0
	goto_if_ne _wrong1
	settrainerflag TRAINER_P1_BURGLAR_QUINN
	npc_msg 7
	wait_button
	closemsg
	apply_movement 2, _aside1
	wait_movement
	setflag FLAG_P1_GYM_ASIDE_1
	releaseall
	end

_wrong1:
	npc_msg 8
	closemsg
	checktrainerflag TRAINER_P1_BURGLAR_QUINN
	goto_if_eq _quizBeaten1
	openmsg
	trainer_message TRAINER_P1_BURGLAR_QUINN, 0
	closemsg
	trainer_battle TRAINER_P1_BURGLAR_QUINN, 0, 0, 0
	check_battle_won VAR_SPECIAL_RESULT
	compare VAR_SPECIAL_RESULT, 0
	goto_if_eq _lost
	settrainerflag TRAINER_P1_BURGLAR_QUINN
_quizBeaten1:
	apply_movement 2, _aside1
	wait_movement
	setflag FLAG_P1_GYM_ASIDE_1
	releaseall
	end

scr_seq_P1_T09GYM_004:
	play_se SEQ_SE_DP_SELECT
	lockall
	goto_if_set FLAG_P1_GYM_ASIDE_2, _answered
	npc_msg 0
	npc_msg 2
	touchscreen_menu_hide
	getmenuchoice VAR_SPECIAL_RESULT
	touchscreen_menu_show
	compare VAR_SPECIAL_RESULT, 1
	goto_if_ne _wrong2
	settrainerflag TRAINER_P1_SUPER_NERD_AVERY
	npc_msg 7
	wait_button
	closemsg
	apply_movement 3, _aside2b
	wait_movement
	setflag FLAG_P1_GYM_ASIDE_2
	releaseall
	end

_wrong2:
	npc_msg 8
	closemsg
	checktrainerflag TRAINER_P1_SUPER_NERD_AVERY
	goto_if_eq _quizBeaten2
	openmsg
	trainer_message TRAINER_P1_SUPER_NERD_AVERY, 0
	closemsg
	trainer_battle TRAINER_P1_SUPER_NERD_AVERY, 0, 0, 0
	check_battle_won VAR_SPECIAL_RESULT
	compare VAR_SPECIAL_RESULT, 0
	goto_if_eq _lost
	settrainerflag TRAINER_P1_SUPER_NERD_AVERY
_quizBeaten2:
	apply_movement 3, _aside2b
	wait_movement
	setflag FLAG_P1_GYM_ASIDE_2
	releaseall
	end

scr_seq_P1_T09GYM_005:
	play_se SEQ_SE_DP_SELECT
	lockall
	goto_if_set FLAG_P1_GYM_ASIDE_3, _answered
	npc_msg 0
	npc_msg 3
	touchscreen_menu_hide
	getmenuchoice VAR_SPECIAL_RESULT
	touchscreen_menu_show
	compare VAR_SPECIAL_RESULT, 1
	goto_if_ne _wrong3
	settrainerflag TRAINER_P1_BURGLAR_RAMON
	npc_msg 7
	wait_button
	closemsg
	apply_movement 4, _aside3
	wait_movement
	setflag FLAG_P1_GYM_ASIDE_3
	releaseall
	end

_wrong3:
	npc_msg 8
	closemsg
	checktrainerflag TRAINER_P1_BURGLAR_RAMON
	goto_if_eq _quizBeaten3
	openmsg
	trainer_message TRAINER_P1_BURGLAR_RAMON, 0
	closemsg
	trainer_battle TRAINER_P1_BURGLAR_RAMON, 0, 0, 0
	check_battle_won VAR_SPECIAL_RESULT
	compare VAR_SPECIAL_RESULT, 0
	goto_if_eq _lost
	settrainerflag TRAINER_P1_BURGLAR_RAMON
_quizBeaten3:
	apply_movement 4, _aside3
	wait_movement
	setflag FLAG_P1_GYM_ASIDE_3
	releaseall
	end

scr_seq_P1_T09GYM_006:
	play_se SEQ_SE_DP_SELECT
	lockall
	goto_if_set FLAG_P1_GYM_ASIDE_4, _answered
	npc_msg 0
	npc_msg 4
	touchscreen_menu_hide
	getmenuchoice VAR_SPECIAL_RESULT
	touchscreen_menu_show
	compare VAR_SPECIAL_RESULT, 1
	goto_if_ne _wrong4
	settrainerflag TRAINER_P1_SUPER_NERD_DEREK
	npc_msg 7
	wait_button
	closemsg
	apply_movement 5, _aside4
	wait_movement
	setflag FLAG_P1_GYM_ASIDE_4
	releaseall
	end

_wrong4:
	npc_msg 8
	closemsg
	checktrainerflag TRAINER_P1_SUPER_NERD_DEREK
	goto_if_eq _quizBeaten4
	openmsg
	trainer_message TRAINER_P1_SUPER_NERD_DEREK, 0
	closemsg
	trainer_battle TRAINER_P1_SUPER_NERD_DEREK, 0, 0, 0
	check_battle_won VAR_SPECIAL_RESULT
	compare VAR_SPECIAL_RESULT, 0
	goto_if_eq _lost
	settrainerflag TRAINER_P1_SUPER_NERD_DEREK
_quizBeaten4:
	apply_movement 5, _aside4
	wait_movement
	setflag FLAG_P1_GYM_ASIDE_4
	releaseall
	end

scr_seq_P1_T09GYM_007:
	play_se SEQ_SE_DP_SELECT
	lockall
	goto_if_set FLAG_P1_GYM_ASIDE_5, _answered
	npc_msg 0
	npc_msg 5
	touchscreen_menu_hide
	getmenuchoice VAR_SPECIAL_RESULT
	touchscreen_menu_show
	compare VAR_SPECIAL_RESULT, 0
	goto_if_ne _wrong5
	settrainerflag TRAINER_P1_BURGLAR_DUSTY
	npc_msg 7
	wait_button
	closemsg
	apply_movement 6, _aside5b
	wait_movement
	setflag FLAG_P1_GYM_ASIDE_5
	releaseall
	end

_wrong5:
	npc_msg 8
	closemsg
	checktrainerflag TRAINER_P1_BURGLAR_DUSTY
	goto_if_eq _quizBeaten5
	openmsg
	trainer_message TRAINER_P1_BURGLAR_DUSTY, 0
	closemsg
	trainer_battle TRAINER_P1_BURGLAR_DUSTY, 0, 0, 0
	check_battle_won VAR_SPECIAL_RESULT
	compare VAR_SPECIAL_RESULT, 0
	goto_if_eq _lost
	settrainerflag TRAINER_P1_BURGLAR_DUSTY
_quizBeaten5:
	apply_movement 6, _aside5b
	wait_movement
	setflag FLAG_P1_GYM_ASIDE_5
	releaseall
	end

scr_seq_P1_T09GYM_008:
	play_se SEQ_SE_DP_SELECT
	lockall
	goto_if_set FLAG_P1_GYM_ASIDE_6, _answered
	npc_msg 0
	npc_msg 6
	touchscreen_menu_hide
	getmenuchoice VAR_SPECIAL_RESULT
	touchscreen_menu_show
	compare VAR_SPECIAL_RESULT, 1
	goto_if_ne _wrong6
	settrainerflag TRAINER_P1_SUPER_NERD_ZAC
	npc_msg 7
	wait_button
	closemsg
	apply_movement 7, _aside6b
	wait_movement
	setflag FLAG_P1_GYM_ASIDE_6
	releaseall
	end

_wrong6:
	npc_msg 8
	closemsg
	checktrainerflag TRAINER_P1_SUPER_NERD_ZAC
	goto_if_eq _quizBeaten6
	openmsg
	trainer_message TRAINER_P1_SUPER_NERD_ZAC, 0
	closemsg
	trainer_battle TRAINER_P1_SUPER_NERD_ZAC, 0, 0, 0
	check_battle_won VAR_SPECIAL_RESULT
	compare VAR_SPECIAL_RESULT, 0
	goto_if_eq _lost
	settrainerflag TRAINER_P1_SUPER_NERD_ZAC
_quizBeaten6:
	apply_movement 7, _aside6b
	wait_movement
	setflag FLAG_P1_GYM_ASIDE_6
	releaseall
	end

scr_seq_P1_T09GYM_009:
	play_se SEQ_SE_DP_SELECT
	lockall
	faceplayer
	goto_if_set FLAG_P1_GYM_ASIDE_1, _after1
	checktrainerflag TRAINER_P1_BURGLAR_QUINN
	goto_if_eq _stepAside1
	openmsg
	trainer_message TRAINER_P1_BURGLAR_QUINN, 0
	closemsg
	trainer_battle TRAINER_P1_BURGLAR_QUINN, 0, 0, 0
	check_battle_won VAR_SPECIAL_RESULT
	compare VAR_SPECIAL_RESULT, 0
	goto_if_eq _lost
	settrainerflag TRAINER_P1_BURGLAR_QUINN
_stepAside1:
	openmsg
	trainer_message TRAINER_P1_BURGLAR_QUINN, 2
	closemsg
	apply_movement 2, _aside1
	wait_movement
	setflag FLAG_P1_GYM_ASIDE_1
	releaseall
	end

_after1:
	openmsg
	trainer_message TRAINER_P1_BURGLAR_QUINN, 2
	goto _talkDone

scr_seq_P1_T09GYM_010:
	play_se SEQ_SE_DP_SELECT
	lockall
	faceplayer
	goto_if_set FLAG_P1_GYM_ASIDE_2, _after2
	checktrainerflag TRAINER_P1_SUPER_NERD_AVERY
	goto_if_eq _stepAside2
	openmsg
	trainer_message TRAINER_P1_SUPER_NERD_AVERY, 0
	closemsg
	trainer_battle TRAINER_P1_SUPER_NERD_AVERY, 0, 0, 0
	check_battle_won VAR_SPECIAL_RESULT
	compare VAR_SPECIAL_RESULT, 0
	goto_if_eq _lost
	settrainerflag TRAINER_P1_SUPER_NERD_AVERY
_stepAside2:
	openmsg
	trainer_message TRAINER_P1_SUPER_NERD_AVERY, 2
	closemsg
	get_player_facing VAR_SPECIAL_RESULT
	compare VAR_SPECIAL_RESULT, 2
	goto_if_ne _asideElse2
	apply_movement 3, _aside2
	goto _asideWait2
_asideElse2:
	apply_movement 3, _aside2b
_asideWait2:
	wait_movement
	setflag FLAG_P1_GYM_ASIDE_2
	releaseall
	end

_after2:
	openmsg
	trainer_message TRAINER_P1_SUPER_NERD_AVERY, 2
	goto _talkDone

scr_seq_P1_T09GYM_011:
	play_se SEQ_SE_DP_SELECT
	lockall
	faceplayer
	goto_if_set FLAG_P1_GYM_ASIDE_3, _after3
	checktrainerflag TRAINER_P1_BURGLAR_RAMON
	goto_if_eq _stepAside3
	openmsg
	trainer_message TRAINER_P1_BURGLAR_RAMON, 0
	closemsg
	trainer_battle TRAINER_P1_BURGLAR_RAMON, 0, 0, 0
	check_battle_won VAR_SPECIAL_RESULT
	compare VAR_SPECIAL_RESULT, 0
	goto_if_eq _lost
	settrainerflag TRAINER_P1_BURGLAR_RAMON
_stepAside3:
	openmsg
	trainer_message TRAINER_P1_BURGLAR_RAMON, 2
	closemsg
	apply_movement 4, _aside3
	wait_movement
	setflag FLAG_P1_GYM_ASIDE_3
	releaseall
	end

_after3:
	openmsg
	trainer_message TRAINER_P1_BURGLAR_RAMON, 2
	goto _talkDone

scr_seq_P1_T09GYM_012:
	play_se SEQ_SE_DP_SELECT
	lockall
	faceplayer
	goto_if_set FLAG_P1_GYM_ASIDE_4, _after4
	checktrainerflag TRAINER_P1_SUPER_NERD_DEREK
	goto_if_eq _stepAside4
	openmsg
	trainer_message TRAINER_P1_SUPER_NERD_DEREK, 0
	closemsg
	trainer_battle TRAINER_P1_SUPER_NERD_DEREK, 0, 0, 0
	check_battle_won VAR_SPECIAL_RESULT
	compare VAR_SPECIAL_RESULT, 0
	goto_if_eq _lost
	settrainerflag TRAINER_P1_SUPER_NERD_DEREK
_stepAside4:
	openmsg
	trainer_message TRAINER_P1_SUPER_NERD_DEREK, 2
	closemsg
	apply_movement 5, _aside4
	wait_movement
	setflag FLAG_P1_GYM_ASIDE_4
	releaseall
	end

_after4:
	openmsg
	trainer_message TRAINER_P1_SUPER_NERD_DEREK, 2
	goto _talkDone

scr_seq_P1_T09GYM_013:
	play_se SEQ_SE_DP_SELECT
	lockall
	faceplayer
	goto_if_set FLAG_P1_GYM_ASIDE_5, _after5
	checktrainerflag TRAINER_P1_BURGLAR_DUSTY
	goto_if_eq _stepAside5
	openmsg
	trainer_message TRAINER_P1_BURGLAR_DUSTY, 0
	closemsg
	trainer_battle TRAINER_P1_BURGLAR_DUSTY, 0, 0, 0
	check_battle_won VAR_SPECIAL_RESULT
	compare VAR_SPECIAL_RESULT, 0
	goto_if_eq _lost
	settrainerflag TRAINER_P1_BURGLAR_DUSTY
_stepAside5:
	openmsg
	trainer_message TRAINER_P1_BURGLAR_DUSTY, 2
	closemsg
	get_player_facing VAR_SPECIAL_RESULT
	compare VAR_SPECIAL_RESULT, 3
	goto_if_ne _asideElse5
	apply_movement 6, _aside5
	goto _asideWait5
_asideElse5:
	apply_movement 6, _aside5b
_asideWait5:
	wait_movement
	setflag FLAG_P1_GYM_ASIDE_5
	releaseall
	end

_after5:
	openmsg
	trainer_message TRAINER_P1_BURGLAR_DUSTY, 2
	goto _talkDone

scr_seq_P1_T09GYM_014:
	play_se SEQ_SE_DP_SELECT
	lockall
	faceplayer
	goto_if_set FLAG_P1_GYM_ASIDE_6, _after6
	checktrainerflag TRAINER_P1_SUPER_NERD_ZAC
	goto_if_eq _stepAside6
	openmsg
	trainer_message TRAINER_P1_SUPER_NERD_ZAC, 0
	closemsg
	trainer_battle TRAINER_P1_SUPER_NERD_ZAC, 0, 0, 0
	check_battle_won VAR_SPECIAL_RESULT
	compare VAR_SPECIAL_RESULT, 0
	goto_if_eq _lost
	settrainerflag TRAINER_P1_SUPER_NERD_ZAC
_stepAside6:
	openmsg
	trainer_message TRAINER_P1_SUPER_NERD_ZAC, 2
	closemsg
	get_player_facing VAR_SPECIAL_RESULT
	compare VAR_SPECIAL_RESULT, 0
	goto_if_ne _asideElse6
	apply_movement 7, _aside6
	goto _asideWait6
_asideElse6:
	apply_movement 7, _aside6b
_asideWait6:
	wait_movement
	setflag FLAG_P1_GYM_ASIDE_6
	releaseall
	end

_after6:
	openmsg
	trainer_message TRAINER_P1_SUPER_NERD_ZAC, 2
	goto _talkDone

scr_seq_P1_T09GYM_015:
	call_if_set FLAG_P1_GYM_ASIDE_1, _resume1
	call_if_set FLAG_P1_GYM_ASIDE_3, _resume3
	call_if_set FLAG_P1_GYM_ASIDE_4, _resume4
	end

_resume1:
	move_person_facing 2, 15, 0, 16, DIR_SOUTH
	return

_resume3:
	move_person_facing 4, 21, 0, 14, DIR_WEST
	return

_resume4:
	move_person_facing 5, 9, 0, 13, DIR_NORTH
	return

_answered:
	npc_msg 14
	goto _talkDone

	.balign 4
_aside1:
	step 12, 1
	step 1, 1
	step_end

	.balign 4
_aside2:
	step 14, 1
	step 3, 1
	step_end

	.balign 4
_aside2b:
	step 15, 1
	step 2, 1
	step_end

	.balign 4
_aside3:
	step 15, 1
	step 2, 1
	step_end

	.balign 4
_aside4:
	step 13, 1
	step 0, 1
	step_end

	.balign 4
_aside5:
	step 15, 1
	step 2, 1
	step_end

	.balign 4
_aside5b:
	step 14, 1
	step 3, 1
	step_end

	.balign 4
_aside6:
	step 12, 1
	step 1, 1
	step_end

	.balign 4
_aside6b:
	step 13, 1
	step 0, 1
	step_end


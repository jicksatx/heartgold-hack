"""hack: the script for one FireRed in-game trade (HeartGold's NPC trade commands), shared by the Part 1 script files."""


def trade_script(label, trade_no, flag, base, local):
    """base = first of the 5 lines of the trade's text set (ask, thanks, declined, wrong Pokemon, afterwards);
    local = a unique suffix for this script's labels"""
    ask, thanks, decline, wrong, after = range(base, base + 5)
    return f'''{label}:
	play_se SEQ_SE_DP_SELECT
	lockall
	faceplayer
	load_npc_trade {trade_no}
	get_offered_species VAR_SPECIAL_x8006
	npc_trade_get_req_species VAR_SPECIAL_x8007
	npc_trade_end
	buffer_species_name 0, VAR_SPECIAL_x8007, 0, 0
	buffer_species_name 1, VAR_SPECIAL_x8006, 0, 0
	goto_if_set {flag}, _tradeAfter{local}
	npc_msg {ask}
	touchscreen_menu_hide
	getmenuchoice VAR_SPECIAL_RESULT
	touchscreen_menu_show
	compare VAR_SPECIAL_RESULT, 1
	goto_if_eq _tradeDecline{local}
	closemsg
	fade_screen 6, 1, 0, 0
	wait_fade
	scrcmd_566
	get_party_selection VAR_SPECIAL_RESULT
	restore_overworld
	fade_screen 6, 1, 1, 0
	wait_fade
	compare VAR_SPECIAL_RESULT, 255
	goto_if_eq _tradeDecline{local}
	copyvar VAR_SPECIAL_x8004, VAR_SPECIAL_RESULT
	get_partymon_species VAR_SPECIAL_x8004, VAR_SPECIAL_x8005
	compare_var_to_var VAR_SPECIAL_x8005, VAR_SPECIAL_x8007
	goto_if_ne _tradeWrong{local}
	load_npc_trade {trade_no}
	npc_trade_exec VAR_SPECIAL_x8004
	npc_trade_end
	setflag {flag}
	npc_msg {thanks}
	goto _tradeDone{local}

_tradeWrong{local}:
	npc_msg {wrong}
	goto _tradeDone{local}

_tradeDecline{local}:
	npc_msg {decline}
	goto _tradeDone{local}

_tradeAfter{local}:
	npc_msg {after}
_tradeDone{local}:
	wait_button
	closemsg
	releaseall
	end

'''


def aide_script(label, count, item, flag, ask, got, explain, short, local):
    return f'''{label}:
	play_se SEQ_SE_DP_SELECT
	lockall
	faceplayer
	goto_if_set {flag}, _aideExplain{local}
	buffer_players_name 0
	npc_msg {ask}
	count_national_dex_owned VAR_SPECIAL_x8004
	buffer_int 1, VAR_SPECIAL_x8004
	compare VAR_SPECIAL_x8004, {count}
	goto_if_lt _aideShort{local}
	npc_msg {got}
	goto_if_no_item_space {item}, 1, _aideBagFull{local}
	giveitem_no_check {item}, 1
	setflag {flag}
_aideExplain{local}:
	npc_msg {explain}
	goto _aideDone{local}

_aideShort{local}:
	npc_msg {short}
_aideDone{local}:
	wait_button
	closemsg
	releaseall
	end

_aideBagFull{local}:
	callstd std_bag_is_full
	closemsg
	releaseall
	end

'''

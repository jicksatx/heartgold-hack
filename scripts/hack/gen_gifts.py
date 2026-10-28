#!/usr/bin/env python3
"""
hack: FireRed's remaining gifts in Kanto interiors that Part 1 still showed with HeartGold's people:

    Vermilion fishing house (361)          the Fishing Guru: Old Rod
    Pewter Museum of Science (471)         the back-room scientist: Old Amber (revived at Cinnabar's Lab), exhibits
    Celadon Condominiums roof room (380)   the Poke Ball with Eevee (Lv. 25)
    Celadon Dept. Store roof (375)         the thirsty girl: TM16 / TM20 / TM33 for Fresh Water / Soda Pop / Lemonade,
                                           and the vending machines that sell them
    Route 10 Pokemon Center (466)          Oak's Aide: Everstone for 20 species
    Route 3 Pokemon Center (511)           the Magikarp salesman (FireRed's Route 4 Pokemon Center, by Mt. Moon)

writes data/scr_seq/scr_seq_01059_P1_GIFTS.s; text data/text/921.txt (build_part1_text.py, TEXT below); events
data/eventdata/part1/641-646.

usage: python3 scripts/hack/gen_gifts.py
"""
import os
import sys

sys.path.insert(0, os.path.dirname(__file__))
from gen_sevii import HEADER, P, R, N, YESNO  # noqa: E402
from trade_script import aide_script  # noqa: E402

NUM = "{STRVAR_1 52, 1, 0}"
TEXT = []


def L(key, label, end=N):
    TEXT.append((key, ("L", label, end)))


def LS(key, label, suffix):
    TEXT.append((key, ("LS", label, suffix)))


def X(key, text):
    TEXT.append((key, ("T", text)))


# Vermilion: the Fishing Guru
LS("guru_ask", "VermilionCity_House1_Text_ImFishingGuruDoYouLikeToFish", YESNO)
L("guru_take", "VermilionCity_House1_Text_TakeThisAndFish", R)
L("guru_life", "VermilionCity_House1_Text_FishingIsAWayOfLife")
L("guru_no", "VermilionCity_House1_Text_OhThatsSoDisappointing")
L("guru_after", "VermilionCity_House1_Text_HowAreTheFishBiting")
# Pewter Museum
L("mus_enjoy", "PewterCity_Museum_1F_Text_PleaseEnjoyYourself")
L("mus_amber", "PewterCity_Museum_1F_Text_WantYouToGetAmberExamined", R)
L("mus_amber2", "PewterCity_Museum_1F_Text_GetOldAmberChecked")
L("mus_genetic", "PewterCity_Museum_1F_Text_AmberContainsGeneticMatter")
L("mus_sap", "PewterCity_Museum_1F_Text_AmberIsFossilizedSap")
L("mus_dragon", "PewterCity_Museum_1F_Text_ShouldBeGratefulForLongLife")
L("mus_fossils", "PewterCity_Museum_1F_Text_WeHaveTwoFossilsOnExhibit")
L("mus_moonstone", "PewterCity_Museum_1F_Text_WhatsSpecialAboutMoonStone")
L("mus_pikachu", "PewterCity_Museum_1F_Text_AskedDaddyToCatchPikachu")
L("mus_aero", "PewterCity_Museum_1F_Text_AerodactylFossil")
L("mus_kabutops", "PewterCity_Museum_1F_Text_KabutopsFossil")
L("mus_amberx", "PewterCity_Museum_1F_Text_BeautifulPieceOfAmber")
L("mus_shuttle", "PewterCity_Museum_1F_Text_SpaceShuttle")
L("mus_meteorite", "PewterCity_Museum_1F_Text_MeteoriteThatFellOnMtMoon")
L("mus_space", "PewterCity_Museum_1F_Text_RunningSpaceExhibitThisMonth")
# Celadon Condominiums roof room
L("roof_know", "CeladonCity_Condominiums_RoofRoom_Text_TheresNothingIDontKnow")
L("roof_eevee", "CeladonCity_Condominiums_RoofRoom_Text_ObtainedAnEevee")
X("roof_full", "There’s no room in your party for\\nanother Pokémon.")
X("roof_ball", "It’s a Poké Ball.\\nThere’s a Pokémon inside!" + R)
L("roof_tms", "CeladonCity_Condominiums_RoofRoom_Text_PamphletOnTMs")
# Celadon Dept. Store roof
L("dept_thirsty", "CeladonCity_DepartmentStore_Roof_Text_ImThirstyIWantDrink")
LS("dept_give", "CeladonCity_DepartmentStore_Roof_Text_ImThirstyGiveHerDrink", YESNO)
L("dept_water", "CeladonCity_DepartmentStore_Roof_Text_YayFreshWaterHaveThis", R)
L("dept_soda", "CeladonCity_DepartmentStore_Roof_Text_YaySodaPopHaveThis", R)
L("dept_lemonade", "CeladonCity_DepartmentStore_Roof_Text_YayLemonadeHaveThis", R)
L("dept_tm16", "CeladonCity_DepartmentStore_Roof_Text_ExplainTM16")
L("dept_tm20", "CeladonCity_DepartmentStore_Roof_Text_ExplainTM20")
L("dept_tm33", "CeladonCity_DepartmentStore_Roof_Text_ExplainTM33")
L("dept_notthirsty", "CeladonCity_DepartmentStore_Roof_Text_ImNotThirstyAfterAll")
L("dept_sister", "CeladonCity_DepartmentStore_Roof_Text_MySisterIsImmature")
L("dept_sign", "CeladonCity_DepartmentStore_Roof_Text_FloorSign")
L("vend_what", "CeladonCity_DepartmentStore_Roof_Text_VendingMachineWhatDoesItHave")
X("vend_water", "Fresh Water ¥200")
X("vend_soda", "Soda Pop ¥300")
X("vend_lemonade", "Lemonade ¥350")
X("vend_exit", "Exit")
L("vend_money", "CeladonCity_DepartmentStore_Roof_Text_NotEnoughMoney")
L("vend_room", "CeladonCity_DepartmentStore_Roof_Text_NoMoreRoomForStuff")
X("vend_popped", "A can popped out!")
X("dept_done", "I’m not thirsty anymore!\\nThank you for the drinks!")
# Route 10 Pokemon Center
L("r10_types", "Route10_PokemonCenter_1F_Text_EveryTypeStrongerThanOthers")
L("r10_nugget", "Route10_PokemonCenter_1F_Text_NuggetUselessSoldFor5000")
L("r10_ghosts", "Route10_PokemonCenter_1F_Text_HeardGhostsHauntLavender")
L("r10_ask", "Route10_PokemonCenter_1F_Text_GiveEverstoneIfCaught20Mons", R)
X("r10_got", "Great! You have caught or owned\\n" + NUM + " kinds of Pokémon!\\rCongratulations!\\nHere you go!" + R)
L("r10_explain", "Route10_PokemonCenter_1F_Text_ExplainEverstone")
X("r10_short", "Let’s see...\\nUh-oh! You have caught only\\f" + NUM + " kinds of Pokémon!\\rYou need twenty kinds if you\\nwant the Everstone.")
# Route 3 Pokemon Center (FireRed's Route 4 one)
LS("karp_ask", "Route4_PokemonCenter_1F_Text_LaddieBuyMagikarpForJust500", YESNO)
L("karp_paid", "Route4_PokemonCenter_1F_Text_PaidOutrageouslyForMagikarp")
L("karp_no", "Route4_PokemonCenter_1F_Text_OnlyDoingThisAsFavorToYou")
L("karp_full", "Route4_PokemonCenter_1F_Text_NoRoomForMorePokemon")
L("karp_money", "Route4_PokemonCenter_1F_Text_YoullNeedMoreMoney")
L("karp_refund", "Route4_PokemonCenter_1F_Text_IDontGiveRefunds")
L("r3_six", "Route4_PokemonCenter_1F_Text_CanHaveSixMonsWithYou")
L("r3_rocket", "Route4_PokemonCenter_1F_Text_TeamRocketAttacksCerulean")
L("r3_pc", "Route4_PokemonCenter_1F_Text_ShouldStoreMonsUsingPC")

IDX = {k: i for i, (k, _) in enumerate(TEXT)}
assert len(IDX) == len(TEXT)
TEXT_LINES = [line for _, line in TEXT]

FLAGS = {
    "FLAG_P1_GOT_OLD_ROD": 2712,
    "FLAG_P1_GOT_OLD_AMBER": 2713,
    "FLAG_P1_GOT_EEVEE": 2714,
    "FLAG_P1_GOT_TM16": 2715,
    "FLAG_P1_GOT_TM20": 2716,
    "FLAG_P1_GOT_TM33": 2717,
    "FLAG_P1_GOT_EVERSTONE": 2718,
    "FLAG_P1_BOUGHT_MAGIKARP": 2719,
}

SCRIPTS = []


def S(comment, body):
    SCRIPTS.append((comment, body))
    return len(SCRIPTS)


def m(k):
    return IDX[k]


def simple(c, k):
    return S(c, f"\tsimple_npc_msg {m(k)}\n\tend\n")


def sign(c, k):
    return S(c, f"\tplay_se SEQ_SE_DP_SELECT\n\tlockall\n\tnpc_msg {m(k)}\n\twait_button\n\tclosemsg\n\treleaseall\n\tend\n")


def nurse():
    return "\tsetvar VAR_SPECIAL_x8007, 0\n\tcallstd std_nurse_joy\n\tend\n"


def yesno(var="VAR_SPECIAL_RESULT"):
    return f"\ttouchscreen_menu_hide\n\tgetmenuchoice {var}\n\ttouchscreen_menu_show\n"


SC = {}
SC["guru"] = S("Vermilion: the Fishing Guru (Old Rod)", f"""	play_se SEQ_SE_DP_SELECT
	lockall
	faceplayer
	buffer_players_name 0
	goto_if_set FLAG_P1_GOT_OLD_ROD, _guruAfter
	npc_msg {m('guru_ask')}
{yesno()}	compare VAR_SPECIAL_RESULT, 1
	goto_if_eq _guruNo
	npc_msg {m('guru_take')}
	goto_if_no_item_space ITEM_OLD_ROD, 1, _bagFull
	giveitem_no_check ITEM_OLD_ROD, 1
	setflag FLAG_P1_GOT_OLD_ROD
	npc_msg {m('guru_life')}
	goto _guruDone

_guruNo:
	npc_msg {m('guru_no')}
	goto _guruDone

_guruAfter:
	npc_msg {m('guru_after')}
_guruDone:
	wait_button
	closemsg
	releaseall
	end
""")
SC["mus_enjoy"] = simple("Pewter Museum: the receptionist", "mus_enjoy")
SC["mus_amber"] = S("Pewter Museum: the scientist in the back (Old Amber)", f"""	play_se SEQ_SE_DP_SELECT
	lockall
	faceplayer
	buffer_players_name 0
	goto_if_set FLAG_P1_GOT_OLD_AMBER, _amberAfter
	npc_msg {m('mus_amber')}
	goto_if_no_item_space ITEM_OLD_AMBER, 1, _bagFull
	giveitem_no_check ITEM_OLD_AMBER, 1
	setflag FLAG_P1_GOT_OLD_AMBER
_amberAfter:
	npc_msg {m('mus_amber2')}
	wait_button
	closemsg
	releaseall
	end
""")
SC["mus_genetic"] = simple("Pewter Museum: visitors", "mus_genetic")
SC["mus_sap"] = simple("", "mus_sap")
SC["mus_dragon"] = simple("", "mus_dragon")
SC["mus_fossils"] = simple("", "mus_fossils")
SC["mus_moonstone"] = simple("", "mus_moonstone")
SC["mus_pikachu"] = simple("", "mus_pikachu")
SC["mus_aero"] = sign("Pewter Museum: exhibits", "mus_aero")
SC["mus_kabutops"] = sign("", "mus_kabutops")
SC["mus_amberx"] = sign("", "mus_amberx")
SC["mus_shuttle"] = sign("", "mus_shuttle")
SC["mus_meteorite"] = sign("", "mus_meteorite")
SC["mus_space"] = sign("", "mus_space")
SC["roof_know"] = simple("Celadon Condominiums roof room: the know-it-all", "roof_know")
SC["roof_eevee"] = S("Celadon Condominiums roof room: the Poke Ball with Eevee", f"""	play_se SEQ_SE_DP_SELECT
	lockall
	get_party_count VAR_SPECIAL_x8005
	compare VAR_SPECIAL_x8005, 6
	goto_if_eq _eeveeFull
	npc_msg {m('roof_ball')}
	hide_person VAR_SPECIAL_LAST_TALKED
	setflag FLAG_P1_GOT_EEVEE
	give_mon 133, 25, 0, 0, 0, VAR_SPECIAL_RESULT
	buffer_players_name 0
	npc_msg {m('roof_eevee')}
	play_fanfare SEQ_ME_POKEGET
	wait_fanfare
	goto _eeveeDone

_eeveeFull:
	npc_msg {m('roof_full')}
_eeveeDone:
	wait_button
	closemsg
	releaseall
	end
""")
SC["roof_tms"] = sign("Celadon Condominiums roof room: the TM pamphlet", "roof_tms")


def drink(item, line, tm, flag, explain, local):
    return f"""_give{local}:
	hasitem {item}, 1, VAR_SPECIAL_RESULT
	compare VAR_SPECIAL_RESULT, 0
	goto_if_eq _next{local}
	goto_if_no_item_space {tm}, 1, _bagFull
	takeitem_no_check {item}, 1
	npc_msg {m(line)}
	giveitem_no_check {tm}, 1
	setflag {flag}
	npc_msg {m(explain)}
	goto _girlDone

"""


SC["dept_girl"] = S("Celadon Dept. Store roof: the thirsty girl (a TM for each kind of drink)", f"""	play_se SEQ_SE_DP_SELECT
	lockall
	faceplayer
	goto_if_unset FLAG_P1_GOT_TM16, _girlAsk
	goto_if_unset FLAG_P1_GOT_TM20, _girlAsk
	goto_if_unset FLAG_P1_GOT_TM33, _girlAsk
	npc_msg {m('dept_done')}
	goto _girlDone

_girlAsk:
	hasitem ITEM_FRESH_WATER, 1, VAR_SPECIAL_x8004
	hasitem ITEM_SODA_POP, 1, VAR_SPECIAL_x8005
	hasitem ITEM_LEMONADE, 1, VAR_SPECIAL_x8006
	addvar VAR_SPECIAL_x8004, VAR_SPECIAL_x8005
	addvar VAR_SPECIAL_x8004, VAR_SPECIAL_x8006
	compare VAR_SPECIAL_x8004, 0
	goto_if_eq _girlThirsty
	npc_msg {m('dept_give')}
{yesno()}	compare VAR_SPECIAL_RESULT, 1
	goto_if_eq _girlNo
	goto_if_set FLAG_P1_GOT_TM16, _nextWater
	goto _giveWater

""" + drink("ITEM_FRESH_WATER", "dept_water", "ITEM_TM016", "FLAG_P1_GOT_TM16", "dept_tm16", "Water").replace(
    "_nextWater:", "") + """_nextWater:
	goto_if_set FLAG_P1_GOT_TM20, _nextSoda
	goto _giveSoda

""" + drink("ITEM_SODA_POP", "dept_soda", "ITEM_TM020", "FLAG_P1_GOT_TM20", "dept_tm20", "Soda") + """_nextSoda:
	goto_if_set FLAG_P1_GOT_TM33, _girlNo
	goto _giveLemonade

""" + drink("ITEM_LEMONADE", "dept_lemonade", "ITEM_TM033", "FLAG_P1_GOT_TM33", "dept_tm33", "Lemonade") + f"""_nextLemonade:
_girlNo:
	npc_msg {m('dept_notthirsty')}
	goto _girlDone

_girlThirsty:
	npc_msg {m('dept_thirsty')}
_girlDone:
	wait_button
	closemsg
	releaseall
	end
""")
SC["dept_sister"] = simple("Celadon Dept. Store roof: her brother", "dept_sister")
SC["dept_sign"] = sign("Celadon Dept. Store roof: floor sign", "dept_sign")


def vend_leg(item, price, local):
    return f"""_vend{local}:
	hasenoughmoneyimmediate VAR_SPECIAL_RESULT, {price}
	compare VAR_SPECIAL_RESULT, 0
	goto_if_eq _vendMoney
	goto_if_no_item_space {item}, 1, _vendRoom
	submoneyimmediate {price}
	update_money_box
	play_se SEQ_SE_DP_REGI
	wait_se SEQ_SE_DP_REGI
	npc_msg {m('vend_popped')}
	giveitem_no_check {item}, 1
	goto _vendMenu

"""


SC["vend"] = S("Celadon Dept. Store roof: vending machine", f"""	play_se SEQ_SE_DP_SELECT
	lockall
	touchscreen_menu_hide
	show_money_box 20, 2
_vendMenu:
	npc_msg {m('vend_what')}
	menu_init 1, 1, 0, 1, VAR_SPECIAL_RESULT
	menu_item_add {m('vend_water')}, 255, 0
	menu_item_add {m('vend_soda')}, 255, 1
	menu_item_add {m('vend_lemonade')}, 255, 2
	menu_item_add {m('vend_exit')}, 255, 3
	menu_exec
	compare VAR_SPECIAL_RESULT, 0
	goto_if_eq _vendWater
	compare VAR_SPECIAL_RESULT, 1
	goto_if_eq _vendSoda
	compare VAR_SPECIAL_RESULT, 2
	goto_if_eq _vendLemonade
	goto _vendDone

""" + vend_leg("ITEM_FRESH_WATER", 200, "Water") + vend_leg("ITEM_SODA_POP", 300, "Soda")
    + vend_leg("ITEM_LEMONADE", 350, "Lemonade") + f"""_vendMoney:
	npc_msg {m('vend_money')}
	wait_button
	goto _vendDone

_vendRoom:
	npc_msg {m('vend_room')}
	wait_button
_vendDone:
	closemsg
	hide_money_box
	touchscreen_menu_show
	releaseall
	end
""")
SC["nurse"] = S("Pokemon Center nurse (Route 10, Route 3)", nurse())
SC["r10_types"] = simple("Route 10 Pokemon Center: visitors", "r10_types")
SC["r10_nugget"] = simple("", "r10_nugget")
SC["r10_ghosts"] = simple("", "r10_ghosts")
aide = aide_script("_aideLabel", 20, "ITEM_EVERSTONE", "FLAG_P1_GOT_EVERSTONE", m("r10_ask"), m("r10_got"),
                   m("r10_explain"), m("r10_short"), "Everstone")
SC["r10_aide"] = S("Route 10 Pokemon Center: Oak's Aide (Everstone)", aide.split(":\n", 1)[1])
SC["karp"] = S("Route 3 Pokemon Center: the Magikarp salesman", f"""	play_se SEQ_SE_DP_SELECT
	lockall
	faceplayer
	buffer_players_name 0
	goto_if_set FLAG_P1_BOUGHT_MAGIKARP, _karpRefund
	touchscreen_menu_hide
	show_money_box 20, 2
	npc_msg {m('karp_ask')}
	getmenuchoice VAR_SPECIAL_RESULT
	compare VAR_SPECIAL_RESULT, 1
	goto_if_eq _karpNo
	hasenoughmoneyimmediate VAR_SPECIAL_RESULT, 500
	compare VAR_SPECIAL_RESULT, 0
	goto_if_eq _karpMoney
	get_party_count VAR_SPECIAL_x8005
	compare VAR_SPECIAL_x8005, 6
	goto_if_eq _karpFull
	submoneyimmediate 500
	update_money_box
	give_mon 129, 5, 0, 0, 0, VAR_SPECIAL_RESULT
	setflag FLAG_P1_BOUGHT_MAGIKARP
	npc_msg {m('karp_paid')}
	play_fanfare SEQ_ME_POKEGET
	wait_fanfare
	goto _karpDone

_karpNo:
	npc_msg {m('karp_no')}
	goto _karpDone

_karpMoney:
	npc_msg {m('karp_money')}
	goto _karpDone

_karpFull:
	npc_msg {m('karp_full')}
_karpDone:
	wait_button
	closemsg
	hide_money_box
	touchscreen_menu_show
	releaseall
	end

_karpRefund:
	npc_msg {m('karp_refund')}
	wait_button
	closemsg
	releaseall
	end
""")
SC["r3_six"] = simple("Route 3 Pokemon Center: visitors", "r3_six")
SC["r3_rocket"] = simple("", "r3_rocket")
SC["r3_pc"] = simple("", "r3_pc")


def main():
    out = [HEADER, "// hack: generated by scripts/hack/gen_gifts.py (edit that, not this): FireRed's remaining gifts in Kanto",
           "// interiors.  events: data/eventdata/part1/641-646, text: data/text/921.txt\n", ".data\n"]
    out += [f"scrdef scr_seq_P1_GIFTS_{i + 1:03d}" + (f" // {c}" if c else "") for i, (c, _) in enumerate(SCRIPTS)]
    out.append("scrdef_end\n")
    out += [f"scr_seq_P1_GIFTS_{i + 1:03d}:\n" + body for i, (c, body) in enumerate(SCRIPTS)]
    out.append("_bagFull:\n\tcallstd std_bag_is_full\n\tclosemsg\n\treleaseall\n\tend\n")
    with open("data/scr_seq/scr_seq_01059_P1_GIFTS.s", "w", newline="\n") as f:
        f.write("\n".join(out))
    print(len(SCRIPTS), "scripts,", len(TEXT), "lines")


if __name__ == "__main__":
    main()

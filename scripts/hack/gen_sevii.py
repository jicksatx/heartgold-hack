#!/usr/bin/env python3
"""
hack: the Sevii Islands 1-3 in Part 1 (FireRed's detour with Bill), on Johto stand-ins:

    One Island      Cianwood City (75): its Pokemon Center (236) is the Pokemon Net Center, two houses (232, 235);
                    Treasure Beach is Cianwood's south beach
    Kindle Road     Route 47 (151), through the Cliff Edge Gate (279); a Cliff Cave mouth leads into the Ember Spa
                    (Cianwood's house 233)
    Mt. Ember       Mt. Silver: 1F (122) -> 2F (463) -> the summit (465), where Moltres waits instead of Red
    Two Island      Cherrygrove City (67): the Mart (68) is the Joyful Game Corner, its Pokemon Center (69), the
                    southwest house (70)
    Cape Brink      Route 30 (34) and Mr. Pokemon's house (143)
    Three Island    Azalea Town (74): Pokemon Center (166), Mart (165), Kurt's house (164), the Charcoal Kiln (163)
    Bond Bridge     Route 33 (37)
    Berry Forest    Ilex Forest (117), through the Azalea gatehouse (100)

the story: after the seventh Badge Bill meets Red outside Cinnabar's Gym and takes him to One Island (VAR_P1_SEVII),
Bill hands over the Meteorite for Two Island's Game Corner owner and Celio the Tri-Pass, Lostelle is rescued from a
Hypno in the Berry Forest, the Game Corner owner trades the Meteorite for a Moon Stone, and Bill sails back to Cinnabar.
the Seagallop sailors (the islands and Vermilion's harbor) sail between the islands once Red has the Tri-Pass.

writes data/scr_seq/scr_seq_01055_P1_SEVII.s and the map script headers 01056 (Cinnabar Island), 01057 (One Island
Pokemon Center) and 01058 (Joyful Game Corner); the text is data/text/920.txt (build_part1_text.py, TEXT below), the
Cinnabar lines are appended to data/text/912.txt (CINNABAR_TEXT) and the Vermilion harbor's to 877.txt (SAIL_TEXT).
events: data/eventdata/part1/617-640 (placed with the map tools used for the other Part 1 builds)

usage: python3 scripts/hack/gen_sevii.py
"""

P = "{STRVAR_1 3, 0, 0}"
R, N = "\\r", ""
YESNO = " {YESNO 0}"

# ------------------------------------------------------------------------------------------------ text (920.txt)
TEXT = []


def L(key, label, end=N, suffix=""):
    TEXT.append((key, ("L", label, end) if not suffix else ("LS", label, suffix)))


def X(key, text):
    TEXT.append((key, ("T", text)))


def SAIL_LINES():
    return [
        ("sail_ask", ("L", "Text_WhereDoYouWantToSail", N)),
        ("sail_go", ("T", "All right!\\nAll aboard Seagallop Hi-Speed!")),
        ("sail_nopass", ("T", "Ahoy! The Seagallop ferries sail\\nthe waters of the Sevii Islands.\\rYou’ll need a Tri-Pass to come\\naboard, though.")),
        ("sail_one", ("T", "One Island")),
        ("sail_two", ("T", "Two Island")),
        ("sail_three", ("T", "Three Island")),
        ("sail_verm", ("T", "Vermilion City")),
        ("sail_exit", ("T", "Exit")),
    ]


TEXT += SAIL_LINES()
# One Island
L("1i_sign", "OneIsland_Text_IslandSign")
L("1i_netsign", "OneIsland_Text_PokemonNetCenterSign")
L("1i_oldman", "OneIsland_Text_LuckyToHaveCelioHere")
L("1i_oldman2", "OneIsland_Text_HavePCLinkageWithKanto")
L("1i_balding", "OneIsland_Text_IsntWarmClimateHereGreat")
L("pc_hey", "OneIsland_PokemonCenter_1F_Text_BillHeyThereCelio", R)
L("pc_cantbelieve", "OneIsland_PokemonCenter_1F_Text_CelioCantBelieveYouCameOut", R)
L("pc_research", "OneIsland_PokemonCenter_1F_Text_BillHowsYourResearchComing", R)
L("pc_buddy", "OneIsland_PokemonCenter_1F_Text_ThisIsMyBuddyCelio", R)
L("pc_rising", "OneIsland_PokemonCenter_1F_Text_PlayerIsRisingPokemonChamp", R)
L("pc_impressive", "OneIsland_PokemonCenter_1F_Text_CelioThatsReallyImpressive", R)
L("pc_speed", "OneIsland_PokemonCenter_1F_Text_BillBringMeUpToSpeed", R)
L("pc_cantlink", "OneIsland_PokemonCenter_1F_Text_CelioPCsCantLinkWithYours", R)
L("pc_help", "OneIsland_PokemonCenter_1F_Text_BillLetMeHelpYou", R)
L("pc_meteorite", "OneIsland_PokemonCenter_1F_Text_CanYouDeliverThisMeteoritePlayer", R)
L("pc_gotmeteorite", "OneIsland_PokemonCenter_1F_Text_AcceptedMeteoriteFromBill")
L("pc_takethis", "OneIsland_PokemonCenter_1F_Text_CelioPleaseTakeThis", R)
L("pc_gottripass", "OneIsland_PokemonCenter_1F_Text_ObtainedTriPass")
X("pc_passexplain", "It’s a Pass for the ferry service\\nserving the local islands.\\rIt will let you travel between the\\nIslands One, Two, and Three.\\rThe ferries also call at Vermilion\\nCity’s harbor." + R)
L("pc_catchyou", "OneIsland_PokemonCenter_1F_Text_BillCatchYouLater")
L("pc_billbusy", "OneIsland_PokemonCenter_1F_Text_HmmHowAboutLikeThis")
L("pc_celiosorry", "OneIsland_PokemonCenter_1F_Text_SorryForBeingPoorHost")
L("pc_celiolater", "OneIsland_PokemonCenter_1F_Text_CelioImModifyingMyNetworkMachine")
L("pc_ohhey", "OneIsland_PokemonCenter_1F_Text_BillOhHeyPlayer", R)
L("pc_done", "OneIsland_PokemonCenter_1F_Text_BillWeGotItDone", R)
L("pc_quick", "OneIsland_PokemonCenter_1F_Text_CelioJobWentQuick", R)
L("pc_learned", "OneIsland_PokemonCenter_1F_Text_BillYouveLearnedALot", R)
L("pc_ehehe", "OneIsland_PokemonCenter_1F_Text_CelioOhReallyEhehe", R)
L("pc_headback", "OneIsland_PokemonCenter_1F_Text_BillWeShouldHeadBackToKanto", R)
L("pc_promise", "OneIsland_PokemonCenter_1F_Text_CelioPromiseIllShowYouAroundSometime")
L("pc_pallet", "OneIsland_PokemonCenter_1F_Text_CameFromPalletDontKnowIt")
L("pc_volcano", "OneIsland_PokemonCenter_1F_Text_EnormousVolcanoOnIsland")
L("pc_boyfriend", "OneIsland_PokemonCenter_1F_Text_WishICouldTradeWithBoyfriend")
L("pc_machine0", "OneIsland_PokemonCenter_1F_Text_MachineUnderAdjustment")
L("pc_machine1", "OneIsland_PokemonCenter_1F_Text_MachineLinkedWithKanto")
L("1h1_gaze", "OneIsland_House1_Text_GazeUponVolcanoOnSunnyDays")
L("1h1_erupt", "OneIsland_House1_Text_LastTimeMtEmberErupted")
L("1h2_stay", "OneIsland_House2_Text_IWantToStayHereForever")
L("kr_sign", "OneIsland_KindleRoad_Text_RouteSign")
L("kr_spasign", "OneIsland_KindleRoad_Text_EmberSpaSign")
L("spa_hm06", "OneIsland_KindleRoad_EmberSpa_Text_UsedThisToMakeEmberSpa", R)
L("spa_hm06x", "OneIsland_KindleRoad_EmberSpa_Text_ExplainHM06")
L("spa_warm", "OneIsland_KindleRoad_EmberSpa_Text_WaterWarmsMeToCore")
L("spa_chowder", "OneIsland_KindleRoad_EmberSpa_Text_EnjoyBowlOfChowder")
L("spa_bruno", "OneIsland_KindleRoad_EmberSpa_Text_BrunoVisitsSpaOnOccasion")
X("spa_welcome", "Welcome to the Ember Spa!\\rPlease, have a good long soak in\\nour hot spring." + R)
L("spa_refreshed", "OneIsland_KindleRoad_EmberSpa_Text_WaterExquisiteFullyRefreshed")
L("tb_boy", "OneIsland_TreasureBeach_Text_GoodThingsWashUpOnBeach")
X("edge", "The currents here are fast and\\ntreacherous.\\rYou can’t go any farther this way.")
# Two Island
L("2i_sign", "TwoIsland_Text_IslandSign")
L("2i_gcsign", "TwoIsland_Text_JoyfulGameCornerSign")
L("2i_current", "TwoIsland_Text_DangerFastCurrent")
L("2i_shop", "TwoIsland_Text_WelcomeToShopMerchandiseLimited", R)
L("2i_celadon", "TwoIsland_Text_FellowMovedFromCeladonCity")
L("2i_bruno", "TwoIsland_Text_BrunoCameToIslandWhileBack")
L("2i_cape", "TwoIsland_Text_OldWomanLivesOutOnCape")
L("2pc_gc", "TwoIsland_PokemonCenter_1F_Text_HaveYouVisitedGameCorner")
L("2pc_cape", "TwoIsland_PokemonCenter_1F_Text_OldLadyLivesOutOnCape")
L("gc_help", "TwoIsland_JoyfulGameCorner_Text_PleaseHelpFindLostelle")
L("gc_rescued", "TwoIsland_JoyfulGameCorner_Text_YouRescuedLostelle", R)
L("gc_forme", "TwoIsland_JoyfulGameCorner_Text_ThisIsForMe", R)
L("gc_handed", "TwoIsland_JoyfulGameCorner_Text_HandedMeteoriteToLostellesDaddy")
L("gc_frombill", "TwoIsland_JoyfulGameCorner_Text_OhThisIsFromBill", R)
L("gc_bagfull", "TwoIsland_JoyfulGameCorner_Text_NotGoingToFitInBag")
L("gc_running", "TwoIsland_JoyfulGameCorner_Text_IllGetGameCornerRunning")
L("gc_info", "TwoIsland_JoyfulGameCorner_Text_NotRunningAnyGamesToday")
L("gc_info2", "TwoIsland_JoyfulGameCorner_Text_GetGamesGoingSoon")
L("gc_lostelle", "TwoIsland_JoyfulGameCorner_Text_LostelleItsOkayDaddy")
X("2h_maniac", "I’m the Pokémon Move Maniac.\\rI know every single move that\\nPokémon learn growing up.\\rI’m also a mushroom maniac.\\nMushrooms are so very fine...")
X("cb_woman", "Oh? I see the spark of a true\\nTrainer in your Pokémon.\\rI have taught ultimate moves to\\nthe Pokémon of great Trainers.\\rCome back once you have become\\nthe Champion, child.")
# Three Island
L("3i_sign", "ThreeIsland_Text_IslandSign")
L("3i_stare", "ThreeIsland_Text_WannaMakeSomethingOfYourStaring", suffix=YESNO)
L("3i_smart", "ThreeIsland_Text_ThatsSmart")
L("3i_b1", "ThreeIsland_Text_Biker1Intro")
L("3i_b1p", "ThreeIsland_Text_Biker1PostBattle", R)
L("3i_b2", "ThreeIsland_Text_Biker2Intro")
L("3i_b2p", "ThreeIsland_Text_Biker2PostBattle", R)
L("3i_b3", "ThreeIsland_Text_Biker3Intro")
L("3i_b3p", "ThreeIsland_Text_Biker3PostBattle", R)
L("3i_pax", "ThreeIsland_Text_PaxtonIntro")
L("3i_paxp", "ThreeIsland_Text_PaxtonPostBattle")
L("3i_goback", "ThreeIsland_Text_GoBackToKanto")
L("3i_thanks", "ThreeIsland_Text_ThankYouOhYourMonGotHurt", R)
L("3i_impressive", "ThreeIsland_Text_YouveGotImpressiveMons")
L("3i_bagfull", "ThreeIsland_Text_OhYourBagIsFull")
L("3i_bondbridge", "ThreeIsland_Text_LostelleWentOffTowardsBondBridge")
L("3i_woman", "ThreeIsland_Text_WouldntWantToSeeBikersHereAgain")
L("3i_boy", "ThreeIsland_Text_WhenDodouEvolvesGoingToPlayGame")
L("3pc_link", "ThreeIsland_PokemonCenter_1F_Text_PCNetworkCanLinkWithKanto")
L("3pc_surf", "ThreeIsland_PokemonCenter_1F_Text_ImpossibleToSurfBetweenIslands")
L("3pc_berries", "ThreeIsland_PokemonCenter_1F_Text_AlwaysBerriesInBerryForest")
L("3m_celadon", "ThreeIsland_Mart_Text_TrueThatCeldadonDeptStoreBigger")
L("3m_berries", "ThreeIsland_Mart_Text_PeopleHealWithBerriesFromForest")
L("3m_bikers", "ThreeIsland_Mart_Text_BikersWereAboutToTrashMart")
L("3h_rocks", "ThreeIsland_House1_Text_RareRocksGemsDisplayed")
L("3h_notlostelle", "ThreeIsland_House5_Text_ImNotLostelle")
L("3h_ghosts", "ThreeIsland_House4_Text_GhostsInBerryForest")
L("3h_papa", "ThreeIsland_House4_Text_PapaKeepsLyingToMe")
L("3h_quiet", "ThreeIsland_House3_Text_WantedToLiveSomewhereQuiet")
L("bb_sign", "ThreeIsland_BondBridge_Text_BondBridgeSign")
L("bf_ahead", "ThreeIsland_BondBridge_Text_BerryForestAhead")
L("bf_welcome", "ThreeIsland_BerryForest_Text_WelcomeToBerryForest")
L("bf_beware", "ThreeIsland_BerryForest_Text_BewareWildBerryLovingMons")
L("bf_help", "ThreeIsland_BerryForest_Text_HelpScaryPokemon", R)
L("bf_again", "ThreeIsland_BerryForest_Text_HereItComesAgain")
L("bf_thanks", "ThreeIsland_BerryForest_Text_ThankYouHaveThis", R)
L("bf_pouchfull", "ThreeIsland_BerryForest_Text_BerryPouchIsFull", R)
L("bf_home", "ThreeIsland_BerryForest_Text_LetsGoHome")
X("gate_guard", "The Berry Forest lies just past\\nthis gate.\\rWild Pokémon love the Berries\\nthere, so take care!")

IDX = {k: i for i, (k, _) in enumerate(TEXT)}
assert len(IDX) == len(TEXT), "duplicate text keys"
TEXT_LINES = [line for _, line in TEXT]

# lines appended to Cinnabar's 912.txt (after its 43 lines) and the Vermilion harbor's 877.txt (after its 5)
CINNABAR_BASE = 43
CINNABAR_TEXT = [
    ("L", "CinnabarIsland_Text_HeyIfItIsntPlayer", R),
    ("LS", "CinnabarIsland_Text_ComeWithMeToOneIsland", YESNO),
    ("L", "CinnabarIsland_Text_AllRightLetsGo", R),
    ("L", "CinnabarIsland_Text_MyPalsBoatArrived", N),
    ("L", "CinnabarIsland_Text_IllBeWaitingInPokeCenter", N),
    ("T", "Bill: Oh, " + P + "!\\nAre you ready to go to One Island?" + YESNO),
    ("T", "Bill: No rush. Come see me when\\nyou’re done with your business here."),
]
VERMILION_BASE = 5
SAIL_TEXT = [line for _, line in SAIL_LINES()]

# ------------------------------------------------------------------------------------------------ flags, places
FLAGS = {
    "FLAG_P1_HIDE_CINNABAR_BILL": 2692,
    "FLAG_P1_HIDE_CINNABAR_PC_BILL": 2693,
    "FLAG_P1_HIDE_ONE_ISLAND_BILL": 2694,
    "FLAG_P1_RESCUED_LOSTELLE": 2695,
    "FLAG_P1_HIDE_HOME_LOSTELLE": 2696,
    "FLAG_P1_BEAT_THREE_ISLAND_BIKERS": 2697,
    "FLAG_P1_GOT_THREE_ISLAND_FULL_RESTORE": 2698,
    "FLAG_P1_HIDE_MOLTRES": 2699,
    "FLAG_P1_GOT_HM06": 2700,
}
# the Sevii item balls reuse HeartGold item-ball flags of Johto maps Part 1 never loads (Routes 42-46, Mt. Mortar...);
# Part 2 starts from a wiped save anyway.  (map, item, flag)
ITEMS = [
    ("kindle", "ITEM_ETHER"), ("kindle", "ITEM_MAX_REPEL"), ("kindle", "ITEM_CARBOS"),
    ("beach", "ITEM_STAR_PIECE"), ("beach", "ITEM_BIG_PEARL"), ("beach", "ITEM_PEARL"), ("beach", "ITEM_ULTRA_BALL"),
    ("ember", "ITEM_ULTRA_BALL"), ("ember", "ITEM_FIRE_STONE"), ("ember", "ITEM_DIRE_HIT"),
    ("two", "ITEM_REVIVE"),
    ("cape", "ITEM_PP_MAX"), ("cape", "ITEM_RARE_CANDY"),
    ("three", "ITEM_ZINC"), ("three", "ITEM_PP_UP"),
    ("bond", "ITEM_MAX_REPEL"), ("bond", "ITEM_PEARL"), ("bond", "ITEM_STARDUST"),
    ("berry", "ITEM_MAX_ETHER"), ("berry", "ITEM_FULL_HEAL"), ("berry", "ITEM_MAX_ELIXIR"),
]
ITEM_FLAG0 = 1172
VAR_SEVII = "VAR_P1_SEVII"

# warp targets (map, x, z, facing).  set by the events builder's placements: keep in sync with data/eventdata/part1/617-640
ARRIVE = {
    "one": (75, 188, 357, 3),          # One Island harbor, east of town (sailor at 189,357)
    "two": (67, 540, 400, 2),          # Two Island's west shore (sailor at 539,400)
    "three": (74, 408, 462, 2),        # Three Island, by the Pokemon Center (sailor at 407,462)
    "verm": (386, 12, 5, 0),           # Vermilion harbor building (sailor at 12,4)
    "onepc": (236, 8, 17, 0),          # One Island Pokemon Center, at Bill and Celio
    "cinnabar": (57, 1039, 503, 1),    # Cinnabar, in front of the Pokemon Center
    "gamecorner": (68, 7, 9, 0),       # Joyful Game Corner, at the owner
}

# object ids the scripts move/hide (placed first in their events files, in this order)
OBJ_CINNABAR_BILL = 3          # Cinnabar Island (after its 3 objects)
OBJ_1PC_BILL, OBJ_1PC_CELIO = 0, 1
OBJ_BIKERS = [0, 1, 2, 3]      # Three Island: Goon, Goon 2, Goon 3, Paxton
OBJ_LOSTELLE = 0               # Berry Forest

# ------------------------------------------------------------------------------------------------ scripts
SCRIPTS = []  # (comment, body)


def S(comment, body):
    SCRIPTS.append((comment, body))
    return len(SCRIPTS)


def m(key):
    return IDX[key]


def simple(comment, key):
    return S(comment, f"\tsimple_npc_msg {m(key)}\n\tend\n")


def warp_to(where, fade_in=True):
    mp, x, z, d = ARRIVE[where]
    dirs = ["DIR_NORTH", "DIR_SOUTH", "DIR_WEST", "DIR_EAST"]
    return f"\tfade_screen 6, 1, 0, 0\n\twait_fade\n\twarp {mp}, 0, {x}, {z}, {dirs[d]}\n" + \
        ("\tfade_screen 6, 1, 1, 0\n\twait_fade\n" if fade_in else "")


def sail(comment, here, msgf=m, local=""):
    """a Seagallop sailor: needs the Tri-Pass (VAR_P1_SEVII >= 4), sails to the other ports"""
    dests = [d for d in ("one", "two", "three", "verm") if d != here]
    items = "".join(f"\tmenu_item_add {msgf('sail_' + d)}, 255, {i}\n" for i, d in enumerate(dests))
    goto = "".join(f"\tcompare VAR_SPECIAL_RESULT, {i}\n\tgoto_if_eq _sail{local}{d}\n" for i, d in enumerate(dests))
    legs = "".join(f"_sail{local}{d}:\n\tnpc_msg {msgf('sail_go')}\n\twait_button\n\tclosemsg\n\tplay_se SEQ_SE_DP_KAIDAN2\n" +
                   warp_to(d) + "\treleaseall\n\tend\n\n" for d in dests)
    return f"""	play_se SEQ_SE_DP_SELECT
	lockall
	faceplayer
	compare {VAR_SEVII}, 4
	goto_if_lt _sail{local}NoPass
	npc_msg {msgf('sail_ask')}
	menu_init 1, 1, 0, 1, VAR_SPECIAL_RESULT
{items}	menu_item_add {msgf('sail_exit')}, 255, 9
	menu_exec
{goto}	closemsg
	releaseall
	end

{legs}_sail{local}NoPass:
	npc_msg {msgf('sail_nopass')}
	wait_button
	closemsg
	releaseall
	end
"""


def talk(lines, pre="", post=""):
    """lockall/faceplayer, the lines (the last one waits for a button), release"""
    out = "\tplay_se SEQ_SE_DP_SELECT\n\tlockall\n\tfaceplayer\n\tbuffer_players_name 0\n" + pre
    out += "".join(f"\tnpc_msg {m(k)}\n" for k in lines)
    return out + "\twait_button\n\tclosemsg\n" + post + "\treleaseall\n\tend\n"


def nurse():
    return "\tsetvar VAR_SPECIAL_x8007, 0\n\tcallstd std_nurse_joy\n\tend\n"


def mart(lines=()):
    pre = "".join(f"\tnpc_msg {m(k)}\n" for k in lines)
    return f"""	play_se SEQ_SE_DP_SELECT
	lockall
	faceplayer
{pre}	callstd std_mart_intro
	holdmsg
	setvar VAR_SPECIAL_x8004, 1
	callstd std_pokemart
	releaseall
	end
"""


def item_ball(item, flag):
    return f"""	play_se SEQ_SE_DP_SELECT
	lockall
	goto_if_no_item_space {item}, 1, _ballFull
	hide_person VAR_SPECIAL_LAST_TALKED
	setflag {flag}
	giveitem_no_check {item}, 1
	closemsg
	releaseall
	end
"""


SC = {}  # name -> script number
# ---- One Island
SC["1i_sign"] = simple("One Island sign", "1i_sign")
SC["1i_netsign"] = simple("Pokemon Net Center sign", "1i_netsign")
SC["1i_sail"] = S("One Island: Seagallop sailor", sail("", "one", local="One"))
SC["1i_oldman"] = S("One Island: old man", f"""	play_se SEQ_SE_DP_SELECT
	lockall
	faceplayer
	compare {VAR_SEVII}, 6
	goto_if_ge _oldManLinked
	npc_msg {m('1i_oldman')}
	goto _oldManDone

_oldManLinked:
	npc_msg {m('1i_oldman2')}
_oldManDone:
	wait_button
	closemsg
	releaseall
	end
""")
SC["1i_balding"] = simple("One Island: balding man", "1i_balding")
SC["1pc_nurse"] = S("One Island Pokemon Center: nurse", nurse())
SC["1pc_celio"] = S("One Island Pokemon Center: Celio", f"""	play_se SEQ_SE_DP_SELECT
	lockall
	faceplayer
	buffer_players_name 0
	compare {VAR_SEVII}, 6
	goto_if_ge _celioLater
	npc_msg {m('pc_celiosorry')}
	goto _celioDone

_celioLater:
	npc_msg {m('pc_celiolater')}
_celioDone:
	wait_button
	closemsg
	releaseall
	end
""")
SC["1pc_bill"] = S("One Island Pokemon Center: Bill (busy at the Network Machine)", talk(["pc_billbusy"]))
SC["1pc_pallet"] = simple("One Island Pokemon Center: visitors", "pc_pallet")
SC["1pc_volcano"] = simple("", "pc_volcano")
SC["1pc_boyfriend"] = simple("", "pc_boyfriend")
SC["1pc_machine"] = S("One Island Pokemon Center: Network Machine", f"""	play_se SEQ_SE_DP_SELECT
	lockall
	compare {VAR_SEVII}, 6
	goto_if_ge _machineLinked
	npc_msg {m('pc_machine0')}
	goto _machineDone

_machineLinked:
	npc_msg {m('pc_machine1')}
_machineDone:
	wait_button
	closemsg
	releaseall
	end
""")
SC["1pc_meet"] = S("One Island Pokemon Center: Bill introduces Celio (frame, VAR_P1_SEVII 3)", f"""	lockall
	buffer_players_name 0
	npc_msg {m('pc_hey')}
	npc_msg {m('pc_cantbelieve')}
	npc_msg {m('pc_research')}
	npc_msg {m('pc_buddy')}
	npc_msg {m('pc_rising')}
	npc_msg {m('pc_impressive')}
	npc_msg {m('pc_speed')}
	npc_msg {m('pc_cantlink')}
	npc_msg {m('pc_help')}
	npc_msg {m('pc_meteorite')}
	npc_msg {m('pc_gotmeteorite')}
	play_fanfare SEQ_ME_KEYITEM
	wait_fanfare
	wait_button
	npc_msg {m('pc_takethis')}
	npc_msg {m('pc_gottripass')}
	play_fanfare SEQ_ME_KEYITEM
	wait_fanfare
	wait_button
	npc_msg {m('pc_passexplain')}
	npc_msg {m('pc_catchyou')}
	wait_button
	closemsg
	setvar {VAR_SEVII}, 4
	releaseall
	end
""")
SC["1pc_return"] = S("One Island Pokemon Center: the job's done, back to Kanto (frame, VAR_P1_SEVII 5)", f"""	lockall
	buffer_players_name 0
	npc_msg {m('pc_ohhey')}
	npc_msg {m('pc_done')}
	npc_msg {m('pc_quick')}
	npc_msg {m('pc_learned')}
	npc_msg {m('pc_ehehe')}
	npc_msg {m('pc_headback')}
	npc_msg {m('pc_promise')}
	wait_button
	closemsg
	setvar {VAR_SEVII}, 6
	setflag FLAG_P1_HIDE_ONE_ISLAND_BILL
	play_se SEQ_SE_DP_KAIDAN2
""" + warp_to("cinnabar") + "\treleaseall\n\tend\n")
SC["1pc_transition"] = S("One Island Pokemon Center: on transition (Bill is here from the first visit until the trip back)", f"""	compare {VAR_SEVII}, 3
	goto_if_lt _billAway
	compare {VAR_SEVII}, 5
	goto_if_gt _billAway
	clearflag FLAG_P1_HIDE_ONE_ISLAND_BILL
	end

_billAway:
	setflag FLAG_P1_HIDE_ONE_ISLAND_BILL
	end
""")
SC["1h1_gaze"] = simple("One Island houses", "1h1_gaze")
SC["1h1_erupt"] = simple("", "1h1_erupt")
SC["1h2_stay"] = simple("", "1h2_stay")
SC["kr_sign"] = simple("Kindle Road sign", "kr_sign")
SC["kr_spasign"] = simple("Ember Spa sign", "kr_spasign")
SC["spa_hm06"] = S("Ember Spa: the old man (HM06 Rock Smash)", f"""	play_se SEQ_SE_DP_SELECT
	lockall
	faceplayer
	goto_if_set FLAG_P1_GOT_HM06, _hm06Explain
	npc_msg {m('spa_hm06')}
	goto_if_no_item_space ITEM_HM06, 1, _bagFull
	giveitem_no_check ITEM_HM06, 1
	setflag FLAG_P1_GOT_HM06
_hm06Explain:
	npc_msg {m('spa_hm06x')}
	wait_button
	closemsg
	releaseall
	end
""")
SC["spa_warm"] = simple("Ember Spa: bathers", "spa_warm")
SC["spa_chowder"] = simple("", "spa_chowder")
SC["spa_bruno"] = simple("", "spa_bruno")
SC["spa_attendant"] = S("Ember Spa: attendant (the hot spring heals the party)", f"""	play_se SEQ_SE_DP_SELECT
	lockall
	faceplayer
	npc_msg {m('spa_welcome')}
	closemsg
	fade_screen 6, 1, 0, 0
	wait_fade
	heal_party
	play_se SEQ_SE_DP_KAIFUKU
	fade_screen 6, 1, 1, 0
	wait_fade
	buffer_players_name 0
	npc_msg {m('spa_refreshed')}
	wait_button
	closemsg
	releaseall
	end
""")
SC["tb_boy"] = simple("Treasure Beach: beachcomber", "tb_boy")
SC["moltres"] = S("Mt. Ember summit: Moltres", """	play_se SEQ_SE_DP_SELECT
	lockall
	faceplayer
	play_cry SPECIES_MOLTRES, 0
	wait_cry
	setflag FLAG_ENGAGING_STATIC_POKEMON
	wild_battle SPECIES_MOLTRES, 50, 0
	clearflag FLAG_ENGAGING_STATIC_POKEMON
	check_battle_won VAR_SPECIAL_RESULT
	compare VAR_SPECIAL_RESULT, 0
	goto_if_eq _lost
	hide_person VAR_SPECIAL_LAST_TALKED
	setflag FLAG_P1_HIDE_MOLTRES
	get_static_encounter_outcome VAR_TEMP_x4005
	compare VAR_TEMP_x4005, 5 // BATTLE_OUTCOME_PLAYER_FLED
	goto_if_ne _moltresDone
	clearflag FLAG_P1_HIDE_MOLTRES // ran away: it's back next time (FireRed)
_moltresDone:
	releaseall
	end
""")
SC["edge"] = S("the edge of a stand-in map (coord): turn back", f"""	lockall
	get_player_facing VAR_SPECIAL_RESULT
	npc_msg {m('edge')}
	wait_button
	closemsg
	compare VAR_SPECIAL_RESULT, 0
	goto_if_eq _edgeSouth
	compare VAR_SPECIAL_RESULT, 1
	goto_if_eq _edgeNorth
	compare VAR_SPECIAL_RESULT, 2
	goto_if_eq _edgeEast
	apply_movement obj_player, _stepWest
	goto _edgeDone

_edgeSouth:
	apply_movement obj_player, _stepSouth
	goto _edgeDone

_edgeNorth:
	apply_movement obj_player, _stepNorth
	goto _edgeDone

_edgeEast:
	apply_movement obj_player, _stepEast
_edgeDone:
	wait_movement
	releaseall
	end
""")
# ---- Two Island
SC["2i_sign"] = simple("Two Island sign", "2i_sign")
SC["2i_gcsign"] = simple("Joyful Game Corner sign", "2i_gcsign")
SC["2i_current"] = simple("Fast current sign", "2i_current")
SC["2i_sail"] = S("Two Island: Seagallop sailor", sail("", "two", local="Two"))
SC["2i_shop"] = S("Two Island: the shop", mart(["2i_shop"]))
SC["2i_celadon"] = simple("Two Island: islanders", "2i_celadon")
SC["2i_bruno"] = simple("", "2i_bruno")
SC["2i_cape"] = simple("", "2i_cape")
SC["2pc_nurse"] = S("Two Island Pokemon Center: nurse", nurse())
SC["2pc_gc"] = simple("Two Island Pokemon Center: visitors", "2pc_gc")
SC["2pc_cape"] = simple("", "2pc_cape")
SC["gc_daddy"] = S("Joyful Game Corner: Lostelle's daddy (the Meteorite for a Moon Stone)", f"""	play_se SEQ_SE_DP_SELECT
	lockall
	faceplayer
	buffer_players_name 0
	compare {VAR_SEVII}, 5
	goto_if_ge _daddyRunning
	goto_if_set FLAG_P1_RESCUED_LOSTELLE, _daddyRescued
	npc_msg {m('gc_help')}
	goto _daddyDone

_daddyRescued:
	goto_if_no_item_space ITEM_MOON_STONE, 1, _daddyBagFull
	npc_msg {m('gc_rescued')}
	npc_msg {m('gc_forme')}
	npc_msg {m('gc_handed')}
	play_fanfare SEQ_ME_KEYITEM
	wait_fanfare
	wait_button
	npc_msg {m('gc_frombill')}
	giveitem_no_check ITEM_MOON_STONE, 1
	setvar {VAR_SEVII}, 5
	closemsg
	releaseall
	end

_daddyBagFull:
	npc_msg {m('gc_bagfull')}
	goto _daddyDone

_daddyRunning:
	npc_msg {m('gc_running')}
_daddyDone:
	wait_button
	closemsg
	releaseall
	end
""")
SC["gc_info"] = S("Joyful Game Corner: attendant", f"""	play_se SEQ_SE_DP_SELECT
	lockall
	faceplayer
	goto_if_set FLAG_P1_RESCUED_LOSTELLE, _infoSoon
	npc_msg {m('gc_info')}
	goto _infoDone

_infoSoon:
	npc_msg {m('gc_info2')}
_infoDone:
	wait_button
	closemsg
	releaseall
	end
""")
SC["gc_lostelle"] = S("Joyful Game Corner: Lostelle, home again", talk(["gc_lostelle"]))
SC["gc_transition"] = S("Joyful Game Corner: on transition (Lostelle is home once rescued)", """	goto_if_set FLAG_P1_RESCUED_LOSTELLE, _lostelleHome
	setflag FLAG_P1_HIDE_HOME_LOSTELLE
	end

_lostelleHome:
	clearflag FLAG_P1_HIDE_HOME_LOSTELLE
	end
""")
SC["2h_maniac"] = simple("Two Island house: the Move Maniac", "2h_maniac")
SC["cb_woman"] = simple("Cape Brink: the old woman", "cb_woman")
# ---- Three Island
SC["3i_sign"] = simple("Three Island sign", "3i_sign")
SC["3i_sail"] = S("Three Island: Seagallop sailor", sail("", "three", local="Three"))
hides = "".join(f"\thide_person {o}\n" for o in OBJ_BIKERS)


def biker_battle(intro, trainer, post):
    return f"""	npc_msg {m(intro)}
	wait_button
	closemsg
	trainer_battle {trainer}, 0, 0, 0
	check_battle_won VAR_SPECIAL_RESULT
	compare VAR_SPECIAL_RESULT, 0
	goto_if_eq _lost
""" + (f"\tnpc_msg {m(post)}\n" if post else "")


SC["3i_bikers"] = S("Three Island: the Bikers (any of them starts the four battles)", f"""	play_se SEQ_SE_DP_SELECT
	lockall
	faceplayer
	npc_msg {m('3i_stare')}
	touchscreen_menu_hide
	getmenuchoice VAR_SPECIAL_RESULT
	touchscreen_menu_show
	compare VAR_SPECIAL_RESULT, 1
	goto_if_eq _bikersDecline
	closemsg
""" + biker_battle("3i_b1", "TRAINER_P1_BIKER_GOON", "3i_b1p")
    + biker_battle("3i_b2", "TRAINER_P1_BIKER_GOON_2", "3i_b2p")
    + biker_battle("3i_b3", "TRAINER_P1_BIKER_GOON_3", "3i_b3p")
    + biker_battle("3i_pax", "TRAINER_P1_CUE_BALL_PAXTON", None) + f"""	npc_msg {m('3i_paxp')}
	wait_button
	closemsg
	fade_screen 6, 1, 0, 0
	wait_fade
{hides}	setflag FLAG_P1_BEAT_THREE_ISLAND_BIKERS
	fade_screen 6, 1, 1, 0
	wait_fade
	releaseall
	end

_bikersDecline:
	npc_msg {m('3i_smart')}
	wait_button
	closemsg
	releaseall
	end
""")
SC["3i_anti1"] = S("Three Island: islander standing up to the Bikers (Full Restore)", f"""	play_se SEQ_SE_DP_SELECT
	lockall
	faceplayer
	buffer_players_name 0
	goto_if_set FLAG_P1_GOT_THREE_ISLAND_FULL_RESTORE, _antiImpressive
	goto_if_set FLAG_P1_BEAT_THREE_ISLAND_BIKERS, _antiThanks
	npc_msg {m('3i_goback')}
	goto _antiDone

_antiThanks:
	npc_msg {m('3i_thanks')}
	goto_if_no_item_space ITEM_FULL_RESTORE, 1, _antiBagFull
	giveitem_no_check ITEM_FULL_RESTORE, 1
	setflag FLAG_P1_GOT_THREE_ISLAND_FULL_RESTORE
_antiImpressive:
	npc_msg {m('3i_impressive')}
	goto _antiDone

_antiBagFull:
	npc_msg {m('3i_bagfull')}
_antiDone:
	wait_button
	closemsg
	releaseall
	end
""")
SC["3i_anti2"] = simple("Three Island: islander (Lostelle went to Bond Bridge)", "3i_bondbridge")
SC["3i_woman"] = simple("Three Island: islanders", "3i_woman")
SC["3i_boy"] = simple("", "3i_boy")
SC["3pc_nurse"] = S("Three Island Pokemon Center: nurse", nurse())
SC["3pc_link"] = simple("Three Island Pokemon Center: visitors", "3pc_link")
SC["3pc_surf"] = simple("", "3pc_surf")
SC["3pc_berries"] = simple("", "3pc_berries")
SC["3m_clerk"] = S("Three Island Mart: clerk", mart())
SC["3m_celadon"] = simple("Three Island Mart: shoppers", "3m_celadon")
SC["3m_berries"] = simple("", "3m_berries")
SC["3m_bikers"] = simple("", "3m_bikers")
SC["3h_rocks"] = simple("Three Island houses", "3h_rocks")
SC["3h_notlostelle"] = simple("", "3h_notlostelle")
SC["3h_ghosts"] = simple("", "3h_ghosts")
SC["3h_papa"] = simple("", "3h_papa")
SC["3h_quiet"] = simple("", "3h_quiet")
SC["bb_sign"] = simple("Bond Bridge sign", "bb_sign")
SC["bf_ahead"] = simple("Berry Forest Ahead sign", "bf_ahead")
SC["bf_welcome"] = simple("Berry Forest signs", "bf_welcome")
SC["bf_beware"] = simple("", "bf_beware")
SC["gate_guard"] = simple("Berry Forest gate (Azalea gatehouse): guard", "gate_guard")
SC["bf_lostelle"] = S("Berry Forest: Lostelle and the Hypno", f"""	play_se SEQ_SE_DP_SELECT
	lockall
	faceplayer
	npc_msg {m('bf_help')}
	apply_movement {OBJ_LOSTELLE}, _lostelleScared
	wait_movement
	npc_msg {m('bf_again')}
	wait_button
	closemsg
	play_cry SPECIES_HYPNO, 0
	wait_cry
	wild_battle SPECIES_HYPNO, 30, 0
	check_battle_won VAR_SPECIAL_RESULT
	compare VAR_SPECIAL_RESULT, 0
	goto_if_eq _lost
	apply_movement {OBJ_LOSTELLE}, _faceDown
	wait_movement
	npc_msg {m('bf_thanks')}
	goto_if_no_item_space ITEM_IAPAPA_BERRY, 1, _lostellePouchFull
	giveitem_no_check ITEM_IAPAPA_BERRY, 1
	goto _lostelleGoHome

_lostellePouchFull:
	npc_msg {m('bf_pouchfull')}
_lostelleGoHome:
	npc_msg {m('bf_home')}
	wait_button
	closemsg
	setflag FLAG_P1_RESCUED_LOSTELLE
	hide_person {OBJ_LOSTELLE}
""" + warp_to("gamecorner") + "\treleaseall\n\tend\n")
ITEM_SCRIPTS = []
for i, (where, item) in enumerate(ITEMS):
    flag = ITEM_FLAG0 + i
    ITEM_SCRIPTS.append((where, item, flag, S(f"item ball: {where} {item}", item_ball(item, flag))))

# ---- Cinnabar Island additions (scr_seq_01038, appended after its 23 scripts) and the Vermilion harbor's sailor
CINNABAR_FIRST = 24


def cm(i):
    return CINNABAR_BASE + i


CINNABAR_SCRIPTS = [
    ("Bill, outside the Gym (frame, VAR_P1_SEVII 1)", f"""	lockall
	apply_movement {OBJ_CINNABAR_BILL}, _billNotice
	wait_movement
	buffer_players_name 0
	npc_msg {cm(0)}
	npc_msg {cm(1)}
	touchscreen_menu_hide
	getmenuchoice VAR_SPECIAL_RESULT
	touchscreen_menu_show
	compare VAR_SPECIAL_RESULT, 1
	goto_if_eq _billDecline
	npc_msg {cm(2)}
	npc_msg {cm(3)}
	wait_button
	closemsg
	setvar {VAR_SEVII}, 3
	setflag FLAG_P1_HIDE_CINNABAR_BILL
	play_se SEQ_SE_DP_KAIDAN2
""" + warp_to("onepc") + f"""	releaseall
	end

_billDecline:
	npc_msg {cm(4)}
	wait_button
	closemsg
	fade_screen 6, 1, 0, 0
	wait_fade
	hide_person {OBJ_CINNABAR_BILL}
	setflag FLAG_P1_HIDE_CINNABAR_BILL
	clearflag FLAG_P1_HIDE_CINNABAR_PC_BILL
	setvar {VAR_SEVII}, 2
	fade_screen 6, 1, 1, 0
	wait_fade
	releaseall
	end
"""),
    ("Bill, waiting in the Pokemon Center (VAR_P1_SEVII 2)", f"""	play_se SEQ_SE_DP_SELECT
	lockall
	faceplayer
	buffer_players_name 0
	npc_msg {cm(5)}
	touchscreen_menu_hide
	getmenuchoice VAR_SPECIAL_RESULT
	touchscreen_menu_show
	compare VAR_SPECIAL_RESULT, 1
	goto_if_eq _billWait
	npc_msg {cm(2)}
	npc_msg {cm(3)}
	wait_button
	closemsg
	setvar {VAR_SEVII}, 3
	setflag FLAG_P1_HIDE_CINNABAR_PC_BILL
	play_se SEQ_SE_DP_KAIDAN2
""" + warp_to("onepc") + f"""	releaseall
	end

_billWait:
	npc_msg {cm(6)}
	wait_button
	closemsg
	releaseall
	end
"""),
    ("on transition: after the seventh Badge, Bill waits outside the Gym", f"""	compare {VAR_SEVII}, 0
	goto_if_ne _billFlags
	check_badge BADGE_VOLCANO, VAR_SPECIAL_RESULT
	compare VAR_SPECIAL_RESULT, 0
	goto_if_eq _billFlags
	setvar {VAR_SEVII}, 1
_billFlags:
	setflag FLAG_P1_HIDE_CINNABAR_BILL
	setflag FLAG_P1_HIDE_CINNABAR_PC_BILL
	compare {VAR_SEVII}, 1
	goto_if_ne _billNotOutside
	clearflag FLAG_P1_HIDE_CINNABAR_BILL
_billNotOutside:
	compare {VAR_SEVII}, 2
	goto_if_ne _billFlagsDone
	clearflag FLAG_P1_HIDE_CINNABAR_PC_BILL
_billFlagsDone:
	end
"""),
]
CINNABAR_MOVES = """
	.balign 4
_billNotice:
	step 75, 1  // !
	step_end
"""
VERMILION_FIRST = 3


def vm(key):
    return VERMILION_BASE + [k for k, _ in SAIL_LINES()].index(key)


VERMILION_SCRIPT = sail("", "verm", msgf=vm, local="Verm")

HEADER = """.include "asm/include/interop_macros.inc"

.include "asm/include/scriptmacros.inc"
.include "asm/include/flags.inc"
.include "asm/include/soundeffects.inc"
.include "asm/include/vars.inc"

.include "asm/include/maps.inc"
.include "asm/include/std_scripts.inc"
.include "asm/include/trainers.inc"

#include "constants/item.h"
#include "config.h"
"""


def write_main():
    out = [HEADER, "// hack: generated by scripts/hack/gen_sevii.py (edit that, not this): " + __doc__.strip().splitlines()[0][6:],
           "// events: data/eventdata/part1/617-640, text: data/text/920.txt\n",
           ".equ SPECIES_MOLTRES, 146", ".equ SPECIES_HYPNO, 97\n", ".data\n"]
    for i, (c, _) in enumerate(SCRIPTS):
        out.append(f"scrdef scr_seq_P1_SEVII_{i + 1:03d}" + (f" // {c}" if c else ""))
    out.append("scrdef_end\n")
    for i, (c, body) in enumerate(SCRIPTS):
        out.append(f"scr_seq_P1_SEVII_{i + 1:03d}:\n" + body)
    out.append("""_ballFull:
_bagFull:
	callstd std_bag_is_full
	closemsg
	releaseall
	end

_lost:
	white_out
	releaseall
	end

	.balign 4
_stepSouth:
	step 13, 1
	step_end

	.balign 4
_stepNorth:
	step 12, 1
	step_end

	.balign 4
_stepEast:
	step 15, 1
	step_end

	.balign 4
_stepWest:
	step 14, 1
	step_end

	.balign 4
_lostelleScared:
	step 75, 1  // !
	step 2, 1
	step 3, 1
	step 2, 1
	step_end

	.balign 4
_faceDown:
	step 1, 1
	step_end
""")
    with open("data/scr_seq/scr_seq_01055_P1_SEVII.s", "w", newline="\n") as f:
        f.write("\n".join(out))


def header(path, comment, entries, frames=()):
    lines = [f"// hack: {comment}", "", ".data", ""]
    if frames:
        lines += ["\t.byte 1 // INIT_SCRIPT_ON_FRAME_TABLE", "\t.long _frameTable-.-4"]
    for kind, script in entries:
        lines += [f"\t.byte {kind} // " + {2: "INIT_SCRIPT_ON_TRANSITION", 3: "INIT_SCRIPT_ON_RESUME"}[kind], f"\t.hword {script}, 0"]
    lines += ["\t.byte 0 // end of entries"]
    if frames:
        lines += ["_frameTable:"] + [f"\t.hword {var}, {val}, {s}" for var, val, s in frames] + ["\t.hword 0"]
    lines += ["\t.balign 4, 0", ""]
    with open(path, "w", newline="\n") as f:
        f.write("\n".join(lines))


MARK = "// ---- Sevii Islands (generated by scripts/hack/gen_sevii.py) ----"


def patch(path, first, scripts, prefix, tail=""):
    """append generated scripts to a hand-written script file (numbered from `first`), replacing an earlier copy"""
    s = open(path).read()
    if MARK in s:
        s = s[:s.index(MARK)].rstrip("\n") + "\n"
    s = "\n".join(l for l in s.split("\n") if not (l.startswith("scrdef ") and "// Sevii:" in l))
    import re
    s = re.sub(r"\n+scrdef_end", "\nscrdef_end", s)
    defs = "".join(f"scrdef {prefix}{first + i:03d} // Sevii: {c}\n" for i, (c, _) in enumerate(scripts))
    s = s.replace("scrdef_end", defs + "scrdef_end", 1)
    s = s.rstrip("\n") + "\n\n" + MARK + "\n\n"
    s += "".join(f"{prefix}{first + i:03d}:\n{body}\n" for i, (c, body) in enumerate(scripts)) + tail
    open(path, "w", newline="\n").write(s)


def main():
    write_main()
    patch("data/scr_seq/scr_seq_01038_P1_T09.s", CINNABAR_FIRST, CINNABAR_SCRIPTS, "scr_seq_P1_T09_", CINNABAR_MOVES)
    patch("data/scr_seq/scr_seq_00997_P1_P01R0103.s", VERMILION_FIRST, [("Seagallop sailor", VERMILION_SCRIPT)],
          "scr_seq_P1_P01R0103_")
    c0 = CINNABAR_FIRST
    header("data/scr_seq/scr_seq_01056_P1_T09_hdr.s",
           f"Cinnabar Island (Part 1) map script header: on transition -> script {c0 + 2} (Bill's flags), frame table "
           f"VAR_P1_SEVII == 1 -> script {c0} (Bill invites Red to One Island); data/scr_seq/scr_seq_01038_P1_T09.s",
           [(2, c0 + 2)], [("0x4176", 1, c0)])
    header("data/scr_seq/scr_seq_01057_P1_1IPC_hdr.s",
           f"One Island Pokemon Center (Part 1) map script header: on transition -> script {SC['1pc_transition']}, "
           f"frame table VAR_P1_SEVII == 3 -> {SC['1pc_meet']}, == 5 -> {SC['1pc_return']} (data/scr_seq/scr_seq_01055_P1_SEVII.s)",
           [(2, SC["1pc_transition"])], [("0x4176", 3, SC["1pc_meet"]), ("0x4176", 5, SC["1pc_return"])])
    header("data/scr_seq/scr_seq_01058_P1_2IGC_hdr.s",
           f"Joyful Game Corner (Part 1) map script header: on transition -> script {SC['gc_transition']} "
           "(data/scr_seq/scr_seq_01055_P1_SEVII.s)", [(2, SC["gc_transition"])])
    print(len(SCRIPTS), "scripts,", len(TEXT), "lines")


if __name__ == "__main__":
    main()

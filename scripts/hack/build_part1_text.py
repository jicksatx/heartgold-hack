#!/usr/bin/env python3
"""
hack: Part 1 (FireRed) text archives built from FireRed's own lines (pret/pokefirered data/maps/*/text.inc).

each archive in ARCHIVES is a list of lines; a line is either ("L", <FireRed text label>, <ending>) or
("T", <literal HeartGold text>).  <ending> is "\\r" when the script shows another message or closes the box right after,
"" when it waits for a button press (wait_button / simple_npc_msg / signs).  writes data/text/<archive>.txt.

usage: python3 scripts/hack/build_part1_text.py [path to pokefirered checkout]
"""
import os
import sys

sys.path.insert(0, os.path.dirname(__file__))
import gen_part1_trainers as g  # noqa: E402

if len(sys.argv) > 1:
    g.PFR = sys.argv[1]

P = "{STRVAR_1 3, 0, 0}"  # the player's name (buffer_players_name 0)
R, N = "\\r", ""

ARCHIVES = {
    865: [  # Route 3
        ("L", "Route3_Text_RouteSign", N),
        ("L", "Route3_Text_TunnelFromCeruleanTiring", N),
    ],
    866: [  # Mt. Moon
        ("L", "MtMoon_B2F_Text_MiguelIntro", R),
        ("L", "MtMoon_B2F_Text_WellEachTakeAFossil", N),
        ("L", "MtMoon_B2F_Text_LabOnCinnabarRegeneratesFossils", N),
        ("T", "Do you want the Dome Fossil? {YESNO 0}"),
        ("T", "Do you want the Helix Fossil? {YESNO 0}"),
        ("L", "MtMoon_B2F_Text_ThenThisFossilIsMine", N),
        ("L", "MtMoon_1F_Text_ZubatIsABloodsucker", N),
        ("L", "MtMoon_1F_Text_BrockHelpsExcavateFossils", N),
        ("T", "Hey, stop! You haven’t beaten me\\nyet! These fossils are mine!"),
    ],
    867: [  # Route 4
        ("L", "Route4_Text_RouteSign", N),
        ("L", "Route4_Text_MtMoonEntrance", N),
        ("L", "Route4_Text_TrippedOverGeodude", N),
        ("L", "Route4_Text_PeopleLikeAndRespectBrock", N),
    ],
    868: [  # Cerulean City
        ("L", "CeruleanCity_Text_RivalIntro", R),
        ("L", "CeruleanCity_Text_RivalPostBattle", R),
        ("T", "Blue: All right, I really am gone.\\nSmell ya later!" + R),
        ("L", "CeruleanCity_Text_CitySign", N),
        ("L", "CeruleanCity_Text_GymSign", N),
        ("L", "CeruleanCity_Text_BikeShopSign", N),
        ("L", "CeruleanCity_Text_TrainerTipsHeldItems", N),
        ("L", "CeruleanCity_Text_TrainerLifeIsToughIsntIt", N),
        ("L", "CeruleanCity_Text_PeopleHereWereRobbed", N),
        ("T", "(Test build) Part 1 continues past\\nhere in a later build." + R),
        ("T", "(Test build) Misty’s Gym opens in a\\nlater build."),
        ("T", "Rt. 24 Ahead\\nNorth to Nugget Bridge"),
        ("L", "CeruleanCity_Text_GruntIntro", R),
        ("L", "CeruleanCity_Text_OkayIllReturnStolenTM", R),
        ("L", "CeruleanCity_Text_BetterGetMovingBye", N),
    ],
    869: [  # Route 24 (Nugget Bridge)
        ("L", "Route24_Text_JustEarnedFabulousPrize", R),
        ("L", "Route24_Text_JoinTeamRocket", R),
        ("L", "Route24_Text_YoudBecomeTopRocketLeader", N),
        ("L", "Route24_Text_YouDontHaveAnyRoom", R),
    ],
    870: [  # Route 25
        ("L", "Route25_Text_SeaCottageSign", N),
    ],
    871: [  # Sea Cottage
        ("L", "Route25_SeaCottage_Text_ImBillHelpMeOutPal", " {YESNO 0}"),
        ("L", "Route25_SeaCottage_Text_NoPleaseChief", R),
        ("L", "Route25_SeaCottage_Text_RunCellSeparationOnPC", R),
        ("L", "Route25_SeaCottage_Text_InitiatedTeleportersCellSeparator", R),
        ("L", "Route25_SeaCottage_Text_ThanksBudTakeThis", R),
        ("L", "Route25_SeaCottage_Text_SSAnnePartyYouGoInstead", N),
        ("L", "Route25_SeaCottage_Text_CheckOutRareMonsOnPC", N),
        ("L", "Route25_SeaCottage_Text_YouveGotTooMuchStuff", N),
    ],
    872: [  # Cerulean Gym
        ("L", "CeruleanCity_Gym_Text_GymGuyAdvice", N),
        ("L", "CeruleanCity_Gym_Text_WeMakePrettyGoodTeam", N),
        ("L", "CeruleanCity_Gym_Text_GymStatue", N),
        ("L", "CeruleanCity_Gym_Text_GymStatuePlayerWon", N),
        ("T", P + " received the Cascade Badge\\nfrom Misty!"),
        ("L", "CeruleanCity_Gym_Text_ExplainCascadeBadge", R),
        ("L", "CeruleanCity_Gym_Text_ExplainTM03", N),
    ],
    873: [  # Route 5
        ("L", "Route5_Text_UndergroundPathSign", N),
    ],
    874: [  # Route 6
        ("L", "Route6_Text_UndergroundPathSign", N),
    ],
    875: [  # Saffron gatehouses (Routes 5 and 6)
        ("L", "Route5_SouthEntrance_Text_ThirstyOnGuardDuty", R),
        ("L", "Route5_SouthEntrance_Text_ThirstyOnGuardDuty", N),
    ],
    876: [  # Vermilion City
        ("L", "VermilionCity_Text_CitySign", N),
        ("L", "VermilionCity_Text_GymSign", N),
        ("L", "VermilionCity_Text_PokemonFanClubSign", N),
        ("L", "VermilionCity_Text_VermilionHarbor", N),
        ("L", "VermilionCity_Text_GrimerMultipliesInSludge", N),
        ("L", "VermilionCity_Text_DidYouSeeSSAnneInHarbor", N),
        ("L", "VermilionCity_Text_SSAnneHasDepartedForYear", N),
        ("T", "(Test build) Part 1 continues past\\nhere in a later build." + R),
        ("T", "(Test build) Lt. Surge’s Gym opens in\\na later build."),
    ],
    877: [  # Vermilion port
        ("L", "VermilionCity_Text_WelcomeToTheSSAnne", N),
        ("L", "VermilionCity_Text_DoYouHaveATicket", R),
        ("L", "VermilionCity_Text_FlashedSSTicket", R),
        ("L", "VermilionCity_Text_DontHaveNeededSSTicket", R),
        ("L", "VermilionCity_Text_TheShipSetSail", R),
    ],
    878: [  # S.S. Anne (HeartGold's S.S. Aqua decks and cabins)
        ("L", "SSAnne_2F_Corridor_Text_RivalIntro", R),
        ("L", "SSAnne_2F_Corridor_Text_RivalPostBattle", R),
    ],
    879: [  # S.S. Anne captain's office
        ("L", "SSAnne_CaptainsOffice_Text_CaptainIFeelSeasick", R),
        ("L", "SSAnne_CaptainsOffice_Text_RubbedCaptainsBack", N),
        ("L", "SSAnne_CaptainsOffice_Text_ThankYouHaveHMForCut", R),
        ("L", "SSAnne_CaptainsOffice_Text_ExplainCut", N),
        ("L", "SSAnne_CaptainsOffice_Text_SSAnneWillSetSailSoon", N),
    ],
}


def main():
    texts = g.parse_all_texts()
    for archive, lines in ARCHIVES.items():
        out = []
        for line in lines:
            if line[0] == "T":
                out.append(line[1])
                continue
            text = g.frlg_text(texts[line[1]], player=P)
            while text.endswith("\\n") or text.endswith("\\r"):
                text = text[:-2]
            out.append(text + line[2])
        with open(f"data/text/{archive}.txt", "w", encoding="utf-8", newline="\n") as f:
            f.write("\n".join(out) + "\n")
        print(f"data/text/{archive}.txt: {len(out)} lines")


if __name__ == "__main__":
    main()

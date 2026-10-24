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
    880: [  # Vermilion Gym
        ("L", "VermilionCity_Gym_Text_GymGuyAdvice", N),
        ("L", "VermilionCity_Gym_Text_GymGuyPostVictory", N),
        ("L", "VermilionCity_Gym_Text_GymStatue", N),
        ("L", "VermilionCity_Gym_Text_GymStatuePlayerWon", N),
        ("L", "VermilionCity_Gym_Text_NopeOnlyTrashHere", N),
        ("L", "VermilionCity_Gym_Text_SwitchUnderTrashFirstLockOpened", N),
        ("T", "Hey! There’s another switch under\\nthe trash! Turn it on!"),
        ("L", "VermilionCity_Gym_Text_SecondLockOpened", N),
        ("L", "VermilionCity_Gym_Text_OnlyTrashLocksWereReset", N),
        ("T", P + " received the Thunder Badge\\nfrom Lt. Surge!"),
        ("L", "VermilionCity_Gym_Text_ExplainThunderBadgeTakeThis", R),
        ("L", "VermilionCity_Gym_Text_ExplainTM34", N),
    ],
    881: [  # Route 11
        ("L", "Route11_Text_DiglettsCave", N),
        ("T", "(Test build) Part 1 continues past\\nhere in a later build." + R),
    ],
    882: [  # Route 9
        ("L", "Route9_Text_RouteSign", N),
    ],
    883: [  # Route 10
        ("L", "Route10_Text_PowerPlant", N),
        ("L", "Route10_Text_RockTunnel", N),
        ("L", "Route10_Text_RockTunnelDetourToLavender", N),
    ],
    884: [  # Lavender Town
        ("L", "LavenderTown_Text_TownSign", N),
        ("L", "LavenderTown_Text_PokemonTowerSign", N),
        ("T", "House of Memories\\nMay Pokémon Spirits Rest Easy"),
        ("L", "LavenderTown_Text_VolunteerPokemonHouse", N),
        ("T", "(Test build) The Pokémon Tower comes\\nin a later build."),
        ("L", "LavenderTown_Text_DoYouBelieveInGhosts", " {YESNO 0}"),
        ("L", "LavenderTown_Text_SoThereAreBelievers", N),
        ("L", "LavenderTown_Text_JustImaginingWhiteHand", N),
        ("L", "LavenderTown_Text_TownKnownAsMonGraveSite", N),
        ("L", "LavenderTown_Text_GhostsAppearedInTower", N),
        ("T", "(Test build) Part 1 continues past\\nhere in a later build." + R),
    ],
    885: [  # Route 8
        ("L", "Route8_Text_UndergroundPathSign", N),
    ],
    886: [  # Route 7
        ("L", "Route7_Text_UndergroundPathSign", N),
    ],
    887: [  # Route 7 / Route 8 Saffron gatehouses (and the Underground Path standing in for FireRed's)
        ("L", "Route5_SouthEntrance_Text_ThirstyOnGuardDuty", R),
        ("T", P + " took the Underground Path\\nunder Saffron City." + R),
        ("L", "Route5_SouthEntrance_Text_ThirstyOnGuardDuty", N),
    ],
    888: [  # Celadon City
        ("L", "CeladonCity_Text_CitySign", N),
        ("L", "CeladonCity_Text_GymSign", N),
        ("L", "CeladonCity_Text_MansionSign", N),
        ("L", "CeladonCity_Text_DeptStoreSign", N),
        ("L", "CeladonCity_Text_PrizeExchangeSign", N),
        ("L", "CeladonCity_Text_GameCornerSign", N),
        ("L", "CeladonCity_Text_GymIsGreatFullOfWomen", N),
        ("L", "CeladonCity_Text_GameCornerIsBadForCitysImage", N),
        ("L", "CeladonCity_Text_ScaldedTongueOnTea", N),
        ("T", "(Test build) Part 1 continues past\\nhere in a later build." + R),
    ],
    889: [  # Celadon Gym
        ("L", "CeladonCity_Gym_Text_GymStatue", N),
        ("L", "CeladonCity_Gym_Text_GymStatuePlayerWon", N),
        ("T", P + " received the Rainbow Badge\\nfrom Erika!"),
        ("L", "CeladonCity_Gym_Text_ExplainRainbowBadgeTakeThis", R),
        ("L", "CeladonCity_Gym_Text_ExplainTM19", N),
    ],
    890: [  # Celadon Condominiums 1F
        ("L", "CeladonCity_Condominiums_1F_Text_TryThisDrinkInstead", R),
        ("L", "CeladonCity_Condominiums_1F_Text_NothingBeatsThirstLikeTea", N),
        ("L", "CeladonCity_Condominiums_1F_Text_ManagersSuite", N),
    ],
    891: [  # Rocket Game Corner (HeartGold's Japanese Game Corner)
        ("L", "CeladonCity_GameCorner_Text_GruntIntro", R),
        ("L", "CeladonCity_GameCorner_Text_GruntPostBattle", R),
        ("L", "CeladonCity_GameCorner_Text_SwitchBehindPosterPushIt", R),
        ("T", "OUT OF ORDER\\nThis is broken."),
        ("L", "CeladonCity_GameCorner_Text_RumoredTeamRocketRunsThisPlace", N),
        ("L", "CeladonCity_GameCorner_Text_ThinkMachinesHaveDifferentOdds", N),
        ("L", "CeladonCity_GameCorner_Text_WinOrLoseItsOnlyLuck", N),
        ("L", "CeladonCity_GameCorner_Text_SoEasyToGetHooked", N),
        ("L", "CeladonCity_GameCorner_Text_WatchReelsClosely", N),
        ("T", "Welcome to Rocket Game Corner!\\rSorry, we aren’t selling Coins\\nright now."),
        ("T", "It’s a poster of a smiling\\nPokémon."),
    ],
    892: [  # Rocket Hideout (HeartGold's Team Rocket HQ)
        ("L", "RocketHideout_B4F_Text_GiovanniIntro", R),
        ("L", "RocketHideout_B4F_Text_GiovanniPostBattle", R),
        ("T", "Giovanni left the Silph Scope\\nbehind!" + R),
    ],
    893: [  # Pokemon Tower (HeartGold's Sprout Tower)
        ("L", "PokemonTower_2F_Text_RivalIntro", R),
        ("L", "PokemonTower_2F_Text_RivalPostBattle", R),
        ("L", "PokemonTower_1F_Text_ComeToPayRespectsSon", N),
        ("L", "PokemonTower_1F_Text_CameToPrayForDepartedClefairy", N),
        ("L", "PokemonTower_1F_Text_GrowlitheWhyDidYouDie", N),
        ("L", "PokemonTower_1F_Text_SenseSpiritsUpToMischief", N),
        ("L", "PokemonTower_5F_Text_RestHereInPurifiedSpace", N),
        ("L", "PokemonTower_5F_Text_PurifiedZoneMonsFullyHealed", N),
        ("L", "PokemonTower_6F_Text_BeGoneIntruders", R),
        ("T", "A ghost blocks the way!\\nIts identity can’t be made out..." + R),
        ("L", "PokemonTower_6F_Text_GhostWasCubonesMother", R),
        ("L", "PokemonTower_6F_Text_MothersSpiritWasCalmed", R),
        ("L", "PokemonTower_7F_Text_MrFujiThankYouFollowMe", R),
        ("L", "PokemonTower_1F_Text_ErectedInMemoryOfDeadMons", N),
        ("T", "The Silph Scope unveiled the\\nghost’s identity!" + R),
    ],
    894: [  # Mr. Fuji's house (Lavender Volunteer Pokemon House)
        ("L", "LavenderTown_VolunteerPokemonHouse_Text_WhereDidMrFujiGo", N),
        ("L", "LavenderTown_VolunteerPokemonHouse_Text_MrFujiWasPrayingForCubonesMother", N),
        ("L", "LavenderTown_VolunteerPokemonHouse_Text_MrFujiLooksAfterOrphanedMons", N),
        ("L", "LavenderTown_VolunteerPokemonHouse_Text_Nidorino", N),
        ("L", "LavenderTown_VolunteerPokemonHouse_Text_Psyduck", N),
        ("L", "LavenderTown_VolunteerPokemonHouse_Text_IdLikeYouToHaveThis", R),
        ("L", "LavenderTown_VolunteerPokemonHouse_Text_ExplainPokeFlute", N),
        ("L", "LavenderTown_VolunteerPokemonHouse_Text_HasPokeFluteHelpedYou", N),
        ("L", "LavenderTown_VolunteerPokemonHouse_Text_PokemonMagazinesLineShelf", N),
    ],    895: [  # Route 12
        ("T", "Route 12\\nNorth to Lavender"),
        ("L", "Route12_Text_SportfishingArea", N),
        ("L", "Route12_Text_MonSprawledOutInSlumber", N),
        ("T", P + " played the Poké Flute.\\rSnorlax woke up!" + R),
        ("T", "Snorlax calmed down.\\rWith a big yawn, it returned to\\nthe mountains."),
        ("L", "Route12_NorthEntrance_2F_Text_TakeTMDontNeedAnymoreMale", R),
        ("L", "Route12_NorthEntrance_2F_Text_ExplainTM27", N),
    ],
    896: [  # Route 12 Fishing House
        ("L", "Route12_FishingHouse_Text_DoYouLikeToFish", " {YESNO 0}"),
        ("L", "Route12_FishingHouse_Text_TakeThisAndFish", R),
        ("T", "Fishing is a way of life!\\nIt is like the finest poetry.\\rFrom the seas to rivers, go out\\nand land the big one, my friend."),
        ("L", "Route12_FishingHouse_Text_OhThatsDisappointing", N),
        ("T", "Hello there, " + P + "!\\nHave you been fishing?\\rTry fishing with the Super Rod in\\nany body of water."),
    ],
    897: [  # Routes 13-15 and the Route 15 gate
        ("L", "Route13_Text_RouteSign", N),
        ("L", "Route13_Text_LookToLeftOfThatPost", N),
        ("L", "Route13_Text_SelectToSwitchItems", N),
        ("L", "Route15_WestEntrance_1F_Text_OaksAideCameByHere", N),
        ("L", "Route15_Text_RouteSign", N),
    ],
    898: [  # Fuchsia City
        ("L", "FuchsiaCity_Text_CitySign", N),
        ("L", "FuchsiaCity_Text_SafariZoneOfficeSign", N),
        ("T", "Safari Zone\\nWarden’s Home"),
        ("L", "FuchsiaCity_Text_GymSign", N),
        ("L", "FuchsiaCity_Text_DidYouTrySafariGame", N),
        ("L", "FuchsiaCity_Text_SafariZoneZooInFront", N),
        ("L", "FuchsiaCity_Text_WheresSara", N),
        ("L", "FuchsiaCity_Text_ItemBallInThere", N),
        ("T", "(Test build) The Safari Zone opens\\nin a later build."),
        ("T", "(Test build) Part 1 continues past\\nhere in a later build." + R),
    ],
    899: [  # Fuchsia Gym
        ("L", "FuchsiaCity_Gym_Text_GymStatue", N),
        ("L", "FuchsiaCity_Gym_Text_GymStatuePlayerWon", N),
        ("T", P + " received the Soul Badge\\nfrom Koga!" + R),
        ("L", "FuchsiaCity_Gym_Text_KogaExplainSoulBadge", R),
        ("L", "FuchsiaCity_Gym_Text_KogaExplainTM06", N),
        ("T", "Yo! Champ in the making!\\rFuchsia Gym is a tricked-up place.\\nIt’s a maze of walls!\\rKoga uses Poison-type Pokémon.\\rPsychic and Ground moves work well\\nagainst them."),
        ("L", "FuchsiaCity_Gym_Text_GymGuyPostVictory", N),
    ],
    900: [  # Fuchsia houses: Fishing Guru's older brother, the Warden
        ("L", "FuchsiaCity_House2_Text_DoYouLikeToFish", " {YESNO 0}"),
        ("L", "FuchsiaCity_House2_Text_LikeYourStyleTakeThis", R),
        ("L", "FuchsiaCity_House2_Text_GoodRodCanCatchBetterMons", N),
        ("L", "FuchsiaCity_House2_Text_OhThatsDisappointing", N),
        ("L", "FuchsiaCity_House2_Text_HowAreTheFishBiting", N),
        ("L", "FuchsiaCity_WardensHouse_Text_HifFuffHefifoo", N),
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

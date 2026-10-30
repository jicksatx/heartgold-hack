#!/usr/bin/env python3
"""
hack: Part 1 (FireRed Kanto) trainers, taken from FireRed (pret/pokefirered).

for every trainer in PART1_TRAINERS (in order; only ever append, the ids are saved-game-visible through trainer
flags), this reads the party from src/data/trainers.h + trainer_parties.h and the intro / defeat / post-battle lines
from the map's scripts.inc + text.inc, and writes:
  - data/Trainers.c, between the PART1 GENERATED markers: the trainer entries (ids from FIRST_ID up)
  - data/Trainers.c sTrainerTextOrder: the ids, between the PART1 GENERATED markers
  - asm/include/trainers.inc: TRAINER_P1_<name> constants, between the PART1 GENERATED markers

scripts use a trainer object with script 3000 + id - 1 (the common trainer script; trainer ids start at 1, double-battle partners 5000 + id - 1), or trainer_battle for gym leaders.

usage: python3 scripts/hack/gen_part1_trainers.py [path to pokefirered checkout]
"""
import re
import sys

PFR = sys.argv[1] if len(sys.argv) > 1 else "../pfr"
FIRST_ID = 744

# (FireRed trainer constant, FireRed map folder its battle script is in)
PART1_TRAINERS = [
    ("TRAINER_BUG_CATCHER_RICK", "ViridianForest"),
    ("TRAINER_BUG_CATCHER_DOUG", "ViridianForest"),
    ("TRAINER_BUG_CATCHER_SAMMY", "ViridianForest"),
    ("TRAINER_BUG_CATCHER_ANTHONY", "ViridianForest"),
    ("TRAINER_BUG_CATCHER_CHARLIE", "ViridianForest"),
    ("TRAINER_CAMPER_LIAM", "PewterCity_Gym"),
    ("TRAINER_LEADER_BROCK", "PewterCity_Gym"),
    # Build 16: Route 3, Mt. Moon, Route 4, Cerulean
    ("TRAINER_LASS_ROBIN", "Route3"),
    ("TRAINER_BUG_CATCHER_JAMES", "Route3"),
    ("TRAINER_LASS_SALLY", "Route3"),
    ("TRAINER_BUG_CATCHER_GREG", "Route3"),
    ("TRAINER_YOUNGSTER_CALVIN", "Route3"),
    ("TRAINER_LASS_JANICE", "Route3"),
    ("TRAINER_BUG_CATCHER_COLTON", "Route3"),
    ("TRAINER_YOUNGSTER_BEN", "Route3"),
    ("TRAINER_LASS_IRIS", "MtMoon_1F"),
    ("TRAINER_BUG_CATCHER_ROBBY", "MtMoon_1F"),
    ("TRAINER_SUPER_NERD_JOVAN", "MtMoon_1F"),
    ("TRAINER_LASS_MIRIAM", "MtMoon_1F"),
    ("TRAINER_BUG_CATCHER_KENT", "MtMoon_1F"),
    ("TRAINER_YOUNGSTER_JOSH", "MtMoon_1F"),
    ("TRAINER_HIKER_MARCOS", "MtMoon_1F"),
    ("TRAINER_TEAM_ROCKET_GRUNT", "MtMoon_B2F"),
    ("TRAINER_TEAM_ROCKET_GRUNT_2", "MtMoon_B2F"),
    ("TRAINER_TEAM_ROCKET_GRUNT_3", "MtMoon_B2F"),
    ("TRAINER_TEAM_ROCKET_GRUNT_4", "MtMoon_B2F"),
    ("TRAINER_SUPER_NERD_MIGUEL", "MtMoon_B2F"),
    ("TRAINER_LASS_CRISSY", "Route4"),
    ("TRAINER_RIVAL_CERULEAN_SQUIRTLE", "CeruleanCity"),
    ("TRAINER_RIVAL_CERULEAN_BULBASAUR", "CeruleanCity"),
    ("TRAINER_RIVAL_CERULEAN_CHARMANDER", "CeruleanCity"),
    # Build 17: Nugget Bridge, Route 25, Misty, the Cerulean burglar
    ("TRAINER_BUG_CATCHER_CALE", "Route24"),
    ("TRAINER_LASS_ALI", "Route24"),
    ("TRAINER_YOUNGSTER_TIMMY", "Route24"),
    ("TRAINER_LASS_RELI", "Route24"),
    ("TRAINER_CAMPER_ETHAN", "Route24"),
    ("TRAINER_CAMPER_SHANE", "Route24"),
    ("TRAINER_TEAM_ROCKET_GRUNT_6", "Route24"),
    ("TRAINER_YOUNGSTER_JOEY", "Route25"),
    ("TRAINER_YOUNGSTER_DAN", "Route25"),
    ("TRAINER_YOUNGSTER_CHAD", "Route25"),
    ("TRAINER_PICNICKER_KELSEY", "Route25"),
    ("TRAINER_LASS_HALEY", "Route25"),
    ("TRAINER_HIKER_FRANKLIN", "Route25"),
    ("TRAINER_HIKER_NOB", "Route25"),
    ("TRAINER_HIKER_WAYNE", "Route25"),
    ("TRAINER_CAMPER_FLINT", "Route25"),
    ("TRAINER_PICNICKER_DIANA", "CeruleanCity_Gym"),
    ("TRAINER_SWIMMER_MALE_LUIS", "CeruleanCity_Gym"),
    ("TRAINER_LEADER_MISTY", "CeruleanCity_Gym"),
    ("TRAINER_TEAM_ROCKET_GRUNT_5", "CeruleanCity"),
    # Build 18: Route 6, the S.S. Anne
    ("TRAINER_BUG_CATCHER_KEIGO", "Route6"),
    ("TRAINER_BUG_CATCHER_ELIJAH", "Route6"),
    ("TRAINER_CAMPER_RICKY", "Route6"),
    ("TRAINER_CAMPER_JEFF", "Route6"),
    ("TRAINER_PICNICKER_NANCY", "Route6"),
    ("TRAINER_PICNICKER_ISABELLE", "Route6"),
    ("TRAINER_LASS_ANN", "SSAnne_1F_Room2"),
    ("TRAINER_YOUNGSTER_TYLER", "SSAnne_1F_Room2"),
    ("TRAINER_GENTLEMAN_ARTHUR", "SSAnne_1F_Room5"),
    ("TRAINER_GENTLEMAN_THOMAS", "SSAnne_1F_Room7"),
    ("TRAINER_FISHERMAN_DALE", "SSAnne_2F_Room2"),
    ("TRAINER_GENTLEMAN_BROOKS", "SSAnne_2F_Room2"),
    ("TRAINER_GENTLEMAN_LAMAR", "SSAnne_2F_Room4"),
    ("TRAINER_LASS_DAWN", "SSAnne_2F_Room4"),
    ("TRAINER_FISHERMAN_BARNY", "SSAnne_B1F_Room1"),
    ("TRAINER_SAILOR_PHILLIP", "SSAnne_B1F_Room1"),
    ("TRAINER_SAILOR_HUEY", "SSAnne_B1F_Room2"),
    ("TRAINER_SAILOR_DYLAN", "SSAnne_B1F_Room3"),
    ("TRAINER_SAILOR_DUNCAN", "SSAnne_B1F_Room4"),
    ("TRAINER_SAILOR_LEONARD", "SSAnne_B1F_Room4"),
    ("TRAINER_SAILOR_EDMOND", "SSAnne_Deck"),
    ("TRAINER_SAILOR_TREVOR", "SSAnne_Deck"),
    ("TRAINER_RIVAL_SS_ANNE_SQUIRTLE", "SSAnne_2F_Corridor"),
    ("TRAINER_RIVAL_SS_ANNE_BULBASAUR", "SSAnne_2F_Corridor"),
    ("TRAINER_RIVAL_SS_ANNE_CHARMANDER", "SSAnne_2F_Corridor"),
    # Build 19: Lt. Surge, Route 11, Route 9, Route 10, Rock Tunnel
    ("TRAINER_ENGINEER_BAILY", "VermilionCity_Gym"),
    ("TRAINER_SAILOR_DWAYNE", "VermilionCity_Gym"),
    ("TRAINER_GENTLEMAN_TUCKER", "VermilionCity_Gym"),
    ("TRAINER_LEADER_LT_SURGE", "VermilionCity_Gym"),
    ("TRAINER_YOUNGSTER_EDDIE", "Route11"),
    ("TRAINER_GAMER_HUGO", "Route11"),
    ("TRAINER_YOUNGSTER_DILLON", "Route11"),
    ("TRAINER_YOUNGSTER_DAVE", "Route11"),
    ("TRAINER_GAMER_JASPER", "Route11"),
    ("TRAINER_GAMER_DARIAN", "Route11"),
    ("TRAINER_ENGINEER_BRAXTON", "Route11"),
    ("TRAINER_YOUNGSTER_YASU", "Route11"),
    ("TRAINER_GAMER_DIRK", "Route11"),
    ("TRAINER_ENGINEER_BERNIE", "Route11"),
    ("TRAINER_PICNICKER_ALICIA", "Route9"),
    ("TRAINER_HIKER_JEREMY", "Route9"),
    ("TRAINER_HIKER_ALAN", "Route9"),
    ("TRAINER_CAMPER_CHRIS", "Route9"),
    ("TRAINER_BUG_CATCHER_BRENT", "Route9"),
    ("TRAINER_BUG_CATCHER_CONNER", "Route9"),
    ("TRAINER_HIKER_BRICE", "Route9"),
    ("TRAINER_PICNICKER_CAITLIN", "Route9"),
    ("TRAINER_CAMPER_DREW", "Route9"),
    ("TRAINER_PICNICKER_CAROL", "Route10"),
    ("TRAINER_HIKER_CLARK", "Route10"),
    ("TRAINER_POKEMANIAC_HERMAN", "Route10"),
    ("TRAINER_HIKER_TRENT", "Route10"),
    ("TRAINER_POKEMANIAC_MARK", "Route10"),
    ("TRAINER_PICNICKER_HEIDI", "Route10"),
    ("TRAINER_PICNICKER_DANA", "RockTunnel_1F"),
    ("TRAINER_PICNICKER_ARIANA", "RockTunnel_1F"),
    ("TRAINER_PICNICKER_LEAH", "RockTunnel_1F"),
    ("TRAINER_HIKER_LUCAS", "RockTunnel_1F"),
    ("TRAINER_HIKER_OLIVER", "RockTunnel_1F"),
    ("TRAINER_HIKER_LENNY", "RockTunnel_1F"),
    ("TRAINER_POKEMANIAC_ASHTON", "RockTunnel_1F"),
    ("TRAINER_POKEMANIAC_COOPER", "RockTunnel_B1F"),
    ("TRAINER_HIKER_DUDLEY", "RockTunnel_B1F"),
    ("TRAINER_PICNICKER_SOFIA", "RockTunnel_B1F"),
    ("TRAINER_HIKER_ALLEN", "RockTunnel_B1F"),
    ("TRAINER_HIKER_ERIC", "RockTunnel_B1F"),
    ("TRAINER_POKEMANIAC_STEVE", "RockTunnel_B1F"),
    ("TRAINER_PICNICKER_MARTHA", "RockTunnel_B1F"),
    ("TRAINER_POKEMANIAC_WINSTON", "RockTunnel_B1F"),
    # Build 20: Route 8, Celadon Gym
    ("TRAINER_LASS_PAIGE", "Route8"),
    ("TRAINER_LASS_ANDREA", "Route8"),
    ("TRAINER_LASS_MEGAN", "Route8"),
    ("TRAINER_LASS_JULIA", "Route8"),
    ("TRAINER_SUPER_NERD_AIDAN", "Route8"),
    ("TRAINER_SUPER_NERD_GLENN", "Route8"),
    ("TRAINER_SUPER_NERD_LESLIE", "Route8"),
    ("TRAINER_GAMER_STAN", "Route8"),
    ("TRAINER_GAMER_RICH", "Route8"),
    ("TRAINER_TWINS_ELI_ANNE", "Route8"),
    ("TRAINER_BIKER_RICARDO", "Route8"),
    ("TRAINER_BIKER_JAREN", "Route8"),
    ("TRAINER_LASS_KAY", "CeladonCity_Gym"),
    ("TRAINER_LASS_LISA", "CeladonCity_Gym"),
    ("TRAINER_PICNICKER_TINA", "CeladonCity_Gym"),
    ("TRAINER_BEAUTY_BRIDGET", "CeladonCity_Gym"),
    ("TRAINER_BEAUTY_TAMIA", "CeladonCity_Gym"),
    ("TRAINER_BEAUTY_LORI", "CeladonCity_Gym"),
    ("TRAINER_COOLTRAINER_MARY", "CeladonCity_Gym"),
    ("TRAINER_LEADER_ERIKA", "CeladonCity_Gym"),
    ("TRAINER_TEAM_ROCKET_GRUNT_7", "CeladonCity_GameCorner"),
    ("TRAINER_TEAM_ROCKET_GRUNT_8", "RocketHideout_B1F"),
    ("TRAINER_TEAM_ROCKET_GRUNT_9", "RocketHideout_B1F"),
    ("TRAINER_TEAM_ROCKET_GRUNT_10", "RocketHideout_B1F"),
    ("TRAINER_TEAM_ROCKET_GRUNT_11", "RocketHideout_B1F"),
    ("TRAINER_TEAM_ROCKET_GRUNT_12", "RocketHideout_B1F"),
    ("TRAINER_TEAM_ROCKET_GRUNT_13", "RocketHideout_B2F"),
    ("TRAINER_TEAM_ROCKET_GRUNT_14", "RocketHideout_B3F"),
    ("TRAINER_TEAM_ROCKET_GRUNT_15", "RocketHideout_B3F"),
    ("TRAINER_TEAM_ROCKET_GRUNT_16", "RocketHideout_B4F"),
    ("TRAINER_TEAM_ROCKET_GRUNT_17", "RocketHideout_B4F"),
    ("TRAINER_TEAM_ROCKET_GRUNT_18", "RocketHideout_B4F"),
    ("TRAINER_BOSS_GIOVANNI", "RocketHideout_B4F"),
    ("TRAINER_RIVAL_POKEMON_TOWER_SQUIRTLE", "PokemonTower_2F"),
    ("TRAINER_RIVAL_POKEMON_TOWER_BULBASAUR", "PokemonTower_2F"),
    ("TRAINER_RIVAL_POKEMON_TOWER_CHARMANDER", "PokemonTower_2F"),
    ("TRAINER_CHANNELER_PATRICIA", "PokemonTower_3F"),
    ("TRAINER_CHANNELER_CARLY", "PokemonTower_3F"),
    ("TRAINER_CHANNELER_HOPE", "PokemonTower_3F"),
    ("TRAINER_CHANNELER_PAULA", "PokemonTower_4F"),
    ("TRAINER_CHANNELER_LAUREL", "PokemonTower_4F"),
    ("TRAINER_CHANNELER_JODY", "PokemonTower_4F"),
    ("TRAINER_CHANNELER_TAMMY", "PokemonTower_5F"),
    ("TRAINER_CHANNELER_RUTH", "PokemonTower_5F"),
    ("TRAINER_CHANNELER_KARINA", "PokemonTower_5F"),
    ("TRAINER_CHANNELER_JANAE", "PokemonTower_5F"),
    ("TRAINER_CHANNELER_ANGELICA", "PokemonTower_6F"),
    ("TRAINER_CHANNELER_EMILIA", "PokemonTower_6F"),
    ("TRAINER_CHANNELER_JENNIFER", "PokemonTower_6F"),
    ("TRAINER_TEAM_ROCKET_GRUNT_19", "PokemonTower_7F"),
    ("TRAINER_TEAM_ROCKET_GRUNT_20", "PokemonTower_7F"),
    ("TRAINER_TEAM_ROCKET_GRUNT_21", "PokemonTower_7F"),    ("TRAINER_FISHERMAN_NED", "Route12"),
    ("TRAINER_FISHERMAN_CHIP", "Route12"),
    ("TRAINER_FISHERMAN_HANK", "Route12"),
    ("TRAINER_FISHERMAN_ELLIOT", "Route12"),
    ("TRAINER_FISHERMAN_ANDREW", "Route12"),
    ("TRAINER_ROCKER_LUCA", "Route12"),
    ("TRAINER_CAMPER_JUSTIN", "Route12"),
    ("TRAINER_YOUNG_COUPLE_GIA_JES", "Route12"),
    ("TRAINER_BIKER_JARED", "Route13"),
    ("TRAINER_BEAUTY_LOLA", "Route13"),
    ("TRAINER_BEAUTY_SHEILA", "Route13"),
    ("TRAINER_BIRD_KEEPER_SEBASTIAN", "Route13"),
    ("TRAINER_BIRD_KEEPER_PERRY", "Route13"),
    ("TRAINER_BIRD_KEEPER_ROBERT", "Route13"),
    ("TRAINER_PICNICKER_ALMA", "Route13"),
    ("TRAINER_PICNICKER_SUSIE", "Route13"),
    ("TRAINER_PICNICKER_VALERIE", "Route13"),
    ("TRAINER_PICNICKER_GWEN", "Route13"),
    ("TRAINER_BIKER_MALIK", "Route14"),
    ("TRAINER_BIKER_LUKAS", "Route14"),
    ("TRAINER_BIKER_ISAAC", "Route14"),
    ("TRAINER_BIKER_GERALD", "Route14"),
    ("TRAINER_BIRD_KEEPER_DONALD", "Route14"),
    ("TRAINER_BIRD_KEEPER_BENNY", "Route14"),
    ("TRAINER_BIRD_KEEPER_CARTER", "Route14"),
    ("TRAINER_BIRD_KEEPER_MITCH", "Route14"),
    ("TRAINER_BIRD_KEEPER_BECK", "Route14"),
    ("TRAINER_BIRD_KEEPER_MARLON", "Route14"),
    ("TRAINER_TWINS_KIRI_JAN", "Route14"),
    ("TRAINER_BIKER_ERNEST", "Route15"),
    ("TRAINER_BIKER_ALEX", "Route15"),
    ("TRAINER_BEAUTY_GRACE", "Route15"),
    ("TRAINER_BEAUTY_OLIVIA", "Route15"),
    ("TRAINER_BIRD_KEEPER_EDWIN", "Route15"),
    ("TRAINER_BIRD_KEEPER_CHESTER", "Route15"),
    ("TRAINER_PICNICKER_YAZMIN", "Route15"),
    ("TRAINER_PICNICKER_KINDRA", "Route15"),
    ("TRAINER_PICNICKER_BECKY", "Route15"),
    ("TRAINER_PICNICKER_CELIA", "Route15"),
    ("TRAINER_CRUSH_KIN_RON_MYA", "Route15"),
    ("TRAINER_JUGGLER_KAYDEN", "FuchsiaCity_Gym"),
    ("TRAINER_JUGGLER_KIRK", "FuchsiaCity_Gym"),
    ("TRAINER_JUGGLER_NATE", "FuchsiaCity_Gym"),
    ("TRAINER_JUGGLER_SHAWN", "FuchsiaCity_Gym"),
    ("TRAINER_TAMER_EDGAR", "FuchsiaCity_Gym"),
    ("TRAINER_TAMER_PHIL", "FuchsiaCity_Gym"),
    ("TRAINER_LEADER_KOGA", "FuchsiaCity_Gym"),    ("TRAINER_SCIENTIST_CONNOR", "SilphCo_2F"),
    ("TRAINER_SCIENTIST_JERRY", "SilphCo_2F"),
    ("TRAINER_TEAM_ROCKET_GRUNT_23", "SilphCo_2F"),
    ("TRAINER_TEAM_ROCKET_GRUNT_24", "SilphCo_2F"),
    ("TRAINER_SCIENTIST_JOSE", "SilphCo_3F"),
    ("TRAINER_TEAM_ROCKET_GRUNT_25", "SilphCo_3F"),
    ("TRAINER_SCIENTIST_RODNEY", "SilphCo_4F"),
    ("TRAINER_TEAM_ROCKET_GRUNT_26", "SilphCo_4F"),
    ("TRAINER_TEAM_ROCKET_GRUNT_27", "SilphCo_4F"),
    ("TRAINER_JUGGLER_DALTON", "SilphCo_5F"),
    ("TRAINER_SCIENTIST_BEAU", "SilphCo_5F"),
    ("TRAINER_TEAM_ROCKET_GRUNT_28", "SilphCo_5F"),
    ("TRAINER_TEAM_ROCKET_GRUNT_29", "SilphCo_5F"),
    ("TRAINER_SCIENTIST_TAYLOR", "SilphCo_6F"),
    ("TRAINER_TEAM_ROCKET_GRUNT_30", "SilphCo_6F"),
    ("TRAINER_TEAM_ROCKET_GRUNT_31", "SilphCo_6F"),
    ("TRAINER_SCIENTIST_JOSHUA", "SilphCo_7F"),
    ("TRAINER_TEAM_ROCKET_GRUNT_33", "SilphCo_7F"),
    ("TRAINER_TEAM_ROCKET_GRUNT_34", "SilphCo_7F"),
    ("TRAINER_TEAM_ROCKET_GRUNT_35", "SilphCo_7F"),
    ("TRAINER_RIVAL_SILPH_SQUIRTLE", "SilphCo_7F"),
    ("TRAINER_RIVAL_SILPH_BULBASAUR", "SilphCo_7F"),
    ("TRAINER_RIVAL_SILPH_CHARMANDER", "SilphCo_7F"),
    ("TRAINER_SCIENTIST_PARKER", "SilphCo_8F"),
    ("TRAINER_TEAM_ROCKET_GRUNT_32", "SilphCo_8F"),
    ("TRAINER_TEAM_ROCKET_GRUNT_36", "SilphCo_8F"),
    ("TRAINER_SCIENTIST_ED", "SilphCo_9F"),
    ("TRAINER_TEAM_ROCKET_GRUNT_37", "SilphCo_9F"),
    ("TRAINER_TEAM_ROCKET_GRUNT_38", "SilphCo_9F"),
    ("TRAINER_SCIENTIST_TRAVIS", "SilphCo_10F"),
    ("TRAINER_TEAM_ROCKET_GRUNT_39", "SilphCo_10F"),
    ("TRAINER_TEAM_ROCKET_GRUNT_40", "SilphCo_11F"),
    ("TRAINER_TEAM_ROCKET_GRUNT_41", "SilphCo_11F"),
    ("TRAINER_BOSS_GIOVANNI_2", "SilphCo_11F"),
    ("TRAINER_BLACK_BELT_HIDEKI", "SaffronCity_Dojo"),
    ("TRAINER_BLACK_BELT_AARON", "SaffronCity_Dojo"),
    ("TRAINER_BLACK_BELT_HITOSHI", "SaffronCity_Dojo"),
    ("TRAINER_BLACK_BELT_MIKE", "SaffronCity_Dojo"),
    ("TRAINER_BLACK_BELT_KOICHI", "SaffronCity_Dojo"),
    ("TRAINER_PSYCHIC_JOHAN", "SaffronCity_Gym"),
    ("TRAINER_PSYCHIC_TYRON", "SaffronCity_Gym"),
    ("TRAINER_PSYCHIC_CAMERON", "SaffronCity_Gym"),
    ("TRAINER_PSYCHIC_PRESTON", "SaffronCity_Gym"),
    ("TRAINER_CHANNELER_AMANDA", "SaffronCity_Gym"),
    ("TRAINER_CHANNELER_STACY", "SaffronCity_Gym"),
    ("TRAINER_CHANNELER_TASHA", "SaffronCity_Gym"),
    ("TRAINER_LEADER_SABRINA", "SaffronCity_Gym"),    ("TRAINER_BIKER_LAO", "Route16"),
    ("TRAINER_BIKER_HIDEO", "Route16"),
    ("TRAINER_BIKER_RUBEN", "Route16"),
    ("TRAINER_CUE_BALL_KOJI", "Route16"),
    ("TRAINER_CUE_BALL_LUKE", "Route16"),
    ("TRAINER_CUE_BALL_CAMRON", "Route16"),
    ("TRAINER_YOUNG_COUPLE_LEA_JED", "Route16"),
    ("TRAINER_CUE_BALL_RAUL", "Route17"),
    ("TRAINER_CUE_BALL_ISAIAH", "Route17"),
    ("TRAINER_CUE_BALL_ZEEK", "Route17"),
    ("TRAINER_CUE_BALL_JAMAL", "Route17"),
    ("TRAINER_CUE_BALL_COREY", "Route17"),
    ("TRAINER_BIKER_VIRGIL", "Route17"),
    ("TRAINER_BIKER_BILLY", "Route17"),
    ("TRAINER_BIKER_NIKOLAS", "Route17"),
    ("TRAINER_BIKER_JAXON", "Route17"),
    ("TRAINER_BIKER_WILLIAM", "Route17"),
    ("TRAINER_BIRD_KEEPER_JACOB", "Route18"),
    ("TRAINER_BIRD_KEEPER_WILTON", "Route18"),
    ("TRAINER_BIRD_KEEPER_RAMIRO", "Route18"),
    ("TRAINER_SWIMMER_MALE_REECE", "Route19"),
    ("TRAINER_SWIMMER_MALE_RICHARD", "Route19"),
    ("TRAINER_SWIMMER_MALE_TONY", "Route19"),
    ("TRAINER_SWIMMER_MALE_MATTHEW", "Route19"),
    ("TRAINER_SWIMMER_MALE_DOUGLAS", "Route19"),
    ("TRAINER_SWIMMER_MALE_DAVID", "Route19"),
    ("TRAINER_SWIMMER_MALE_AXLE", "Route19"),
    ("TRAINER_SWIMMER_FEMALE_ALICE", "Route19"),
    ("TRAINER_SWIMMER_FEMALE_CONNIE", "Route19"),
    ("TRAINER_SWIMMER_FEMALE_ANYA", "Route19"),
    ("TRAINER_SIS_AND_BRO_LIA_LUC", "Route19"),
    ("TRAINER_SWIMMER_FEMALE_MELISSA", "Route20"),
    ("TRAINER_PICNICKER_MISSY", "Route20"),
    ("TRAINER_SWIMMER_FEMALE_NORA", "Route20"),
    ("TRAINER_BIRD_KEEPER_ROGER", "Route20"),
    ("TRAINER_SWIMMER_MALE_DEAN", "Route20"),
    ("TRAINER_PICNICKER_IRENE", "Route20"),
    ("TRAINER_SWIMMER_MALE_BARRY", "Route20"),
    ("TRAINER_SWIMMER_MALE_DARRIN", "Route20"),
    ("TRAINER_SWIMMER_FEMALE_SHIRLEY", "Route20"),
    ("TRAINER_SWIMMER_FEMALE_TIFFANY", "Route20"),
    ("TRAINER_FISHERMAN_RONALD", "Route21_North"),
    ("TRAINER_FISHERMAN_WADE", "Route21_North"),
    ("TRAINER_SWIMMER_MALE_SPENCER", "Route21_North"),
    ("TRAINER_SIS_AND_BRO_LIL_IAN", "Route21_North"),
    ("TRAINER_FISHERMAN_CLAUDE", "Route21_South"),
    ("TRAINER_FISHERMAN_NOLAN", "Route21_South"),
    ("TRAINER_SWIMMER_MALE_JACK", "Route21_South"),
    ("TRAINER_SWIMMER_MALE_JEROME", "Route21_South"),
    ("TRAINER_SWIMMER_MALE_ROLAND", "Route21_South"),
    ("TRAINER_SCIENTIST_TED", "PokemonMansion_1F"),
    ("TRAINER_YOUNGSTER_JOHNSON", "PokemonMansion_1F"),
    ("TRAINER_BURGLAR_ARNIE", "PokemonMansion_2F"),
    ("TRAINER_BURGLAR_SIMON", "PokemonMansion_3F"),
    ("TRAINER_SCIENTIST_BRAYDON", "PokemonMansion_3F"),
    ("TRAINER_BURGLAR_LEWIS", "PokemonMansion_B1F"),
    ("TRAINER_SCIENTIST_IVAN", "PokemonMansion_B1F"),
    ("TRAINER_BURGLAR_QUINN", "CinnabarIsland_Gym"),
    ("TRAINER_SUPER_NERD_ERIK", "CinnabarIsland_Gym"),
    ("TRAINER_SUPER_NERD_AVERY", "CinnabarIsland_Gym"),
    ("TRAINER_BURGLAR_RAMON", "CinnabarIsland_Gym"),
    ("TRAINER_SUPER_NERD_DEREK", "CinnabarIsland_Gym"),
    ("TRAINER_BURGLAR_DUSTY", "CinnabarIsland_Gym"),
    ("TRAINER_SUPER_NERD_ZAC", "CinnabarIsland_Gym"),
    ("TRAINER_LEADER_BLAINE", "CinnabarIsland_Gym"),
    ("TRAINER_TAMER_JASON", "ViridianCity_Gym"),
    ("TRAINER_TAMER_COLE", "ViridianCity_Gym"),
    ("TRAINER_BLACK_BELT_ATSUSHI", "ViridianCity_Gym"),
    ("TRAINER_BLACK_BELT_KIYO", "ViridianCity_Gym"),
    ("TRAINER_BLACK_BELT_TAKASHI", "ViridianCity_Gym"),
    ("TRAINER_COOLTRAINER_SAMUEL", "ViridianCity_Gym"),
    ("TRAINER_COOLTRAINER_YUJI", "ViridianCity_Gym"),
    ("TRAINER_COOLTRAINER_WARREN", "ViridianCity_Gym"),
    ("TRAINER_LEADER_GIOVANNI", "ViridianCity_Gym"),
    ("TRAINER_RIVAL_ROUTE22_LATE_SQUIRTLE", "Route22"),
    ("TRAINER_RIVAL_ROUTE22_LATE_BULBASAUR", "Route22"),
    ("TRAINER_RIVAL_ROUTE22_LATE_CHARMANDER", "Route22"),
    ("TRAINER_COOLTRAINER_NAOMI", "VictoryRoad_1F"),
    ("TRAINER_COOLTRAINER_ROLANDO", "VictoryRoad_1F"),
    ("TRAINER_POKEMANIAC_DAWSON", "VictoryRoad_2F"),
    ("TRAINER_BLACK_BELT_DAISUKE", "VictoryRoad_2F"),
    ("TRAINER_JUGGLER_NELSON", "VictoryRoad_2F"),
    ("TRAINER_JUGGLER_GREGORY", "VictoryRoad_2F"),
    ("TRAINER_TAMER_VINCENT", "VictoryRoad_2F"),
    ("TRAINER_COOLTRAINER_GEORGE", "VictoryRoad_3F"),
    ("TRAINER_COOLTRAINER_COLBY", "VictoryRoad_3F"),
    ("TRAINER_COOLTRAINER_CAROLINE", "VictoryRoad_3F"),
    ("TRAINER_COOLTRAINER_ALEXA", "VictoryRoad_3F"),
    ("TRAINER_COOL_COUPLE_RAY_TYRA", "VictoryRoad_3F"),
    ("TRAINER_ELITE_FOUR_LORELEI", "PokemonLeague_LoreleisRoom"),
    ("TRAINER_ELITE_FOUR_BRUNO", "PokemonLeague_BrunosRoom"),
    ("TRAINER_ELITE_FOUR_AGATHA", "PokemonLeague_AgathasRoom"),
    ("TRAINER_ELITE_FOUR_LANCE", "PokemonLeague_LancesRoom"),
    ("TRAINER_CHAMPION_FIRST_SQUIRTLE", "PokemonLeague_ChampionsRoom"),
    ("TRAINER_CHAMPION_FIRST_BULBASAUR", "PokemonLeague_ChampionsRoom"),
    ("TRAINER_CHAMPION_FIRST_CHARMANDER", "PokemonLeague_ChampionsRoom"),
    ("TRAINER_SWIMMER_FEMALE_MARIA", "OneIsland_KindleRoad"),
    ("TRAINER_SWIMMER_FEMALE_ABIGAIL", "OneIsland_KindleRoad"),
    ("TRAINER_SWIMMER_MALE_FINN", "OneIsland_KindleRoad"),
    ("TRAINER_SWIMMER_MALE_GARRETT", "OneIsland_KindleRoad"),
    ("TRAINER_FISHERMAN_TOMMY", "OneIsland_KindleRoad"),
    ("TRAINER_CRUSH_GIRL_SHARON", "OneIsland_KindleRoad"),
    ("TRAINER_CRUSH_GIRL_TANYA", "OneIsland_KindleRoad"),
    ("TRAINER_BLACK_BELT_SHEA", "OneIsland_KindleRoad"),
    ("TRAINER_BLACK_BELT_HUGH", "OneIsland_KindleRoad"),
    ("TRAINER_CAMPER_BRYCE", "OneIsland_KindleRoad"),
    ("TRAINER_PICNICKER_CLAIRE", "OneIsland_KindleRoad"),
    ("TRAINER_CRUSH_KIN_MIK_KIA", "OneIsland_KindleRoad"),
    ("TRAINER_SWIMMER_FEMALE_AMARA", "OneIsland_TreasureBeach"),
    ("TRAINER_CRUSH_GIRL_JOCELYN", "MtEmber_Exterior"),
    ("TRAINER_PKMN_RANGER_BETH", "MtEmber_Exterior"),
    ("TRAINER_PKMN_RANGER_LOGAN", "MtEmber_Exterior"),
    ("TRAINER_BIKER_GOON", "ThreeIsland"),
    ("TRAINER_BIKER_GOON_2", "ThreeIsland"),
    ("TRAINER_BIKER_GOON_3", "ThreeIsland"),
    ("TRAINER_CUE_BALL_PAXTON", "ThreeIsland"),
    ("TRAINER_AROMA_LADY_NIKKI", "ThreeIsland_BondBridge"),
    ("TRAINER_AROMA_LADY_VIOLET", "ThreeIsland_BondBridge"),
    ("TRAINER_SWIMMER_FEMALE_TISHA", "ThreeIsland_BondBridge"),
    ("TRAINER_TUBER_ALEXIS", "ThreeIsland_BondBridge"),
    ("TRAINER_TUBER_AMIRA", "ThreeIsland_BondBridge"),
    ("TRAINER_TWINS_JOY_MEG", "ThreeIsland_BondBridge"),
]

# HeartGold overworld sprite for each FireRed class (for the events' trainer objects)
SPRITES = {
    "BUG_CATCHER": 318, "YOUNGSTER": 317, "LASS": 319, "CAMPER": 345, "PICNICKER": 346, "HIKER": 333,
    "SUPER_NERD": 338, "TEAM_ROCKET": 222, "SCIENTIST": 29, "POKEMANIAC": 377, "SAILOR": 348, "FISHERMAN": 347,
    "SWIMMER_M": 342, "SWIMMER_F": 343, "BIKER": 229, "CUE_BALL": 229, "GENTLEMAN": 341, "BEAUTY": 326,
    "BIRD_KEEPER": 323, "BLACK_BELT": 344, "PSYCHIC": 227, "CHANNELER": 219, "JUGGLER": 378, "TAMER": 378, "ROCKER": 322, "YOUNG_COUPLE": 323, "CRUSH_KIN": 344, "BURGLAR": 218, "SIS_AND_BRO": 342, "COOL_COUPLE": 324, "CRUSH_GIRL": 321, "PKMN_RANGER": 324, "TUBER": 316, "AROMA_LADY": 327, "COOLTRAINER": 324, "RIVAL_EARLY": 375,
    "RIVAL_LATE": 375, "LEADER": 352, "ENGINEER": 324, "GAMER": 330, "TWINS": 316,
}


def trainer_id(const):
    """Part 1 id of a FireRed trainer constant (for building the events)"""
    return FIRST_ID + [c for c, _ in PART1_TRAINERS].index(const)

# FireRed class -> HeartGold class
CLASSES = {
    "TWINS": "TRAINERCLASS_TWINS",
    "BUG_CATCHER": "TRAINERCLASS_BUG_CATCHER",
    "CAMPER": "TRAINERCLASS_CAMPER",
    "PICNICKER": "TRAINERCLASS_PICNICKER",
    "LASS": "TRAINERCLASS_LASS",
    "YOUNGSTER": "TRAINERCLASS_YOUNGSTER",
    "HIKER": "TRAINERCLASS_HIKER",
    "SUPER_NERD": "TRAINERCLASS_SUPER_NERD",
    "TEAM_ROCKET": "TRAINERCLASS_TEAM_ROCKET",
    "SAILOR": "TRAINERCLASS_SAILOR",
    "FISHERMAN": "TRAINERCLASS_FISHERMAN",
    "SWIMMER_M": "TRAINERCLASS_SWIMMER_M",
    "SWIMMER_F": "TRAINERCLASS_SWIMMER_F",
    "GENTLEMAN": "TRAINERCLASS_GENTLEMAN",
    "BEAUTY": "TRAINERCLASS_BEAUTY",
    "POKEMANIAC": "TRAINERCLASS_POKE_MANIAC",
    "ENGINEER": "TRAINERCLASS_WORKER",
    "GAMER": "TRAINERCLASS_GENTLEMAN",
    "BIKER": "TRAINERCLASS_BIKER",
    "CUE_BALL": "TRAINERCLASS_ROUGHNECK",
    "BURGLAR": "TRAINERCLASS_BURGLAR",
    "SCIENTIST": "TRAINERCLASS_SCIENTIST",
    "BIRD_KEEPER": "TRAINERCLASS_BIRD_KEEPER",
    "BLACK_BELT": "TRAINERCLASS_BLACK_BELT",
    "JUGGLER": "TRAINERCLASS_JUGGLER",
    "TAMER": "TRAINERCLASS_JUGGLER",
    "PSYCHIC": "TRAINERCLASS_PSYCHIC_M",
    "CHANNELER": "TRAINERCLASS_MEDIUM",
    "ROCKER": "TRAINERCLASS_GUITARIST",
    "COOLTRAINER": "TRAINERCLASS_ACE_TRAINER_M",
    "BOSS": "TRAINERCLASS_ROCKET_BOSS",
    "YOUNG_COUPLE": "TRAINERCLASS_YOUNG_COUPLE",
    "CRUSH_KIN": "TRAINERCLASS_DOUBLE_TEAM",
    "COOL_COUPLE": "TRAINERCLASS_DOUBLE_TEAM",
    "CRUSH_GIRL": "TRAINERCLASS_BATTLE_GIRL",
    "PKMN_RANGER_M": "TRAINERCLASS_PKMN_RANGER_M",
    "PKMN_RANGER_F": "TRAINERCLASS_PKMN_RANGER_F",
    "TUBER_M": "TRAINERCLASS_TUBER_M",
    "TUBER_F": "TRAINERCLASS_TUBER_F",
    "AROMA_LADY": "TRAINERCLASS_AROMA_LADY",
    "SIS_AND_BRO": "TRAINERCLASS_DOUBLE_TEAM",
}
LEADERS = {
    "BROCK": "TRAINERCLASS_LEADER_BROCK",
    "MISTY": "TRAINERCLASS_LEADER_MISTY",
    "LT. SURGE": "TRAINERCLASS_LEADER_LT_SURGE",
    "ERIKA": "TRAINERCLASS_LEADER_ERIKA",
    "KOGA": "TRAINERCLASS_ELITE_FOUR_KOGA",
    "SABRINA": "TRAINERCLASS_LEADER_SABRINA",
    "BLAINE": "TRAINERCLASS_LEADER_BLAINE",
    "GIOVANNI": "TRAINERCLASS_P1_LEADER_GIOVANNI",  # the Viridian Gym battle (the Rocket Boss battles are class BOSS)
}

ELITE_FOUR = {
    "LORELEI": "TRAINERCLASS_ELITE_FOUR_LORELEI",
    "BRUNO": "TRAINERCLASS_ELITE_FOUR_BRUNO",
    "AGATHA": "TRAINERCLASS_ELITE_FOUR_AGATHA",
    "LANCE": "TRAINERCLASS_P1_ELITE_FOUR_LANCE",
}

KEEP_UPPER = {"OK", "HQ", "TV", "HP", "PP", "TM", "HM", "PC", "S.S.", "LT.", "KO", "ID", "DNA"}
WORDS = [
    ("POKéMON", "Pokémon"), ("POKéDEX", "Pokédex"), ("POKé BALL", "Poké Ball"), ("POKé", "Poké"),
    ("PROF. OAK", "Professor Oak"), ("TEAM ROCKET", "Team Rocket"), ("LT. SURGE", "Lt. Surge"), ("MR. FUJI", "Mr. Fuji"),
    ("HALL OF\\n", "Hall of\\n"), ("HALL OF FAMERS", "Hall of Famers"), ("HALL OF FAME", "Hall of Fame"),
]
GENERATED_BEGIN = "// BEGIN PART1 GENERATED (scripts/hack/gen_part1_trainers.py)"
GENERATED_END = "// END PART1 GENERATED"


def read(path):
    return open(path, encoding="utf-8").read()


def frlg_text(text, player=None):
    """FireRed string -> HeartGold text-archive line: \\n newline, \\l scroll -> \\f, \\p new box -> \\r"""
    # a leader's defeat line narrates getting the badge in another font; the gym script does that part here
    text = re.sub(r"\{FONT_NORMAL\}.*?\{FONT_MALE\}", "", text)
    text = text.replace("{PLAYER}", "\x01" if player else "you").replace("{RIVAL}", "Blue")
    text = re.sub(r"\{[A-Z_]+ 0x[0-9A-Fa-f]+\}", "", text)  # {PAUSE 0xFE}
    text = re.sub(r"\{[A-Z0-9_ ]+\}", "", text)
    text = re.sub(r"([A-Z]+)BADGE", lambda m: m.group(1) + " Badge", text)
    for a, b in WORDS:
        text = text.replace(a, b)

    def fix(m):
        w = m.group(0)
        if w in KEEP_UPPER or w.rstrip(".") in KEEP_UPPER or len(w) < 2:
            return w
        return w[0] + w[1:].lower()

    text = re.sub(r"[A-Zé]{2,}(?:\.)?", fix, text)
    text = text.replace("\\l", "\\f").replace("\\p", "\\r")
    text = text.replace("'", "’").replace("…", "...")
    while text.endswith("\\n"):  # a line left empty once a {PAUSE} or music command is dropped
        text = text[:-2]
    if player:
        text = text.replace("\x01", player)
    return text


def parse_texts(map_name):
    out = {}
    label = None
    for line in read(f"{PFR}/data/maps/{map_name}/text.inc").splitlines():
        m = re.match(r"^(\w+)::", line)
        if m:
            label = m.group(1)
            out[label] = ""
            continue
        m = re.match(r'^\s*\.string "(.*)"', line)
        if m and label:
            out[label] += m.group(1)
    return {k: v.rstrip("$") for k, v in out.items()}


_ALL_TEXTS = {}
NOT_ENOUGH = {}


def parse_all_texts():
    if not _ALL_TEXTS:
        import glob
        for path in glob.glob(f"{PFR}/data/maps/*/text.inc"):
            _ALL_TEXTS.update(parse_texts(path.split("/")[-2]))
    return _ALL_TEXTS


def parse_battle_texts(map_name, const):
    lines = read(f"{PFR}/data/maps/{map_name}/scripts.inc").splitlines() + read(f"{PFR}/data/scripts/trainers.inc").splitlines()
    for i, line in enumerate(lines):
        m = re.match(r"\s*trainerbattle_\w+ " + const + r", (\w+)(?:, (\w+))?(?:, .*)?\s*$", line)
        if not m:
            continue
        md = re.match(r"\s*trainerbattle_double " + const + r", \w+, \w+, (\w+)", line)
        NOT_ENOUGH[const] = md.group(1) if md else None
        if m.group(2):
            intro, defeat = m.group(1), m.group(2)
        else:
            intro, defeat = None, m.group(1)  # trainerbattle_no_intro: the script says the intro
        after = None
        for nxt in lines[i + 1:i + 8]:
            m2 = re.match(r"\s*msgbox (\w+)", nxt)
            if m2:
                after = m2.group(1)
                break
        return intro, defeat, after
    raise SystemExit(f"no trainerbattle for {const} in {map_name}")


def parse_trainers():
    src = read(f"{PFR}/src/data/trainers.h")
    out = {}
    for m in re.finditer(r"\[(TRAINER_\w+)\] = \{(.*?)\n    \},", src, re.S):
        body = m.group(2)
        if ".party" not in body:
            continue
        cls = re.search(r"\.trainerClass = TRAINER_CLASS_(\w+)", body).group(1)
        name = re.search(r'\.trainerName = _\("(.*?)"\)', body).group(1)
        party = re.search(r"\.party = (\w+)\((\w+)\)", body)
        pic = re.search(r"\.trainerPic = TRAINER_PIC_(\w+)", body)
        items = re.search(r"\.items = \{(.*?)\}", body).group(1)
        if cls in ("TUBER", "PKMN_RANGER"):  # gendered in HeartGold
            cls += "_F" if pic and pic.group(1).endswith("_F") else "_M"
        out[m.group(1)] = dict(cls=cls, name=name, kind=party.group(1), party=party.group(2),
                               double=".doubleBattle = TRUE" in body,
                               items=[x.strip() for x in items.split(",") if x.strip()])
    return out


MOVE_NAMES = {"MOVE_FAINT_ATTACK": "MOVE_FEINT_ATTACK"}  # FireRed spelling -> hg-engine


def parse_parties():
    src = read(f"{PFR}/src/data/trainer_parties.h")
    out = {}
    for m in re.finditer(r"static const struct \w+ (sParty_\w+)\[\] = \{([^\n]*\}|.*?\n\});", src, re.S):
        mons = []
        for mm in re.finditer(r"\{(.*?)\n    \}", m.group(2), re.S):
            body = mm.group(1)
            mon = dict(iv=int(re.search(r"\.iv = (\d+)", body).group(1)),
                       lvl=int(re.search(r"\.lvl = (\d+)", body).group(1)),
                       species=re.search(r"\.species = (\w+)", body).group(1))
            item = re.search(r"\.heldItem = (\w+)", body)
            moves = re.search(r"\.moves = \{(.*?)\}", body)
            mon["item"] = item.group(1) if item else None
            mon["moves"] = [MOVE_NAMES.get(x.strip(), x.strip()) for x in moves.group(1).split(",")] if moves else None
            mons.append(mon)
        out[m.group(1)] = mons
    return out


def cstr(text):
    return text.replace("\\", "\\\\").replace('"', '\\"')


def title(name):
    if name == "LT. SURGE":
        return "Lt. Surge"
    return " ".join(w.capitalize() if w not in KEEP_UPPER else w for w in name.split(" "))


def main():
    trainers = parse_trainers()
    parties = parse_parties()
    entries, consts, ids = [], [], []
    for n, (const, map_name) in enumerate(PART1_TRAINERS):
        tid = FIRST_ID + n
        t = trainers[const]
        mons = parties[t["party"]]
        texts = parse_texts(map_name)
        for label in parse_battle_texts(map_name, const):
            if label and label not in texts:
                texts.update(parse_all_texts())
        intro, defeat, after = parse_battle_texts(map_name, const)
        if t["cls"].startswith("RIVAL"):
            cls, t = "TRAINERCLASS_LEADER_BLUE", dict(t, name="BLUE")  # Part 1's rival is always Blue (enemy_party.c)
        elif t["cls"] == "CHAMPION":
            cls, t = "TRAINERCLASS_P1_CHAMPION_BLUE", dict(t, name="BLUE")
        elif t["cls"] == "ELITE_FOUR":
            cls = ELITE_FOUR[t["name"]]
        else:
            cls = LEADERS.get(t["name"]) if t["cls"] == "LEADER" else CLASSES[t["cls"]]
        has_items = "ITEM" in t["kind"] and "NO_ITEM" not in t["kind"]
        has_moves = "CUSTOM_MOVES" in t["kind"]
        types = []
        if has_moves:
            types.append("TRAINER_DATA_TYPE_MOVES")
        if has_items:
            types.append("TRAINER_DATA_TYPE_ITEMS")
        items = (t["items"] + ["ITEM_NONE"] * 4)[:4]
        e = [f"    // {const} (FireRed, {map_name})", f"    [{tid}] = {{", f'        .name = "{title(t["name"])}",',
             "        .data = {",
             f"            .trainerType = {' | '.join(types) if types else 'TRAINER_DATA_TYPE_NOTHING'},",
             f"            .trainerClass = {cls},",
             f"            .items = {{ {', '.join(items)} }},",
             "            .aiFlags = F_PRIORITIZE_SUPER_EFFECTIVE | F_EVALUATE_ATTACKS,",
             f"            .battleType = {'DOUBLE_BATTLE' if t['double'] else 'SINGLE_BATTLE'},", "        },", "        .party = {"]
        for mon in mons:
            e += ["            {", f"                .ivs = {mon['iv']},",
                  "                .abilitySlot = TRAINER_POKEMON_ABILITY_1,",
                  f"                .level = {mon['lvl']},", f"                .species = {mon['species']},"]
            if has_items:
                e.append(f"                .item = {mon['item'] or 'ITEM_NONE'},")
            if has_moves:
                e.append(f"                .moves = {{ {', '.join(mon['moves'])} }},")
            e += ["                .ballSeal = 0,", "            },"]
        e += ["        },", "        .text = {"]
        kinds = (("TRMSG_INTRO", intro), ("TRMSG_LOSE", defeat), ("TRMSG_AFTER", after))
        if t["double"]:
            # both trainers of a double battle say the same lines (HeartGold asks for each one's)
            one = NOT_ENOUGH.get(const)
            kinds = (("TRMSG_DBL_INTRO_1", intro), ("TRMSG_DBL_LOSE_1", defeat), ("TRMSG_DBL_AFTER_1", after),
                     ("TRMSG_DBL_1POKE_1", one), ("TRMSG_DBL_INTRO_2", intro), ("TRMSG_DBL_LOSE_2", defeat),
                     ("TRMSG_DBL_AFTER_2", after), ("TRMSG_DBL_1POKE_2", one))
        for kind, label in kinds:
            if label:
                e += ["            {", f"                .type = {kind},",
                      f'                .text = "{cstr(frlg_text(texts[label]))}\\\\n",', "            },"]
        e += ["        },", "    },", ""]
        entries += e
        consts.append(f".equ TRAINER_P1_{const[len('TRAINER_'):]}, {tid}")
        ids.append(f"    {tid},")

    path = "data/Trainers.c"
    s = read(path)
    block = GENERATED_BEGIN + "\n" + "\n".join(entries) + "    " + GENERATED_END + "\n"
    if GENERATED_BEGIN in s:
        s = re.sub(re.escape(GENERATED_BEGIN) + r".*?" + re.escape(GENERATED_END) + r"\n", lambda m: block.lstrip(), s, count=1, flags=re.S)
    else:
        s = s.replace("};\n\nconst u16 sTrainerTextOrder[] = {", "    " + block + "};\n\nconst u16 sTrainerTextOrder[] = {", 1)
    order_block = "    " + GENERATED_BEGIN + "\n" + "\n".join(ids) + "\n    " + GENERATED_END + "\n"
    head, tail = s.split("const u16 sTrainerTextOrder[] = {", 1)
    if GENERATED_BEGIN in tail:
        tail = re.sub(r"    " + re.escape(GENERATED_BEGIN) + r".*?" + re.escape(GENERATED_END) + r"\n", lambda m: order_block, tail, count=1, flags=re.S)
    else:
        tail = tail.replace("\n};", "\n" + order_block + "};", 1)
    open(path, "w", encoding="utf-8").write(head + "const u16 sTrainerTextOrder[] = {" + tail)

    path = "asm/include/trainers.inc"
    s = read(path)
    block = "// " + GENERATED_BEGIN[3:] + "\n" + "\n".join(consts) + "\n// " + GENERATED_END[3:] + "\n"
    if GENERATED_BEGIN[3:] in s:
        s = re.sub(r"// " + re.escape(GENERATED_BEGIN[3:]) + r".*?" + re.escape(GENERATED_END[3:]) + r"\n", lambda m: block, s, count=1, flags=re.S)
    else:
        s = s.replace("\n.endif", "\n" + block + "\n.endif", 1)
    open(path, "w", encoding="utf-8").write(s)
    print(f"{len(PART1_TRAINERS)} Part 1 trainers, ids {FIRST_ID}-{FIRST_ID + len(PART1_TRAINERS) - 1}")


if __name__ == "__main__":
    main()

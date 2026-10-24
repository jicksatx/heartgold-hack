#!/usr/bin/env python3
"""
hack: Part 1 (FireRed Kanto) trainers, taken from FireRed (pret/pokefirered).

for every trainer in PART1_TRAINERS (in order; only ever append, the ids are saved-game-visible through trainer
flags), this reads the party from src/data/trainers.h + trainer_parties.h and the intro / defeat / post-battle lines
from the map's scripts.inc + text.inc, and writes:
  - data/Trainers.c, between the PART1 GENERATED markers: the trainer entries (ids from FIRST_ID up)
  - data/Trainers.c sTrainerTextOrder: the ids, between the PART1 GENERATED markers
  - asm/include/trainers.inc: TRAINER_P1_<name> constants, between the PART1 GENERATED markers

scripts use a trainer object with script 3000 + id (the common trainer script), or trainer_battle for gym leaders.

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
]

# HeartGold overworld sprite for each FireRed class (for the events' trainer objects)
SPRITES = {
    "BUG_CATCHER": 318, "YOUNGSTER": 317, "LASS": 319, "CAMPER": 345, "PICNICKER": 346, "HIKER": 333,
    "SUPER_NERD": 338, "TEAM_ROCKET": 222, "SCIENTIST": 29, "POKEMANIAC": 377, "SAILOR": 348, "FISHERMAN": 347,
    "SWIMMER_M": 342, "SWIMMER_F": 343, "BIKER": 229, "CUE_BALL": 229, "GENTLEMAN": 341, "BEAUTY": 326,
    "BIRD_KEEPER": 323, "BLACK_BELT": 344, "PSYCHIC": 227, "CHANNELER": 219, "COOLTRAINER": 324, "RIVAL_EARLY": 375,
    "RIVAL_LATE": 375, "LEADER": 352, "ENGINEER": 324, "GAMER": 330,
}


def trainer_id(const):
    """Part 1 id of a FireRed trainer constant (for building the events)"""
    return FIRST_ID + [c for c, _ in PART1_TRAINERS].index(const)

# FireRed class -> HeartGold class
CLASSES = {
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
}
LEADERS = {
    "BROCK": "TRAINERCLASS_LEADER_BROCK",
    "MISTY": "TRAINERCLASS_LEADER_MISTY",
    "LT. SURGE": "TRAINERCLASS_LEADER_LT_SURGE",
    "ERIKA": "TRAINERCLASS_LEADER_ERIKA",
    "KOGA": "TRAINERCLASS_ELITE_FOUR_KOGA",
    "SABRINA": "TRAINERCLASS_LEADER_SABRINA",
    "BLAINE": "TRAINERCLASS_LEADER_BLAINE",
    "GIOVANNI": "TRAINERCLASS_ROCKET_BOSS",
}

KEEP_UPPER = {"OK", "TV", "HP", "PP", "TM", "HM", "PC", "S.S.", "LT.", "KO", "ID"}
WORDS = [
    ("POKéMON", "Pokémon"), ("POKéDEX", "Pokédex"), ("POKé BALL", "Poké Ball"), ("POKé", "Poké"),
    ("PROF. OAK", "Professor Oak"), ("TEAM ROCKET", "Team Rocket"), ("LT. SURGE", "Lt. Surge"),
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
        items = re.search(r"\.items = \{(.*?)\}", body).group(1)
        out[m.group(1)] = dict(cls=cls, name=name, kind=party.group(1), party=party.group(2),
                               items=[x.strip() for x in items.split(",") if x.strip()])
    return out


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
            mon["moves"] = [x.strip() for x in moves.group(1).split(",")] if moves else None
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
             "            .battleType = SINGLE_BATTLE,", "        },", "        .party = {"]
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
        for kind, label in (("TRMSG_INTRO", intro), ("TRMSG_LOSE", defeat), ("TRMSG_AFTER", after)):
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

#include "config.h"
#include "debug.h"
#include "types.h"

#include "constants/species.h"
#include "rtc.h"
#include "save.h"
#include "pokemon.h"

#include "randomizer.h"

/*
 *  hack: seeded randomizer shared by the starter randomizer and (later) the area randomizer.
 *
 *  the seed is created once per new game, the first time anything asks for it (the starter selection in
 *  Elm's lab comes before any wild encounter), and is kept in two otherwise unused script vars so it is
 *  saved with the game.  everything derived from it is deterministic for that save.
 */

#define RANDOMIZER_SEED_VAR_LO 0x4164
#define RANDOMIZER_SEED_VAR_HI 0x4165

u32 LONG_CALL Randomizer_GetSeed(void)
{
    u32 seed = GetScriptVar(RANDOMIZER_SEED_VAR_LO) | (GetScriptVar(RANDOMIZER_SEED_VAR_HI) << 16);

    if (seed == 0) {
        struct RTCTime time;
        GF_RTC_CopyTime(&time);
        seed = ((u32)gf_rand() << 16) ^ gf_rand() ^ (time.second * 2654435761u) ^ (time.minute << 8);
        if (seed == 0) {
            seed = 0x1D872B41;
        }
        SetScriptVar(RANDOMIZER_SEED_VAR_LO, seed & 0xFFFF);
        SetScriptVar(RANDOMIZER_SEED_VAR_HI, seed >> 16);
    }
    return seed;
}

/**
 *  @brief deterministic hash of (seed, salt) -> 32 bit value.  same inputs always give the same output.
 */
u32 LONG_CALL Randomizer_Hash(u32 seed, u32 salt)
{
    u32 x = seed ^ (salt * 0x9E3779B9u);
    x ^= x >> 16;
    x *= 0x7FEB352Du;
    x ^= x >> 15;
    x *= 0x846CA68Bu;
    x ^= x >> 16;
    return x;
}

// ---------------------------------------------------------------- starters

enum {
    STARTER_GRASS,
    STARTER_FIRE,
    STARTER_WATER,
};

#define STARTER_LINES_PER_TYPE 9
#define JOHTO_LINE_INDEX       1 // Chikorita / Cyndaquil / Totodile, the lines Silver's trainer data uses

// [type][line][stage]
static const u16 sStarterLines[3][STARTER_LINES_PER_TYPE][3] = {
    [STARTER_GRASS] = {
        { SPECIES_BULBASAUR,  SPECIES_IVYSAUR,    SPECIES_VENUSAUR    },
        { SPECIES_CHIKORITA,  SPECIES_BAYLEEF,    SPECIES_MEGANIUM    },
        { SPECIES_TREECKO,    SPECIES_GROVYLE,    SPECIES_SCEPTILE    },
        { SPECIES_TURTWIG,    SPECIES_GROTLE,     SPECIES_TORTERRA    },
        { SPECIES_SNIVY,      SPECIES_SERVINE,    SPECIES_SERPERIOR   },
        { SPECIES_CHESPIN,    SPECIES_QUILLADIN,  SPECIES_CHESNAUGHT  },
        { SPECIES_ROWLET,     SPECIES_DARTRIX,    SPECIES_DECIDUEYE   },
        { SPECIES_GROOKEY,    SPECIES_THWACKEY,   SPECIES_RILLABOOM   },
        { SPECIES_SPRIGATITO, SPECIES_FLORAGATO,  SPECIES_MEOWSCARADA },
    },
    [STARTER_FIRE] = {
        { SPECIES_CHARMANDER, SPECIES_CHARMELEON, SPECIES_CHARIZARD   },
        { SPECIES_CYNDAQUIL,  SPECIES_QUILAVA,    SPECIES_TYPHLOSION  },
        { SPECIES_TORCHIC,    SPECIES_COMBUSKEN,  SPECIES_BLAZIKEN    },
        { SPECIES_CHIMCHAR,   SPECIES_MONFERNO,   SPECIES_INFERNAPE   },
        { SPECIES_TEPIG,      SPECIES_PIGNITE,    SPECIES_EMBOAR      },
        { SPECIES_FENNEKIN,   SPECIES_BRAIXEN,    SPECIES_DELPHOX     },
        { SPECIES_LITTEN,     SPECIES_TORRACAT,   SPECIES_INCINEROAR  },
        { SPECIES_SCORBUNNY,  SPECIES_RABOOT,     SPECIES_CINDERACE   },
        { SPECIES_FUECOCO,    SPECIES_CROCALOR,   SPECIES_SKELEDIRGE  },
    },
    [STARTER_WATER] = {
        { SPECIES_SQUIRTLE,   SPECIES_WARTORTLE,  SPECIES_BLASTOISE   },
        { SPECIES_TOTODILE,   SPECIES_CROCONAW,   SPECIES_FERALIGATR  },
        { SPECIES_MUDKIP,     SPECIES_MARSHTOMP,  SPECIES_SWAMPERT    },
        { SPECIES_PIPLUP,     SPECIES_PRINPLUP,   SPECIES_EMPOLEON    },
        { SPECIES_OSHAWOTT,   SPECIES_DEWOTT,     SPECIES_SAMUROTT    },
        { SPECIES_FROAKIE,    SPECIES_FROGADIER,  SPECIES_GRENINJA    },
        { SPECIES_POPPLIO,    SPECIES_BRIONNE,    SPECIES_PRIMARINA   },
        { SPECIES_SOBBLE,     SPECIES_DRIZZILE,   SPECIES_INTELEON    },
        { SPECIES_QUAXLY,     SPECIES_QUAXWELL,   SPECIES_QUAQUAVAL   },
    },
};

/**
 *  @brief which line (0-8) the seed picked for the given starter type
 */
static u32 Randomizer_GetStarterLine(u32 type)
{
#ifdef RANDOMIZE_STARTERS
    return Randomizer_Hash(Randomizer_GetSeed(), 0x57A27E00 + type) % STARTER_LINES_PER_TYPE;
#else
    return JOHTO_LINE_INDEX;
#endif
}

/**
 *  @brief species offered in Elm's lab for slot 0 (grass), 1 (fire), 2 (water)
 */
u16 LONG_CALL Randomizer_GetStarterSpecies(int slot)
{
    if (slot < 0 || slot > 2) {
        return SPECIES_NONE;
    }
    return sStarterLines[slot][Randomizer_GetStarterLine(slot)][0];
}

/**
 *  @brief true if the species is in any starter line (used to keep starters out of the wild)
 */
BOOL LONG_CALL Randomizer_IsStarterLineSpecies(u16 species)
{
    for (int type = 0; type < 3; type++) {
        for (int line = 0; line < STARTER_LINES_PER_TYPE; line++) {
            for (int stage = 0; stage < 3; stage++) {
                if (sStarterLines[type][line][stage] == species) {
                    return TRUE;
                }
            }
        }
    }
    return FALSE;
}

/**
 *  @brief Silver's trainer data uses the Johto starter lines.  swap them for the randomized line of the same type
 *         at the same evolution stage, so he still has the starter that is strong against the player's.
 */
u16 LONG_CALL Randomizer_RemapRivalSpecies(u16 species)
{
#ifdef RANDOMIZE_STARTERS
    for (int type = 0; type < 3; type++) {
        for (int stage = 0; stage < 3; stage++) {
            if (sStarterLines[type][JOHTO_LINE_INDEX][stage] == species) {
                return sStarterLines[type][Randomizer_GetStarterLine(type)][stage];
            }
        }
    }
#endif
    return species;
}

# HeartGold hack – progress notes

Branch `hgss-hack` on jicksatx/heartgold-hack (fork of BluRosie/hg-engine).
Base ROM: US English HeartGold (game code IPKE). Personal use only.

## Plan (priority order) and status
1. National Dex + Running Shoes at New Game — DONE (`NEW_GAME_START_BONUSES`, src/save.c)
2. Goldenrod evolution items (3F) + Mints (4F, replacing vitamins) — DONE (src/field/mart.c). Celadon 5F vitamins also → Mints. Mints 4,000; Razor Claw / Chipped Pot 3,000.
3. Running indoors (vanilla HGSS already allows), infinite TMs (`REUSABLE_TMS`), remove EVs — DONE (`REMOVE_EVS`, bytereplacement). EV berries kept as friendship berries (text updated).
4. Impossible evolutions — DONE. Trade/trade-item evos → use item (Linking Cord, Sachet, Whipped Dream, held items made usable). Levels: Milcery 25, Poltchageist 28, Gimmighoul 40, Bisharp 50, Stantler 30, Pawmo 32, Bramblin 30, Rellor 30, Primeape 35, Dipplin→Hydrapple 40.
5. Gens 1–9 + Fairy — DONE (audit). Missing Gen 9 battle sprites (9) and follower sprites (30) converted from pokeemerald-expansion (scripts/hack/). HeightTable recomputed for Gen 5+.
   - Extra: 8 abilities and 30 moves implemented (see git log). Skipped: Opportunist, Ball Fetch, Symbiosis, Embody Aspect; 29 moves still unimplemented (doubles/field effects).
6. Remove Dynamax/Gigantamax, Z-moves, Tera leftovers — NEXT
7. Mega Stone shop (Slowpoke Tail vendor near Lake of Rage) + Key Stone
8. Level caps tied to next Gym Leader (hg-engine has IMPLEMENT_LEVEL_CAP)
9. Move Relearner in all 16 gym towns, standard relearner, 500₽ per move
10. Starter randomizer (seeded; Grass/Fire/Water pools Gens 1–9 incl. Johto starters)
11. Area randomizer (seeded; similar BST; excludes starters, legendaries, Ultra Beasts, battle forms; starters never wild)
12. Nuzlocke mode (RadiantRed rules: New Game option; first encounter per area once you have Poké Balls; fainted → locked graveyard box; dupes + shiny clauses; gifts/statics free; forced Set; nicknames optional; wipe = game over)
13. Sinnoh/Platinum content — decide later

## Building in the cloud workspace (workarounds)
- Only GitHub is reachable: ARM toolchain from xpack GitHub release (arm-none-eabi-gcc 14.2.1),
  ndspy copied from its GitHub source into `.venv`, and build with `make ROM_TOOL=tools/ndstool`
  (ds-rom needs crates.io, which is blocked).
- On your own machine (WSL) the normal README steps work.

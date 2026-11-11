#ifndef SLOTS_SOUND_H
#define SLOTS_SOUND_H
// hack: Platinum's sound API names as used by the slot machine, mapped to HeartGold (see shim.c)
#include <nitro/types.h>
enum { PLAYER_FIELD = 1, PLAYER_BGM = 7 };
#define SOUND_SCENE_SUB_66 64 // HeartGold's Voltorb Flip scene
#define SEQ_NONE 0
BOOL Sound_SetSceneAndPlayBGM(u8 scene, u16 bgmID, int unused);
void Sound_SetBGMPlayerPaused(u8 playerID, BOOL paused);
#endif

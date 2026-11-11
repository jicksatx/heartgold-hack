#ifndef SLOTS_SOUND_PLAYBACK_H
#define SLOTS_SOUND_PLAYBACK_H
// hack: HeartGold sound ids for the Platinum names used by the slot machine
#include <nitro/types.h>
#include "sound.h"
#define SE_CONFIRM_sseq_6        1500 // SEQ_SE_DP_SELECT
#define SEQ_SE_DP_ZUKAN02_sseq   1517
#define SEQ_SE_DP_OPEN2_sseq     1518
#define SEQ_SE_DP_025_sseq       1520
#define SEQ_SE_DP_UG_020_sseq    1571
#define SEQ_SE_DP_UG_022_sseq    1573
#define SEQ_SE_DP_DENSI16_sseq   1580
#define SEQ_SE_DP_SLOT01_sseq    1743
#define SEQ_SE_DP_SLOT02_sseq    1744
#define SEQ_SLOT_ATARI_sseq      1162 // SEQ_GS_GAMEATARI (HeartGold's Game Corner win music)
#define SEQ_SLOT_OOATARI_sseq    1162
BOOL Sound_PlayBasicBGM(u16 bgmID);
void Sound_StopBGM(u16 bgmID, int fadeOutFrames);
BOOL Sound_PlayEffect(u16 seqID);
BOOL Sound_PlayPokemonCry(u16 species, u8 form);
#endif

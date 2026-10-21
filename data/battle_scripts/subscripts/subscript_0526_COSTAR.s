#include "constants/battle_constants.h"
.include "battle_commands.inc"

.data

// Costar: stat stages were already copied in C (SwitchInAbilityCheck); show popup + message
_000:
    AbilityPopup BATTLER_CATEGORY_MSG_BATTLER_TEMP
    WaitButtonABTime 15
    // {0} copied {1}'s stat changes!
    PrintMessage 452, TAG_NICKNAME_NICKNAME, BATTLER_CATEGORY_MSG_BATTLER_TEMP, BATTLER_CATEGORY_SIDE_EFFECT_MON
    Wait
    WaitButtonABTime 30
    End

#include "constants/battle_constants.h"
.include "battle_commands.inc"

.data

// Curious Medicine: the ally's stat stages were already reset in C (SwitchInAbilityCheck); show popup + message
_000:
    AbilityPopup BATTLER_CATEGORY_MSG_BATTLER_TEMP
    WaitButtonABTime 15
    // All stat changes were eliminated!
    PrintMessage 817, TAG_NONE
    Wait
    WaitButtonABTime 30
    End

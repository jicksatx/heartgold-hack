#include "constants/battle_constants.h"
.include "battle_commands.inc"

.data

// Cud Chew: the berry eaten last turn was put back in C (ServerFieldConditionCheck); it then activates as normal
_000:
    AbilityPopup BATTLER_CATEGORY_MSG_BATTLER_TEMP
    WaitButtonABTime 30
    End

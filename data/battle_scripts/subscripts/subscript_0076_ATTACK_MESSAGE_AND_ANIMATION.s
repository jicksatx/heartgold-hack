#include "constants/battle_constants.h"
.include "battle_commands.inc"

.data

_000:
    PrintAttackMessage 
    Wait 
    WaitButtonABTime 20
    PlayMoveAnimation BATTLER_CATEGORY_ATTACKER
    Wait 
    End 

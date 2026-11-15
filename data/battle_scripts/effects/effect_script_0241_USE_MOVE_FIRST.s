#include "constants/battle_constants.h"
.include "battle_commands.inc"

.data

_000:
    SetPsychicTerrainMoveUsedFlag 
    TryMeFirst _011
    PrintAttackMessage 
    Wait 
    WaitButtonABTime 20 // hack: a beat after "<mon> used <move>!" now that text is instant
    PlayMoveAnimation BATTLER_CATEGORY_ATTACKER
    Wait 
    GotoIfCurrentMoveIsValidForParentalBond _016

_009:
    GoToMoveScript FALSE
    End

_011:
    UpdateVar OPCODE_FLAG_ON, BSCRIPT_VAR_MOVE_STATUS_FLAGS, MOVE_STATUS_FAILED
    End 

_016:
    Call BATTLE_SUBSCRIPT_HANDLE_PARENTAL_BOND
    GoTo _009

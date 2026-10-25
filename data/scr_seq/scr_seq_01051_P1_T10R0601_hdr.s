// hack: T10R0601 (Part 1) map script header: frame table VAR_TEMP_x4001 == 0 -> script 14, on transition -> script 15
// (data/scr_seq/scr_seq_01046_P1_LEAGUE.s), like HeartGold's own League room headers

.data

	.byte 1 // INIT_SCRIPT_ON_FRAME_TABLE
	.long _frameTable-.-4
	.byte 2 // INIT_SCRIPT_ON_TRANSITION
	.hword 15, 0
	.byte 0 // end of entries
_frameTable:
	.hword 0x4001, 0, 14 // VAR_TEMP_x4001
	.hword 0
	.balign 4, 0

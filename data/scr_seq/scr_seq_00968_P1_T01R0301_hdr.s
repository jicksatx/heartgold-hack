// hack: Oak's Lab (Part 1) map script header (data/scr_seq/scr_seq_00967_P1_T01R0301.s)
//   on transition -> script 10
//   frame table: VAR_P1_STORY == 1 -> script 1 (the scene when Oak brings Red in)

.data

	.byte 2 // INIT_SCRIPT_ON_TRANSITION
	.hword 10, 0
	.byte 1 // INIT_SCRIPT_ON_FRAME_TABLE
	.word _frameTable - . - 4
	.byte 0 // end of entries

_frameTable:
	.hword 0x4167, 1, 1 // VAR_P1_STORY == 1 -> script 1
	.hword 0

	.balign 4, 0

// hack: One Island Pokemon Center (Part 1) map script header: on transition -> script 15, frame table VAR_P1_SEVII == 3 -> 13, == 5 -> 14 (data/scr_seq/scr_seq_01055_P1_SEVII.s)

.data

	.byte 1 // INIT_SCRIPT_ON_FRAME_TABLE
	.long _frameTable-.-4
	.byte 2 // INIT_SCRIPT_ON_TRANSITION
	.hword 15, 0
	.byte 0 // end of entries
_frameTable:
	.hword 0x4141, 3, 13
	.hword 0x4141, 5, 14
	.hword 0
	.balign 4, 0

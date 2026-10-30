// hack: Cinnabar Island (Part 1) map script header: on transition -> script 26 (Bill's flags), frame table VAR_P1_SEVII == 1 -> script 24 (Bill invites Red to One Island); data/scr_seq/scr_seq_01038_P1_T09.s

.data

	.byte 1 // INIT_SCRIPT_ON_FRAME_TABLE
	.long _frameTable-.-4
	.byte 2 // INIT_SCRIPT_ON_TRANSITION
	.hword 26, 0
	.byte 0 // end of entries
_frameTable:
	.hword 0x4141, 1, 24
	.hword 0
	.balign 4, 0

// hack: Viridian City Poke Mart (Part 1) map script header (data/scr_seq/scr_seq_00973_P1_T02FS0101.s)
//   frame table: VAR_P1_STORY == 4 -> script 4 (the clerk gives Red Oak's Parcel)

.data

	.byte 1 // INIT_SCRIPT_ON_FRAME_TABLE
	.word _frameTable - . - 4
	.byte 0 // end of entries

_frameTable:
	.hword 0x4167, 4, 4 // VAR_P1_STORY == 4 -> script 4
	.hword 0

	.balign 4, 0

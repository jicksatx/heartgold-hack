// hack: Route 18 (Part 1) map script header, as HeartGold's: on resume -> script 8 (scr_seq_01035)

.data

	.byte 3 // INIT_SCRIPT_ON_RESUME
	.hword 8, 0
	.byte 0 // end of entries
	.balign 4, 0

// hack: Route 17 (Part 1) map script header, as HeartGold's: on transition/resume -> script 7 (scr_seq_01035)

.data

	.byte 2 // INIT_SCRIPT_ON_TRANSITION
	.hword 7, 0
	.byte 3 // INIT_SCRIPT_ON_RESUME
	.hword 7, 0
	.byte 0 // end of entries
	.balign 4, 0

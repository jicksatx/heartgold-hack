// hack: Route 16 east of the gate (Part 1) map script header, as HeartGold's: on transition -> script 9 (scr_seq_01035)

.data

	.byte 2 // INIT_SCRIPT_ON_TRANSITION
	.hword 9, 0
	.byte 0 // end of entries
	.balign 4, 0

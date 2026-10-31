// hack: Route 16 gate (Part 1) map script header: on resume -> script 92 (data/scr_seq/scr_seq_01060_P1_INTERIORS.s), like
// HeartGold's: keep the player on the Bicycle while on Cycling Road

.data

	.byte 3 // INIT_SCRIPT_ON_RESUME
	.hword 92, 0
	.byte 0 // end of entries
	.balign 4, 0

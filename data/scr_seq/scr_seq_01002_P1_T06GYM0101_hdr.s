// hack: Vermilion Gym (Part 1) map script header (data/scr_seq/scr_seq_01001_P1_T06GYM0101.s), as HeartGold's:
//   on transition -> script 19 (gym init), on resume -> script 20 (barriers back)

.data

	.byte 2 // INIT_SCRIPT_ON_TRANSITION
	.hword 19, 0
	.byte 3 // INIT_SCRIPT_ON_RESUME
	.hword 20, 0
	.byte 0 // end of entries
	.balign 4, 0

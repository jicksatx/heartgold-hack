// hack: Viridian Gym (Part 1) map script header: on transition -> script 4 (data/scr_seq/scr_seq_01042_P1_T02GYM.s):
// viridian_gym_init, as HeartGold's header does, so the sliding floor's gymmick overlay is loaded

.data

	.byte 2 // INIT_SCRIPT_ON_TRANSITION
	.hword 4, 0
	.byte 0 // end of entries
	.balign 4, 0

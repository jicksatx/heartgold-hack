// hack: Rocket Hideout B4F (Part 1) map script header: on transition -> script 7 (data/scr_seq/scr_seq_01014_P1_D35R0102.s):
// remember that the elevator is on B4F (VAR_P1_LIFT), so the elevator's exit leads back here

.data

	.byte 2 // INIT_SCRIPT_ON_TRANSITION
	.hword 7, 0
	.byte 0 // end of entries
	.balign 4, 0

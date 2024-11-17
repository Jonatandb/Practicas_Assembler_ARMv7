/* Implement a simple macro      */

	.global  _start
_start:

.macro multtwo val1, val2
	MOV R1, #\val1
	MOV R2, #\val2
	MUL R0, R1, R2
.endm

	multtwo 2, 2
	multtwo 3, 4

	MOV R7, #1		@ exit through syscall
	SWI 0

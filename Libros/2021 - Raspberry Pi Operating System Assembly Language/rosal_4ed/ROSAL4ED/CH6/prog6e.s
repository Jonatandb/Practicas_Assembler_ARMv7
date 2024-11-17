/* Signed Division Example. RPi2 and Greater  */

	.global  _start
_start:

	MOV R3, #20		@ Denominator
	MOV R4, #5		@ Numerator
	SDIV R0, R3, R4	@ R0=R3/R4
	
	MOV R7, #1		@ exit through syscall
	SWI 0

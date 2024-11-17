/* Multiply with use of UMULL    */
/* mult: routine can be replaced with one instruction! */
/* by way of an example... */

@ R1=Unsigned number 1
@ R2=Unisgned number 2

@ On Exit:
@ R3=Result (low word product)
@ R4=Result (high word product
@ R1= Undefined, R2= Undefined

.global  _start
_start:	
	MOV R1, #0xF0000002
	MOV R2, #0x2
	MOV R3, #0x0		@ Going to do...
	MOV R4, #0x0		@ 
	
	UMULL R3, R4, R1, R2
	
	MOV R7, #1				@ Exit Syscall
	SWI 0


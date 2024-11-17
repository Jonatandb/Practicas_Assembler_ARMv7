/* Multiply without use of UMULL    */
/* mult: routine can be replaced with one instruction! */


@ R1=Unsigned 32-bit number 1 (low)
@ R2=Unisgned 32-bit number 2 (high)

@ On Exit:
@ R3=Result (low word product)
@ R4=Result (high word product)
@ R1= Undefined, R2= Undefined, R5= Undefined


	.global  _start
	
_start:	
	MOV R1, #0xF0000002		@ Going to do...
	MOV R2, #0x2	    	@ [R3,R4]=R1*R2

mult:	
	MOVS R4, R1, LSR #16		@ R4 is ms 16-bits of R1
	BIC R1, R1, R4, LSL #16		@ R1 is ls 16-bits of R1
	MOV R5, R2, LSR #16			@ R5 is ms 16-bits of R2
	BIC R2, R2, R5, LSL #16		@ R2 is ls 16-bits of R2
	
	MUL R3, R1, R2				@ Low partial product
	MUL R2, R4, R2				@ First mid-partial product
	MUL R1, R5, R1				@ Second mid-partial product 
	MULNE R4, R5, R4			@ High partial product
	
	ADDS R1, R1, R2				@ Add mid-partial
	ADDCS R4, R4, #0x10000		@ Add Carry to high partial
	ADDS R3, R3, R1, LSL #16    @ Add middle partial product
	ADC R4, R4, R1, LSR #16	    @ Sum into low and high words or result
						
	MOV R7, #1					@ Exit Syscall
	SWI 0

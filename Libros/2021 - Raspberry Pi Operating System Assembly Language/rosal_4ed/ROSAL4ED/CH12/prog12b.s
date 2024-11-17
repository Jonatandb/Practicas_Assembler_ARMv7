/* Long Divide using no specific Divide instruction */
/* Provides Quotient and Remainder as result       */
@ On Entry: R1=Dividend,  R2=Divisor
@ On Exit: R3=Quotient, R1=Remainder, R2 Original Divisor

	.global  _start

_start:
	MOV R1, #111			@ Going to do 111/20
	MOV R2, #20
	MOV R4, R2				@ Preserve Divisor
	CMP R4, R1, LSR #1	
	
Div1:	
	MOVLS R4, R4, LSL #1	@ Double Divisor until
	CMP R4, R1, LSR #1		@ 2xR4>divisor
	BLS Div1
	MOV R3, #0				@ Initialise quotient
								
Div2:	
	CMP R1, R4				@ Can we subtract R4?
	SUBCS R1, R1, R4		@ Do so if possible
	ADC R3, R3, R3			@ Double quotient, add new bit
	MOV R4, R4, LSR #1		@ Halve R4
	CMP R4, R2				@ Loop until gone past...
	BHS Div2				@ ..original divisir
																							
	MOV R0, R3				@ Move quotient into R0

	MOV R7, #1				@ Exit Syscall
	SWI 0

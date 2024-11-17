@  Use of UAL code on Raspberry Pi 
@  Add two values using short subroutine call
@  gcc option can be used also

	.syntax unified
	.global _start

_start: 
	MOV     r0, #10     @ set up parameter
        MOV     r1, #5	@ set up parameter
        MOV	r2, #5
        MOV	r3,	#20
        BL      doadd       @ Call subroutine
        
        MOV	R4, #0xff00
        MOVT	R4, #0xffff
        MLA	R0, R1, R2, R3

stop:   
        MOV R7, #1
	SWI 0

doadd:
	ADD     r0, r0, r1   @ Subroutine code - UAL format
        BX      lr           @ Return from subroutine
        

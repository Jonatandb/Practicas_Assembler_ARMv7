/*  AddMult.s                   */
/* Add two numbers passed       */

.macro addtwo val1, val2
	MOV R1, #\val1
	MOV R2, #\val2
	ADD R0, R1, R2
.endm

.macro multtwo val1, val2
	MOV R1, #\val1
	MOV R2, #\val2
	MLA R0, R1, R2, R0
.endm

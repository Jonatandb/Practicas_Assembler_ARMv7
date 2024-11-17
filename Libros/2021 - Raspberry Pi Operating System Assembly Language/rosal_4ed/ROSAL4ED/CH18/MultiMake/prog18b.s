/* Implement a simple macro  #1 */
/* Add two numbers passed       */

	.global _start
_start:

.macro addtwo val1, val2
	MOV R1, #\val1
	MOV R2, #\val2
	ADD R0, R1, R2
.endm

	addtwo 3,4

	MOV R7, #1
	SWI 0

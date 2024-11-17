/* Implement a simple macro  #2 */

.global _start
_start:

.macro multtwo val1, val2
	MOV R1, #\val1
	MOV R2, #\val2
	MLA R0, R1, R2, R0
.endm

	MOV R0, #0
	multtwo 2, 2
	multtwo 3, 4
	multtwo 5, 6

	MOV R7, #1
	SWI 0

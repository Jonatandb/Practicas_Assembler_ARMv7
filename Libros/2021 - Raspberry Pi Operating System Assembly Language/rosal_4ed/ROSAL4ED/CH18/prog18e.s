/* Test External Macros   */

.include "prog18d.s"

.global _start
_start:
		MOV R0, #0

_add:
		addtwo 3, 4
_mult:
		multtwo 2, 2
_exit:	
		MOV R7, #1
		SWI 0

/* Simple Neon test */

.global _start

_start:

LDR R0, =number1
LDR R1, =number2

VLD1.32  {Q1}, [R0]
VLD1.32  {Q2}, [R1]

VADD.I32 Q0, Q1, Q2


MOV R7, #1
SWI 0

.data

number1:	.word 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
number2:	.word 2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0


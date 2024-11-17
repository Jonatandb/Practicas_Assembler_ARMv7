/* Add two 4x4 matrix together */

.global _start

_start:

LDR R0, =matrix1
LDR R1, =matrix2
LDR R2, =matrix3


VLD1.i32 {Q0}, [R0]	@ Load 4 x 32bit integers of the 1st array.
VLD1.i32 {Q1}, [R1]	@ Load 4 x 32bit integers of the 2nd array.
VADD.i32 Q2, Q0, Q1	@ Add the values of 4 int32 using just one operation.
VST1.i32 {Q2}, [R2]	@ Store the 4 x 32bit integers back into the 1st array.


MOV R7, #1
SWI 0

.data
matrix1:	.word 2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
matrix2:	.word 4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
matrix3:	.word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0

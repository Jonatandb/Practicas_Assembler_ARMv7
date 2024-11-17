/* Rotate 4x4 Matrix Through 90 Degrees */

.global _start
_start:

@ Get data pointers
LDR R0,=matrix0
LDR R1,=matrix1
LDR R2,=matrix2
LDR R3,=matrix3

@ Load Q0-Q1 with the data
VLD1.32 {Q0}, [R0]
VLD1.32	{Q1}, [R1]
VLD1.32	{Q2}, [R2]
VLD1.32	{Q3}, [R3]

@ Transpose Matrix
VZIP.32 Q0, Q1
VZIP.32 Q2, Q3

@ Interleave inner pairs
VSWP D1, D4
VSWP D3, D6

@ Mirror flip matrix
VREV64.32 Q0, Q0
VREV64.32 Q1, Q1
VREV64.32 Q2, Q2
VREV64.32 Q3, Q3

@ Swap high and low halves
VSWP D0, D1
VSWP D2, D3
VSWP D4, D5
VSWP D6, D7

@ Store result
VST1.32 {Q0}, [R0]
VST1.32 {Q1}, [R1]
VST1.32 {Q2}, [R2]
VST1.32 {Q3}, [R3]

MOV R7, #1
SWI 0

.data
matrix0:	.word 0,1,2,3
matrix1:	.word 4,5,6,7
matrix2:	.word 8,9,10,11
matrix3:	.word 12,13,14,15
	


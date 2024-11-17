/* Floating Point 4x4 Matrix Multiplication */

.global _start

_start:

.macro matrixf32 resultQ, col0_d, col1_d
VMUL.f32    \resultQ, Q8,  \col0_d[0] @ element 0 by matrix column 0
VMLA.f32    \resultQ, Q9,  \col0_d[1] @ element 1 by matrix column 1
VMLA.f32    \resultQ, Q10, \col1_d[0] @ element 2 by matrix column 2
VMLA.f32    \resultQ, Q11, \col1_d[1] @ element 3 by matrix column 3
.endm


LDR R0, =matrix0
LDR R1, =matrix1
LDR R2, =matrix2

VLD1.32  {D16-D19}, [R1]!	@ first eight elements of matrix 1
VLD1.32  {D20-D23}, [R1]! 	@ second eight elements of matrix 1
VLD1.32  {D0-D3}, [R2]!       	@ first eight elements of matrix 2
VLD1.32  {D4-D7}, [R2]!         @ second eight elements of matrix 2


matrixf32 Q12, D0, D1 	@ matrix 1 * matrix 2 col 0
matrixf32 Q13, D2, D3 	@ matrix 1 * matrix 2 col 1
matrixf32 Q14, D4, D5 	@ matrix 1 * matrix 2 col 2
matrixf32 Q15, D6, D7 	@ matrix 1 * matrix 2 col 3

VST1.32  {D24-D27}, [R0]! 	@ store first eight elements of result.
VST1.32  {D28-D31}, [R0]! 	@ store second eight elements of result.


MOV R7, #1
SWI 0

.data
matrix0:	.float 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
matrix1:	.float 1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5
matrix2:	.float 2.5,2.5,2.5,2.5,2.5,2.5,2.5,2.5,2.5,2.5,2.5,2.5,2.5,2.5,2.5,2.5



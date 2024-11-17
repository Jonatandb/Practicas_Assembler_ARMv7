/* Floating Point 4x4 Matrix Multiplication */
/* Using a macro to reduce coding           */
/* Re-hash of previous example              */

.global main
.func main
    
main:
    LDR R10, =result
    LDR R11, =matrix1
    LDR R12, =matrix2

.macro matrixf32 resultQ, col0_d, col1_d
VMUL.f32    \resultQ, Q8,  \col0_d[0] 	@ element 0 by matrix column 0
VMLA.f32    \resultQ, Q9,  \col0_d[1] 	@ element 1 by matrix column 1
VMLA.f32    \resultQ, Q10, \col1_d[0] 	@ element 2 by matrix column 2
VMLA.f32    \resultQ, Q11, \col1_d[1] 	@ element 3 by matrix column 3
.endm

VLD1.32  {D16-D19}, [R11]!	@ first eight elements of matrix 1
VLD1.32  {D20-D23}, [R11]! 	@ second eight elements of matrix 1
VLD1.32  {D0-D3}, [R12]!    @ first eight elements of matrix 2
VLD1.32  {D4-D7}, [R12]!    @ second eight elements of matrix 2

@ Call macro
matrixf32 Q12, D0, D1		@ matrix 1 * matrix 2 col 0
matrixf32 Q13, D2, D3		@ matrix 1 * matrix 2 col 1
matrixf32 Q14, D4, D5		@ matrix 1 * matrix 2 col 2
matrixf32 Q15, D6, D7		@ matrix 1 * matrix 2 col 3

VST1.32  {D24-D27}, [R10]! 	@ store first eight elements of result.
VST1.32  {D28-D31}, [R10]! 	@ store second eight elements of result.

@ Following code will print out results if required as example of use only

matrixprint:	
	
    .equ Num, 4				@ Num is the number of number of bytes                       
    .equ Cells, 16			@ Cells, is the number of matrix cells

    LDR R10, =result		@ R10 hold address of result matix
    MOV R7, #Cells			@ R7  holds matrix cell counter
loop:    
    LDR R0, [R10] 			@ Get data item into R0
    VMOV S2, R0				@ Get into FPU register
    VCVT.F64.F32 D0, S2		@ Convert to Single Precision format
    VMOV r2, r3, D0			@ Move into R2 and R3 for fprin
    LDR R0, =string		    @ point R0 to string
    BL printf				@ call printf function
    ADD R10, #Num			@ increment address of next result
    SUBS R7, #1				@ decrement cell counter
    BNE loop 				@ do next cell if not complete
							
    MOV R7, #1              @ otherwise ready to return to finish
    SWI 0
    
string:	.asciz "Result is: %f\n"

.data
matrix1:    .single 106.6,2.4,4.5,6.2
            .single 105,4,6,8
            .single 104,6,8,10
            .single 103,8,10,12

matrix2:    .single 2,3,4,5
            .single 3,4,5,6
            .single 4,5,6,7
            .single 5,6,7,8
            
result:     .word 0,0,0,0       
            .word 0,0,0,0       
            .word 0,0,0,0       
            .word 0,0,0,0       



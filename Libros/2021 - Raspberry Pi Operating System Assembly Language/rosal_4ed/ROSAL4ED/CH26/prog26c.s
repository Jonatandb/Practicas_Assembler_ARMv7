/* Add two 4x4 matrix together */
/* Column Major Order	       */

@ Pointers:
@ R10 = pointer to where 4x4 matrix result will be stored: column major order
@ R11 = pointer to 4x4 matrix 1, single precision floats, column major order
@ R12 = pointer to 4x4 matrix 2, single precision floats, column major order
@ d16-d19 and d20-d23 (Q8, Q9, Q10, Q11) for Matrix 1
@ d8-d11 and d12-d15 (Q4, Q5, Q6, Q7) for Matrix 2
@ d24-d27 and d28-d31 (Q12-Q15) contains result on exit

    .global main
    .func main
    
main:

    LDR R10, =result
    LDR R11, =matrix1
    LDR R12, =matrix2

    vld1.32     {d16-d19},[r11]!    @ Q8-Q9   load matrix 1 - 2 lines
    vld1.32     {d20-d23}, [r11]!   @ Q10-Q11 load matrix 1 - 2 lines
    vld1.32     {d8-d11},[r12]!     @ Q4-Q5   load matrix 2 - 2 lines
    vld1.32     {d12-d15}, [r12]!   @ Q6-Q7   load matrix 2 - 2 lines

    VADD.F32 	Q12, Q8, Q4	    @ Only added on Q register
    VADD.F32	Q13, Q9, Q5
    VADD.F32	Q14, Q10, Q6
    VADD.F32	Q15, Q11, Q7		

    vst1.32     {d24-d27}, [r10]!   @ d24-d27 store first eight elements of result
    vst1.32     {d28-d31}, [r10]!   @ d28-d31 store second eight elements of result

@ Following code will print out results if required as example of use only

matrixprint:	
	
    .equ Num, 4                     @ Num is the number of number of bytes                       
    .equ Cells, 16                  @ Cells, is the number of matrix cells

    LDR R10, =result                @ R10 hold address of result matix
    MOV R7, #Cells                  @ R7  holds matrix cell counter
loop:    
    LDR R0, [R10]                   @ Get data item into R0
    VMOV S2, R0                     @ Get into FPU register
    VCVT.F64.F32 D0, S2	            @ Convert to Single Precision format
    VMOV r2, r3, D0                 @ Move into R2 and R3 for fprin
    LDR R0, =string		    @ point R0 to string
    BL printf		            @ call fprint function
    ADD R10, #Num                   @ increment address of next result
    SUBS R7, #1                     @ decrement cell counter
    BNE loop                        @ do next cell if not complete
                                    @ otherwise ready to return to finish
    MOV R7, #1                      @ exit
    SWI 0
    

MOV R7, #1
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

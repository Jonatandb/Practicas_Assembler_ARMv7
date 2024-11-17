/* Neon 4 x 4 Single Precision Matrix Multiplication */
/* Column Major Order  */

@ Pointers:
@ R10 = pointer to where 4x4 matrix result will be stored
@ R11 = pointer to 4x4 M1, single precision floats
@ R12 = pointer to 4x4 M1, single precision floats
@ d16-d19 and d20-d23 (Q8, Q9, Q10, Q11) for M1
@ d8-d11 and d12-d15 (Q4, Q5, Q6, Q7) for M2
@ d24-d27 and d28-d31 (Q12-Q15) contains result  

	.global main   
	.func main
main:   

LDR R10, =result    
LDR R11, =matrix1   
LDR R12, =matrix2  

VLD1.32 {D16-D19},[R11]!	@ Q8-Q9   load M1, 2 lines   
VLD1.32 {D20-D23}, [R11]!	@ Q10-Q11 load M1, 2 lines  
VLD1.32 {D8-D11},[R12]!		@ Q4-Q5   load M2, 2 lines
VLD1.32 {D12-D15}, [R12]!	@ Q6-Q7   load M2, 2 lines    
VMUL.f32 Q12, Q8, D8[0]		@ RC0  = (M1 C0) * (M2 C0 E0)   
VMUL.f32 Q13, Q8, D10[0]	@ RC1  = (M1 C0) * (M2 C1 E0)    
VMUL.f32 Q14, Q8, D12[0]	@ RC2  = (M1 C0) * (M2 C2 E0)    
VMUL.f32 Q15, Q8, D14[0]	@ RC3  = (M1 C0) * (M2 C3 E0)   

VMLA.f32 Q12, Q9, D8[1]		@ RC0 += (M1 C1) * (M2 C0 E1)   
VMLA.f32 Q13, Q9, D10[1]	@ RC1 += (M1 C1) * (M2 C1 E1)    
VMLA.f32 Q14, Q9, D12[1]	@ RC2 += (M1 C1) * (M2 C2 E1)    
VMLA.f32 Q15, Q9, D14[1]	@ RC3 += (M1 C1) * (M2 C3 E1)   

VMLA.f32 Q12, Q10, D9[0]	@ RC0 += (M1 C2) * (M2 C0 E2)    
VMLA.f32 Q13, Q10, D11[0]	@ RC1 += (M1 C2) * (M2 C1 E2)   
VMLA.f32 Q14, Q10, D13[0]	@ RC2 += (M1 C2) * (M2 C2 E2)    
VMLA.f32 Q15, Q10, D15[0]	@ RC3 += (M1 C2) * (M2 C3 E2)    

VMLA.f32 Q12, Q11, D9[1]	@ RC0 += (M1 C3) * (M2 C0 E3)    
VMLA.f32 Q13, Q11, D11[1]	@ RC1 += (M1 C3) * (M2 C1 E3)    
VMLA.f32 Q14, Q11, D13[1]	@ RC2 += (M1 C3) * (M2 C2 E3)   
VMLA.f32 Q15, Q11, D15[1]	@ RC3 += (M1 C3) * (M2 C3 E3)   

VST1.32 {D24-D27}, [R10]!	@ d24-d27 store 1st eight  
VST1.32 {D28-D31}, [R10]!	@ d28-d31 store 2nd eight   

@ Following code will print out results if required

matrixprint:
.equ Num, 4 		@ Number of bytes
.equ Cells, 16		@ Number of matrix cells   

LDR R10, =result 	@ R10 address of result matrix   
MOV R7, #Cells		@ R7  matrix cell counter
loop:      
LDR R0, [R10]		@ Get data item into R0   
VMOV S2, R0			@ Get into FPU register   
VCVT.F64.F32 D0, S2	@ Convert to Single Precision   
VMOV R2, R3, D0		@ Into R2 and R3 for fprint   
LDR R0, =string		@ Point R0 to string   
BL printf			@ Call fprint function   
ADD R10, #Num		@ Inc address of next result   
SUBS R7, #1			@ Decrement cell counter
BNE loop            @ Next cell if not complete   	
					@ Otherwise finish    
MOV R7, #1	@ exit   
SWI 0    

string:	.asciz "Result is: %f\n"
.data
matrix1:	
.single 106.6,2.4,4.5,6.2            
.single 105,4,6,8            
.single 104,6,8,10            
.single 103,8,10,12
matrix2:	
.single 2,3,4,5            
.single 3,4,5,6            
.single 4,5,6,7            
.single 5,6,7,8
result:     
.word 0,0,0,0           
.word 0,0,0,0           
.word 0,0,0,0           
.word 0,0,0,0  

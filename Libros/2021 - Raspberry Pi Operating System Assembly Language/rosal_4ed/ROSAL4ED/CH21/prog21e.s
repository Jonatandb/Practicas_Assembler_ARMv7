/* Bubble Sort Test                                  */ 

.global main 

main:
  LDR R0, =values
  MOV R1, #items
  LDR R2, =before
  LDR R3, =comma
  BL  _printw
  LDR R0, =new_line
  BL  printf
  LDR R0,  =values
  MOV R1, #items
  BL  _bubble
 
  LDR R0, =values
  MOV R1, #items
  LDR R2, =after
  LDR R3, =comma
  BL  _printw
  LDR R0, =new_line
  BL  printf
 
  MOV R7, #1
  SWI #0
  
.equ items,16
  
.data
before: .asciz "Order before sorting, values are : %d" 
after:  .asciz "Order after sorting,  values are : %d"
comma:  .asciz ", %d"
new_line:.asciz "\n"
values: .word 12, 2, 235, -64, 28, 315, 456, 63, 134, 97, 221, -453, 190333, 145, 117, 5


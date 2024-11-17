/* test_printw – Test subroutine printw */
.equ _size,4
.global main
.align 2
.section .rodata
first:  .asciz "Vector of words - values : %d"
rest:   .asciz ", %d"
final:  .asciz "\n"
values: .word 10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60
@ endvalues:
.align 2
.text

main:
  LDR R0, =values
  MOV R1, #11
  LDR R2, =first
  LDR R3, =rest
  BL  _printw
  LDR R0, =final
  BL  printf
 
  MOV R7, #1
  SWI 0 
 

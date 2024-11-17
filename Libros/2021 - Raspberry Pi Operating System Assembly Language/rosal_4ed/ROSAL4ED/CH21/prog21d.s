/* Bubble Sort - this subroutine bubble sorts vectors of words */
/* R0= start of vector of elements  */
/* R1= Number of elements to sort   */
/*                                  */
/* R4 = current pointer             */
/* R5 = inner counter               */
/* R6 = keep_going flag             */
/* R7 = first element               */
/* R8 = second element              */
/* R9 = swap register               */
 

  .global _bubble
  .text
_bubble:
  STMFD SP!, {R4, R5, R6, R7, R8, R9, LR}
  CMP      R1, #1       @ number of elements must be > 1
  BLE      _exit        @ exit if nothing to do
 
  SUB      R5, R1, #1   @ Set inner counter
  MOV      R4, R0       @ Set current pointer
  MOV      R6, #0       @ Register set on swap
 
_loop:
  LDR      R7, [R4], #size @ Load element
  LDR      R8, [R4]       @ and next element
  CMP      R7, R8         @ compare them
  BLE      no_swap        @ branch if second greater
  
  MOV      R6, #1         @ Set keep_going flag
  SUB      R4, #size      @ Reset pointer to element
  LDR      R9, [R4]       @ Load word at address
  STR      R8, [R4]         @ Save lower value back in memory
  STR      R9, [R4, #size]! @ Complete swap process
  
no_swap:
  SUBS     R5, #1         @ decrement counter
  BNE      _loop          @ loop again if not finished
 
end_inner:
  CMP      R6, #0         @ check if done
  BEQ      _exit          @ and leave if not set
 
  MOV      R6, #0         @ clear flag 
  MOV      R4, R0         @ reset pointer
  SUB      R5, R1, #1     @ reset counter
  B        _loop          @ And go again
 
_exit:
  LDMFD    SP!, {R4, R5, R6, R7, R8, R9, PC}      @ restore state
 
.data
  .equ size,4

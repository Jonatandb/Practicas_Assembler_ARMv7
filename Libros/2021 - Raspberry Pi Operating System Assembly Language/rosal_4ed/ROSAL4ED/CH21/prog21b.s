/* printw - This routine prints a vector of words */
/* R0 = address of vector                         */
/* R1 = number of vector elements                 */
/* R2 = pointer string to print first element     */
/* R3 = pointer string to print next elements     */

.global _printw
.equ _wsize,4
.align 2
_printw:
  STMFD    SP!, {R4, R5, R6, R7, LR}  @ save registers on the stack
  CMP      R1, #0                     @ exit if no elements
  BLE      _last
  MOV      R4, R0                    @ save parameters to locals
  MOV      R5, R1
  MOV      R6, R2
  MOV      R7, R3
  LDR      R1, [R4], #_wsize     @  load first vector element to r0
  MOV      R0, R6                    @ address of first string to r0
  BL       printf                    @ print it
  SUBS     R5, R5, #1                @ decrement counter
  BEQ      _last                      @ exit if zero
_printw_loop:
  LDR      R1, [R4], #_wsize     @ load next vector item to r0r
  MOV      R0, R7                    @ address of next string to r0
  BL       printf                    @  print it
  SUBS     R5, R5, #1                @ decrement counter
  BNE      _printw_loop              @ loop if more
_last:
 
  LDMFD    SP!, {R4, R5, R6, R7, PC} @ restore and return

/* Accessing GPIO using virtual memory mapping */
/* Using ROS preferred methodology             */
/* Uses GPIO Pin 17 example                    */
/* (c) Bruce Smith  - prog23a_17.s             */


@ Constants for assembler - memory map associated
.equ    gpiobase,0x3F000000     @ RPi 2,3,4, 400 peripherals
.equ    offset,  0x200000       @ start of GPIO device
.equ    prot_read, 0x1          @ can be read
.equ    prot_write,0x2          @ can be written
.equ    readwrite,prot_read|prot_write
.equ    mapshare,  0x01         @ share changes
.equ    nopref,    0
.equ    pagesize,  4096         @ memory size
 
.equ    O_RDWR,  00000002       @ open for read/write
.equ    O_DSYNC, 00010000       @ values are octal not hex
.equ    __O_SYNC,04000000
.equ    O_SYNC,__O_SYNC|O_DSYNC
.equ    openflags,O_RDWR|O_SYNC @ open file flags

@ Constants for Function Select
.equ    pinnumber,17           @ pin set bit
.equ    output,   1            @ use pin for ouput
.equ    pinfield, 0b111        @ 3 bits

@ other...
@        .equ    O_DSYNC,00010000
@        .equ    __O_SYNC,04000000
@        .equ    INPUT,0        @ use pin for input

.equ    seconds,2               @ sleep value

@ Constants for assembler pinclear and pinset
.equ  pinbit,       1           @ 1 bit for pin
.equ  registerpins, 32
.equ  GPCLR0,   0x28            @ clear register offset
.equ  GPSET0,   0x1c            @ set register offset

@ addresses of messages
devicefile:     .word   device
openMode:       .word   openflags
gpio:           .word   gpiobase+offset
openerror:      .word   openstring1
memerror:       .word   memstring2
   

@ Constant program data
        .section .rodata
        .align  2
device:         .asciz  "/dev/gpiomem"
openstring1:    .asciz  "Didnt open /dev/gpiomem\n"
memstring2:     .asciz  "Didnt Map /dev/gpiomem \n"

@ The program
        .text
        .align  2
        .global main
main:
        
@ Open /dev/gpiomem for read/write and syncing
        LDR     R0, devicefile  @ address of /dev/gpiomem string
        LDR     R1, openMode    @ flags for accessing device
        BL      open            @ call open
        MOVS    R4, R0		@ error check
        BPL     moveon1		@ If positive, moveon
        LDR     R0, openerror   @ error, tell user
        BL      printf
        B       _exit           @ and end program
        
moveon1:
@ Map GPIO memory to a main memory location so we can access them
@ Keep a copy of the mapped memory address returned in R0 
@ this will be need later on.

        MOV     R4, R0          @ use r4 for file descriptor
        MOV     R8, R0          @ Save a copy of file descriptor
        
        LDR     R0, gpio        @ address of GPIO
        MOV     R9, R0          @ save a copy of GPIO address
        PUSH    {R9}            @ Copy on stack for mmmap
        PUSH    {R8}            @ file descriptor on stack for mmap
        MOV     R0, #nopref     @ let kernel pick memory
        MOV     R1, #pagesize   @ get 1 page of memory
        MOV     R2, #readwrite  @ read/write this memory
        MOV     R3, #mapshare   @ share with other processes
        BL      mmap            @ R0-R3+top of stack has info
        MOV     R9,R0           @ save mapped address
        CMP     R0, #-1         @ check for error
        BNE     moveon2         @ no error, continue
        LDR     R0, memerror    @ error, tell user
        BL      printf
        B       _exit 

moveon2:  
@  Select pin number and function.
        MOV     R0, R9          @ programming memory
        MOV     R1, #pinnumber  @ pin number
        MOV     R2, #output     @ pin function
        MOV     R4, R0          @ save pointer to GPIO
        MOV     R5, R1          @ save pin number
        MOV     R6, R2          @ save function code

@ Compute address of GPFSEL register and pin field
        MOV     R3, #10         @ divisor
        UDIV    R0, R5, R3      @ GPFSEL number
        MUL     R1, R0, R3      @ compute remainder
        SUB     R1, R5, R1      @ for GPFSEL pin    
        
@ Set up the GPIO pin funtion register in programming memory
        LSL     R0, R0, #2      @4 bytes in a register
        ADD     R0, R4, R0      @ GPFSELn address
        LDR     R2, [R0]        @ get entire register
        
        MOV     R3, R1          @ need to multiply pin
        ADD     R1, R1, R3, lsl #1   @    position by 3
        MOV     R3, #pinfield   @ gpio pin field
        LSL     R3, R3, R1      @ shift to pin position
        BIC     R2, R2, R3      @ clear pin field

        LSL     R6, R6, R1      @ shift function code to pin position
        ORR     R2, R2, R6      @ enter function code
        STR     R2, [R0]        @ update register
 

@ setGPIOpin
@ All OK, now turn on the LED 
@ Requires mmap address and pin number
 
S5:     MOV     R0, R9           @ Get memory address
        MOV     R1, #pinnumber   @ Get pin number
        ADD     R4, R0, #GPSET0  @ point to GPSET regs in R4
        MOV     R5, R1           @ save pin number
        
@ Compute address of GPSET register and pin field        
        MOV     R3, #registerpins @ divisor
        UDIV    R0, R5, R3       @ GPSET number
        MUL     R1, R0, R3       @ compute remainder
        SUB     R1, R5, R1       @ for relative pin position
        LSL     R0, R0, #2       @ 4 bytes in a register
        ADD     R0, R0, R4       @ address of GPSETn
        
@ Set up the GPIO pin funtion register in programming memory
        LDR     R2, [R0]        @ get entire register
        MOV     R3, #pinbit     @ one pin
        LSL     R3, R3, R1      @ shift to pin position
        ORR     R2, R2, R3      @ set bit
        STR     R2, [R0]        @ update register
 
@ Wait for seconds
        MOV     R0, #seconds     @ wait seconds
        BL      sleep
 
@ clearGPIOpin
@ Clears a GPIO pin. Requires mmap addr & pin number
        
S4:     @ mov   R0, R5           @ GPIO programming memory
        MOV     R0, R9           @ Get GPIO mapped address
        MOV     R1, #pinnumber
        ADD     R4, R0, #GPCLR0  @ pointer to GPSET regs.
        MOV     R5, R1           @ save pin number

@ Compute address of GPSET register and pin field        
        MOV     R3, #registerpins @ divisor
        UDIV    R0, R5, R3       @ GPSET number
        MUL     R1, R0, R3       @ compute remainder
        SUB     R1, R5, R1       @ for relative pin position
        LSL     R0, R0, #2       @ 4 bytes in a register
        ADD     R0, R0, R4       @ address of GPSETn
        
@ Set up the GPIO pin funtion register in programming memory
        LDR     R2, [R0]         @ get entire register
        MOV     R3, #pinbit      @ one pin
        LSL     R3, R3, R1       @ shift to pin position
        ORR     R2, R2, R3       @ clear bit
        STR     R2, [R0]         @ update register
 
@ end PRGRAM Here
       _exit:
@       (NEED TO CHECK if EXIT VIA ERROR AS STACK MAY NOT NEED ADJUSTING...
S6:     POP {R8}                @ restore SP to entry level.
        POP {R9}
        MOV R7, #1
        SWI #0
        
   
        

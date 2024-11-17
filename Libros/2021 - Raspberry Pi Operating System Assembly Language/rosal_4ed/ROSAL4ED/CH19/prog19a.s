/* File Creation and Access Using Syscall             */
/* Create and Open File, Read from File, Write to File */

.global _start

_start:
@ Open file to read from
@ Assumes file already exits in current directory
@ Or will generate an error message (error1)
	
	LDR	R0, =inputFile	@ Addr of filename
	MOV	R1, #o_rdonly	@ flag read only file
	MOV	R2, #s_rdwr		@ 
	MOV	R7, #sys_open	@ Load syscall 5
	SWI	0
	
	MOVS	R8, R0		@ Save returned file flag in R8
	BPL		moveon		@ If positive, moveon
	MOV	R0, #1			@ Set screen as output
	LDR R1, =error1		@ addr of error1 message
	MOV R2, #18			@ string length
	MOV R7, #4			@ Write code	
	SWI 0				@ Do it			
	B finish 			@ terminate program
	
moveon:
	@  Create/and-or Open File to write too
	LDR	R0, =outputFile	@ addr of output filename
	MOV	R1, #(o_create+o_wronly) @ Create or open file
	MOV	R2, #s_rdwr		@ access rights
	MOV	R7, #sys_open	@ load syscall 5
	SWI	0				@ Make the call
	MOVS R9, R0			@ Save file flag
	BPL readlinein		@ If positive file there
	MOV	R0, #1			@ Non-existant so error
	LDR R1, =error2
	MOV R2, #18
	MOV R7, #4
	SWI 0
	B finish

readlinein:				@ read line from InFile.txt
	MOV R0, R8			@ File descriptor R8>R0
	LDR R1, =inbuffer	@ location of inbuffer
	MOV R2, #alphabet	@ lenth of alphabetbuffer
	MOV R7, #sys_read
	SWI 0				@ InFile string now store in InBuffer
	MOV R10, R0			@ R0 Returns bytes written, Save in R10
	MOV R1, #0
	LDR R0,=inbuffer
	STRB R1, [R0, R10]	@ write null terminator to buffer
	
convertUpperCase:
	PUSH {R8}
	PUSH {R9}
	MOV R8, #0			@ counter
	
loop:
	LDR R0, =inbuffer	@ Move file from in to out
	LDRB R1, [R0, R8]	@ doing ORR conversion
	ORR R1, R1, #0x20
	LDR r0, =outbuffer
	STRB R1, [R0, R8]
	ADD R8, #1			@ increment loop counter
	CMP R8, #26			@ is it alphabet length?
	BNE loop			@ no so loop again
	
	POP {R9}			@ restore file files
	POP {R8}
	
writebuffer:	
	MOV R0, R9
	LDR R1,=outbuffer	@ addr of outbuffer
	MOV R2, #alphabet	@ length of alphabet
	MOV R7, #sys_write	@ write converted buffer
	SWI 0
	MOV R1, #0
	
	
@ flush and close 'infile'
	mov R0, R8
	mov R7, #sys_fsync
	SWI 0
	
	mov R0, R8
	mov R7, #sys_close
	SWI 0
	
	
@ flush and close 'outfile'
	mov R0, R9
	mov R7, #sys_fsync
	SWI 0
	
	mov R0, R9
	mov R7, #sys_close
	SWI 0	

finish:
		MOV     R0, #0      @ Use 0 return code
		MOV     R7, #1     
        SWI     0       
            

.equ 	sys_open, 5
.equ	sys_read, 3
.equ	sys_write, 4
.equ	sys_close, 6
.equ	sys_fsync, 118
.equ	o_rdonly, 0
.equ	s_rdwr,   0666	
.equ	o_wronly, 1
.equ	o_create,  0100
.equ	alphabet, 26		@ file length in bytes

.data
inputFile: .asciz "infile.txt"
outputFile: .asciz "outfile.txt"
error1: .asciz "Input file error \n"
error2: .asciz "Output file error\n" 
inbuffer: .fill (alphabet+1), 1, 65
outbuffer: .fill (alphabet+1), 1, 66


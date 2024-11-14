.data
valor: .ascii "  "

.text
.global main

main:
	mov r7, #3
	mov r0, #0
	mov r2,#4
	

	ldr r1, =valor
	swi 0

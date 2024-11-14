.data
cadena: .asciz "Hola Mudo!\n"

.text
.global main

main:
	mov r0, #1
	ldr r1, =cadena
	mov r2, #12
	mov r7, #4
	swi #0
	mov r0, #0
fin:
	mov r7, #1
	swi 0

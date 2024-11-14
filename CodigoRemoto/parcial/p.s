.data
texto: .asciz "hola amigos"
.text
.global main
main:
	ldr r0,=texto
ciclo:
	ldrb r1,[r0],#1
	cmp r1,#0
	beq fin
	cmp r1,#'a'
	beq reemplazar
	b ciclo

reemplazar:
	sub r0,r0,#1
	mov r2,#'@'
	strb r2,[r0]
	b ciclo
fin:
	mov r7,#1
	swi 0


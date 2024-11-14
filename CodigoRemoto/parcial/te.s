.data
vec: .word 1,-2,1,-2
largo: .word 4
.text
.global main
main:
	ldr r0,=vec
	mov r2,#0
	ldr r3,=largo
	ldr r4,[r3]

ciclo:
	ldr r1,[r0],#4
	cmp r4,#0
	beq fin
	cmp r1,#0
	bgt sumar
	b avanzar

sumar:
	add r2,r2,r1
	b avanzar

avanzar:
	sub r4,r4,#1
	b ciclo

fin:
	mov r7,#1
	swi 0

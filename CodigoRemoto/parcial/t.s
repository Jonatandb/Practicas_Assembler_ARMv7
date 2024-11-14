.data
datos: .word 1,2,5,4,3
largo: .byte 5
.text
.global main
main:
	ldr r0, =datos //a r0 le carga la direc.memo de datos
	ldr r1,=largo
	ldr r2,[r1]
	ldr r5,[r0]//1
	ldr r3,[r0]//1
ciclo:
	cmp r2,#0
	beq fin
	cmp r3, r5
	bgt sustituir
	b avanzar

sustituir:
	ldr r5,[r3]
	b avanzar

avanzar:
	ldrb r3,[r0],#4  //1,2,5,4,3
	sub r2,r2,#1
	b ciclo
fin:
	mov r7,#1
	swi 0

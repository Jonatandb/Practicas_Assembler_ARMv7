.data
	archivo: .ascii "palabras.txt"
	buffer: .space 10
.text

.global main:
main:
	//abrir
	mov r7,#5
	ldr r0,=archivo
	mov r1,#0
	mov r2,#0
	swi 0
	
	//chequear resultado
	cmp r0,#0
	blt error
	mov r6,r0

	//leer archivo
	mov r7,#3
	ldr r1,=buffer
	mov r2,#7
	swi 0

	//cerrar archivo
	mov r0,r6
	mov r7,#6
	swi 0

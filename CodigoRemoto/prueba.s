.data
palabra_escondida: .asciz "casas"
palabra_usuario: .asciz "perra"
leyenda: .asciz "la palabra del usuario es: "
.text
.global main
main:
	//mov r7,#3
	//mov r0,#0
	//mov r2,#5
	ldr r1,=palabra_usuario
	mov
	
	mov r7,#4
	mov r0,#1
	mov r2,#27
	
	ldr r1,=leyenda
	swi 0

	mov r7,#4
        mov r0,#1
        mov r2,#5

        ldr r1,=palabra_usuario
        swi 0
	b compararPalabras

compararPalabras:
	ldrb r2,[r1],#1
	ldr r3,=palabra_escondida
	cmp r2,#0
	beq fin
	ciclo:
		ldrb r4,[r3],#1
		cmp r4,#0
		beq compararPalabras
		cmp r2,r4
		beq contar
		b ciclo

contar:
	mov r7,#4

fin:

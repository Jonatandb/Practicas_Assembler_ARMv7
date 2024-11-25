/*

  Roadmap:

	- [x] Crear distintos tipos de variables

	- [x] Aprender a crear comparaciones

	- [x] Aprender a crear loops

	- [x] Aprender a crear funciones

	- [ ] Aprender a colorear texto (línea y letra a letra)

	- [ ] Aprender a leer datos de archivo .txt

	- [ ] Arepnder a pedir un ingreso al usuario


*/


/* 	// Swap usando la pila

	.global main

	fin:
		mov r7, #1
		swi 0

	main:
		mov r0, #4	@ r0 pasa a tener el 4
		mov r1, #8	@ r1 pasa a tener el 8

		push {r0}		@ la pila pasa a tener el 4

		mov r0, r1	@ r0 pasa a tener el 8
		pop {r1}		@ r1 pasa a tener el 4

		b fin
*/


/* 	// Swap usando registros

	.global main

	fin:
		mov r7, #1
		swi 0

	main:
		mov r0, #4	@ r0 pasa a tener el 4
		mov r1, #8	@ r1 pasa a tener el 8

		mov r2, r0	@ r2 pasa a tener el 4. Se usó r2 como "variable auxiliar"

		mov r0, r1	@ r0 pasa a tener el 8
		mov r1, r2	@ r1 pasa a tener el 4

		b fin
*/


/* 	// Ejercicio Swap

	@.data
		var1: .word 0xFFFFFFFF
		var2: .word 0x0

	.global main

	fin:
		mov r7, #1
		swi 0

	main:
		ldr r0, =var1
		ldr r1, =var2

		push {r0}		@ la pila pasa a tener el valor de var1

		mov r0, r1	@ r0 pasa a tener el valor de var2

		pop {r1}		@ r1 pasa a tener el valor de var1

		b fin

*/


/* // Carga y almacenamiento de datos desde y hacia la memoria

			// Direccionamiento relativo a registro

	.data						@ En esta sección (.data) se declaran "variables" y se almacenan datos.
		num1: .word 12500

	.text						@ En esta sección (.text) se define el código del programa.
									@		Cuando se define la sección .data, se DEBE definir la sección .text
									@		Sin esta línea, el ensamblador no sabrá dónde almacenar el código del programa
									@		y el programa no se podrá ejecutar correctamente.  ** ** **
	.global main

	fin:
		mov r7, #1
		swi 0

	main:
		ldr r0, =num1 	@ Cargo en r0 la dirección de memoria de la variable num1
		ldr r1, [r0]		@ Cargo en r1 el contenido guardado en la dirección de memoria apuntada por r0
										@		por lo tanto r1 => 0x30d4 (En decimal: 12500)
		b fin

*/


/* // Carga y almacenamiento de datos desde y hacia la memoria

			// Direccionamiento relativo a registro, ejemplo 2

	.data						@ En esta sección (.data) se declaran "variables" y se almacenan datos.
		num1: .word 5
		num2: .word 3
		sum:	.word 0

	.text
	.global main

	main:
		ldr r0, =num1 @ pongo la dir de memoria de num1
		ldr r1, [r0]	@ en r1 pongo el 5

		ldr r0, =num2 @ pongo la dir de memoria de num2
		ldr r2, [r0]	@ en r1 pongo el 3

		add r0, r1, r2 @ en r0 pongo la suma -> 8

		ldr r1, =sum @ pongo la dir de memoria de sum
		str r0, [r1]	@ lo que está en r0 (el 8)
									@ lo pongo en la dirección apuntada por r1
									@ entonces sum pasa a guardar el 8.

		b fin

	fin:
		mov r7, #1
		swi 0
*/


/* 	// Sumando números

	.global main

	fin:
		mov r7, #1
		swi 0

	main:
		mov r0, #0 			@ Pongo el 0
		add r0, #1 			@ Incremento en 1

		mov r1, #0 			@ Pongo el 0
		add r1, #5 			@ Incremento en 5

		add r2, r0, r1	@ Dejo en r2 la suma de lo que hay en r0 + lo que hay en r1: 1 + 5 => 6

		b fin

*/


/* // Suma, resta, multiplicación y división (con y sin signo)

	.data						@ En esta sección (.data) se declaran "variables" y se almacenan datos.
		num1: .word 1
		num2: .word 2
		suma:	.word 0
		resta: .word 0
		multi: .word 0
		divi: .word 0

	.text
	.global main

	main:
		@ Suma
		ldr r0, =num1 @ pongo la dir de memoria de num1
		ldr r1, [r0]	@ en r1 pongo el 1

		ldr r0, =num2 @ pongo la dir de memoria de num2
		ldr r2, [r0]	@ en r1 pongo el 2

		add r0, r1, r2 @ en r0 pongo la suma -> 3

		ldr r1, =suma @ pongo en la dir apuntada por r1
		str r0, [r1]	@ lo que está en r0 (el resultado de la suma: 3)

		@ Resta
		mov r2, #10
		mov r3, #8
		sub r0, r2, r3 @ r0 recibirá el 2.
		ldr r1, =resta
		str r0, [r1]

		@ Multiplicación
		mov r2, #2
		mov r3, #4
		mul r0, r2, r3 @ r0 recibirá el 8.
		ldr r1, =multi
		str r0, [r1]

		@ División sin signo
		mov r2, #10
		mov r3, #2
		udiv r0, r2, r3 @ r0 recibirá el 5.
		ldr r1, =divi
		str r0, [r1]

		@ División con signo (es indiferente si ninguno, uno o ambos tienen signo)
		mov r2, #10
		mov r3, #-2
		sdiv r0, r2, r3 @ r0 recibirá el -5.
		ldr r1, =divi
		str r0, [r1]

		b fin

	fin:
		mov r7, #1
		swi 0
*/


/*  // Bucle tipo while que suma los números del 1 al 10 y guarda el resultado en el registro r0
	.global main
	fin:
		mov r7, #1																										@ r0  r1		r0
		swi 0																													@ 0		1			1
																																	@ 1		2			3
	main:																														@ 3		3			6
		mov r0, #0				@ Inicializar r0 en 0												@ 6		4			10
		mov r1, #1				@ Inicializar r1 en 1												@ 10	5			15
		loop:							@ Etiqueta para el bucle										@	15	6			21
			add r0, r0, r1	@ Sumar el valor de r1 a r0									@	21	7			28
			add r1, r1, #1	@ Incrementar r1 en 1												@	28	8			36
			cmp r1, #11			@ Comparar r1 con 11												@	36	9			45
			blt loop				@ Saltar a la etiqueta loop si r1 < 11			@	45	10		55
			b fin																												@ 55	11		En r0 queda el 37,
																																	@ que es el 55 en hexadecimal.
*/


/*  // Bucle tipo for que suma todos los números de un "array" y guarda el resultado en el registro r0
	.data
	cant_nums:	.word 8
	nums:				.word 2, 4, 6, 8, -2, -4, -6, -7
	suma:				.word 0

	.text
	.global main
	main:
		ldr r0, =cant_nums			@ cargo en r0 la dirección de cant_nums
		ldr r1, [r0]						@ cargo en r1 el valor en la dirección dada por r0: 8
		ldr r2, =nums						@ cargo en r2 la dirección de donde empiezan los nums
		mov r3, #0							@ inicializo r3 en 0, porque ahí haré la sumatoria
		loop:	cmp r1, #0				@ comparo el valor actual en cant_nums contra cero
					beq	salir					@ si cant_nums llegó a 0, termino el programa
					ldr r4, [r2], #4	@ cargo en r4 el valor dado por la dirección en r2 desplazada 4 bytes (siguiente num)
					add r3, r3, r4		@ cargo en r3 la suma parcial del número actual con los ya sumados
					sub r1, #1				@ le resto a r1, 1, ya que ya pocresé el número actual
					b loop						@ vuelvo a procesar para sumar siguiente número
		salir:
					ldr r0, =suma			@ cargo en r0 la dirección de suma
					str r3, [r0]			@ guardo en la dirección de suma el total de los números sumados
					bx lr							@ finalizo el programa
*/


/* // Uso de subrutinas
	.global main
	main:
			mov r1, #1
			mov r2, #2
			bl nivel1    @ lr va a guardar la dirección de
			mov r5, #5   @ <- esta instrucción
			b fin

	fin:mov r7, #1
			swi 0

	nivel1:
			push {lr}    @ guardo en la pila la dir. de "mov r5, #5" de main
			mov r3, #3
			bl nivel2    @ lr va a guardar la dirección de
			pop {lr}     @ <- esta instrucción
			bx lr        @ como pop restauró lr, salta a "mov r5, #5" de main

	nivel2:
			mov r4, #4
			bx lr        @ salta al pop {lr} de nivel1
*/


/* // Cuadrado de un número
.global main

.data
	num: .word 2
	res: .word 0

.text
cuadrado:
	mul r2, r1, r1  @ r2 => 4
	bx lr

main:
	ldr r0, =num
	ldr r1, [r0]    @ r1 => 2

	bl cuadrado

	ldr r0, =res
	str r2, [r0]    @ r0 => 4

	b exit

exit:
	mov r0, #0
	mov r7, #1
	swi 0
*/


/* // Impresión de texto */
	.global main

	.data
		mensaje1: .asciz "Este es un mensaje\n"   @ 19 carcteres en total

	.text

  // Escribe en pantalla lo que esté en la dirección seteada con ldr a r1
  // con la longitud de caracteres especificada en r2
  // Ej:
  //  ldr r1, =msg_importante
  //  mov r2, #6
	mostrar_texto:
		mov r0, #1					@ Descriptor de archivo (stdout)
		mov r7, #4					@ Código de sistema (syscall) para write
		svc 0								@ Llamada al sistema
		bx lr

	main:
		ldr r1, =mensaje1  	@ r1 tendrá la dirección (por eso el "=") de mensaje1
		mov r2, #19					@ r2, cantidad de caracteres de mensaje1
		bl mostrar_texto

	fin:
		mov r0, #0
		mov r7, #1
		swi 0

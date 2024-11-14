
.data
bienvenida: .asciz "!BIENVENIDO A WORDLE!\n"
instruccion: .asciz "LA PALABRA TIENE 5 LETRAS\n"
nombreDelUsuario: .asciz ""
solicitud_nombre: .asciz "Ingresa tu nombre por favor: "
palabra_usuario: .asciz ""
pedirPalabra: .asciz "ingrese una palabra: "
.text
.global main

// Subrutina para imprimir un mensaje
imprimir_mensaje:
	.fnstart
        push {lr}
        mov r7, #4
        mov r0, #1               // file descriptor 1 (stdout)
        svc #0                   // llamada al sistema para escribir
        pop {lr}
        bx lr
	.fnend

// Subrutina para inicializar e imprimir el mensaje de bienvenida
imprimirInicio:
	.fnstart
        push {lr}
        ldr r1, =bienvenida      // Cargar dirección del mensaje
        ldr r2, =22              // Cargar longitud del mensaje
        bl imprimir_mensaje      // Llamar a imprimir_mensaje

        ldr r1, =instruccion      // Cargar dirección del mensaje
        ldr r2, =27              // Cargar longitud del mensaje
        bl imprimir_mensaje      // Llamar a imprimir_mensaje

        pop {lr}
        bx lr
	.fnend


pedir_nombre:
        .fnstart
        push {lr}
        ldr r1, =solicitud_nombre // Cargar dirección del mensaje
        ldr r2, =29               // Cargar longitud del mensaje
        bl imprimir_mensaje       // Llamar a imprimir_mensaje
        
        ldr r1, =nombreDelUsuario // Cargar la dirección del buffer para el nombre
        bl cargarTexto           // Llamar a cargarNombre para leer el nombre
        pop {lr}
        bx lr
        .fnend

// Subrutina para leer el nombre ingresado por el usuario
cargarTexto:
        .fnstart
        push {lr}
        mov r7, #3                // syscall para sys_read
        mov r0, #0                // file descriptor 0 (stdin)
        mov r2, #6               // Tamaño máximo de caracteres a leer (ajústalo según necesites)
        svc #0                    // Llamada al sistema
        pop {lr}
        bx lr
        .fnend

comenzarJuego:
	.fnstart
        push {lr}
	ldr r1, =pedirPalabra      // Cargar dirección del mensaje
        ldr r2, =22              // Cargar longitud del mensaje
        bl imprimir_mensaje      // Llamar a imprimir_mensaje

	ldr r1,=palabra_usuario
	bl cargarTexto
	pop {lr}
        bx lr
        .fnend



// Punto de entrada principal
main:
        bl imprimirInicio        // Llamar a imprimirInicio
        bl pedir_nombre          // Llamar a pedir_nombre
	bl comenzarJuego
	
        // Terminar el programa
        mov r7, #1
	mov r0, #0
        svc #0

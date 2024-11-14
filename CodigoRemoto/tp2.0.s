.section .data
bienvenida: .asciz "BIENVENIDO A WORDLE\n\n"
len_bienvenida: .int 20
longitud_palabra: .asciz "LA PALABRA TIENE 5 LETRAS\n"
len_longitud_palabra: .int 28
nombre_prompt: .asciz "Introduce tu nombre: "        // Mensaje para pedir el nombre
len_nombre_prompt: .int 24                            // Longitud del mensaje
nombre_buffer: .int 50                              // Buffer para almacenar el nombre (50 caracteres)

.section .text
.global main

main:
    // Imprimir "BIENVENIDO A WORDLE"
    mov r0, #1
    ldr r1, =bienvenida 
    ldr r2, =len_bienvenida
    ldr r2, [r2]
    bl imprimir_mensaje

    // Imprimir "LA PALABRA TIENE X LETRAS"
    mov r0, #1
    ldr r1, =longitud_palabra
    ldr r2, =len_longitud_palabra
    ldr r2, [r2]
    bl imprimir_mensaje

    // Solicitar el nombre del usuario
    mov r0, #1
    ldr r1, =nombre_prompt
    ldr r2, =len_nombre_prompt
    ldr r2, [r2]
    bl imprimir_mensaje

    // Leer el nombre del usuario
    mov r0, #0                              // file descriptor 0 (stdin)
    ldr r1, =nombre_buffer                  // Dirección del buffer
    mov r2, #50                             // Leer hasta 50 caracteres
    mov r7, #3                              // syscall para sys_read
    svc #0                                   // Llamada al sistema

    // Aquí puedes agregar más lógica para usar el nombre

    // Salir del programa
    mov r7, #1
    mov r0, #0
    svc #0

// Subrutina para imprimir un mensaje
imprimir_mensaje:
    mov r7, #4
    svc #0
    bx lr


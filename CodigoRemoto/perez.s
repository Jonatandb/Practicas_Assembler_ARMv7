.data
bienvenida: .asciz "BIENVENIDO A WORDLE\n\n"
len_bienvenida: .int 20
longitud_palabra: .asciz "LA PALABRA TIENE 5 LETRAS\n"
len_longitud_palabra: .int 28
nombre_prompt: .asciz "Introduce tu nombre: "        // Mensaje para pedir el nombre
len_nombre_prompt: .int 10                            // Longitud del mensaje
nombre_buffer: .byte 20                              // Buffer para almacenar el nombre (20 caracteres)
palabra_prompt: .asciz "Introduce una palabra (max 5 letras): " // Mensaje para pedir la palabra
len_palabra_prompt: .int 37                          // Longitud del mensaje
palabra_buffer: .byte 6                              // Buffer para almacenar la palabra (5 letras + nulo)

.text
.global main

main:
    // Imprimir "BIENVENIDO A WORDLE"
    mov r0, #1
    ldr r1, =bienvenida
    ldr r2, =len_bienvenida
    ldr r2, [r2]
    bl imprimir_mensaje

    // Imprimir "LA PALABRA TIENE 5 LETRAS"
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
    bl imprimir_mensaje

    // Imprimir "LA PALABRA TIENE 5 LETRAS"
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

    // Solicitar una palabra de máximo 5 letras
    mov r0, #1
    ldr r1, =palabra_prompt                 // Mensaje para pedir la palabra
    ldr r2, =len_palabra_prompt
    ldr r2, [r2]
    bl imprimir_mensaje

    // Leer la palabra del usuario
    mov r0, #0                              // file descriptor 0 (stdin)
    ldr r1, =palabra_buffer                 // Dirección del buffer para la palabra
    mov r2, #6                              // Leer hasta 5 caracteres + nulo
    mov r7, #3                              // syscall para sys_read
    svc #0                                   // Llamada al sistema

    // Aquí puedes agregar más lógica para usar el nombre y la palabra

    // Salir del programa
    mov r7, #1
    mov r0, #0
    svc #0


// Subrutina para imprimir un mensaje
imprimir_mensaje:
    mov r7, #4
    mov r0, #1                              // file descriptor 1 (stdout)
    svc #0
    bx lr



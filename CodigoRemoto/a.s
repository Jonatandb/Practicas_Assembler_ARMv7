.data
bienvenida: .asciz "BIENVENIDO A WORDLE\n\n"
len_bienvenida: .int 20
longitud_palabra: .asciz "LA PALABRA TIENE 5 LETRAS\n"
len_longitud_palabra: .int 28
nombre_prompt: .asciz "Introduce tu nombre: "        // Mensaje para pedir el nombre
len_nombre_prompt: .int 21                            // Longitud del mensaje
nombre_buffer: .byte 21                              // Buffer para almacenar el nombre (20 caracteres + nulo)
palabra_prompt: .asciz "Introduce una palabra (max 5 letras): " // Mensaje para pedir la palabra
len_palabra_prompt: .int 39                          // Longitud del mensaje
palabra_buffer: .byte 6                              // Buffer para almacenar la palabra (5 letras + nulo)

.text
.global main

main:
        b imprimir_Inicio

imprimir_Inicio:
        .fnstart
        push {lr}
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
        mov r2, #21                             // Leer hasta 20 caracteres + nulo
        mov r7, #3                              // syscall para sys_read
        svc #0                                   // Llamada al sistema

    // Eliminar el salto de línea y agregar carácter nulo al final del nombre
        mov r3, #0                              // Índice para recorrer el buffer
buscar_salto_linea:
        ldrb r4, [r1, r3]                      // Cargar byte del buffer
        cmp r4, #10                             // Comparar con salto de línea (10 en ASCII)
        beq fin_nombre                          // Si es salto de línea, saltar al final
        add r3, r3, #1                          // Incrementar el índice
        b buscar_salto_linea                    // Repetir búsqueda
fin_nombre:
        mov r4, #0                              // Establecer carácter nulo (0) en la posición del salto de línea
        strb r4, [r1, r3]                       // Poner el nulo al final del nombre

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

    // Eliminar el salto de línea y agregar carácter nulo al final de la palabra
        mov r3, #0                              // Índice para recorrer el buffer
buscar_salto_palabra:
        ldrb r4, [r1, r3]                      // Cargar byte del buffer
        cmp r4, #10                             // Comparar con salto de línea (10 en ASCII)
        beq fin_palabra                         // Si es salto de línea, saltar al final
        add r3, r3, #1                          // Incrementar el índice
        b buscar_salto_palabra                  // Repetir búsqueda
fin_palabra:
        mov r4, #0                              // Establecer carácter nulo (0) en la posición del salto de línea
        strb r4, [r1, r3]                       // Poner el nulo al final de la palabra

    // Imprimir el nombre ingresado
        mov r0, #1
        ldr r1, =nombre_buffer
        mov r2, #21
        mov r7, #4
        svc #0                                   // Imprimir el nombre

    // Imprimir la palabra ingresada
        mov r0, #1
        ldr r1, =palabra_buffer
        mov r2, #6
        mov r7, #4
        svc #0                                   // Imprimir la palabra

    // Salir del programa
        mov r7, #1
        mov r0, #0
        svc #0
        pop {lr}
        bx lr
        .fnend

// Subrutina para imprimir un mensaje
imprimir_mensaje:
        push {lr}
        .fnstart
        mov r7, #4
        mov r0, #1                              // file descriptor 1 (stdout)
        svc #0
        pop {lr}
        bx lr
        .fnend


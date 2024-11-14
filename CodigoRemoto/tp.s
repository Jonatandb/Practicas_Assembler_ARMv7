.data
bienvenida: .asciz "BIENVENIDO A WORDLE\n"
longitud_palabra: .asciz "LA PALABRA TIENE 5 LETRAS\n"  // Cambia '5' por la cantidad que quieras mostrar
.text
.global main

main:
    // Imprimir "BIENVENIDO A WORDLE"
    mov r0, #1                // File descriptor 1 es stdout
    ldr r1, =bienvenida       // Cargar la dirección del mensaje "bienvenida"
    bl imprimir_mensaje

    // Imprimir "LA PALABRA TIENE X LETRAS"
    mov r0, #1                // File descriptor 1 es stdout
    ldr r1, =longitud_palabra // Cargar la dirección del mensaje "longitud_palabra"
   // bl imprimir_mensaje

    // Salir del programa
    mov r7, #1                // syscall para sys_exit
    mov r0, #0                // Estado de salida 0
    svc #0                    // Llamada al sistema

// Subrutina para imprimir un mensaje
imprimir_mensaje:
    ldr r2, [r1, #0]          // Longitud del mensaje
    mov r7, #4                // syscall para sys_write
    svc #0                    // Llamada al sistema
    bx lr                     // Regresar al llamador


.data
bienvenida: .asciz "BIENVENIDO A WORDLE\n"
len_bienvenida: .int 22                     // Longitud de "BIENVENIDO A WORDLE\n"
longitud_palabra: .asciz "LA PALABRA A ADIVINAR TIENE 5 LETRAS\n"
len_longitud_palabra: .int 40               // Longitud de "LA PALABRA TIENE 5 LETRAS\n"

.text
.global main

main:
    // Imprimir "BIENVENIDO A WORDLE"
    mov r0, #1                             // File descriptor 1 (stdout)
    ldr r1, =bienvenida                    // Dirección del mensaje "bienvenida"
    ldr r2, =len_bienvenida                // Longitud del mensaje
    ldr r2, [r2]                           // Cargar el valor de la longitud
    bl imprimir_mensaje                    // Llamar a la subrutina

    // Imprimir "LA PALABRA TIENE X LETRAS"
    mov r0, #1                             // File descriptor 1 (stdout)
    ldr r1, =longitud_palabra              // Dirección del mensaje "longitud_palabra"
    ldr r2, =len_longitud_palabra          // Longitud del mensaje
    ldr r2, [r2]                           // Cargar el valor de la longitud
    bl imprimir_mensaje                    // Llamar a la subrutina

    // Salir del programa
    mov r7, #1                             // syscall para sys_exit
    mov r0, #0                             // Estado de salida 0
    svc #0                                 // Llamada al sistema

// Subrutina para imprimir un mensaje
imprimir_mensaje:
    mov r7, #4                             // syscall para sys_write
    svc #0                                 // Llamada al sistema
    bx lr                                  // Regresar al llamador


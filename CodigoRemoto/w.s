.data
archivo_nombre: .asciz "palabras.txt"                     // Nombre del archivo
palabras: .byte 50 * 6                                      // Espacio para 50 palabras de 5 letras + terminador nulo
palabras_count: .int 0                                      // Contador de palabras leídas
error_mensaje: .asciz "Error al abrir el archivo\n"       // Mensaje de error
mensaje_bienvenida: .asciz "Bienvenido a Wordle\n"         // Mensaje de bienvenida

.text
.global main

main:
    // Imprimir mensaje de bienvenida
    ldr r0, =mensaje_bienvenida                           // Cargar dirección del mensaje
    bl imprimir_mensaje                                   // Llamar a la subrutina para imprimir el mensaje

    // Llamar a la función para leer palabras
    bl leer_palabras                                      // Llamar a leer_palabras

    // Salir del programa
    mov r7, #1                                           // syscall para sys_exit
    mov r0, #0                                           // Código de salida
    svc #0                                                // Llamada al sistema

leer_palabras:
    // Abrir el archivo
    ldr r0, =archivo_nombre                              // Nombre del archivo
    mov r1, #0                                           // Opción de apertura (O_RDONLY)
    mov r7, #5                                           // syscall para sys_open
    svc #0                                                // Llamada al sistema
    cmp r0, #0                                           // Comprobar si el descriptor de archivo es negativo
    blt error_abrir                                      // Si es negativo, ir a manejar el error
    mov r4, r0                                           // Guardar el descriptor de archivo

    // Leer las palabras
    ldr r5, =palabras                                    // Dirección para almacenar palabras
    mov r6, #0                                           // Contador de palabras leídas

leer_linea:
    mov r2, #6                                           // Leer hasta 5 caracteres + nulo
    mov r7, #3                                           // syscall para sys_read
    svc #0                                                // Llamada al sistema
    cmp r0, #0                                           // Comprobar si se llegó al final del archivo
    beq fin_leer                                         // Si r0 es 0, terminar la lectura

    // Almacenar la palabra en la lista
    cmp r6, #50                                          // Verificar si ya se leyeron 50 palabras
    bge fin_leer                                         // Si ya se leyeron 50, salir

    // Copiar la palabra del buffer a la lista de palabras
    str r0, [r5, r6, lsl #2]                             // Almacenar la dirección de la palabra
    add r5, r5, #6                                      // Mover el puntero de almacenamiento (5 caracteres + nulo)
    add r6, r6, #1                                      // Incrementar el contador de palabras leídas

    b leer_linea                                        // Volver a leer la siguiente línea

fin_leer:
    // Cerrar el archivo
    mov r7, #6                                          // syscall para sys_close
    mov r0, r4                                          // Usar el descriptor de archivo guardado
    svc #0                                               // Llamada al sistema
    bx lr                                               // Regresar de la subrutina

error_abrir:
    // Manejar el error de apertura
    ldr r0, =error_mensaje                              // Cargar dirección de un mensaje de error
    bl imprimir_mensaje                                  // Llamar a la subrutina para imprimir el mensaje
    bx lr                                               // Regresar de la subrutina

imprimir_mensaje:
    // Subrutina para imprimir un mensaje
    mov r7, #4                                          // syscall para sys_write
    mov r1, r0                                          // Dirección del mensaje a imprimir
    mov r2, #27                                         // Longitud del mensaje (ajusta si es necesario)
    mov r0, #1                                          // Descritor de archivo 1 (stdout)
    svc #0                                               // Llamada al sistema
    bx lr                                               // Regresar de la subrutina


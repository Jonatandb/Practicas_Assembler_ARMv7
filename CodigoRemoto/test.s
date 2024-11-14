.data
palabra_oculta: .asciz "ARMOR"                  // Palabra oculta (5 letras)
buffer_usuario: .space 6                        // Buffer para la palabra del usuario (5 letras + null)
mensaje_bienvenida: .asciz "BIENVENIDO A WORDLE\n"
mensaje_pedir_palabra: .asciz "\nIntroduce una palabra de 5 letras:\n"
mensaje_ganar: .asciz "\n¡Has adivinado la palabra!\n"
mensaje_intentos: .asciz "Resultado: "
resultado_buffer: .space 6                      // Buffer para almacenar el resultado de colores (5 letras + null)

.text
.global main

main:
    // Imprimir mensaje de bienvenida
    mov r0, #1                                   // stdout
    ldr r1, =mensaje_bienvenida
    mov r2, #20
    mov r7, #4
    svc #0

inicio_juego:
    // Pedir al usuario una palabra
    mov r0, #1
    ldr r1, =mensaje_pedir_palabra
    mov r2, #37
    mov r7, #4
    svc #0

    // Leer la palabra ingresada por el usuario
    mov r0, #0                                   // stdin
    ldr r1, =buffer_usuario
    mov r2, #6                                   // Leer hasta 6 bytes (5 letras + terminador)
    mov r7, #3                                   // syscall para read
    svc #0

    // Comparar letras individuales y generar resultado
    ldr r1, =buffer_usuario                      // Dirección de la palabra ingresada
    ldr r2, =palabra_oculta                      // Dirección de la palabra oculta
    ldr r3, =resultado_buffer                    // Dirección para almacenar el resultado
    bl comparar_letras                           // Llamar a la subrutina de comparación

    // Imprimir resultado
    mov r0, #1
    ldr r1, =mensaje_intentos                    // Texto "Resultado: "
    mov r2, #10
    mov r7, #4
    svc #0

    // Imprimir el buffer con el resultado (X, Y, G)
    mov r0, #1
    ldr r1, =resultado_buffer                    // Mostrar los colores de pistas
    mov r2, #5
    mov r7, #4
    svc #0

    // Verificar si ganó el juego
    ldr r1, =resultado_buffer
    mov r0, #0
    bl verificar_victoria                        // Llamar a la subrutina para verificar victoria
    cmp r0, #0                                   // Si r0 es 0, ha ganado
    beq ganar                                    // Saltar a ganar si ganó
    b inicio_juego                               // Reintentar el juego si no ha ganado

ganar:
    // Mostrar mensaje de victoria
    mov r0, #1
    ldr r1, =mensaje_ganar
    mov r2, #25
    mov r7, #4
    svc #0
    b fin

fin:
    mov r7, #1                                   // syscall para exit
    mov r0, #0
    svc #0

// Subrutina para comparar letras individuales y generar pistas
comparar_letras:
    push {r4, r5, r6, lr}                        // Guardar registros temporales y lr

    mov r5, #0                                   // Índice (contador de letras)

compara_loop:
    ldrb r4, [r1, r5]                            // Cargar la letra de la palabra ingresada
    ldrb r6, [r2, r5]                            // Cargar la letra de la palabra oculta
    cmp r4, #0                                   // Si llegamos al final de la palabra
    beq fin_comparacion                          // Salir del bucle si terminamos

    cmp r4, r6                                   // Comparar letra de palabra ingresada con la oculta
    beq letra_correcta                           // Si son iguales, es verde (posición correcta)

    // Verificar si la letra está en la palabra pero en otra posición
    mov r7, #0                                   // Bandera de presencia
    mov r8, #0                                   // Índice para búsqueda

buscar_letra:
    ldrb r9, [r2, r8]                            // Cargar letra de la palabra oculta
    cmp r9, #0                                   // Si llegamos al final, salir del bucle
    beq letra_incorrecta
    cmp r4, r9                                   // Comparar con letra de la palabra oculta
    beq letra_presente                           // Si está presente en otra posición, es amarillo
    add r8, r8, #1                               // Incrementar índice
    b buscar_letra                               // Repetir

letra_correcta:
    mov r10, #'G'                                // Green: letra correcta y en la posición correcta
    b almacenar_resultado

letra_presente:
    mov r10, #'Y'                                // Yellow: letra presente en otra posición
    b almacenar_resultado

letra_incorrecta:
    mov r10, #'X'                                // Gray: letra no presente en la palabra

almacenar_resultado:
    strb r10, [r3, r5]                           // Almacenar el resultado en el buffer
    add r5, r5, #1                               // Incrementar el índice
    b compara_loop                               // Continuar con la siguiente letra

fin_comparacion:
    strb r10, [r3, r5]                           // Almacenar terminador null en el buffer
    pop {r4, r5, r6, lr}
    bx lr

// Subrutina para verificar si el usuario ha ganado (todas las letras son correctas)
verificar_victoria:
    push {r4, lr}
    mov r4, #0                                   // Índice para recorrer el resultado

verificar_loop:
    ldrb r5, [r1, r4]                            // Cargar el siguiente byte del resultado
    cmp r5, #0                                   // Si es el terminador, salir
    beq es_ganador
    cmp r5, #'G'                                 // Comparar con 'G' (green)
    bne no_ganador                               // Si no es 'G', no ha ganado
    add r4, r4, #1                               // Incrementar índice
    b verificar_loop                             // Repetir

es_ganador:
    mov r0, #0                                   // Retornar 0 si ha ganado
    pop {r4, lr}
    bx lr

no_ganador:
    mov r0, #1                                   // Retornar 1 si no ha ganado
    pop {r4, lr}
    bx lr


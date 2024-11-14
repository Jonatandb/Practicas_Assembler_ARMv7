.data
rojo: .asciz "\033[31m"          // Rojo
verde: .asciz "\033[32m"         // Verde
amarillo: .asciz "\033[33m"      // Amarillo
reset: .asciz "\033[0m"          // Resetea al color por defecto
palabra_oculta: .asciz "ARMOR"   // Palabra oculta (5 letras)
buffer_usuario: .space 6         // Buffer para la palabra del usuario (5 letras + null)
mensaje_bienvenida: .asciz "BIENVENIDO A WORDLE\n"
mensaje_pedir_palabra: .asciz "\nIntroduce una palabra de 5 letras:\n"
mensaje_ganar: .asciz "\n¡Has adivinado la palabra!\n"
mensaje_intentos: .asciz "Resultado: "
resultado_buffer: .space 6       // Buffer para almacenar el resultado de colores (5 letras + null)

.text
.global main

main:
    // Imprimir mensaje de bienvenida
    mov r0, #1                              // stdout
    ldr r1, =mensaje_bienvenida
    mov r2, #20
    mov r7, #4
    svc #0

inicio_juego:
    // Pedir al usuario una palabra
    mov r0, #1
    ldr r1, =mensaje_pedir_palabra            // Mensaje para pedir la palabra
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

    // Imprimir el buffer con el resultado (letras en verde o "X" / "Y")
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
    // Imprimir mensaje de victoria
    mov r0, #1
    ldr r1, =mensaje_ganar
    mov r2, #24
    mov r7, #4
    svc #0

    // Terminar el programa
    mov r7, #1
    mov r0, #0
    svc #0

// Subrutina para comparar letras y generar pistas
comparar_letras:
    mov r4, #0                     // Índice para recorrer la palabra (0 a 4)
comparar_loop:
    ldrb r5, [r1, r4]              // Cargar letra de buffer_usuario (usuario)
    ldrb r6, [r2, r4]              // Cargar letra de palabra_oculta
    cmp r5, r6                     // Comparar las letras
    beq letra_correcta             // Si son iguales, es una letra correcta

    // Si la letra no es igual, verificar si está en la palabra pero en otra posición
    // Aquí puedes agregar la lógica para verificar si la letra está en la palabra (en otro lugar)
    mov r7, #'X'                   // Si la letra no está en la palabra, asignar "X" (gris)
    strb r7, [r3, r4]              // Almacenar "X" en resultado_buffer
    b siguiente_letra

letra_correcta:
    // Letra correcta, colocarla en verde
    ldr r7, =verde                  // Cargar secuencia de escape ANSI para verde
    mov r2, #6                      // Longitud de la secuencia de escape (6 bytes)
    mov r0, #1                      // stdout
    mov r7, #4                      // syscall para write
    svc #0                           // Imprimir secuencia de escape para verde
    ldrb r7, [r1, r4]               // Cargar la letra correcta (por ejemplo, 'G')
    mov r0, #1                      // stdout
    mov r2, #1                      // Longitud de la letra
    mov r7, #4                      // syscall para write
    svc #0                           // Imprimir la letra correcta en verde
    ldr r7, =reset                  // Cargar secuencia para resetear color
    mov r2, #4                      // Longitud de la secuencia de escape
    mov r7, #4                      // syscall para write
    svc #0                           // Imprimir secuencia para resetear el color

    strb r7, [r3, r4]              // Almacenar "G" en resultado_buffer
    b siguiente_letra

siguiente_letra:
    add r4, r4, #1                 // Incrementar índice
    cmp r4, #5                     // Verificar si hemos comparado todas las letras
    blt comparar_loop              // Si no, continuar comparando

    bx lr                          // Volver de la subrutina

// Subrutina para verificar si el usuario ha adivinado la palabra
verificar_victoria:
    // Compara si el resultado tiene todas las "G"
    mov r4, #0                     // Índice
    ldr r5, =resultado_buffer       // Dirección del buffer de resultado
    verificar_loop:
        ldrb r6, [r5, r4]          // Cargar letra del resultado
        cmp r6, #'G'               // Si es "G" (correcta)
        bne no_gano                 // Si no es "G", el juego no ha ganado
        add r4, r4, #1
        cmp r4, #5                 // Verificar si ya comprobamos todas las letras
        blt verificar_loop         // Si no, continuar
    mov r0, #0                      // Si todas las letras son "G", se ha ganado
    bx lr

no_gano:
    mov r0, #1                      // Si no todas son "G", el juego continúa
    bx lr


    .data
matriz:
    .byte 1, 2, 3, 4       @ Fila 1
    .byte 5, 6, 7, 8       @ Fila 2
    .byte 9, 10, 11, 12    @ Fila 3
    .byte 13, 14, 15, 16   @ Fila 4

    .text
    .global main

main:
    ldr r0, =matriz         @ Cargar la dirección de la matriz en r0
    mov r1, #0              @ Inicializar r1 a 0 para la suma
    mov r2, #0              @ Inicializar r2 a 0 (contador de fila)

sumar_diagonal:
    ldrb r3, [r0],#5    @ Cargar el valor diagonal (r0 + (r2 * 4))
    add r1, r1, r3                @ Sumar el valor de la diagonal a r1

    add r2, r2, #1                @ Incrementar el contador de fila
    cmp r2, #4                    @ Comparar si hemos recorrido las 4 filas
    blt sumar_diagonal            @ Si r2 < 4, repetir el bucle

fin:
    mov r7, #1                   @ syscall: sys_exit
    mov r0, #0                   @ Código de salida 0
    svc #0


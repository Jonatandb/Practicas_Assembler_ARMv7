.data
numeros: .word 4, 7, 12, 15, 18, 21, 24, 30, 33, 36  @ Lista de números (puedes agregar más)
.text
.global main

main:
    ldr r0, =numeros          @ Cargar la dirección de la lista en r0
    ldr r1, =10               @ Número de elementos en la lista (modifica según el tamaño)
    mov r2, #0                @ Inicializar r2 a 0 para la suma de pares

sumar_pares:
    ldr r3, [r0], #4          @ Cargar el siguiente número en r3 y avanzar r0 en 4 bytes
    ands r3, r3, #1           @ Realizar and en el bit menos significativo y actualizar flags
    beq es_par                @ Si es 0 (par), saltar a es_par

    b siguiente               @ Si no es par, saltar a siguiente

es_par:
    add r2, r2, r3            @ Sumar el número par a r2

siguiente:
    subs r1, r1, #1           @ Restar 1 del contador de elementos
    bne sumar_pares           @ Si quedan elementos, repetir el bucle

fin:
    mov r7, #1                @ syscall: sys_exit
    mov r0, #0                @ Código de salida 0
    svc #0


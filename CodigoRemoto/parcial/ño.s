.data
matriz: .byte '1', '2', '3', '4',     // Primera fila
              '5', '6', '7', '8',     // Segunda fila
              '9', 'A', '5', 'C',     // Tercera fila
              'D', 'E', 'F', '1'      // Cuarta fila

.text
.global main
main:
        ldr r0, =matriz       // Cargar la dirección base de la matriz en r0
        mov r1, #0            // Inicializar el acumulador en r1 para la suma de la diagonal

        // Cargar y sumar los elementos de la diagonal usando desplazamientos
        ldrb r2, [r0, #0]     // Cargar el primer elemento de la diagonal (posición 0)
        add r1, r1, r2        // Sumar el valor al acumulador

        ldrb r2, [r0, #5]     // Cargar el segundo elemento de la diagonal (posición 5)
        add r1, r1, r2        // Sumar el valor al acumulador

        ldrb r2, [r0, #10]    // Cargar el tercer elemento de la diagonal (posición 10)
        add r1, r1, r2        // Sumar el valor al acumulador

        ldrb r2, [r0, #15]    // Cargar el cuarto elemento de la diagonal (posición 15)
        add r1, r1, r2        // Sumar el valor al acumulador

fin:
        mov r7, #1            // Código de salida del sistema
        swi 0                 // Llamada al sistema para salir




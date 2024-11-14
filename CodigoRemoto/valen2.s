.data
        archivo: .asciz "palabras.txt"
        buffer: .space 10
.text
.global main
main:
        // Abrir el archivo
        mov r7, #5                // Código de llamada al sistema para sys_open
        ldr r0, =archivo          // Cargar la dirección de "palabras.txt" en r0
        mov r1, #0                // Modo de apertura (lectura)
        mov r2, #0                // Sin permisos especiales
        svc #0                    // Llamada al sistema

        // Chequear el resultado de apertura
        cmp r0, #0                // Comprobar si la apertura fue exitosa
        blt error                 // Si r0 es negativo, ir a error
        mov r6, r0                // Guardar el file descriptor en r6

        // Leer el archivo
        mov r7, #3                // Código de llamada al sistema
        ldr r1, =buffer           // Cargar dirección del buffer
        mov r2, #7                // Número de bytes a leer
        svc #0                    // Llamada al sistema

        // Cerrar el archivo
        mov r0, r6                // File descriptor en r0
        mov r7, #6                // Código de llamada al sistema para sys_close
        svc #0                    // Llamada al sistema

        // Fin del programa (salida)
        mov r7, #1                // Código de llamada al sistema para sys_exit
        mov r0, #0                // Código de salida 0
        svc #0                    // Llamada al sistema

error:
        // Manejo de error en caso de falla de apertura del archivo
        mov r7, #4	                // sys_exit
        mov r0, #1                // Código de salida 1 para indicar error
        svc #0                    // Llamada al sistema


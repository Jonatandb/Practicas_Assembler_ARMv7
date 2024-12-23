.data
bienvenida: .asciz "BIENVENIDO A WORDLE\n\n"         
len_bienvenida: .int 20                             
longitud_palabra: .asciz "LA PALABRA TIENE 5 LETRAS\n\n" 
len_longitud_palabra: .int 28                        
nombre_prompt: .asciz "Introduce tu nombre: "        
len_nombre_prompt: .int 24                            
nombre_buffer: .int 6                              // Buffer para el nombre
palabra_prompt: .asciz "Introduce una palabra: "       
len_palabra_prompt: .int 28                            
palabra_buffer: .int 6                              // Buffer para almacenar la palabra ingresada
archivo_nombre: .asciz "palabras.txt"                  // Nombre del archivo
palabras_buffer: .int 256                             // Buffer para almacenar las palabras leídas
palabras_count: .int 0                                  // Contador de palabras
palabra_elegida: .int 6                               // Buffer para almacenar la palabra elegida (5 letras + terminador nulo)

.text
.global main

main:
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
    mov r2, #6                             // Leer hasta 50 caracteres
    mov r7, #3                              // syscall para sys_read
    svc #0                                   // Llamada al sistema

    // Solicitar que el usuario ingrese una palabra
    mov r0, #1                             
    ldr r1, =palabra_prompt                 
    ldr r2, =len_palabra_prompt              
    ldr r2, [r2]                           
    bl imprimir_mensaje                    

    // Leer la palabra ingresada por el usuario
    mov r0, #0                              // file descriptor 0 (stdin)
    ldr r1, =palabra_buffer                 // Dirección del buffer para la palabra
    mov r2, #6                             // Leer hasta 20 caracteres
    mov r7, #3                              // syscall para sys_read
    svc #0                                   // Llamada al sistema

    // Leer palabras del archivo
    bl leer_palabras                         // Llamar a la subrutina para leer palabras

    // Sortear una palabra
    bl sortear_palabra                       // Llamar a la subrutina para sortear una palabra

    // Imprimir la palabra elegida
    mov r0, #1                             
    ldr r1, =palabra_elegida                // Dirección de la palabra elegida
    ldr r2, =6                              // Longitud de la palabra (5 letras + 1 para el terminador)
    bl imprimir_mensaje                     // Imprimir la palabra elegida

    // Salir del programa
    mov r7, #1                             
    mov r0, #0                             
    svc #0                                 

// Subrutina para imprimir un mensaje
imprimir_mensaje:
    mov r7, #4                             
    svc #0                                 
    bx lr                                   // Regresar de la subrutina

// Subrutina para leer palabras desde un archivo
leer_palabras:
    // Abrir el archivo
    ldr r0, =archivo_nombre                 // Nombre del archivo
    mov r1, #0                              // Opción de apertura (O_RDONLY)
    mov r7, #5                              // syscall para sys_open
    svc #0                                   // Llamada al sistema
    mov r4, r0                              // Guardar el descriptor de archivo

    // Leer las palabras
    ldr r1, =palabras_buffer                // Buffer para almacenar las palabras
    mov r2, #256                            // Leer hasta 256 bytes
leer_linea:
    mov r7, #3                              // syscall para sys_read
    svc #0                                   // Llamada al sistema
    cmp r0, #0                              // Comprobar si se llegó al final del archivo
    beq fin_leer                            // Si r0 es 0, terminar la lectura

    // Contar la cantidad de palabras
    ldr r5, =palabras_count                 // Cargar dirección de palabras_count
    ldr r6, [r5]                            // Cargar el contador actual
    add r6, r6, #1                          // Incrementar contador
    str r6, [r5]                            // Almacenar el nuevo contador
    
    // Aquí puedes agregar lógica para manejar las palabras leídas (ej. saltar líneas)
    
    b leer_linea                            // Volver a leer la siguiente línea

fin_leer:
    // Cerrar el archivo
    mov r7, #6                              // syscall para sys_close
    mov r0, r4                              // Usar el descriptor de archivo guardado
    svc #0                                   // Llamada al sistema
    bx lr                                   // Regresar de la subrutina

// Subrutina para sortear una palabra de la lista
sortear_palabra:
    ldr r5, =palabras_count                 // Cargar dirección de palabras_count
    ldr r0, [r5]                            // Cargar el número de palabras
    cmp r0, #0                              // Comprobar si hay palabras
    beq no_palabras                         // Si no hay palabras, ir a no_palabras

    // Generar un número aleatorio
    bl generar_numero_aleatorio             // Llamar a la subrutina para generar un número aleatorio
    mov r1, r0                              // r1 contendrá el índice aleatorio

    // Calcular la dirección de la palabra aleatoria
    ldr r2, =palabras_buffer                // Dirección base del buffer de palabras
    
    // Usar un registro temporal para la multiplicación
    mov r3, r1                              // Copiar el índice aleatorio a r3
    lsl r3, r3, #4                          // Multiplicar por 16 (5 letras + 1 terminador)

    add r2, r2, r3                          // Sumar el índice a la dirección base
    ldr r3, =palabra_elegida                // Dirección del buffer de la palabra elegida
    ldr r4, =5                              // Longitud de la palabra (5 letras)
    bl copiar_palabra                        // Llamar a la subrutina para copiar la palabra

no_palabras:
    bx lr                                   // Regresar de la subrutina

// Subrutina para copiar la palabra elegida al buffer
copiar_palabra:
    mov r5, #0                              // Inicializar contador
copia_loop:
    ldrb r6, [r2, r5]                       // Cargar un byte de la palabra sorteada
    strb r6, [r3, r5]                       // Almacenar el byte en el buffer de la palabra elegida
    add r5, r5, #1                          // Incrementar el contador
    cmp r5, r4                              // Comparar con la longitud de la palabra
    blt copia_loop                          // Continuar mientras no se haya copiado toda la palabra
    mov r6, #0                              // Agregar terminador nulo
    strb r6, [r3, r5]                       // Agregar el terminador nulo al final
    bx lr                                   // Regresar de la subrutina

// Subrutina para generar un número aleatorio
generar_numero_aleatorio:
    // Implementación simple para generar un número aleatorio
    // Por simplicidad, puedes usar un valor fijo o una lógica simple
    mov r0, #0                              // Número de palabras
    bx lr                                   // Regresar de la subrutina


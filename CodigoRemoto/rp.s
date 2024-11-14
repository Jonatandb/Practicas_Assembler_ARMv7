.section .data
bienvenida: .asciz "BIENVENIDO A WORDLE\n\n"         
len_bienvenida: .int 20                             
longitud_palabra: .asciz "LA PALABRA TIENE 5 LETRAS\n\n" 
len_longitud_palabra: .int 28                        
nombre_prompt: .asciz "Introduce tu nombre: "        
len_nombre_prompt: .int 24                            
nombre_buffer: .int 50                              
archivo_nombre: .asciz "palabras.txt"                // Nombre del archivo
palabras_buffer: .int 256                            // Buffer para almacenar las palabras leídas (256 bytes)

.section .text
.global main

main:
    // Imprimir "BIENVENIDO A WORDLE"
    mov r0, #1                             
    ldr r1, =bienvenida                    
    ldr r2, =len_bienvenida                
    ldr r2, [r2]                           
    bl imprimir_mensaje                    

    // Imprimir "LA PALABRA TIENE X LETRAS"
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
    mov r2, #50                             // Leer hasta 50 caracteres
    mov r7, #3                              // syscall para sys_read
    svc #0                                   // Llamada al sistema

    // Leer palabras del archivo
    bl leer_palabras                         // Llamar a la subrutina para leer palabras

    // Salir del programa
    mov r7, #1                             
    mov r0, #0                             
    svc #0                                 

// Subrutina para imprimir un mensaje
imprimir_mensaje:
    mov r7, #4                             
    svc #0                                 
    bx lr                                  

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

    // Procesar la línea leída (aquí puedes agregar lógica para manejar las palabras)
    
    b leer_linea                            // Volver a leer la siguiente línea

fin_leer:
    // Cerrar el archivo
    mov r7, #6                              // syscall para sys_close
    mov r0, r4                              // Usar el descriptor de archivo guardado
    svc #0                                   // Llamada al sistema
    bx lr                                   // Regresar de la subrutina


.global main

.data
  rojo:   .asciz "\033[31m"    // Secuencia para color rojo
  verde:  .asciz "\033[32m"    // Secuencia para color verde
  magenta:   .asciz "\033[35m"    // Secuencia para color magenta
  amarillo: .asciz "\033[33m"  // Secuencia para color amarillo
  blanco:  .asciz "\033[0m"     // Secuencia para restablecer color
  texto:  .asciz "Hola\n"      // Texto que queremos imprimir

.text

  // Escribe en pantalla lo que esté en la dirección seteada con ldr a r1
  // con la longitud de caracteres especificada en r2
  // Ej:
  //  ldr r1, =texto_rojo
  //  mov r2, #6
  escribir:
    mov r0, #1             // Descriptor de archivo (stdout)
    mov r7, #4             // syscall número 4: Escribir
    swi 0
    bx lr

  // Escribe en pantalla el texto especificado con ldr en r1
  // con la longitud especificada en r2
  // usando el color especificado en r3, ej:
  //     ldr r1, =texto1        // Cargar el texto a mostrar
  //     ldr r2, =largo_texto1  // Longitud del texto
  //         alternativa:  mov r2, #1
  //     ldr r3, =color_rojo    // Color
  //     bl escribir_en_color
  escribir_en_color:
    push {r1, r2, lr}      // Guarda lo que hay que imprimir, su longitud y lr, en la pila
    mov r1, r3             // Cargar la secuencia para el color
    mov r2, #6             // Longitud de la secuencia de color
    bl escribir

    pop {r1, r2}           // Restaura lo que hay que imprimir y su longitud, desde la pila
    bl escribir

    ldr r1, =blanco        // Cargar la secuencia para restablecer el color a blanco
    mov r2, #4             // Longitud de la secuencia de blanco
    bl escribir
    pop {lr}
    bx lr

main:
  // Imprimir la "H" en rojo
  ldr r1, =texto       // Cargar el texto (primer carácter "H")
  mov r2, #1           // Longitud de la "H" (1 byte)
  ldr r3, =rojo
  bl escribir_en_color

  // Imprimir la "o" en verde
  ldr r1, =texto + 1   // Cargar el texto (segundo carácter "o")
  mov r2, #1           // Longitud (1 byte)
  ldr r3, =verde
  bl escribir_en_color

  // Imprimir la "l" en magenta
  ldr r1, =texto + 2   // Cargar el texto (tercer carácter "l")
  mov r2, #1           // Longitud (1 byte)
  ldr r3, =magenta
  bl escribir_en_color

  // Imprimir la "a" en amarillo
  ldr r1, =texto + 3   // Cargar el texto (cuarto carácter "a")
  mov r2, #2           // Longitud de la "a" (1 byte) + longitud del "\n" (1 byte)
  ldr r3, =amarillo
  bl escribir_en_color

  // Fin del programa
  mov r0, #0           // Código de salida
  mov r7, #1           // syscall número 1 (salir)
  swi 0

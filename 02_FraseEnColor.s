.global main

.data
  color_rojo:  .asciz "\033[31m"
  color_verde: .asciz "\033[32m"
  color_blanco: .asciz "\033[0m"    // Secuencia para restablecer color
  texto1:  .asciz "Este texto aparece en color rojo\n"    // Almacena el texto (terminado en null)
  largo_texto1 =.- texto1
  texto2: .asciz "Este texto aparece en color verde\n"   // Almacena el texto (terminado en null)
  largo_texto2 =.- texto2

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
  //     ldr r3, =color_rojo    // Color
  //     bl escribir_en_color
  escribir_en_color:
    push {r1, r2, lr}      // Guarda lo que hay que imprimir, su longitud y lr, en la pila
    mov r1, r3             // Cargar la secuencia para el color
    mov r2, #6             // Longitud de la secuencia de color
    bl escribir

    pop {r1, r2}           // Restaura lo que hay que imprimir y su longitud, desde la pila
    bl escribir

    ldr r1, =color_blanco  // Cargar la secuencia para restablecer el color a blanco
    mov r2, #4             // Longitud de la secuencia de color_blanco
    bl escribir
    pop {lr}
    bx lr


  main:
    // Imprimir texto en rojo
    ldr r1, =texto1        // Cargar el texto a mostrar
    ldr r2, =largo_texto1  // Longitud del texto
    ldr r3, =color_rojo    // Color
    bl escribir_en_color

    // Imprimir texto en verde
    ldr r1, =texto2        // Cargar el texto a mostrar
    ldr r2, =largo_texto2  // Longitud del texto
    ldr r3, =color_verde   // Color
    bl escribir_en_color

    // Fin del programa
    mov r0, #0             // Código de salida 0 (Ejecución OK)
    mov r7, #1             // syscall número 1 (salir)
    swi 0

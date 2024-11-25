.global main

.data
  color_rojo:  .asciz "\033[31m"
  color_verde: .asciz "\033[32m"
  color_blanco: .asciz "\033[0m"    // Secuencia para restablecer color
  textorojo:  .asciz "Este texto aparece en color rojo\n"    // Almacena el texto (terminado en null)
  largo_textorojo =.- textorojo
  textoverde: .asciz "Este texto aparece en color verde\n"   // Almacena el texto (terminado en null)
  largo_textoverde =.- textoverde

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

  escribir_rojo:
    push {r1, r2, lr}      // Guarda lo que hay que imprimir, su longitud y lr en la pila
    ldr r1, =color_rojo    // Cargar la secuencia para color rojo
    mov r2, #6             // Longitud de la secuencia de color
    bl escribir

    pop {r1, r2}           // Restaura lo que hay que imprimir y su longitud desde la pila
    bl escribir

    ldr r1, =color_blanco  // Cargar la secuencia para restablecer el color
    mov r2, #4             // Longitud de la secuencia de color_blanco
    bl escribir
    pop {lr}
    bx lr

  escribir_verde:
    push {r1, r2, lr}      // Guarda lo que hay que imprimir, su longitud y lr en la pila
    ldr r1, =color_verde   // Cargar la secuencia para color verde
    mov r2, #6             // Longitud de la secuencia de color
    bl escribir

    pop {r1, r2}           // Restaura lo que hay que imprimir y su longitud desde la pila
    bl escribir

    ldr r1, =color_blanco  // Cargar la secuencia para restablecer el color
    mov r2, #4             // Longitud de la secuencia de color_blanco
    bl escribir
    pop {lr}
    bx lr


  main:
    // Imprimir texto en rojo
    ldr r1, =textorojo       // Cargar el texto a mostrar en rojo
    ldr r2, =largo_textorojo // Longitud del texto
    bl escribir_rojo

    // Imprimir texto en verde
    ldr r1, =textoverde       // Cargar el texto a mostrar en verde
    ldr r2, =largo_textoverde // Longitud del texto
    bl escribir_verde

    // Fin del programa
    mov r0, #0             // Código de salida 0 (Ejecución OK)
    mov r7, #1             // syscall número 1 (salir)
    swi 0

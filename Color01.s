.data
  rojo:  .asciz "\033[31m"
  verde: .asciz "\033[32m"
  reset: .asciz "\033[0m"  // Secuencia para restablecer color
  textorojo:  .asciz "Este texto aparece en color rojo\n"
  textoverde: .asciz "Este texto aparece en color verde\n"

.text
.global main

main:
  // Imprimir texto en rojo
  ldr r1, =rojo          // Cargar la secuencia para color rojo
  mov r2, #6             // Longitud de la secuencia de color
  mov r0, #1             // Descriptor de archivo (stdout)
  mov r7, #4             // syscall número 4 (escribir)
  swi 0

  ldr r1, =textorojo     // Cargar el texto en rojo
  mov r2, #33            // Longitud del texto
  mov r0, #1             // Descriptor de archivo (stdout)
  mov r7, #4             // syscall número 4 (escribir)
  swi 0

  ldr r1, =reset         // Cargar la secuencia para restablecer el color
  mov r2, #4             // Longitud de la secuencia de reset
  mov r0, #1             // Descriptor de archivo (stdout)
  mov r7, #4             // syscall número 4 (escribir)
  swi 0

  // Imprimir texto en verde
  ldr r1, =verde         // Cargar la secuencia para color verde
  mov r2, #6             // Longitud de la secuencia de color
  mov r0, #1             // Descriptor de archivo (stdout)
  mov r7, #4             // syscall número 4 (escribir)
  swi 0

  ldr r1, =textoverde    // Cargar el texto en verde
  mov r2, #34            // Longitud del texto
  mov r0, #1             // Descriptor de archivo (stdout)
  mov r7, #4             // syscall número 4 (escribir)
  swi 0

  ldr r1, =reset         // Cargar la secuencia para restablecer el color
  mov r2, #4             // Longitud de la secuencia de reset
  mov r0, #1             // Descriptor de archivo (stdout)
  mov r7, #4             // syscall número 4 (escribir)
  swi 0

  // Fin del programa
  mov r0, #0             // Código de salida
  mov r7, #1             // syscall número 1 (salir)
  swi 0

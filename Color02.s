.data
  rojo:   .asciz "\033[31m"    // Secuencia para color rojo
  verde:  .asciz "\033[32m"    // Secuencia para color verde
  magenta:   .asciz "\033[35m"    // Secuencia para color magenta
  amarillo: .asciz "\033[33m"  // Secuencia para color amarillo
  reset:  .asciz "\033[0m"     // Secuencia para restablecer color
  texto:  .asciz "Hola\n"      // Texto que queremos imprimir

.text
.global main

main:
  // Imprimir la "H" en rojo
  ldr r1, =rojo        // Cargar la secuencia para color rojo
  mov r2, #6           // Longitud de la secuencia de color (6 bytes)
  mov r0, #1           // Descriptor de archivo (stdout)
  mov r7, #4           // syscall número 4 (escribir)
  swi 0

  ldr r1, =texto       // Cargar el texto (primer carácter "H")
  mov r2, #1           // Longitud de la "H" (1 byte)
  mov r0, #1           // Descriptor de archivo (stdout)
  mov r7, #4           // syscall número 4 (escribir)
  swi 0

  ldr r1, =reset       // Restablecer color
  mov r2, #4           // Longitud de la secuencia de reset (4 bytes)
  mov r0, #1           // Descriptor de archivo (stdout)
  mov r7, #4           // syscall número 4 (escribir)
  swi 0

  // Imprimir la "o" en verde
  ldr r1, =verde       // Cargar la secuencia para color verde
  mov r2, #6           // Longitud de la secuencia de color (6 bytes)
  mov r0, #1           // Descriptor de archivo (stdout)
  mov r7, #4           // syscall número 4 (escribir)
  swi 0

  ldr r1, =texto + 1   // Cargar el texto (segundo carácter "o")
  mov r2, #1           // Longitud de la "o" (1 byte)
  mov r0, #1           // Descriptor de archivo (stdout)
  mov r7, #4           // syscall número 4 (escribir)
  swi 0

  ldr r1, =reset       // Restablecer color
  mov r2, #4           // Longitud de la secuencia de reset (4 bytes)
  mov r0, #1           // Descriptor de archivo (stdout)
  mov r7, #4           // syscall número 4 (escribir)
  swi 0

  // Imprimir la "l" en magenta
  ldr r1, =magenta        // Cargar la secuencia para color magenta
  mov r2, #6           // Longitud de la secuencia de color (6 bytes)
  mov r0, #1           // Descriptor de archivo (stdout)
  mov r7, #4           // syscall número 4 (escribir)
  swi 0

  ldr r1, =texto + 2   // Cargar el texto (tercer carácter "l")
  mov r2, #1           // Longitud de la "l" (1 byte)
  mov r0, #1           // Descriptor de archivo (stdout)
  mov r7, #4           // syscall número 4 (escribir)
  swi 0

  ldr r1, =reset       // Restablecer color
  mov r2, #4           // Longitud de la secuencia de reset (4 bytes)
  mov r0, #1           // Descriptor de archivo (stdout)
  mov r7, #4           // syscall número 4 (escribir)
  swi 0

  // Imprimir la "a" en amarillo
  ldr r1, =amarillo    // Cargar la secuencia para color amarillo
  mov r2, #6           // Longitud de la secuencia de color (6 bytes)
  mov r0, #1           // Descriptor de archivo (stdout)
  mov r7, #4           // syscall número 4 (escribir)
  swi 0

  ldr r1, =texto + 3   // Cargar el texto (cuarto carácter "a")
  mov r2, #2           // Longitud de la "a" (1 byte) + longitud del "\n" (1 byte)
  mov r0, #1           // Descriptor de archivo (stdout)
  mov r7, #4           // syscall número 4 (escribir)
  swi 0

  ldr r1, =reset       // Restablecer color
  mov r2, #4           // Longitud de la secuencia de reset (4 bytes)
  mov r0, #1           // Descriptor de archivo (stdout)
  mov r7, #4           // syscall número 4 (escribir)
  swi 0

  // Fin del programa
  mov r0, #0           // Código de salida
  mov r7, #1           // syscall número 1 (salir)
  swi 0

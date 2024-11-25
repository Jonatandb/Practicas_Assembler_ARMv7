.global main      // "main" será el punto de entrada

.data             // Definición de "variables"
  cadena: .asciz "Hola Mundo!\n"

.text             // Comienza el código ejecutable (rutinas)
main:
  ldr r1, =cadena // En r1 va la dir. de la cadena a mostrar
  mov r2, #12     // En r2 la longitud de la cadena
  mov r0, #1      // Descriptor de archivo (stdout)
  mov r7, #4      // syscall número 4: Escribir
  swi 0           // swi: Software Interruption

fin:
  mov r0, #0      // "Resultado" de ejecución del programa, cero -> OK
  mov r7, #1      // syscall número 7: Fin del programa
  swi 0           // swi: Software Interruption

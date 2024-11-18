# Mis notas sobre Assembler

Compilación y enlazado:
-----------------------
  Generación de un ejecutable

    Compilación:  as -g -o archivo.o archivo.s
    Enlazado:     gcc -o archivo archivo.o
                    * archivo seré el ejecutable, ejecutable mediante:
                      ./archivo


Registros
---------
Al usar los registros de manera eficiente, se puede minimizar la necesidad de acceder a la memoria principal,
  lo que a su vez mejora considerablemente la velocidad y eficiencia del programa.
    Son ubicaciones de memoria de alta velocidad utilizadas para almacenar temporalmente datos
      y realizar operaciones en ellos.
  Estos registros son áreas de memoria muy rápidas que se encuentran dentro del procesador.

PC  Promgram Counter
  El registro del contador de programa (PC) se utiliza para almacenar la dirección de la siguiente instrucción que se ejecutará.

LR  Link Counter
  El registro de enlace (LR) se utiliza para almacenar la dirección de retorno de una llamada a una función.

El nivel más cercano al procesador es la memoria caché. (La más rápida)
El siguiente nivel en la jerarquía de memoria es la memoria principal o RAM.
Más allá de la memoria principal, se encuentra el almacenamiento secundario. (HD, SSD, SDCard)


Estructuras de control
----------------------
  La más común, es la condicional (If):
    CMP, para comparar valores
          luego, dependiendo del resultado, se salta a una parte del código utilizando
          las instrucciones BEQ, BNE, BGT

  El bucle, en assembler se usan B, BL, BLT entre otras, junto con las instrucciones de
    comparación CMP, para crear bucles en nuestros programas.

  Otras estructuras de control:
    B instrucción de salto incondicional, permite saltar a cualquier parte del código
        sin necesidad de cumplir una condición.

    BL y BLX: instrucciones de llamada a subrutina, permiten llamar a una subrutina
                y luego retornar al punto de partida.


Manipulación de datos
---------------------
  MOV:  Asignar un valor a un registro específico:
          MOV r0, #1
            r0 es el nombre del registro
            #1 es el valor que se desea asignar, # se utiliza para indicar un valor inmediato

  ADD:  Se utiliza para sumar dos valores, y el resultado se almacena en un registro específico (opcional, si no se especifica se incrementa el primer registro):
          MOV r0, #1
          ADD r1, #5
          ADD r2, r0, r1   // Sumar los valores de r0 y r1 y guardar el resultado en r2


Carga y almacenamiento de datos desde/hacia la memoria
------------------------------------------------------
  Transferir los datos entre la memoria y los registros:

    STR   (store register, store word)  Guarda en memoria un valor tomado de un registro

    LDR   (load register, load word)   Guarda en un registro un valor tomado de la memoria
      Ejemplo:  ldr r0, =5   // Cargar el valor 5 en el registro r0



Links investigados
------------------
- https://elblogdelprogramador.com/posts/aprende-programacion-en-lenguaje-assembly-con-arm-practica-y-ejemplos/#gsc.tab=0
- https://kevinboone.me/pi-asm-toc.html
  - https://github.com/kevinboone/pi-asm
- https://azeria-labs.com/arm-data-types-and-registers-part-2/
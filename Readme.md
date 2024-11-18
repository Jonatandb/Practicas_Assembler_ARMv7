# Mis notas sobre Assembler

### Compilación y enlazado:
Generación de un ejecutable
  - Compilación:  ```as -g -o archivo.o archivo.s```
  - Enlazado:     ```gcc -o archivo_binario archivo.o``` (* *archivo_binario* será el ejecutable, ejecutable mediante:```./archivo_binario```)

---
### Registros
Al usar los registros de manera eficiente, se puede minimizar la necesidad de acceder a la memoria principal, lo que a su vez mejora considerablemente la velocidad y eficiencia del programa. Son ubicaciones de memoria de alta velocidad utilizadas para almacenar temporalmente datos
      y realizar operaciones en ellos.
  Estos registros son áreas de memoria muy rápidas que se encuentran dentro del procesador.

PC  Promgram Counter
  El registro del contador de programa (PC) se utiliza para almacenar la dirección de la siguiente instrucción que se ejecutará.

LR  Link Counter
  El registro de enlace (LR) se utiliza para almacenar la dirección de retorno de una llamada a una función.

El nivel más cercano al procesador es la memoria caché. (La más rápida)
El siguiente nivel en la jerarquía de memoria es la memoria principal o RAM.
Más allá de la memoria principal, se encuentra el almacenamiento secundario. (HD, SSD, SDCard)


---
### Estructuras de control
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


---
### Manipulación de datos
  MOV:  Asignar un valor a un registro específico:
          MOV r0, #1
            r0 es el nombre del registro
            #1 es el valor que se desea asignar, # se utiliza para indicar un valor inmediato

  ADD:  Se utiliza para sumar dos valores, y el resultado se almacena en un registro específico (opcional, si no se especifica se incrementa el primer registro):
          MOV r0, #1
          ADD r1, #5
          ADD r2, r0, r1   // Sumar los valores de r0 y r1 y guardar el resultado en r2


---
### Carga y almacenamiento de datos desde y hacia la memoria
En ARM, los datos deben trasladarse de la memoria a los registros antes de ser operados.
  - Transferir los datos entre la memoria y los registros:
      - STR   (store register, store word)  Guarda en memoria un valor tomado de un registro
      - LDR   (load register, load word)   Guarda en un registro un valor tomado de la memoria
          - Ejemplos:
            - ```ldr r0, =5```     // Cargar el valor 5 en el registro r0
            - ```ldr r2, [r1]``` // Los corchetes ([ ]) significan: el valor que se encuentra en el registro entre estos corchetes es una dirección de memoria desde la que queremos cargar algo.


---
### Rutinas (funciones) y subrutinas (rutinas que se llaman desde otras rutinas)
Pasaje de parámetros y return de valores
- No hay una forma explícita de pasar parámetros a una subrutina o devolver valores desde una subrutina, como se hace en lenguajes de alto nivel. En lugar de eso, se utilizan los registros y la pila para pasar parámetros y devolver valores.

- AAPCS es la convención de llamada a procedimientos de la arquitectura ARM (ARM Architecture Procedure Call Standard). Esta convención de llamada se utiliza en ARMv7 para definir cómo se deben pasar los argumentos a una función, cómo se deben retornar los valores y cómo se deben manejar los registros.

Convención de llamada:
- La convención de llamada en ARMv7 es la siguiente:
  - La función llamante debe pasar los argumentos en los registros r0-r3 y en la pila si es necesario.
  - La función llamada debe salvar los registros r4-r11 si los utiliza.
  - La función llamada debe restaurar los registros r4-r11 antes de retornar.
  - La función llamada debe devolver el valor de retorno en el registro r0.

Manejar los registros
- En la convención AAPCS, los registros se manejan de la siguiente manera:

  - r0-r3: registros de argumentos y valor de retorno, se utilizan para pasar argumentos y devolver valores.
  - r4-r11: registros de propósito general, se utilizan para almacenar variables locales y temporales.
  - r12: se utiliza como registro de pila (SP).
  - r13: se utiliza como registro de enlace (LR).
  - r14: se utiliza como registro de contador de programa (PC).
  - r15: se utiliza como registro de estado (CPSR)

Pasar parámetros a una subrutina:
- Los parámetros se pasan a una subrutina utilizando los registros. Los primeros cuatro parámetros se pasan en los registros r0, r1, r2 y r3. Los parámetros adicionales se pasan en la pila.
  - Ejemplo:
    ```assembly
    mov r0, #10      // pasa el primer parámetro en r0
    mov r1, #20      // pasa el segundo parámetro en r1
    bl mi_subrutina  // llama a la subrutina
    ```

Devolver valores desde una subrutina:
- Los valores se devuelven desde una subrutina utilizando los registros.  El valor de retorno se coloca en el registro r0.
  - Ejemplo:
    ```assembly
    mi_subrutina:
      ...           // código de la subrutina
      mov r0, #30   // "devuelve" el valor en r0
      bx lr         // retorna a la rutina principal
    ```
    La instrucción ```bx lr``` es una forma de saltar a la dirección de retorno que se encuentra en el registro ```lr```. El registro ```lr``` se utiliza para almacenar la dirección de retorno cuando se llama a una subrutina.

---
### Links investigados
- https://elblogdelprogramador.com/posts/aprende-programacion-en-lenguaje-assembly-con-arm-practica-y-ejemplos/#gsc.tab=0
- https://kevinboone.me/pi-asm-toc.html
  - https://github.com/kevinboone/pi-asm
- https://azeria-labs.com/arm-data-types-and-registers-part-2/
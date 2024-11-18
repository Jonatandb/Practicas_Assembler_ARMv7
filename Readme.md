# Mis notas sobre Assembler

---
### Compilación, enlazado y ejecución:
Generación de un ejecutable:
  - 1 - Compilación:  `as -g -o archivo.o archivo.s`
    - `archivo.s` será el código fuente en Assembler.
    - `archivo.o` será el archivo objeto que se generará (a utilizar para crear el binaro).
  - 2 - Enlazado:     `gcc -o archivo_binario archivo.o`
    - `archivo_binario` será el ejecutable.

Ejecución de un archivo binario:
  - 3- `./archivo_binaro`

---
### Debuggeando con gdb:

  `gdb archivo_binario`

  - Comandos gdb:
    - `start`: Para iniciar el debugging
    - `s`: Para avanzar linea a linea (step). Presionando enter ejecuta una linea a la vez.
    - `q`: Para salir, (o quit).
    - `x`: Se usa para inspeccionar una dirección de memoria
      - Uso:
        - `x 0x0002102c`   			Muestra que valor hay en dicha dirección de memoria.
        - `x /d 0x0002102c`   		Muestra el valor en formato decimal.
        - `x /d $r1`						También se le puede pasar un registro.
    - `r`: se usa para reiniciar el debugging, por lo que hay que ingresar start y s nuevamente.
    - `b 8`: Para poner un breakpoint en línea 8.
    - `run`: Para ejecutar todo el programa (se frena si se establecieró algún breakpoint).
    - `print /d $r0`: Muestra en formato decimal (gracias al /d, que se puede omitir) el contenido del registro `r0`.
    - `info registers`: Muestra todos los registros
    - `info registers r0 r1`: Muestra el valor de los registros `r0` y `r1`.
    - `help`: Muestra ayuda sobre como usar muchísimos más comandos de gdb, ej:
      - `help x`

  - Si se cuelga o falla gdb, se puede salir con `Ctrl+d`

    Más sobre gdb:
				https://azeria-labs.com/debugging-with-gdb-introduction/
---
### Registros


Jerarquía de memoria

- Banco de registros (registros R0, R1, etc.)
- Memoria caché
- Memoria principal (RAM)
- Almacenamiento secundario (HD, SSD, SDCard, etc)

El banco de registros es un conjunto de memoria de alta velocidad que se utiliza para almacenar datos y resultados temporales durante la ejecución de instrucciones. Los registros R0, R1, etc. son parte de este banco de registros y se utilizan para almacenar datos y resultados de las operaciones aritméticas y lógicas.

En términos de la jerarquía de memoria, el banco de registros se encuentra en el nivel más cercano al procesador, por encima de la memoria caché. La memoria caché se utiliza para almacenar datos y instrucciones que se utilizan con frecuencia, mientras que el banco de registros se utiliza para almacenar datos y resultados temporales durante la ejecución de instrucciones.

Al usar los registros de manera eficiente, se puede minimizar la necesidad de acceder a la memoria principal, lo que a su vez mejora considerablemente la velocidad y eficiencia del programa. _Estos registros son áreas de memoria muy rápidas que se encuentran dentro del procesador._

`PC`  Promgram Counter
  - El registro del contador de programa (PC) se utiliza para almacenar la dirección de la siguiente instrucción que se ejecutará.
  - El PC se incrementa automáticamente después de cada instrucción para apuntar a la siguiente instrucción.

`LR`  Link Counter
  - El registro de enlace (LR) se utiliza para almacenar la dirección de retorno de una llamada a una función.
  - Cuando se llama a una función, el valor actual del PC se almacena en el registro LR.
  - Cuando la función termina, el valor del LR se restaura en el PC para que la ejecución continúe desde la instrucción siguiente a la llamada a la función.

`SP` (Stack Pointer)
  - El registro SP se utiliza para almacenar la dirección de la pila de llamadas.
  - La pila de llamadas es un área de memoria que se utiliza para almacenar los parámetros y variables locales de las funciones.
  - El SP se utiliza para acceder a los elementos de la pila de llamadas.

`R0-R12` (Registros de propósito general)
  - Estos registros se utilizan para almacenar datos y resultados temporales durante la ejecución de instrucciones.
  - Los registros R0-R12 son de 32 bits y se pueden utilizar para realizar operaciones aritméticas y lógicas.

---
### Estructuras de control
  La más común, es la condicional (If):
    CMP, para comparar valores
          luego, dependiendo del resultado, se salta a una parte del código utilizando
          las instrucciones BEQ, BNE, BGT

  El bucle, en assembler se usan B, BL, BLT entre otras, junto con las instrucciones de
    comparación CMP, para crear bucles en nuestros programas.

  Otras estructuras de control:
  - B instrucción de salto incondicional, permite saltar a cualquier parte del código sin necesidad de cumplir una condición.
  - BL y BLX: instrucciones de llamada a subrutina, permiten llamar a una subrutina y luego retornar al punto de partida.


---
### Manipulación de datos
  MOV:
  - Asignar un valor a un registro específico:
    - `MOV r0, #1` // Guarda el 1 en r1
      - `r0` es el nombre del "registro destino".
      - `#1` es el valor que se desea asignar (`#` se utiliza para indicar un valor "inmediato").

  ADD:
  - Se utiliza para sumar dos valores. El resultado se almacena en un registro específico (opcional: si no se especifica se incrementa el primer registro):
    - Suma usando registros:
      - `ADD r0, r1, r2`  // Deja la suma de los valores de `r1` y `r2`, en `r0`.
      - `ADD r0, r1`  // Si se especifica solo dos operandos el resultado queda en el primer registro (registro destino).

    - Suma usando valor inmediato:
      - `ADD r0, #5` // Deja la suma en `r0`.

  SUB:
  - Se utiliza igual que ADD, solo hay que recordar que:
    - Cuando se le pasan 2 registros:
      - Restará al registro de la izquiera el valor de la derecha:
        - `SUB r0, #1` Al valor en `r0` le restará 1, y dejará el resultado en `r0`.
    - Cuando se le pasan 3 registros:
      - Restará al segundo registro, el valor en el tercero:
        - `SUB r0, r1, #1` Al valor en `r1` le restará 1, y dejará el resultado en `r0`.

  MUL:
  - Sirve para multiplicar, y se utiliza igual que ADD.

  UDIV y SDIV:
  - Sirven para dividir, y se utiliza igual que ADD.
  - UDIV sirve para dividir operandos _sin_ signo.
  - SDIV divide aunque ninguno, uno, o ambos de los operandos tenga signo.

    Por qué _no_ usar SDIV siempre:
    - Aunque SDIV puede manejar operandos con y sin signo, UDIV es una operación más simple que solo se preocupa por dividir números enteros sin signo, lo que la hace más rápida y eficiente.

---
### Carga y almacenamiento de datos desde y hacia la memoria
En ARM, los datos deben trasladarse de la memoria a los registros antes de ser operados.
  - Transferir los datos entre la memoria y los registros:
      - LDR   (load register, load word)   Guarda en un registro un valor tomado de la memoria
          - Ejemplos:
            - `ldr r1, =mensaje1` Carga en `r1` la dirección de memoria de `mensaje1`.
            - `ldr r2, [r1]` Con el uso de los corchetes [ ], carga en `r2` el valor almacenado en la dirección de memoria almacenada en `r1`.
            - También se puede ejecutar: `ldr r0, =5` Carga el valor 5 en el registro `r0` (Aunque en realidad se ejecutará `mov r0, #5`)

      - STR   (store register, store word)  Guarda en memoria un valor tomado de un registro
        - Ejemplo:
          - `ldr r3, =sum` Almacena en `r3` la dirección de memoria de `sum`.
          - `str r0, [r3]` Guarda en la dirección de memoria apuntada por `r3` el valor guardado en el registro `r0`.


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
### Sitios investigados
- https://elblogdelprogramador.com/posts/aprende-programacion-en-lenguaje-assembly-con-arm-practica-y-ejemplos/#gsc.tab=0
- https://kevinboone.me/pi-asm-toc.html
  - https://github.com/kevinboone/pi-asm
- https://azeria-labs.com/arm-data-types-and-registers-part-2/
- Curso ARM desde 0: https://www.youtube.com/playlist?list=PLqsewl9xsOjZoZ_0HeQxJ3w0vvTuQaa72
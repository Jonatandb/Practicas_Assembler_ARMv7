/*

Wordle es un juego de adivinanzas en el que un jugador debe descubrir una palabra oculta en un número limitado
de intentos (5). A medida que el jugador ingresa palabras, el juego proporciona pistas indicando qué letras están
en la palabra oculta (en verde) y si están en la posición correcta (amarillo y rojo).

      El programa deberá obtener un listado de palabras de un archivo externo,
        y eligirá una palabra aleatoriamente para cada partida.

      Luego se deberá informar al jugador cuantas letras contiene la palabra que debe adivinar.

      Paso seguido, se solicitará al jugador una palabra que tenga la cantidad de letras especificadas.
        Esto se repetirá hasta que el jugador adivine la palabra o en su defecto,
          que se hayan terminado los intentos (5).

      Por cada palabra que ingrese el usuario se debe verificar si las letras son correctas y
        estan en su posición, esto se mostrara pintando cada letra de un color distinto dependiendo
        de su condición:
          Verde:    la letra aparece en la palabra y está en la posición correcta.
          Amarillo: la letra aparece en la palabra pero no esta en la posición correcta.
          Rojo:     la letra no aparece en la palabra.

      Si se adivina la palabra antes de perder todos los intentos, se informará al usuario la
        cantidad de puntos obtenidos:
            "¡Felicitaciones has, ganado!"
            "Tu puntaje obtenido es: ##"
            "Ingresa tu nombre:"
          Los puntos se calcularan multiplicando la cantidad de intentos restantes por la cantidad
            de letras que tenía la palabra.
              Ejemplo: si el jugador acertó una palabra de 5 letras en el primer intento
                        obtendrá 25 puntos, en caso de que lo hizo en el último intento
                        solo obtendrá 5 puntos.

      A continuación, el programa deberá abrir el archivo que contiene los últimos 3 jugadores
        y escribirá en el mismo el nombre del jugador con los puntos obtenidos.
        Luego mostrará el ranking con los 3 últimos jugadores en pantalla:
          "Ranking:"
          "usuario1 ## puntos"
          "usuario2 ## puntos"
          "usuario3 ## puntos"

      En caso de que luego de 5 intentos el jugador no adivine la palabra, se deberá informar
        que el juego terminó y dar la opción de volver a jugar:
          "¡Se acabaron los intentos, perdiste!"
          "Ingresa 'j' para volver a jugar, o 't' para terminar:"

        Si el jugador acepta se deberá volver a elegir una palabra al azar y comenzar nuevamente,
          en caso contrario el programa debe terminar.


Incluir al menos las siguientes rutinas principales, se pueden agregar más de ser necesario:

	leer_palabras 								Leer palabras del archivo .txt y guardarlas en una lista.
	sortear_palabra 							Elige una palabra al azar de la lista de palabras en memoria.
	calcular_letras 							Cuenta la cantidad de letras que tiene la palabra.

	Verificar_intentos 						Verifica la cantidad de intentos restantes.

	leer_palabra 									Lee la palabra ingresada por el usuario

	Verificar_letras_verdes 			Verifica las letras que son correctas.
	Verificar_letras_amarillas 		Verifica las letras que aparecen en la palabra pero están	en posición incorrecta.

	Informar_resultado 						Informa por pantalla el resultado de la palabra ingresada,
																	mostrando las letras con el color que le corresponde.

	Calcular_puntos 							Calcula la cantidad de puntos obtenidos.
																	Los puntos se calcularan multiplicando la cantidad de intentos restantes
																	por la cantidad de letras que tenía la palabra.
																	Ejemplo: si el jugador acertó una palabra de 5 letras en el primer
																						intento obtendrá 25 puntos, en caso de que lo hizo en el
																						último intento solo obtendrá 5 puntos.

	Pedir_nombre 									Solicita el nombre al usuario para luego guardarlo en el ranking.

	Grabar_ranking 								Graba en el archivo .txt el nombre del usuario con los puntos obtenidos
	Mostrar_ranking 							Muestra el ranking de los últimos 3 jugadores.

	* En caso de que luego de 5 intentos el jugador no adivine la palabra, se deberá informar que el juego terminó
		y dar la opción de volver a jugar.
	Si el jugador acepta se deberá volver a elegir una palabra al azar y comenzar nuevamente, en caso contrario
	el programa debe terminar.

*/

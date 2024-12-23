.data
errorArchivo: .asciz "Error al abrir archivo\n"
lenErrorArchivo: .word 22 
palabras: .asciz "/home/orga2021/occ5g19/palabras.txt"
leerPalabras: .space 1024
espaciosPalabra: .space 30
palabraOculta: .asciz "      "
largoPalabra: .byte 5
mensajeSolicitarNumero: .asciz "Por favor, ingrese un numero del 1 al 50:\n"
lenMensajeSolicitarNumero: .word . - mensajeSolicitarNumero
mensajeErrorNumero: .asciz "Entrada invalida. Por favor, ingrese un numero del 1 al 50:\n"
lenMensajeErrorNumero: .word . - mensajeErrorNumero
bufferNumero: .asciz "    "  // Buffer para almacenar el número ingresado (4 bytes)
bufferNumeroDecimal: .word 0

.text
.global seleccionarPalabra
seleccionarPalabra:
    	.fnstart
    	push {r1, r2, r3, r4, r5, lr}
    	bl abrirArchivo
    	bl solicitarNumero
    	ldr r1, =leerPalabras
    	ldr r5, =bufferNumeroDecimal
    	ldr r5, [r5]       
    	sub r5, r5, #1     // Convertir número ingresado a índice basado en 0
    	mov r3, #0

loopSeleccionarPalabra:
    	cmp r3, r5
    	beq encontrarPalabra
    	ldrb r4, [r1], #1
    	cmp r4, #10        // Comparar con '\n'
    	bne loopSeleccionarPalabra
    	add r3, r3, #1
    	b loopSeleccionarPalabra

encontrarPalabra:
    	mov r3, #0
    	ldr r2, =palabraOculta

loopCopiaPalabra:
    	ldrb r4, [r1], #1
    	cmp r4, #10        // Comparar con '\n'
    	beq finCopiaPalabra
    	strb r4, [r2, r3]
    	add r3, r3, #1
    	b loopCopiaPalabra

finCopiaPalabra:
   	mov r4, #0          // Añadir terminador nulo al final de la palabra
    	strb r4, [r2, r3]
    	pop {r1, r2, r3, r4, r5, lr}
    	bx lr
    	.fnend
//----------------------------------------------------------
abrirArchivo:
	.fnstart
	push {r0, r1, r2, lr}
        mov r7, #5           
        ldr r0, =palabras     
        mov r1, #0          // Abrir en modo lectura
        mov r2, #0          // Sin permisos adicionales
        svc #0                

        cmp r0, #0       
        blt error 

        mov r4, r0        	
 leerArchivo:
        mov r7, #3        
        mov r0, r4        
        ldr r1, =leerPalabras   
        mov r2, #300
        svc #0
        cmp r0, #0 
        blt error
	bl cerrarArchivo
    	.fnend
//----------------------------------------------------------
cerrarArchivo:
	.fnstart
	mov r7, #6
	mov r0, r4  // Aseguramos que r0 contiene el descriptor de archivo
	svc #0
	pop {r0, r1, r2, lr}
	bx lr
    	.fnend
//----------------------------------------------------------
error:
	.fnstart
    	mov r7, #4
    	mov r0, #1
    	ldr r1, =errorArchivo
    	ldr r2, =lenErrorArchivo
	ldr r2, [r2]
    	svc #0
    	pop {r0, r1, r2, lr}
    	b fin
    	.fnend
solicitarNumero:
     	.fnstart
    	push {r4, r5, lr}
    	mov r0, #1
    	ldr r1, =mensajeSolicitarNumero
    	ldr r2, =lenMensajeSolicitarNumero
	ldr r2, [r2]
    	mov r7, #4
    	svc #0

solicitarNumeroLoop:
    	mov r0, #0
    	ldr r1, =bufferNumero       
    	mov r2, #4                  
    	mov r7, #3                  
    	svc #0                      

     	bl convertirNumero          
    	ldr r5, =bufferNumeroDecimal 
    	ldr r5, [r5]
    
    	// Verificar si el número está en el rango deseado (1-50)
    	cmp r5, #1
    	blt solicitarNumeroError
    	cmp r5, #50
    	bgt solicitarNumeroError

    	b solicitarNumeroParaSalir

solicitarNumeroError:
    	mov r0, #1                 
    	ldr r1, =mensajeErrorNumero
    	ldr r2, =lenMensajeErrorNumero
	ldr r2, [r2]
    	mov r7, #4                  
    	svc #0                       
    	b solicitarNumeroLoop

solicitarNumeroParaSalir:
    	pop {r4, r5, lr}
    	bx lr
    	.fnend
//----------------------------------------------------------
convertirNumero:
    	.fnstart
    	push {r1, r2, r3, r4, r5, lr}
    	ldr r1, =bufferNumero
    	mov r2, #0
    	mov r3, #10
    	mov r4, #0  // Registro temporal para el resultado de la multiplicación

convertirLoop:
    	ldrb r5, [r1], #1
    	cmp r5, #'0'
    	blt finConvertir
    	cmp r5, #'9'
    	bgt finConvertir
    	sub r5, r5, #'0'
    	mov r4, r2
    	mul r2, r4, r3
    	add r2, r2, r5
    	b convertirLoop

finConvertir:
    	ldr r1, =bufferNumeroDecimal
    	str r2, [r1]
    	pop {r1, r2, r3, r4, r5, lr}
    	bx lr
	.fnend

fin:
    	mov r7, #1
    	svc #0

.global main
main:
	bl seleccionarPalabra


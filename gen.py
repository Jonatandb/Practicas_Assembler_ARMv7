# -*- coding: utf-8 -*-

import sys
import os

if len(sys.argv) > 1:
    archivo = sys.argv[1]
    compilado = "as -g -o {}.o {}.s".format(archivo, archivo) # Traducir el código fuente a código objeto, contiene instrucciones de máquina, aún no es ejecutable.
    enlazado = "gcc -o {}.exe {}.o".format(archivo, archivo) # Uno o más archivos de código objeto son combinados en un archivo ejecutable.
    print("Compilando... " +  compilado)
    print("Enlazando... " + enlazado)
    os.system(compilado)
    os.system(enlazado)
else:
    print("No se proporcionaron argumentos. Uso: python gen.py <nombre_del_archivo>")
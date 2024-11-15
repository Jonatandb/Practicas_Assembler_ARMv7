#!/bin/bash

# Para que este archivo se ejecute en Linux,
#   la terminación de las lineas debe ser LF.

# Para poder ejecutar este script, hay que darle permisos ejecutando:
# chmod +x limpiar.sh

echo "Eliminando archivos .o y .exe..."
rm -rf *.o *.exe # Borrado de todos los archivos .o y .exe

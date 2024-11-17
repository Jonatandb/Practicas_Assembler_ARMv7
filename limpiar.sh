#!/bin/bash

# Para que este archivo se ejecute en Linux,
#   la terminación de las lineas debe ser LF.

# Para poder ejecutar este script, hay que darle permisos ejecutando:
# chmod +x limpiar.sh

echo "Eliminando archivos .o y .exe..."
rm -vrf *.o *.exe | sed 's/borrado/\x1b[32mEliminado\x1b[0m/g' # Borrado de todos los archivos .o y .exe

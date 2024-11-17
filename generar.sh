#!/bin/bash

# Para que este archivo se ejecute en Linux,
#   la terminación de las lineas debe ser LF.

# Para poder ejecutar este script, hay que darle permisos ejecutando:
# chmod +x generar.sh

ORIGEN=$1
if [ -z "$1" ]; then
  echo "Uso: generar.sh archivo.s"
else
  OBJ=${ORIGEN/.s/.o}
  BIN=${ORIGEN/.s/.exe}
  (echo -n "Compilando $ORIGEN -> $OBJ...   " && as -g -o $OBJ $ORIGEN && echo -e "\033[32m[OK]\033[0m") || { echo -e "\033[31mError al compilar\033[0m"; exit 1; }
  (echo  -n "Enlazando  $OBJ -> $BIN... "   && gcc -o $BIN $OBJ && echo -e "\033[32m[OK]\033[0m")      || { echo -e "\033[31mError al enlazar\033[0m"; exit 1; }
  echo -e "Ejecución: \033[32m./$BIN\033[0m"
fi

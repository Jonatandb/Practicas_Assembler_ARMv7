#!/bin/bash

ORIGEN=$1
if [ -z "$1" ]; then
  echo "Uso: generar.sh archivo.s"
else
  OBJ=${ORIGEN/.s/.o}
  BIN=${ORIGEN/.s/.exe}
  echo "Compilando y enlazando $ORIGEN..."
  as -g -o $OBJ $ORIGEN && gcc -o $BIN $OBJ
fi

# Para poder ejecutar este script, hay que darle permisos ejecutando:
# chmod +x generar.sh


# Para que este archivo se ejecute en Linux, la terminación de las lineas debe ser LF.

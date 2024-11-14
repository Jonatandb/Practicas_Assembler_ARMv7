#!/bin/bash
if [ -z "$1" ]; then
  echo "No se proporcionaron argumentos. Uso: ./generar.sh <nombre_del_archivo>"
  exit 1
fi
python gen.py "$1"
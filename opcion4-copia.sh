#!/bin/bash

export FILENAME="alumnos"
ENTORNO="$HOME/EPNro1/"
ARCHIVO_SALIDA="$ENTORNO/salida/${FILENAME}.txt"

if [ -f "$ARCHIVO_SALIDA" ]; then 
    sort -k5,5nr "$ARCHIVO_SALIDA" | head -n 10
else
    echo "Error: El archivo ${FILENAME}.txt no existe en la carpeta salida."
fi

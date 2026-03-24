#!/bin/bash

DIRECTORIO_BASE="$HOME/EPNro1"
ARCHIVO_FINAL="$SALIDA/${FILENAME}.txt"
for archivo in $(ls "$DIRECTORIO_BASE/entrada" --ignore=!*); do
	echo "Moviendo el archivo $archivo a $DIRECTORIO_BASE/procesado/"
	cat "$DIRECTORIO_BASE/entrada/$archivo" >> $ARCHIVO_FINAL
	mv "$DIRECTORIO_BASE/entrada/$archivo" "$DIRECTORIO_BASE/procesado/$ARCHIVO_FINAL"
done

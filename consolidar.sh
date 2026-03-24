#!/bin/bash

DIRECTORIO_BASE="$HOME/EPNro1"
ENTRADA="$DIRECTORIO_BASE/entrada"
SALIDA="$DIRECTORIO_BASE/salida"
PROCESADO="$DIRECTORIO_BASE/procesado"

ARCHIVO_FINAL="$SALIDA/${FILENAME}.txt"


while true; do
    for archivo in "$ENTRADA"/*.txt; do
        if [ -f "$archivo" ]; then
            cat "$archivo" >> "$ARCHIVO_FINAL"
            mv "$archivo" "$PROCESADO/"
        fi
    done
    sleep 5
done
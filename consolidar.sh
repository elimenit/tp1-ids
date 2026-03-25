#!/bin/bash

for ruta_archivo in "$DIR_WORK/entrada"/*.txt; do
    # Usamos $( ) para ejecutar el comando basename y obtener solo el nombre del archivo
    nombre_archivo=$(basename "$ruta_archivo")
    # Concatenamos el contenido
    cat "$ruta_archivo" >> "$FILENAME.txt"
    mv "$ruta_archivo" "$DIR_WORK/procesado/$nombre_archivo"
done
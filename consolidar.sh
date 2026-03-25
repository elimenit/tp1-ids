#!/bin/bash
declare -i i=0
for ruta_archivo in $(find "$DIR_WORK/entrada" -name *.txt -type f -readable); do
    # Concatenamos el contenido
    cat "$ruta_archivo" >> "$FILENAME.txt"
    mv "$ruta_archivo" "$DIR_WORK/procesado/$datos$i.txt"
	(( i ++ ))
done

#!/bin/bash

for archivo in $(ls "$DIR_WORK/entrada"); do
    # Concatenamos el contenido
    cat "$DIR_WORK/entrada/$archivo" >> "$FILENAME.txt"
    
    # REGLA: $? captura el éxito (0) o error (1+) del comando anterior (cat)
    if [[ $? -eq 0 ]]; then
        echo "Procesado correctamente: $archivo"
    else
        echo "La falla está en cat y $archivo"
    fi

    # Movimiento corregido (añadida / después de procesado)
    mv "$DIR_WORK/entrada/$archivo" "$DIR_WORK/procesado/$archivo"
done

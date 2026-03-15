#!/bin/bash

export FILENAME="/home/EPNro1/salida/filename.txt"

opcion_cinco() {
    if [[ -f $FILENAME ]]; then

        read -p "Ingrese un numero de padron" padron
        grep -i $padron $FILENAME
        echo "[+] Archivos mostrados con exito"
    else 
        echo "[-] No existe el fichero de notas (parametro FILENAME)"
    fi
}
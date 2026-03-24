#!/bin/bash

# Variables de Entorno
export DIR_WORK="$HOME/EPNro1"
export FILENAME="$DIR_WORK/salida/filename"
parametro=$1

crear_entorno(){
	if [[ -d $DIR_WORK ]]; then
		rm -rf $DIR_WORK
	fi
    echo "[+] Creando directorio de trabajo"
    mkdir -p $DIR_WORK
    declare -a subdrirectorios=( entrada salida procesado )
    for subd in ${subdrirectorios[@]}; do
       if [[ ! (-d $subd) ]]; then 
        mkdir -p $DIR_WORK/$subd
       fi
    done
    echo -e "122332 Juan Lopez jlopez@fi.uba.ar 8\n100998 Pedro Valdéz pvaldez@fi.uba.ar 5" >"$DIR_WORK/entrada/datos.txt"

}
correr_proceso(){
    cp consolidar.sh "$DIR_WORK/consolidar.sh"
    bash "$DIR_WORK/consolidar.sh"
}

mostrar_listado(){
    if [[ -f "$FILENAME.txt" ]]; then
        echo "[+] Mostrando Alumnos"
        sort -k 1 -n "$FILENAME.txt"
    else
        echo "No hay datos"
    fi
}
diez_notas_altas(){
    if [[ -f "$FILENAME.txt" ]]; then
        echo "[+] Mostrando las 10 notas mas altas"
        sort -k 5 -nr "$FILENAME.txt" | head -n 10
    else
        echo "No existen datos"
    fi
}
obtener_usuario(){
    read -p "Ingrese un numero de padron: " padron
    echo "[+] Informacion para $padron"
    grep $padron "$FILENAME.txt" | uniq -u  # | head -n 1

}
borrar_entorno() {
    parametro=$1
    if [[ $parametro == "-d" ]]; then
        echo "Borrando Directorio de trabajo"
        rm -rf $DIR_WORK 
   		trap 'kill $(jobs -p) 2>/dev/null' EXIT
    fi
}
menu(){
    echo "1. Crear Entorno"
    echo "2. Correr Proceso"
    echo "3. Mostrar listado" # Ordenado por padron
    echo "4. Mostrar las 10 Notas mas Altas"
    echo "5. Mostrar Informacion de un usuario"
    echo "6. Salir"
}
main() {
    declare -i continuar=0
    while [[ $continuar -eq 0 ]]; do 
        menu
        read -p "Ingrese una Opcion: " opcion
        case $opcion in 
            1) 
                crear_entorno
                ;;
            2)
                correr_proceso
                ;;
            3) 
                mostrar_listado
                ;;
            4) 
                diez_notas_altas
                ;;
            5)
                obtener_usuario
                ;;
            6)
                echo "Saliendo ..."
                let continuar=1
                ;;
            *)
                echo "Opcion ingresada es invalida"
                ;;
        esac
   		echo -e "\n"
    done
   
    borrar_entorno $parametro
}
main

#!/bin/bash

export FILENAME="alumnos"

ENTORNO="$HOME/EPNro1" # DIRECTORIO DE TRABAJO
ARCHIVO_SALIDA="$ENTORNO/salida/${FILENAME}.txt"
SCRIPT_CONSOLIDAR="$ENTORNO/consolidar.sh"


borrar_entorno() {
    echo "Borrando entorno..."
    rm -rf "$HOME/EPNro1"
    echo "Entorno eliminado y procesos finalizados."
}

crear_entorno() {
	ar_ejemplo="$ENTORNO/entrada/data.txt"
	if [[ ! ( -d $ENTORNO) ]]; then
		echo "Creando el entorno de trabajo"
		mkdir -p "$ENTORNO"/{entrada,salida,procesado}
   		touch "$ARCHIVO_SALIDA"
        cp "consolidar.sh" "$SCRIPT_CONSOLIDAR"
        chmod 700 "$SCRIPT_CONSOLIDAR"
		echo -ne "122332 Juan Lopez jlopez@fi.uba.ar 8\n100998 Pedro Valdéz pvaldez@fi.uba.ar 5\n89032 Carla Simone csimone@fi.uba.ar 7\n77542 Franco Lomba flomba@fi.uba.ar 10\n100223 Juana Pola jpola@fi.uba.ar 4\n122435 Lucia Fernandez lfernandez@fi.uba.ar 9" > $ar_ejemplo
	    echo "Entorno creado."
   	else
   		echo "Ya existe el directorio de trabajo"
   	fi
}

correr_proceso() {
    echo "Opcion seleccionada: Correr proceso"
    if [ -f "$SCRIPT_CONSOLIDAR" ]; then
        # el & hace que se ejecute en segundo plano
        bash "$SCRIPT_CONSOLIDAR"  # Envia a segundo plano un proceso
        echo "Proceso corriendo en segundo plano."
    else
        echo "Error: No se encontró consolidar.sh en $ENTORNO"
    fi
}

listar_por_padron() {
    if [ -f "$ARCHIVO_SALIDA" ]; then 
        sort -n "$ARCHIVO_SALIDA"
    else
        echo "Error: El archivo ${FILENAME}.txt no existe"
    fi
}

top_10_notas() {
    echo "Opcion seleccionada: Top 10 notas"
    if [ -f "$ARCHIVO_SALIDA" ]; then 
        sort k5,5 nr "$ARCHIVO_SALIDA" | head -n 10
    else
        echo "Error: El archivo ${FILENAME}.txt no existe en la carpeta salida."
    fi
}

buscar_por_padron() {
    echo "Opcion seleccionada: Buscar por padrón"
    if [[ -f $ARCHIVO_SALIDA ]]; then
        read -p "Ingrese un numero de padron" padron
        grep -i $padron $ARCHIVO_SALIDA
        echo "[+] Archivos mostrados con exito"
    else 
        echo "[-] No existe el fichero de notas (parametro FILENAME)"
    fi
}

imprimir_menu() {
    echo "-------------------------------"
    echo "MENU DE OPCIONES"
    echo "-------------------------------"
    echo "1 - Crear entorno"
    echo "2 - Correr proseso en background (mover elementos de 'entrada' a 'salida')"
    echo "3 - Listado de fichero ordenado por padron"
    echo "4 - Top 10 mejores notas"
    echo "5 - Buscar por numero de padrón"
    echo "6 - Salir"
    echo -n "Seleccione una opcion de 1 a 6: "
}

main() {
	if [[ $1 == "-d" ]]; then
		borrar-entorno
	fi
  	continuar=0 
    while [[ $continuar -eq 0 ]]; do
        imprimir_menu
        read OPCION

        case $OPCION in
            1)
                crear_entorno
                ;;
            2)
                correr_proceso
                ;;
            3)
                listar_por_padron
                ;;
            4)
                top_10_notas
                ;;
            5)
                buscar_por_padron
                ;;
            6)
                echo "Saliendo del programa. ¡Adiós!"
               continuar=1
                ;;
            *)
                echo "Opción no válida. Intente de nuevo."
                ;;
        esac
    done
    if [[ $1 == "-d" ]]; then
    	borrar_entorno
    fi
}

main
clear

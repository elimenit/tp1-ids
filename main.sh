#!/bin/bash

export FILENAME="alumnos"

ENTORNO="$HOME/EPNro1"
ARCHIVO_SALIDA="$ENTORNO/salida/${FILENAME}.txt"
SCRIPT_CONSOLIDAR="$ENTORNO/consolidar.sh"


borrar_entorno() {
    echo "Borrando entorno..."
    pkill -f "consolidar.sh"
    rm -rf "$HOME/EPNro1"
    echo "Entorno eliminado y procesos finalizados."
    exit 0
}

crear_entorno() {
    echo "Opcion seleccionada: Crear entorno"
    echo "Creando entorno en $ENTORNO..."
    
    mkdir -p "$ENTORNO"/{entrada,salida,procesado}
    touch "$ARCHIVO_SALIDA"
    if [ ! -f "$SCRIPT_CONSOLIDAR" ]; then
        cp "consolidar.sh" "$SCRIPT_CONSOLIDAR"
        chmod +x "$SCRIPT_CONSOLIDAR"
    fi

    echo "Entorno creado."
}

correr_proceso() {
    echo "Opcion seleccionada: Correr proceso"
    if [ -f "$SCRIPT_CONSOLIDAR" ]; then
        # el & hace que se ejecute en background
        bash "$SCRIPT_CONSOLIDAR" &
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
        sort -k5,5nr "$ARCHIVO_SALIDA" | head -n 10
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


if [ "$1" == "-d" ]; then
    borrar_entorno
    exit 0
fi

while true; do
    imprimir_menu
    read OPCION

    case $OPCION in
        1)
            crear_entorno()
            ;;
        2)
            correr_proceso()
            ;;
        3)
            listar_por_padron()
            ;;
        4)
            top_10_notas()
            ;;
        5)
            buscar_por_padron()
            ;;
        6)
            echo "Saliendo del programa. ¡Adiós!"
            exit 0
            ;;
        *)
            echo "Opción no válida. Intente de nuevo."
            ;;
    esac
    

    echo ""
    echo "Presione Enter para continuar..."
    read CONTINUAR
    clear
done
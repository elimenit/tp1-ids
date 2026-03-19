#!/bin/bash
DIR_TRABAJO="/home/$USER/EPNro1" # variable global porque es donde vive el proyecto
export FILENAME="$DIR_TRABAJO/salida/FILENAME.txt" # Variable de ambiente y despues variable de entorno en el process child

crear_directorio_no_existe() { #1
    directorio=$1
    if [[ ! (-d $directorio) ]]; then
        echo "+ Directorio creado $directorio"
        mkdir -p "$directorio"
    fi
}
crear_entorno() { #1
    ar_ejemplo="$DIR_TRABAJO/entrada/alumnos.txt"
    declare -a SUB_DIRECTORIOS="entrada salida procesado" #declaracion explicita de un array
    crear_directorio_no_existe $DIR_TRABAJO
    for subd in $SUB_DIRECTORIOS; do
        crear_directorio_no_existe "$DIR_TRABAJO/$subd"
    done
    if [[ !(-f  $ar_ejemplo) ]]; then
        echo "agregando informacion al archivo $ar_ejemplo"
        echo -ne "122332 Juan Lopez jlopez@fi.uba.ar 8\n100998 Pedro Valdéz pvaldez@fi.uba.ar 5\n89032 Carla Simone csimone@fi.uba.ar 7\n77542 Franco Lomba flomba@fi.uba.ar 10\n100223 Juana Pola jpola@fi.uba.ar 4\m122435 Lucia Fernandez lfernandez@fi.uba.ar 9" 1>$ar_ejemplo
    fi
}
correr_proceso() { #2
    ar_consolidar="$DIR_TRABAJO/salida/consolidar.sh"
    echo -ne "#!/bin/bash\nfor archivo in $(ls /home/$USER/EPNro1/entrada); do\n        cat $DIR_TRABAJO/entrada/\$archivo >> $FILENAME \n        mv $DIR_TRABAJO/entrada/\$archivo '$DIR_TRABAJO/procesado/$archivo'\ndone\n" > $ar_consolidar
    bash $ar_consolidar # proceso hijo 
}
alumnos_ordenados_padron() { #3
    echo "Luciana"
}
notas_mas_altas() { # 4
    echo "Atila"
}
buscar_usuario() {
    read -p "Ingrese el padron de un usuario: " padron
    if [[ !(-f $FILENAME) ]]; then
        echo "El archivo $FILENAME no existe"
    else
        echo -en "Mostrando alumno:\n"
        grep $padron $FILENAME | head -n 1
    fi
}
menu() {
    echo "1) Crear Entorno"
    echo "2) Correr Proceso"
    echo "3) Listado Alumnos"
    echo "4) Notas Mas altas"
    echo "5) Buscar por padron"
    echo "6) Salir"

}
main() {
    declare -i continuar=0 #Declaracion explicita de un numero entero en bash
    while [[ $continuar -eq 0 ]]; do 
        menu
        read -p "Opcion > " opcion
        case $opcion in
            1) 
                crear_entorno
                ;;
            2)
                correr_proceso
                ;;
            3) 
                alumnos_ordenados_padron
                ;;
            4) 
                notas_mas_altas
                ;;
            5) 
                buscar_usuario
                ;;
            6) 
                let continuar=1
                ;;
            *)
                echo "Vuelva ha intentarlo"
                salir
                ;;
        esac
        echo -ne "\n ------------\n"
    done
}
salir() {
    sleep 2 # Duerme ala notebook por 2 segundos
    systemctl reboot # reinicia pero antes duerme los programas 
}
main
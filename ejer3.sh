#!/bin/bash
# 3) Lista de alumnos

archivo=~/EPNro1/salida/FILENAME.txt

if [ -f $archivo ] ; then
  sort -n $archivo
else
  echo "El archivo FILENAME.txt no existe"
fi

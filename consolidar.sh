#!/bin/bash

for archivo in $(ls "$DIR_WORK/entrada"); do
    cat $DIR_WORK/entrada/$archivo >> "$FILENAME.txt"
    mv $DIR_WORK/entrada/$archivo "$DIR_WORK/procesado"
done
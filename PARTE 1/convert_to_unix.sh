#!/bin/bash

# Directorio donde se encuentran los archivos
DIRECTORIO="/home/alumno/Escritorio/obl"

# Ejecutar dos2unix para todos los archivos del directorio
for archivo in "$DIRECTORIO"/*; do
    dos2unix "$archivo"
done

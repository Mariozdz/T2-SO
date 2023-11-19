#!/bin/bash

echo "[*] ====== Inicio del Script de Prueba para la Tarea 3 ======"

# Configuración inicial
VULP_EXECUTABLE="./vulp_v3"
ATTACKER_SCRIPT="./attacker.sh"
TEST_FILE="/tmp/XYZ"
ORIGINAL_FILE="/etc/passwd"

echo "[*] Preparando el archivo de prueba $TEST_FILE..."
if [ -f "$TEST_FILE" ]; then
    echo "[*] El archivo $TEST_FILE ya existe. Limpieza de su contenido."
    > $TEST_FILE
else
    echo "[*] El archivo $TEST_FILE no existe. Creándolo..."
    touch $TEST_FILE
fi
chmod 666 $TEST_FILE
echo "[+] Preparación del archivo de prueba completada."

echo "[*] Realizando copia de seguridad del archivo $ORIGINAL_FILE..."
BACKUP_FILE="/tmp/passwd.backup"
sudo cp $ORIGINAL_FILE $BACKUP_FILE
echo "[+] Copia de seguridad realizada en $BACKUP_FILE."

echo "[*] Ejecutando el programa vulp para la Tarea 3..."
$VULP_EXECUTABLE &
VULP_PID=$!

echo "[*] Iniciando el script atacante en segundo plano..."
$ATTACKER_SCRIPT &
ATTACKER_PID=$!

echo "[*] Esperando a que el programa vulp termine..."
wait $VULP_PID

echo "[*] Deteniendo el script atacante..."
kill $ATTACKER_PID

echo "[*] Verificando si el enlace simbólico /tmp/XYZ apunta a $ORIGINAL_FILE..."
if [ "$(readlink -f $TEST_FILE)" == "$ORIGINAL_FILE" ]; then
    echo "[-] Tarea 3 Prueba FALLIDA: El ataque de condición de carrera tuvo éxito."
else
    echo "[+] Tarea 3 Prueba EXITOSA: El ataque de condición de carrera no tuvo éxito."
fi

echo "[*] Restaurando el archivo original desde la copia de seguridad..."
sudo mv $BACKUP_FILE $ORIGINAL_FILE
echo "[+] Restauración completada."

echo "[*] ====== Fin del Script de Prueba para la Tarea 3 ======"

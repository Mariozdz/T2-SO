#!/bin/bash


TEST_FILE="/tmp/XYZ"
EXECUTABLE="./vulp_v3"

# Agregar una entrada al programa
add_entry() {
    echo "Agregando entrada: $1"
    echo $1 | $EXECUTABLE
}

# Verificar el contenido del archivo
check_file() {
    echo "Verificando que '$1' esté en $TEST_FILE..."
    if grep -q "$1" "$TEST_FILE"; then
        echo "Prueba exitosa: '$1' encontrado en $TEST_FILE"
    else
        echo "Prueba fallida: '$1' no encontrado en $TEST_FILE"
    fi
    echo ""
}

# Limpiar archivo de prueba
echo "Limpiando $TEST_FILE..."
> $TEST_FILE

# Cambiar los permisos del archivo para que el usuario actual no pueda escribir
sudo chown root $TEST_FILE
sudo chmod 644 $TEST_FILE

# Ejecutar pruebas sin permisos de escritura
echo "Iniciando pruebas sin permisos de escritura..."

# Texto para probar sin permisos de escritura
entries=("test1" "entrada2" "ejemplo3")

# Probar cada entrada sin permisos de escritura
for entry in "${entries[@]}"; do
    add_entry "$entry"
    check_file "$entry"
done

echo "Pruebas de escritura con permisos adecuados..."

# Cambiar los permisos para permitir la escritura al usuario actual
sudo chown $(whoami) $TEST_FILE
sudo chmod 666 $TEST_FILE

# Agregar una entrada adicional con permisos de escritura
additional_entry="test_permisos"
add_entry "$additional_entry"
check_file "$additional_entry"

echo "Pruebas finalizadas"

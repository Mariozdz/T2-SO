#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>

#define DELAY 10000

int main()
{
    char *fn = "/tmp/XYZ";
    char buffer[60];
    FILE *fp;
    long int i;

    printf(">>> Iniciando el programa...\n");

    // Guardar el UID efectivo original
    uid_t original_euid = geteuid();
    printf(">>> UID efectivo original: %d\n", original_euid);

    // Renunciar a permisos de root temporalmente
    seteuid(getuid());
    printf(">>> Permisos de root renunciados temporalmente\n");

    // Obtener entrada del usuario
    printf(">>> Ingrese una entrada: ");
    scanf("%50s", buffer);
    printf(">>> Entrada recibida: %s\n", buffer);

    // Intentar abrir el archivo para agregar (append)
    fp = fopen(fn, "a+");
    if (fp == NULL) {
        perror("[ Fallo al abrir el archivo ]");
        // Restaurar el UID efectivo antes de salir
        seteuid(original_euid);
        return 1;
    }

    // Restaurar permisos de root para escribir en el archivo
    seteuid(original_euid);
    printf(">>> Permisos de root restaurados para operaciones de archivo\n");

    for (i = 0; i < DELAY; i++) {
        int a = i ^ 2; 
    }

    fwrite("\n", sizeof(char), 1, fp);
    fwrite(buffer, sizeof(char), strlen(buffer), fp);
    printf(">>> Datos escritos en el archivo\n");
    fclose(fp);

    // Renunciar a permisos de root después de la operación
    seteuid(getuid());
    printf(">>> Permisos de root renunciados despues de la operacion\n");

    // Restaurar el UID efectivo al final
    seteuid(original_euid);
    printf(">>> UID efectivo restaurado al valor original al finalizar\n");

    return 0;
}

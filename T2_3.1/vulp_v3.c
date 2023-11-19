#include <stdio.h>
#include <unistd.h>
#include <string.h>  // Incluir para la función strlen
#define DELAY 10000

int main() {
    char *fn = "/tmp/XYZ";
    char buffer[60];
    FILE *fp;
    long int i;

    printf("Iniciando programa vulp_v3 para la Tarea 3...\n");
    printf("Introduce la entrada: ");
    scanf("%50s", buffer);

    // Renunciar temporalmente a los privilegios de root
    printf("Renunciando temporalmente a los privilegios de root...\n");
    seteuid(getuid());

    if (!access(fn, W_OK)) {
        printf("Permiso de escritura en %s concedido. Restaurando privilegios de root...\n", fn);
        
        // Restaurar privilegios de root
        seteuid(0);

        // Simulando retraso
        for (i = 0; i < DELAY; i++) {
            int a = i^2;
        }

        fp = fopen(fn, "a+");
        if (fp == NULL) {
            perror("Error al abrir el archivo");
            return 1;
        }

        fwrite("\n", sizeof(char), 1, fp);
        fwrite(buffer, sizeof(char), strlen(buffer), fp);
        fclose(fp);

        // Renunciar de nuevo a los privilegios
        printf("Operación de archivo completada. Renunciando a los privilegios de root...\n");
        seteuid(getuid());
    } else {
        printf("No se tienen permisos de escritura en %s.\n", fn);
    }

    printf("Programa vulp_v3 finalizado.\n");
    return 0;
}

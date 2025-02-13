#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#define MAX_LENGTH 100

char* itoa(int num) {
    char* str = (char*)malloc(12 * sizeof(char));
    sprintf(str, "%d", num);
    return str;
}

char* name_crafting(char *number) {
    int next_nbr = 0;
    
    next_nbr = atoi(number) - 1;
    free(number);
    
    char tmp[100];
    tmp[0] ='\0';
    strcat(tmp, "Sully_");
    char *str = itoa(next_nbr);
    strcat(tmp, str);
    free(str);
    strcat(tmp, ".c");

    FILE *next_file = fopen(tmp, "w");
    return next_file;
}

void copy(char *replace, FILE *input_file, char *output_file) {
    printf("%s\n", replace);
    char * buffer = (char *) malloc( MAX_LENGTH );

    while(!feof(input_file))
    {
        fgets(buffer, MAX_LENGTH, input_file);
        fprintf(output_file, buffer);
    }
}

int main() {

    FILE *input_file;
    input_file = fopen(__FILE__, "r");
    int i = 567;
    if (i < 1)
        return 0;
    
    size_t total_len = strlen("int i ") + strlen(" = ");
    char *search = (char *)malloc(total_len * sizeof(char));
    char * buffer = (char *) malloc( MAX_LENGTH );

    strcat(search, "int i ");
    strcat(search, "= ");
    
    while(!feof(input_file))
    {
        fgets(buffer, MAX_LENGTH, input_file);
            if (strstr(buffer, search))
            {
                int j = 0;
                while(buffer[j] != '=')
                    j++;
                j = j + 2;
                
                char *number = (char *)malloc(15 * sizeof(char));
                int k = 0;
                while (buffer[j])
                {
                    number[k] = buffer[j];
                    k++;
                    j++;
                }
                number[k - 2] = '\0';
                copy(buffer, input_file, name_crafting(number));
                break ;
            }
    }
    


    free(search);
    free(buffer);

    fclose(input_file);

    return 0;
}

#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#define MAX_LENGTH 100

char* itoa(int num) {
    char* str = (char*)malloc(12 * sizeof(char));
    sprintf(str, "%d", num);
    return str;
}

FILE* name_crafting(char *number) {
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

void copy(char *replace, FILE *input_file, FILE *output_file, int f) {

    rewind(input_file);
    char buffer[MAX_LENGTH];

    int skip = 0;

    char *itoaed = itoa(f - 1);
    char *tmp = (char*)malloc((strlen(itoaed) + 15)*sizeof(char));
    free(itoaed);
    tmp[0] = '\0';
    strcat(tmp, "    int i =");
    strcat(tmp, " ");
    char *itoaed2 = itoa(f - 1);
    strcat(tmp, itoaed2);
    free(itoaed2);
    strcat(tmp, ";\n");
    while(fgets(buffer, MAX_LENGTH, input_file) != NULL) {
        if (strstr(buffer, replace))
        {
            fputs(tmp, output_file);
        }
        else
            fputs(buffer, output_file);
    }
    free(tmp);
}

int main() {

    FILE *input_file;
    input_file = fopen(__FILE__, "r");
    if(input_file == NULL)
        return 1;
    int i = 567;
    if (i < 0)
        return 0;
    
    size_t total_len = strlen("int i ") + strlen(" = ");
    char *search = (char *)malloc(total_len * sizeof(char));
    char * buffer = (char *) malloc( MAX_LENGTH );

    search[0] = '\0';
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
                FILE* tmp_file = name_crafting(number);
                copy(buffer, input_file, tmp_file, i);
                pclose(tmp_file);
                break ;
            }
    }
    
    free(search);
    free(buffer);

    fclose(input_file);

    return 0;
}

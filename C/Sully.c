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
    int i = 567;
    // int f = i;
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


// #include <stdio.h>
// #include <string.h>
// #include <stdlib.h>
// #define MAX_LENGTH 100

// char* itoa(int num) {
//     char* str = (char*)malloc(12 * sizeof(char));
//     if (str) {
//         sprintf(str, "%d", num);
//     }
//     return str;
// }

// FILE* name_crafting(char *number) {
//     int next_nbr = 0;
//     next_nbr = atoi(number) - 1;
//     free(number);
//     char tmp[100];
//     tmp[0] = '\0';
//     strcat(tmp, "Sully_");
//     char *str = itoa(next_nbr);
//     if (str) {
//         strcat(tmp, str);
//         free(str);
//     }
//     strcat(tmp, ".c");
//     FILE *next_file = fopen(tmp, "w");
//     return next_file;
// }

// void copy(char *replace, FILE *input_file, FILE *output_file, int f) {
//     if (!input_file || !output_file) return;
    
//     rewind(input_file);
//     char buffer[MAX_LENGTH];
    
//     char *str_f = itoa(f - 1);
//     if (!str_f) return;
    
//     char *tmp = (char*)malloc((strlen(str_f) + 14) * sizeof(char));
//     if (tmp) {
//         tmp[0] = '\0';
//         strcat(tmp, " int i =");
//         strcat(tmp, " ");
//         strcat(tmp, str_f);
//         strcat(tmp, ";\n");
        
//         while(fgets(buffer, MAX_LENGTH, input_file) != NULL) {
//             if (strstr(buffer, replace)) {
//                 fputs(tmp, output_file);
//             } else {
//                 fputs(buffer, output_file);
//             }
//         }
//         free(tmp);
//     }
//     free(str_f);
// }

// int main() {
//     FILE *input_file;
//     input_file = fopen(__FILE__, "r");
//     if (!input_file) return 1;
    
//     int i = 567;
//     // int f = i;
//     if (i < 0) {
//         fclose(input_file);
//         return 0;
//     }
    
//     size_t total_len = strlen("int i ") + strlen(" = ") + 1;
//     char *search = (char *)malloc(total_len * sizeof(char));
//     if (!search) {
//         fclose(input_file);
//         return 1;
//     }
//     search[0] = '\0';
    
//     char *buffer = (char *)malloc(MAX_LENGTH);
//     if (!buffer) {
//         free(search);
//         fclose(input_file);
//         return 1;
//     }
    
//     strcat(search, "int i ");
//     strcat(search, "= ");
    
//     while(fgets(buffer, MAX_LENGTH, input_file) != NULL) {
//         if (strstr(buffer, search)) {
//             int j = 0;
//             while(buffer[j] != '=')
//                 j++;
//             j = j + 2;
            
//             char *number = (char *)malloc(15 * sizeof(char));
//             if (!number) {
//                 free(buffer);
//                 free(search);
//                 fclose(input_file);
//                 return 1;
//             }
            
//             int k = 0;
//             while (buffer[j] && k < 14) {
//                 number[k] = buffer[j];
//                 k++;
//                 j++;
//             }
            
//             if (k > 0) {
//                 number[k - (k > 1 ? 2 : 1)] = '\0';
//                 copy(buffer, input_file, name_crafting(number), i);
//             } else {
//                 free(number);
//             }
            
//             break;
//         }
//     }
    
//     free(search);
//     free(buffer);
//     fclose(input_file);
//     return 0;
// }
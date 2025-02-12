//La structure FILE permet de stocker les informations relatives à la gestion d'un flux de données.
#include <stdio.h>

int autre_fonction_qui_add_les_variables_a_et_b(int a, int b) {
    return (a + b);
}

int main() {
    int a = 1;
    int b = 2;
    int result;
    FILE *input_file;
    int c = 0;
    input_file = fopen(__FILE__, "r"); //__FILE__ = macro qui donne le nom de l'input file

    while((c = getc(input_file)) != EOF)
        putchar(c);
    fclose(input_file);

    result = autre_fonction_qui_add_les_variables_a_et_b(a, b);
    return 0;
}
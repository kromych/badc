// C99 7.19.6.4 scanf and 7.19.6.2 fscanf must be declared by <stdio.h>,
// alongside the already-present sscanf, and reach a definition: the C
// library's, or libc/lib/scanf_ext.c's on Windows. The calls sit
// behind a runtime-unknown guard (argc) so the program never blocks
// on stdin; the regression is that both spellings compile and link --
// they were previously rejected at compile time as "unknown function".
#include <stdio.h>

int main(int argc, char **argv) {
    int a = 0, b = 0;
    (void)argv;
    if (argc > 99999) {
        scanf("%d", &a);
        fscanf(stdin, "%d", &b);
    }
    return a + b;
}

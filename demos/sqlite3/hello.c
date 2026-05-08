/*
** Bisection probe: minimal "hello world" with the same -include /
** -D set as the regular smoke. Three checkpoint shapes so the
** windows CI can distinguish where output gets lost:
**   * raw write(2, ...) -- direct kernel syscall via msvcrt._write
**   * fprintf(stderr, ...) + fflush -- stdio path same as shell.c
**   * printf(...) + fflush -- stdout path
*/
#include <stdio.h>
#include <unistd.h>

int main(int argc, char **argv) {
    write(2, "hello-write2\n", 13);
    fprintf(stderr, "hello-fprintf-stderr\n");
    fflush(stderr);
    printf("hello-printf-stdout\n");
    fflush(stdout);
    return 0;
}

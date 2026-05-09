/*
** Bisection probe: minimal "hello world" with the same -include /
** -D set as the regular smoke. Four checkpoint shapes so the
** windows CI can distinguish where output gets lost:
**   * raw write(2, ...) -- direct kernel syscall via msvcrt._write
**   * fprintf(stderr, ...) + fflush -- stdio path same as shell.c
**   * printf(...) + fflush -- stdout path
**   * fopen + fwrite + fclose to a side-channel file -- proof the
**     binary's main() runs even if the inherited stdout/stderr is
**     somehow detached. The smoke driver `cat`s the file back.
*/
#include <stdio.h>
#include <unistd.h>

int main(int argc, char **argv) {
    write(2, "hello-write2\n", 13);
    fprintf(stderr, "hello-fprintf-stderr\n");
    fflush(stderr);
    printf("hello-printf-stdout\n");
    fflush(stdout);

    /* Side-channel: write to a fixed-name file so smoke.sh can cat
    ** it back. Avoids any stdout/stderr inheritance issues. */
    FILE *f = fopen("hello.proof", "w");
    if (f) {
        fputs("hello-fopen-fwrite\n", f);
        fclose(f);
    }
    return 0;
}

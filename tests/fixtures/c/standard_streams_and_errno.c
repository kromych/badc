// The standard streams and `errno` through the bundled <stdio.h> and
// <errno.h>: glibc's `stderr`, Apple's `__stderrp` or the CRT's
// `__iob_func()` natively, the interpreter's own under --interp. Returns 0
// when every check passes; each failure returns a distinct code.

#include <errno.h>
#include <stdio.h>

int main(void) {
    if (fileno(stdin) != 0 || fileno(stdout) != 1 || fileno(stderr) != 2) return 1;
    if (stdout == stderr || stdin == stdout) return 2;
    if (fputs("err: fputs\n", stderr) < 0) return 3;
    if (fprintf(stderr, "err: %s %d\n", "fprintf", 2) != 15) return 4;
    if (fputc('!', stderr) != '!' || putc('\n', stderr) != '\n') return 5;
    if (fwrite("err: fwrite\n", 1, 12, stderr) != 12) return 6;
    if (fputs("out: fputs\n", stdout) < 0 || puts("out: puts") < 0) return 7;
    if (fprintf(stdout, "out: %c\n", 'x') != 7) return 8;
    if (fflush(stdout) != 0 || fflush(stderr) != 0 || fflush(NULL) != 0) return 9;
    errno = 0;
    if (errno != 0) return 10;
    errno = ERANGE;
    if (errno != ERANGE) return 11;
    return 0;
}

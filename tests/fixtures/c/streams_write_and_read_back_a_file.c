// C99 7.19.5 - 7.19.9 on a file named by the first argument: fopen's
// modes, the output functions writing to it, and reading it back by line,
// by field, by character with pushback and in blocks; the position, the
// end-of-file indicator, and a missing file failing with ENOENT. What
// feof returns when set is the C library's: 1, or msvcrt's _IOEOF bit.

#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(int argc, char **argv) {
    if (argc < 2)
        return 2;
    FILE *f = fopen(argv[1], "w");
    if (!f)
        return 3;
    fprintf(f, "%d %s\n", 42, "first");
    fputs("second line\n", f);
    fputc('x', f);
    fwrite("yz\n3.5 7\n", 1, 9, f);
    fclose(f);
    f = fopen(argv[1], "a");
    fputs("tail", f);
    fclose(f);

    char line[32];
    f = fopen(argv[1], "r");
    printf("[%s]", fgets(line, sizeof line, f));
    printf("[%s]", fgets(line, 7, f));
    printf("[%s]", fgets(line, sizeof line, f));
    int c = getc(f);
    ungetc('Y', f);
    printf("%c%c%c", c, fgetc(f), getc(f));
    printf("[%s]", fgets(line, sizeof line, f));
    double d = 0;
    int n = 0, k = fscanf(f, "%lf %d", &d, &n);
    printf("%d %g %d %ld\n", k, d, n, ftell(f));
    char *buf = 0;
    size_t cap = 0;
    long len = getline(&buf, &cap, f);
    printf("%ld [%s] %d ", len, buf, feof(f) != 0);
    len = getline(&buf, &cap, f);
    printf("%ld [%s] %d %d\n", len, buf, feof(f), getc(f));
    free(buf);
    rewind(f);
    char block[8] = {0};
    size_t got = fread(block, 2, 3, f);
    fseek(f, -4, SEEK_END);
    printf("%d [%s] %c %ld\n", (int)got, block, getc(f), ftell(f));
    clearerr(f);
    printf("%d %d\n", feof(f), ferror(f));
    fclose(f);

    errno = 0;
    char missing[256];
    snprintf(missing, sizeof missing, "%s.missing", argv[1]);
    printf("%d %d\n", fopen(missing, "r") == 0, errno == ENOENT);
    return 0;
}

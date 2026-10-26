// C99 7.19.6.9 vfscanf and 7.19.6.11 vscanf scan through a va_list: a
// stream holding numbers, a literal %, a suppressed field, a scanset that
// opens with ], a character, bounded and suppressed strings and a %n
// position is read back as fscanf reads it. vscanf runs an empty format,
// which reads nothing from the standard input.

#include <stdarg.h>
#include <stdio.h>
#include <string.h>

static int scan_file(FILE *f, const char *fmt, ...) {
    va_list ap;
    va_start(ap, fmt);
    int r = vfscanf(f, fmt, ap);
    va_end(ap);
    return r;
}

static int scan_stdin(const char *fmt, ...) {
    va_list ap;
    va_start(ap, fmt);
    int r = vscanf(fmt, ap);
    va_end(ap);
    return r;
}

int main(void) {
    static const char text[] = "12 % 34 ]x]y abcdef 99";
    FILE *f = tmpfile();
    int a = 0, n = 0;
    short b = 0;
    char set[8] = {0}, c = 0, word[4] = {0};
    if (!f || fputs(text, f) < 0)
        return 1;
    rewind(f);
    if (scan_file(f, "%d %% %*d %[]x]%c %3s%*s%n %hd", &a, set, &c, word, &n, &b) != 5)
        return 2;
    if (a != 12 || strcmp(set, "]x]") || c != 'y' || strcmp(word, "abc"))
        return 3;
    if (n != (int)strlen("12 % 34 ]x]y abcdef") || b != 99)
        return 4;
    if (scan_file(f, "%d", &a) != EOF)
        return 5;
    fclose(f);
    if (scan_stdin("") != 0)
        return 6;
    return 0;
}

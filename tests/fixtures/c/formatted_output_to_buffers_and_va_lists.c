// C99 7.19.6: sprintf, snprintf's truncation and return value, and the
// `va_list` forms reading every argument class a variadic call passes,
// `long double` included. A null pointer's `%p` text is the C library's;
// msvcrt's _snprintf writes no terminator when the output fills the buffer
// and returns -1 when it does not fit.

#include <stdarg.h>
#include <stdio.h>
#include <string.h>

static int format(char *b, size_t n, const char *fmt, ...) {
    va_list ap;
    va_start(ap, fmt);
    int r = vsnprintf(b, n, fmt, ap);
    va_end(ap);
    return r;
}

static void say(const char *fmt, ...) {
    va_list ap, again;
    va_start(ap, fmt);
    va_copy(again, ap);
    vprintf(fmt, ap);
    vfprintf(stdout, fmt, again);
    va_end(again);
    va_end(ap);
}

int main(void) {
    char b[64];
    int r = sprintf(b, "%5d|%-4s|%c", 42, "ab", 'z');
    printf("%d [%s]\n", r, b);
    memset(b, '#', sizeof b);
    r = snprintf(b, 5, "%d", 123456);
    printf("%d [%s] %c\n", r, b, b[5]);
    printf("%d\n", snprintf(0, 0, "%s", "counted"));
    r = format(b, sizeof b, "%d %s %Lf %g %c %lld %hhd", 1, "two", 3.5L, 4.5, 'z', -5LL, 300);
    printf("%d [%s]\n", r, b);
    say("%s=%ld;", "v", 7L);
    printf("\n%p\n", (void *)0);
#ifdef _WIN32
    memset(b, '#', sizeof b);
    r = _snprintf(b, 3, "%d", 123);
    printf("%d %c%c%c%c\n", r, b[0], b[1], b[2], b[3]);
    printf("%d\n", _snprintf(b, 2, "%d", 123));
#endif
    return 0;
}

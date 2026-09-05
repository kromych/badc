// C99 7.19.6.12 / 7.19.6.13: `vsnprintf` and `vsprintf` format from a
// `va_list` a variadic caller forwards. `<stdio.h>` declares both with
// a prototype, so the forwarded list and the count are checked against
// it rather than the call being assumed to return `int`. The checks
// cover the formatted bytes, the untruncated length `vsnprintf`
// reports on a short buffer, the NUL it places, a zero count that
// touches nothing, and `vsprintf` through the same forward.
#include <stdarg.h>
#include <stdio.h>
#include <string.h>

static int format(char *out, size_t n, const char *fmt, ...) {
    va_list ap;
    va_start(ap, fmt);
    int len = vsnprintf(out, n, fmt, ap);
    va_end(ap);
    return len;
}

static int format_unbounded(char *out, const char *fmt, ...) {
    va_list ap;
    va_start(ap, fmt);
    int len = vsprintf(out, fmt, ap);
    va_end(ap);
    return len;
}

int main(void) {
    char buf[16];
    memset(buf, 'x', sizeof buf);
    if (format(buf, sizeof buf, "%d:%s:%c", 42, "ab", 'z') != 7) return 1;
    if (strcmp(buf, "42:ab:z") != 0) return 2;
    memset(buf, 'x', sizeof buf);
    if (format(buf, 4, "%d:%s:%c", 42, "ab", 'z') != 7) return 3;
    if (strcmp(buf, "42:") != 0) return 4;
    if (buf[4] != 'x') return 5;
    if (format(buf, 0, "%d", 1) != 1) return 6;
    if (buf[0] != '4') return 7;
    if (format_unbounded(buf, "%s=%d", "n", 7) != 3) return 8;
    if (strcmp(buf, "n=7") != 0) return 9;
    return 0;
}

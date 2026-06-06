// C99 7.15.1: `vsnprintf` reads variadic arguments through a
// `va_list`. c5's `va_list` is the host platform's own
// representation, so a c5 `va_list` forwarded to libc's `vsnprintf`
// is walked correctly by libc's formatter. The fixture captures a
// `va_list` in a variadic c5 function, forwards it through libc
// `vsnprintf`, and asserts the formatted bytes match the input.
#include <stdio.h>
#include <stdarg.h>
#include <string.h>

static int formatter(char *out, int n, const char *fmt, ...) {
    va_list ap;
    va_start(ap, fmt);
    int rc = vsnprintf(out, n, fmt, ap);
    va_end(ap);
    return rc;
}

int main() {
    char buf[64];
    formatter(buf, sizeof(buf), "%d %d", 42, 99);
    if (strcmp(buf, "42 99") != 0) {
        printf("FAIL: vsnprintf via va_list -> '%s' (expected '42 99')\n", buf);
        return 1;
    }
    return 0;
}

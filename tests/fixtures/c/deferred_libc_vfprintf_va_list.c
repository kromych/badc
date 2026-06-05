// C99 7.15.1: `vsnprintf` reads variadic arguments through a
// `va_list`. c5's `va_list` is a `long *` walking 16-byte c5
// stack slots; the platform's libc va_list has a different
// shape, so passing c5's `va_list` to libc's `vsnprintf` would
// have the formatter walk the wrong memory. <stdio.h> redirects
// `vsnprintf` (and the rest of the `v*printf` family) to
// `c5_vsnprintf` in <c5io.h>, which walks the c5-shaped cursor
// directly. The fixture forwards a captured `va_list` through
// `vsnprintf` and asserts the formatted bytes match the input.
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

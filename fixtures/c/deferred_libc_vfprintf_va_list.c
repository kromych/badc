// DEFERRED: libc vfprintf called with a c5 va_list.
//
// c5's `va_list` is a `long *` walking the c5 stack at 16 bytes
// per slot. The platform's libc vfprintf expects a platform-ABI
// `va_list` (a struct on aarch64 / x86_64, a register-spill
// descriptor with multiple fields). Passing c5's va_list to
// libc's vfprintf -- as `vfprintf(out, fmt, ap)` -- corrupts
// the formatter: it walks the wrong memory for arguments and
// emits garbage bytes (or crashes).
//
// Surfaced when sqlite3 shell.c's `cli_printf` chained through
// `sqlite3_vfprintf -> vfprintf`. Worked around there by
// routing through sqlite3_vmprintf (which is c5-compiled and
// agrees with c5's va_list view). The general fix is to either
// match c5's va_list to the platform's, or to provide
// c5-side wrappers around every variadic libc function that
// might be called with a forwarded va_list.
//
// Today this fixture exits 1: the libc vfprintf reads garbage
// for the int and writes the wrong characters. Once the va_list
// gap closes, it should exit 0.
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

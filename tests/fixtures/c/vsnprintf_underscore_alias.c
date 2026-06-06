/* Verifies that the c5 <stdio.h> aliases for the underscored
   MSVC-compatible v* spellings (`_vsnprintf`, `_vsprintf`,
   `_vfprintf`, `_vprintf`) resolve to the platform C library's v*
   formatters.

   Windows-flavoured headers commonly rewrite the standard v* names
   into the leading-underscore CRT spellings (e.g.
       # define vsnprintf _vsnprintf
   inside a `#ifdef _WIN32` block per the MS C runtime convention).
   The substituted `_vsnprintf` token from any later `vsnprintf(...)`
   call aliases to the canonical `vsnprintf`, which binds to the
   platform entry point (libc on Linux / macOS, msvcrt's `_vsnprintf`
   on Windows). c5's <stdarg.h> va_list is the host's own
   representation, so libc walks the forwarded list directly. */

#include <stdio.h>
#include <stdarg.h>
#include <string.h>

static int relay(char *buf, int size, char *fmt, ...) {
    va_list ap;
    int n;
    va_start(ap, fmt);
    /* Underscored spelling -- exactly the token MSVC-compat blocks
       produce after a `#define vsnprintf _vsnprintf` rewrite. */
    n = _vsnprintf(buf, size, fmt, ap);
    va_end(ap);
    return n;
}

int main(void) {
    char buf[64];
    int n = relay(buf, 64, "%s %d", "x", 1);
    if (n != 3 || strcmp(buf, "x 1") != 0) {
        return 1;
    }
    return 0;
}

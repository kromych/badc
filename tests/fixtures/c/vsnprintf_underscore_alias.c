/* Compile-only fixture: verifies that the c5 <stdio.h> aliases for
   the underscored MSVC-compatible v* spellings (`_vsnprintf`,
   `_vsprintf`, `_vfprintf`, `_vprintf`) resolve to the c5-side
   cursor-aware shims rather than to msvcrt's native va_list ABI.

   Windows-flavoured headers commonly rewrite the standard v*
   names into the leading-underscore CRT spellings (e.g.
       # define vsnprintf _vsnprintf
   inside a `#ifdef _WIN32` block per the MS C runtime convention).
   The substituted `_vsnprintf` token from any later `vsnprintf(...)`
   call has to land on `c5_vsnprintf` so the long-long-cursor
   va_list c5's <stdarg.h> produces reaches a walker that
   understands it. Without the alias the call resolves against
   msvcrt's `_vsnprintf` directly and the variadic reads come from
   the wrong slot offsets, leaving every argument past the first
   reading garbage.

   The c5 VM doesn't shim vsnprintf, so this fixture is exercised
   through compile_fixture rather than run_fixture; the runtime
   contract is covered by the PE-host fixture parity tests. */

#include <stdio.h>
#include <stdarg.h>

static int relay(char *buf, int size, char *fmt, ...) {
    va_list ap;
    int n;
    va_start(ap, fmt);
    /* Underscored spelling -- exactly the token MSVC-compat
       blocks produce after a `#define vsnprintf _vsnprintf`
       rewrite. Must resolve through the c5 alias. */
    n = _vsnprintf(buf, size, fmt, ap);
    va_end(ap);
    return n;
}

int main(void) {
    char buf[64];
    return relay(buf, 64, "%s %d", "x", 1);
}

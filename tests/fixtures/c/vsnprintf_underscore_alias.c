/* Compile-only fixture: verifies that the c5 <stdio.h> aliases for
   the underscored MSVC-compatible v* spellings (`_vsnprintf`,
   `_vsprintf`, `_vfprintf`, `_vprintf`) resolve to the c5-side
   cursor-aware shims rather than to msvcrt's native va_list ABI.

   Real-world trigger: tcc.h does
       # define vsnprintf _vsnprintf
   in its `#ifdef _WIN32` block. The substituted `_vsnprintf` token
   from any later `vsnprintf(...)` call has to land on
   `c5_vsnprintf` so the long-long-cursor va_list c5's <stdarg.h>
   produces reaches a walker that understands it. Without the
   alias the call resolves against msvcrt's `_vsnprintf` directly
   and the variadic reads come from wrong slot offsets. The
   tinycc-stage1 binary on windows-arm64 emitted garbage bytes
   for every `cstr_vprintf` predef line until this alias landed.

   The c5 VM doesn't shim vsnprintf, so this fixture is exercised
   through compile_fixture rather than run_fixture; the Windows
   tinycc self-host parity lane covers the runtime end-to-end. */

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

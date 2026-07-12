// assert.h -- runtime assertions.
//
// The `assert(expr)` macro expands to a conditional that reports the
// failed expression and terminates when `expr` is false. `NDEBUG`
// suppresses the check entirely (the macro becomes a no-op `((void)0)`).

#pragma once

// `printf` + `fflush` come from <stdio.h>; the message is flushed with
// `fflush(NULL)` (C99 7.21.5.2 flushes every open output stream) so it
// reaches the terminal before the trap.
#include <stdio.h>

#pragma intrinsic("__builtin_trap")

#ifdef NDEBUG
#define assert(expr) ((void)0)
#else
#define assert(expr) ((expr) ? ((void)0) : __c5_assert_fail(#expr, __FILE__, __LINE__))
#endif

// Inline trampoline that reports the failed expression and terminates
// through the `__builtin_trap()` illegal-instruction exception. Defined
// as a static c5 function so each TU that includes assert.h gets a copy
// at file scope. Acceptable: it's small and only fires on the failing
// path.
static _Noreturn void __c5_assert_fail(char *expr, char *file, int line) {
    printf("Assertion failed: %s, file %s, line %d\n", expr, file, line);
    fflush(0);
    __builtin_trap();
}

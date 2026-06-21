// Conditional directives may appear inside the argument list of a
// function-like macro call that spans several lines. C99 6.10.3p11
// leaves the result undefined, but the common toolchains evaluate the
// directives and include only the active branch, and real code (e.g.
// CPython's perf trampoline) depends on it. The inactive branches below
// reference undefined identifiers, so selecting the wrong branch fails
// to compile.

#include <stdio.h>

#define DEFINED_ONE 1
#define WRAP(body) do { body } while (0)

int main(void) {
    int r = 0;
    WRAP(
#ifdef DEFINED_ONE
        r += 1;
#else
        r += this_identifier_does_not_exist;
#endif
    );
    WRAP(
#ifndef NOT_DEFINED_AT_ALL
        r += 2;
#else
        r += this_identifier_does_not_exist;
#endif
    );
    WRAP(
#ifdef DEFINED_ONE
#if defined(ALSO_UNSET)
        r += this_identifier_does_not_exist;
#else
        r += 4;
#endif
#endif
    );
    if (r != 7) {
        printf("FAIL r=%d\n", r);
        return 1;
    }
    printf("ok\n");
    return 0;
}

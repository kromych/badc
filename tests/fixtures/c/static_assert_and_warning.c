/* Regression for the C11 6.7.10 `_Static_assert` / C23
 * `static_assert` declaration and the C23 / GNU `#warning`
 * directive. `#error` already worked; this fixture pins the
 * two adjacent diagnostics so neither regresses.
 *
 * Both spellings of static_assert must accept:
 *   * a non-zero constant integer expression at file scope
 *   * the same at block scope
 *   * a trailing `, "<message>"` (C11 form)
 *   * a bare `(<expr>)` with no message (C23 form)
 *
 * The fixture only exercises the success cases -- a failing
 * static_assert aborts the build, so it can't be a runtime
 * check. The `#warning` line emits but doesn't stop the
 * compile.
 */

#include <stdint.h>
#include <stdio.h>

#define ANSWER 42

_Static_assert(sizeof(int) >= 4, "int must be at least 32-bit");
static_assert(ANSWER == 42, "expected the canonical 42");
_Static_assert(1 << 4 == 16);
static_assert(0 + 1);

#warning fixture loaded -- this line emits one warning at parse time

int main(void) {
    static_assert(sizeof(long long) == 8, "long long must be 64-bit");
    _Static_assert(1, "block scope");

    int n = 0;
    if (ANSWER == 42) n++;
    if (sizeof(int) >= 4) n++;
    return n != 2;
}

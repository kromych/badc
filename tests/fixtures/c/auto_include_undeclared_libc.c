// C99 7.1.4p2: each library function may be implemented as a
// macro, an inline function, OR an external object with no header
// declaration visible at the call site. badc walks the embedded
// header registry before parsing and auto-includes any header
// that declares a libc-shaped identifier the source calls but
// did not bring in itself. Lets a minimalist TU that omits the
// `#include` lines still link against libc.

int main(void) {
    // No `#include <stdio.h>` and no hand-rolled prototype --
    // the scan must auto-include stdio.h so the `#pragma binding`
    // pulls printf in from libc.
    return printf("ok\n") > 0 ? 0 : 1;
}

// C99 6.5.16.1 + 6.5.2.2: a function that takes the address of a
// parameter and passes it to a same-block-tail call must NOT be
// rewritten to `jmp callee`. The tail-call lowering tears down the
// caller's frame before the jump, and the param cell holding the
// address would be overwritten by the callee's prologue. The
// `mz_uncompress` -> `mz_uncompress2` shape in miniz hit exactly
// this when only negative-slot LocalAddr was excluded; widening
// the exclusion to every LocalAddr fixes it.

#include <stdio.h>

static int sink(unsigned long *p) {
    return (*p == 17) ? 0 : 1;
}

static int wrap(unsigned long source_len) {
    return sink(&source_len);
}

int main(void) {
    return wrap(17);
}

// C99 6.2.2p4: a block-scope `extern` declaration may forward-reference
// a global that is defined later in the same translation unit. Every
// access -- a read-modify-write in a function parsed before the
// definition, and an address-of after it -- must resolve to the single
// object the definition allocates. The walker used to fall back to the
// parse-time identifier snapshot for the early reference, which carried
// a stale offset, so the increment landed at a different address than
// the definition.
#include <stdio.h>

static void bump(void) {
    extern int fwd_counter;
    fwd_counter++;
    fwd_counter += 4;
}

int fwd_counter = 0; // defined after bump() references it

int main(void) {
    bump();
    if (fwd_counter != 5) {
        return 1;
    }
    extern int fwd_counter;
    int *p = &fwd_counter;
    if (*p != 5) {
        return 2;
    }
    if (p != &fwd_counter) {
        return 3;
    }
    return 0;
}

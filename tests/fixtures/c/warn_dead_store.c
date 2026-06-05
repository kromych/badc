// Dead-store diagnostic fixtures. Each block exercises one
// pattern the analysis should catch when -Wdead-store is on, plus
// some shapes that must NOT fire to guard against false positives.

int dead_initializer(void) {
    int a = 1;     // dead: overwritten before any read.
    a = 2;         // dead: function returns without reading `a`.
    return 1;
}

int self_referencing_rhs(void) {
    int b = 5;     // live: read on the next line.
    b = b + 1;     // live: read on the return.
    return b;
}

int store_consumed_after_branch_is_silenced(int cond) {
    int c = 1;     // not flagged: a branch (Bz) flushes the tracker.
    if (cond) {
        c = 2;
    }
    return c;
}

int address_escapes_silences(void) {
    int d = 1;     // not flagged: `&d` escapes; callee may read.
    int *p = &d;
    return *p;
}

int main(void) {
    return dead_initializer()
         + self_referencing_rhs()
         + store_consumed_after_branch_is_silenced(1)
         + address_escapes_silences();
}

// A predicate whose left operand is a compile-time 0 -- the shape a
// disabled build-configuration flag compiles to -- selects an arm that
// calls a function declared and never defined. The walker folds the
// `0 && x` branch away at the point it builds the body, but the dead
// arm's instructions stay in the flat instruction array with no block
// naming them; a candidate filter reading the raw array judges the
// helper on code that cannot execute and leaves it out of line, where
// the caller's `else if` never sees a constant and keeps the call.
//
// Each predicate is also reachable with the flag on (`flag_on`), so the
// arms are dead by the constant, not by being unreferenced.

struct frame {
    unsigned long flags;
};

// Declared, never defined: only the disabled arms call these.
int absent_ia32(struct frame *f);
int absent_x32(struct frame *f);

static inline int is_ia32(struct frame *f) {
    return 0 && (f->flags & 2u);
}

static inline int is_x32(struct frame *f) {
    return 0 && (f->flags & 4u);
}

static inline int flag_on(struct frame *f) {
    return 1 && (f->flags & 8u);
}

static int x64_frame(struct frame *f) {
    return (int)(f->flags & 1u) + 10;
}

static int setup_frame(struct frame *f) {
    if (is_ia32(f))
        return absent_ia32(f);
    else if (is_x32(f))
        return absent_x32(f);
    else
        return x64_frame(f);
}

int dispatch(struct frame *f) {
    return setup_frame(f) + (flag_on(f) ? 1 : 0);
}

int main(void) {
    long acc = 0;
    for (unsigned long i = 0; i < 16u; i++) {
        struct frame f;
        f.flags = i;
        acc += dispatch(&f);
    }
    if (acc != 176)
        return 1;

    struct frame a = {0u};
    struct frame b = {9u};
    if (dispatch(&a) != 10)
        return 2;
    if (dispatch(&b) != 12)
        return 3;
    return 0;
}

// An always_inline callee that dispatches through a function-pointer
// parameter must still be spliced, so a guard on one of its scalar
// parameters folds once the constant argument lands. `absent_guard` is
// declared and never defined: it is reachable only when `rw` is neither
// value the callers pass, so leaving the callee out of line -- where
// `rw` stays a runtime parameter -- turns the guard into a link error.
//
// The callers cover the shapes whose block-id references the multi-block
// splice has to carry: a plain wrapper, a `switch`, and a computed goto.

enum rw { RW_R = 1, RW_W = 2 };

typedef int (*access_fn)(unsigned idx, long *data);

// Declared, never defined.
void absent_guard(void);

static int read_at(unsigned idx, long *data) {
    *data = (long)idx * 3;
    return 0;
}

static int write_at(unsigned idx, long *data) {
    *data += (long)idx;
    return 1;
}

static inline __attribute__((always_inline)) int access(unsigned idx, long *data,
                                                        enum rw rw, access_fn fn) {
    if (rw != RW_R && rw != RW_W)
        absent_guard();

    int ret = fn(idx, data);
    if (ret && rw == RW_R)
        *data = 0;
    if (rw == RW_W)
        return ret + 1;
    return ret;
}

static int wrapper(unsigned idx, long *data) {
    return access(idx, data, RW_R, read_at);
}

static int by_switch(int sel, unsigned idx, long *data) {
    switch (sel) {
    case 0:
        return access(idx, data, RW_R, read_at);
    case 1:
        return access(idx, data, RW_W, write_at);
    case 4:
        return access(idx + 1u, data, RW_R, read_at);
    case 9:
        return access(idx + 2u, data, RW_W, write_at);
    default:
        return -1;
    }
}

static int by_computed_goto(int sel, unsigned idx, long *data) {
    static void *table[] = {&&l0, &&l1, &&l2};
    int acc = 0;
    goto *table[sel % 3];
l0:
    acc = access(idx, data, RW_R, read_at);
    goto done;
l1:
    acc = access(idx, data, RW_W, write_at) * 2;
    goto done;
l2:
    acc = access(idx + 1u, data, RW_R, read_at) * 3;
    goto done;
done:
    return acc;
}

int main(void) {
    long d = 0;

    if (wrapper(5u, &d) != 0 || d != 15)
        return 1;

    d = 0;
    if (by_switch(0, 5u, &d) != 0 || d != 15)
        return 2;
    d = 4;
    if (by_switch(1, 5u, &d) != 2 || d != 9)
        return 3;
    d = 0;
    if (by_switch(4, 5u, &d) != 0 || d != 18)
        return 4;
    if (by_switch(7, 5u, &d) != -1)
        return 5;

    d = 0;
    if (by_computed_goto(0, 2u, &d) != 0 || d != 6)
        return 6;
    d = 1;
    if (by_computed_goto(1, 2u, &d) != 4 || d != 3)
        return 7;
    d = 0;
    if (by_computed_goto(2, 2u, &d) != 0 || d != 9)
        return 8;

    long acc = 0;
    for (int s = 0; s < 12; s++) {
        d = s;
        acc += by_switch(s, (unsigned)s, &d) + d;
        d = s;
        acc += by_computed_goto(s, (unsigned)s, &d) * 2 + d;
    }
    if (acc != 305)
        return 9;
    return 0;
}

// A guard whose short-circuit arms both decide the same way must delete
// the call it guards. The shape is a configuration predicate compiled to
// a constant: `flag_off` returns 0, so `!flag_off(o)` is 1 and the `||`
// is 1 on both paths; the mirrored `&&` is 0 on both. Each guards a call
// to a function that is declared and never defined, so the call surviving
// the fold is a link error rather than a silent size regression.
//
// C99 6.5.13p3 / 6.5.14p3 fix the operator result at 0 or 1, so the
// short-circuit edge carries a constant even when the deciding operand
// is a runtime comparison; the merge of two equal constants is then that
// constant and the branch folds.

struct obj {
    unsigned long flags;
    unsigned long ext;
};

// Declared, never defined: reachable only from a statically dead arm.
int absent_split(struct obj *o);
int absent_join(struct obj *o);

static inline int flag_off(const struct obj *o) {
    (void)o;
    return 0;
}

static inline unsigned order(const struct obj *o) {
    if (!(o->flags & 1u))
        return 0;
    return (unsigned)(o->ext & 0xffu);
}

static inline int unqueue(struct obj *o) {
    // `order(o) <= 1` is a runtime compare; `!flag_off(o)` folds to 1.
    if (order(o) <= 1 || !flag_off(o))
        return 0;
    return absent_split(o);
}

static inline int join(struct obj *o) {
    // Mirror: the runtime compare is ANDed with a constant 0.
    if (order(o) > 1 && flag_off(o))
        return absent_join(o);
    return 7;
}

int main(void) {
    struct obj a = {0u, 0u};
    struct obj b = {1u, 5u};
    struct obj c = {1u, 0u};

    if (unqueue(&a) != 0)
        return 1;
    if (unqueue(&b) != 0)
        return 2;
    if (unqueue(&c) != 0)
        return 3;

    if (join(&a) != 7)
        return 4;
    if (join(&b) != 7)
        return 5;
    if (join(&c) != 7)
        return 6;

    // Keep the guards live across a range of inputs so neither arm is
    // reachable only through a constant this fixture supplies.
    long acc = 0;
    for (unsigned i = 0; i < 8u; i++) {
        struct obj o;
        o.flags = i & 1u;
        o.ext = i;
        acc += unqueue(&o) + join(&o);
    }
    if (acc != 56)
        return 7;
    return 0;
}

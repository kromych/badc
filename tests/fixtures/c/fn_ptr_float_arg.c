// A float argument passed through a function pointer is converted to the
// pointer's declared parameter type, not promoted to double. The pointee
// signature's parameter types are recorded on the fn-pointer so an indirect
// call narrows each argument the same way a direct call does (C99 6.5.2.2p7
// vs the 6.5.2.2p6 default promotions, which apply only without a prototype).

static int take_float(float x) { return (int)(x * 2.0f); }
static int mix(int n, float x) { return n + (int)x; }

typedef int (*FF)(float);

// A callback type whose parameter name shadows an enclosing prototype's
// parameter: the inner list is a prototype, so its names have no linkage and
// must not collide. This is the shape libraries use for tokenizer/visitor
// callbacks.
static int run(int ctx, int (*cb)(int ctx, float v), float v) {
    return cb(ctx, v);
}

static int cb_impl(int ctx, float v) { return ctx + (int)v; }

int main(void) {
    FF p = take_float;
    if (p(2.5f) != 5) return 1;

    int (*pm)(int, float) = mix;
    if (pm(3, 4.5f) != 7) return 2;

    if (run(10, cb_impl, 2.5f) != 12) return 3;

    // A second float call catches a stale-register dependence.
    if (p(3.5f) != 7) return 4;

    return 0;
}

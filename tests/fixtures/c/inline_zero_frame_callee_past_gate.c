// The inliner's caller-frame gate bounds how far a splice may grow a
// caller's frame. A callee whose body holds nothing in the frame grows
// it by nothing, so the gate must not refuse it: a constant-returning
// guard left out of line turns a compile-time-false condition into a
// run-time one and keeps the call it guards.
//
// `undefined_crypto_free` is declared and never defined, so linking is
// the assertion -- it survives exactly when the guard stays out of line.
// The frame is driven past the gate first: each `grow_*` helper both
// holds a large array and makes a call, so its slots get a region of
// their own instead of sharing the pooled one leaf callees reuse.

extern void undefined_crypto_free(void *rq);

static long sink;

void consume(volatile long *p);
void consume(volatile long *p) {
    sink += p[0] + p[89];
}

#define GROW(n)                                                                                    \
    static void grow_##n(int k) {                                                                  \
        volatile long buf[90];                                                                     \
        int i;                                                                                     \
        for (i = 0; i < 90; i++)                                                                   \
            buf[i] = k + i;                                                                        \
        consume(buf);                                                                              \
    }

GROW(a)
GROW(b)
GROW(c)
GROW(d)

// The configuration-off form of a feature predicate: constant, and no
// frame slot of its own.
static inline int rq_is_encrypted(void *rq) {
    (void)rq;
    return 0;
}

static inline void free_crypto(void *rq) {
    if (rq_is_encrypted(rq))
        undefined_crypto_free(rq);
}

static void put_request(void *rq) {
    free_crypto(rq);
}

static int slot;

void submit(void *rq);
void submit(void *rq) {
    grow_a(1);
    grow_b(2);
    grow_c(3);
    grow_d(4);
    put_request(rq);
}

int main(void) {
    submit(&slot);
    // 1 + 89 for grow_a's first and last element, and so on through d.
    if (sink != (1 + 90) + (2 + 91) + (3 + 92) + (4 + 93))
        return 1;
    return 0;
}

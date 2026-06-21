// A by-value aggregate argument must reach the callee through the
// platform ABI -- System V AMD64 3.2.3 (an aggregate of at most two
// eightbytes in the integer / SSE register banks) and AAPCS64 6.4.2 /
// 6.8.2 (a composite of <= 16 bytes in GPRs, an HFA in the FP bank) --
// regardless of how the call site is shaped:
//   * a call through a function pointer (the pointed-to prototype's
//     parameter types drive the classification),
//   * a call in tail position (`return f(...)`),
//   * an argument that is a subscript / member lvalue rather than a
//     local, so its address is computed rather than a frame slot.
// Each must place the aggregate's eightbytes the same way the callee's
// prologue reads them; a by-address fallback on either end leaves a
// register holding a stale value.

typedef struct {
    long a, b;
} Pair; // two integer eightbytes
typedef struct {
    double x, y;
} Vec; // two SSE eightbytes / a 2-member HFA

static long take_pair(void *ctx, Pair p, void *tab, int n) {
    return p.a * 1000 + p.b * 10 + n + (ctx ? 0 : 0) + (tab ? 1 : 0);
}
static double take_vec(Vec v, int n) {
    return v.x * 4.0 + v.y * 2.0 + (double)n;
}

typedef long (*pair_fn)(void *ctx, Pair p, void *tab, int n);
typedef double (*vec_fn)(Vec v, int n);

// Indirect call with a by-value aggregate argument, in tail position.
static long pair_via_ptr(pair_fn fn, void *ctx, Pair p, void *tab, int n) {
    return fn(ctx, p, tab, n);
}
static double vec_via_ptr(vec_fn fn, Vec v, int n) {
    return fn(v, n);
}

struct Holder {
    void *head;
    Pair items[8];
};

// Aggregate argument from a subscript lvalue, in tail position.
static long pair_from_subscript(struct Holder *h, int i) {
    static int marker;
    return take_pair(h, h->items[i], &marker, i);
}

int main(void) {
    Pair p = {7, 3};
    if (take_pair(0, p, 0, 5) != 7035)
        return 1;
    if (pair_via_ptr(take_pair, 0, p, (void *)1, 5) != 7036)
        return 2;

    struct Holder h;
    h.head = 0;
    for (int i = 0; i < 8; i++) {
        h.items[i].a = i + 1;
        h.items[i].b = i;
    }
    // items[3] = {4, 3}; marker != 0 -> +1; n = 3.
    if (pair_from_subscript(&h, 3) != 4034)
        return 3;

    Vec v = {1.5, 2.25};
    if (take_vec(v, 1) != 1.5 * 4.0 + 2.25 * 2.0 + 1.0)
        return 4;
    if (vec_via_ptr(take_vec, v, 1) != 1.5 * 4.0 + 2.25 * 2.0 + 1.0)
        return 5;
    return 0;
}

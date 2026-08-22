/* Frame-slot sharing across block-scoped aggregates. dispatch() is one large
   function whose switch arms each declare their own array; the arms' live
   ranges are disjoint, so the frame holds one array-sized block rather than
   one per arm (the interpreter-loop shape, where per-arm storage otherwise
   multiplies the frame and with it C-stack recursion cost). The bound is a
   volatile load so no trip count is constant: the loops survive unrolling and
   the subscripts stay variable, which keeps the arrays memory-resident. The
   escape arm passes its array to a noinline helper, which pins that array to
   dedicated whole-function storage; results are checked against closed-form
   sums computed without arrays. Returns 0 on success. */

static volatile int bound = 64;

__attribute__((noinline)) static long long tally(const long long *p, int n) {
    long long s = 0;
    for (int i = 0; i < n; i++) s += p[i];
    return s;
}

__attribute__((noinline)) static long long dispatch(int op, long long x, int n) {
    long long r = 0;
    switch (op) {
    case 0: {
        long long a[64];
        for (int i = 0; i < n; i++) a[i] = x + i;
        for (int i = 0; i < n; i++) r += a[i];
        break;
    }
    case 1: {
        long long b[64];
        for (int i = 0; i < n; i++) b[i] = x * i;
        for (int i = 0; i < n; i++) r += b[i];
        break;
    }
    case 2: {
        long long c[64];
        for (int i = 0; i < n; i++) c[i] = x - i;
        for (int i = 0; i < n; i++) r += c[i];
        break;
    }
    case 3: {
        long long d[64];
        for (int i = 0; i < n; i++) d[i] = x ^ i;
        for (int i = 0; i < n; i++) r += d[i];
        break;
    }
    case 4: {
        long long e[64];
        for (int i = 0; i < n; i++) e[i] = x + 3 * i;
        r = tally(e, n);
        break;
    }
    }
    return r;
}

int main(void) {
    int n = bound;
    long long x = 1000, got = 0, want = 0;
    for (int op = 0; op < 5; op++) got += dispatch(op, x, n);
    for (int i = 0; i < n; i++)
        want += (x + i) + (x * i) + (x - i) + (x ^ i) + (x + 3 * i);
    return got == want ? 0 : 1;
}

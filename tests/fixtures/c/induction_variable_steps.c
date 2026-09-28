// Induction variables whose steps stay inside `int`. Without -fwrapv a
// signed step's overflow is undefined (C99 6.5p5), so -O takes each
// counter's renormalization as the identity; every loop below stays inside
// `int`, and the results are those any conforming build computes. The
// accumulator at the end keeps its renormalization. The exit code names
// the first check that fails.

#define NOINLINE __attribute__((noinline))

// An unguarded scan: only the value past the pivot ends it.
NOINLINE static int scan(const int *v, int pivot) {
    int i = 0;
    while (v[i] < pivot)
        i++;
    return i;
}

// The same scan from the other end.
NOINLINE static int scan_down(const int *v, int from, int pivot) {
    int j = from;
    while (v[j] > pivot)
        j--;
    return j;
}

// A constant stride.
NOINLINE static long stride(const int *v, int n) {
    long s = 0;
    for (int i = 0; i < n; i += 3)
        s += v[i];
    return s;
}

// A stride held in a variable.
NOINLINE static long stride_var(const int *v, int n, int k) {
    long s = 0;
    for (int i = 0; i < n; i += k)
        s += v[i];
    return s;
}

// A step by another induction variable.
NOINLINE static long triangle(const int *v, int n) {
    long s = 0;
    for (int i = 0, j = 0; i < n; i++, j += i)
        s += v[j];
    return s;
}

// `i <= n`, which no range bounds inside `int`.
NOINLINE static long upto(const int *v, int n) {
    long s = 0;
    for (int i = 0; i <= n; i++)
        s += v[i];
    return s;
}

// A counter that crosses zero, read at full width.
NOINLINE static long cross_zero(int from, int to) {
    long s = 0;
    for (int i = from; i < to; i++)
        s += (long)i * i - (i >> 1) + i / 3 + i % 5;
    return s;
}

// A bound on another expression of the counter.
NOINLINE static long square_bound(const int *v, long lim) {
    long s = 0;
    for (int i = 0; (long)i * i < lim; i++)
        s += v[i];
    return s;
}

// Two increments per iteration, as an interpreter's program counter.
NOINLINE static long two_steps(const unsigned char *code, int n) {
    long s = 0;
    int pc = 0;
    while (pc < n) {
        s += code[pc++];
        s -= 2 * code[pc++];
    }
    return s;
}

// A decreasing counter by three.
NOINLINE static long down3(const int *v, int n) {
    long s = 0;
    for (int i = n - 1; i >= 0; i -= 3)
        s += v[i];
    return s;
}

// The counter's value after the loop.
NOINLINE static long last_index(const int *v, int n, int x) {
    int i;
    for (i = 0; i < n && v[i] != x; i++)
        ;
    return i;
}

// An accumulator keeps its renormalization.
NOINLINE static long hash(const unsigned char *c, int n) {
    int h = 7;
    for (int i = 0; i < n; i++)
        h = h * 31 + c[i];
    return h;
}

static int v[64];
static unsigned char code[40];

int main(void) {
    for (int i = 0; i < 64; i++)
        v[i] = i * 7 - 50;
    for (int i = 0; i < 40; i++)
        code[i] = (unsigned char)(i * 13 + 5);
    volatile int n64 = 64, n40 = 40, k = 5, pivot = 200, low = -40;
    volatile long lim = 1000;

    if (scan(v, pivot) != 36) return 1;
    if (scan_down(v, 63, low) != 1) return 2;
    if (stride(v, n64) != 3751) return 3;
    if (stride_var(v, n64, k) != 2080) return 4;
    if (triangle(v, 11) != 990) return 5;
    if (upto(v, 62) != 10521) return 6;
    if (cross_zero(-37, 41) != 39721) return 7;
    if (square_bound(v, lim) != 1872) return 8;
    if (two_steps(code, n40) != -2488) return 9;
    if (down3(v, n64) != 3751) return 10;
    if (last_index(v, n64, 90) != 20 || last_index(v, n64, 91) != 64) return 11;
    if (hash(code, 5) != 205589112) return 12;
    return 0;
}

/* Blocks that hold no code after register allocation, and the ones that
 * look like them but do not. A branch is sent past an empty block only
 * when the block's outgoing edge moves nothing; each function below has an
 * edge that must keep its moves, or a block whose address something other
 * than a direct branch holds. Every check is against values computed here,
 * so the fixture checks itself at any optimization level. */

/* The `if` arm only renames: its block is empty and its edge to the join
 * swaps the two carried values, a parallel copy with a cycle. The skip
 * edge moves nothing. */
static long swap_walk(long a, long b, int n) {
    for (int i = 0; i < n; i++) {
        if (i & 1) { long t = a; a = b; b = t; }
    }
    return a * 3 + b;
}

/* Three carried values rotated on one edge, left in place on the other. */
static long rotate_walk(long a, long b, long c, int n) {
    for (int i = 0; i < n; i++) {
        if ((i % 3) == 0) { long t = a; a = b; b = c; c = t; }
    }
    return a * 100 + b * 10 + c;
}

/* An empty arm whose edge carries a constant and a copy. */
static long pick(long x, int k) {
    long r = x;
    if (k == 1) r = 7;
    else if (k == 2) r = x + x;
    else if (k == 3) { }
    return r * 2 + k;
}

/* A `double` pair swapped on an edge: the FP register file's copy. */
static double fswap_walk(double a, double b, int n) {
    for (int i = 0; i < n; i++) {
        if (i & 1) { double t = a; a = b; b = t; }
    }
    return a * 4.0 + b;
}

/* A dense switch whose cases are empty or share a body: the table's slots
 * name blocks that hold no code of their own. */
static int classify(int x) {
    int r = 0;
    switch (x) {
    case 0: break;
    case 1: case 2: r = 10; break;
    case 3: break;
    case 4: r = 40; break;
    case 5: case 6: case 7: break;
    case 8: r = 80; break;
    case 9: break;
    default: r = -1; break;
    }
    return r + x;
}

/* Computed goto through labels whose blocks are empty: each label's
 * address must name a place that continues at `out`. */
static int dispatch(int op, int v) {
    static const void *const table[] = { &&inc, &&nop, &&dbl, &&nop2 };
    goto *table[op & 3];
inc:
    v += 1;
    goto out;
nop:
    goto out;
dbl:
    v *= 2;
    goto out;
nop2:
    goto out;
out:
    return v;
}

/* A loop with no body and no exit edge of its own: left by the return. */
static int spin_until(int n) {
    int i = 0;
    for (;;) {
        if (i >= n) return i;
        i++;
    }
}

/* `continue` and the loop's step meet in blocks without code. */
static int count_odd(const unsigned char *p, int n) {
    int c = 0;
    for (int i = 0; i < n; i++) {
        if (!(p[i] & 1)) continue;
        c++;
    }
    return c;
}

/* Loops whose bottom test is repeated ahead of the body at -O: no trip,
 * one trip, many; a test that loads; a nest, whose inner loop is entered
 * once per outer trip. */
static long sum_to(const int *a, int n) {
    long s = 0;
    for (int i = 0; i < n; i++) s += a[i];
    return s;
}

static long run_len(const char *p) {
    long n = 0;
    while (p[n]) n++;
    return n;
}

static long grid(int rows, int cols) {
    long s = 0;
    for (int r = 0; r < rows; r++)
        for (int c = 0; c < cols; c++) s += r * cols + c;
    return s;
}

static unsigned halvings(unsigned n) {
    unsigned steps = 0;
    while (n != 0) { n >>= 1; steps++; }
    return steps;
}

int main(void) {
    if (swap_walk(1, 2, 0) != 5) return 1;
    if (swap_walk(1, 2, 1) != 5) return 2;   /* i = 0: no swap */
    if (swap_walk(1, 2, 2) != 7) return 3;   /* i = 1 swaps */
    if (swap_walk(1, 2, 4) != 5) return 4;   /* two swaps */
    if (swap_walk(1, 2, 7) != 7) return 5;   /* three swaps */

    if (rotate_walk(1, 2, 3, 0) != 123) return 6;
    if (rotate_walk(1, 2, 3, 1) != 231) return 7;
    if (rotate_walk(1, 2, 3, 4) != 312) return 8;
    if (rotate_walk(1, 2, 3, 7) != 123) return 9;

    if (pick(5, 0) != 10) return 10;
    if (pick(5, 1) != 15) return 11;
    if (pick(5, 2) != 22) return 12;
    if (pick(5, 3) != 13) return 13;

    if (fswap_walk(1.0, 2.0, 1) != 6.0) return 14;
    if (fswap_walk(1.0, 2.0, 2) != 9.0) return 15;
    if (fswap_walk(1.0, 2.0, 4) != 6.0) return 16;

    static const int want[11] = { 0, 11, 12, 3, 44, 5, 6, 7, 88, 9, 9 };
    for (int x = 0; x < 11; x++) {
        if (classify(x) != want[x]) return 20 + x;
    }
    if (classify(-3) != -4) return 31;

    if (dispatch(0, 5) != 6) return 32;
    if (dispatch(1, 5) != 5) return 33;
    if (dispatch(2, 5) != 10) return 34;
    if (dispatch(3, 5) != 5) return 35;

    if (spin_until(0) != 0 || spin_until(9) != 9) return 36;

    static const unsigned char bytes[8] = { 1, 2, 3, 5, 8, 13, 21, 34 };
    if (count_odd(bytes, 8) != 5) return 37;
    if (count_odd(bytes, 0) != 0) return 38;

    static const int ints[8] = { 3, -1, 4, -1, 5, -9, 2, 6 };
    if (sum_to(ints, 0) != 0 || sum_to(ints, -2) != 0) return 39;
    if (sum_to(ints, 1) != 3 || sum_to(ints, 8) != 9) return 40;
    if (run_len("") != 0 || run_len("a") != 1 || run_len("abcdefg") != 7) return 41;
    if (grid(0, 5) != 0 || grid(3, 0) != 0 || grid(1, 1) != 0) return 43;
    if (grid(3, 4) != 66) return 44;
    if (halvings(0) != 0 || halvings(1) != 1 || halvings(255) != 8) return 45;
    return 42;
}

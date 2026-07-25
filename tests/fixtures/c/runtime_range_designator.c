/* GNU array range designator `[lo ... hi] = value` in an automatic
   (runtime-classified) initializer. The value expression is evaluated
   once and its bytes fill every element of the range (gcc semantics,
   probed via side-effect counters); positional entries resume after
   the range end; a later designator overrides an earlier range with
   the last entry winning. Covers 1/2/4/8-byte and floating element
   widths, a deferred size taken from the range end, and gaps
   receiving zero. Asserted by return code. */

static int calls;
static int next(int seed) {
    calls++;
    return seed;
}

static int check_once_eval(int seed) {
    calls = 0;
    int a[17] = { [0 ... 16] = next(seed) };
    if (calls != 1) return 101;
    for (int i = 0; i < 17; i++)
        if (a[i] != seed) return 1;
    return 0;
}

static int check_resume_and_gap(int seed) {
    /* [1 ... 3] filled, positional 42 lands at index 4, gaps stay 0 */
    int a[6] = { [1 ... 3] = next(seed), 42 };
    if (a[0] != 0 || a[5] != 0) return 2;
    if (a[1] != seed || a[2] != seed || a[3] != seed) return 3;
    if (a[4] != 42) return 4;
    return 0;
}

static int check_override(int seed) {
    /* a later single designator overrides one range slot; the range
       value still initializes the surviving slots, so both entries
       are evaluated exactly once (gcc-verified) */
    calls = 0;
    int b[5] = { [0 ... 4] = next(seed), [2] = next(seed + 7) };
    if (calls != 2) return 102;
    if (b[0] != seed || b[1] != seed || b[3] != seed || b[4] != seed) return 5;
    if (b[2] != seed + 7) return 6;
    /* overlapping ranges: the last one wins on the overlap */
    int c[6] = { [0 ... 3] = seed, [2 ... 5] = seed + 1 };
    if (c[0] != seed || c[1] != seed) return 7;
    if (c[2] != seed + 1 || c[3] != seed + 1 || c[5] != seed + 1) return 8;
    return 0;
}

static int check_widths(int seed) {
    calls = 0;
    char c[8] = { [2 ... 5] = (char)next(65) };
    short s[5] = { [0 ... 4] = (short)next(seed) };
    long long w[3] = { [0 ... 2] = next(seed) * 1000000000LL };
    double d[4] = { [1 ... 2] = next(seed) / 2.0 };
    float f[3] = { [0 ... 2] = next(seed) / 4.0f };
    if (calls != 5) return 103;
    if (c[0] != 0 || c[1] != 0 || c[2] != 65 || c[5] != 65 || c[6] != 0) return 9;
    if (s[0] != seed || s[4] != seed) return 10;
    if (w[0] != seed * 1000000000LL || w[2] != seed * 1000000000LL) return 11;
    if (d[0] != 0.0 || d[1] != seed / 2.0 || d[2] != seed / 2.0 || d[3] != 0.0) return 12;
    if (f[0] != seed / 4.0f || f[2] != seed / 4.0f) return 13;
    return 0;
}

static int check_deferred(int seed) {
    /* deferred size resolves to range end + 1 (C99 6.7.8p22) */
    calls = 0;
    const unsigned dm[] = { [0 ... 16] = (unsigned)next(seed) };
    if (sizeof(dm) / sizeof(dm[0]) != 17) return 104;
    if (calls != 1) return 105;
    for (int i = 0; i < 17; i++)
        if (dm[i] != (unsigned)seed) return 14;
    /* a plain designator past the positional count also sizes the array */
    int sp[] = { 1, [5 ... 6] = next(seed), 3 };
    if (sizeof(sp) / sizeof(sp[0]) != 8) return 106;
    if (sp[0] != 1 || sp[4] != 0 || sp[5] != seed || sp[6] != seed || sp[7] != 3) return 15;
    return 0;
}

int main(void) {
    int r;
    if ((r = check_once_eval(11))) return r;
    if ((r = check_resume_and_gap(23))) return r;
    if ((r = check_override(31))) return r;
    if ((r = check_widths(12))) return r;
    if ((r = check_deferred(19))) return r;
    return 0;
}

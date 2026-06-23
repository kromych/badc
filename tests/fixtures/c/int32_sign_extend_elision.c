// C99 6.5p5 / 6.2.5p9 / 6.3.1.3: 32-bit integer arithmetic is computed
// in the low word and wraps mod 2^32, and a widening to a 64-bit type
// sign-extends the 32-bit result. The redundant-extend pass drops the
// per-op sign-narrow only where no consumer reads the upper bits; the
// consumers below (long widening, signed compare, pointer index) do
// read them, so the kept extensions must still produce the right value.
// Expected exits cross-checked against clang -O2. Returns 0 on success.

static int sum4(int a, int b, int c, int d) { return a + b + c + d; }
static long widen(int a, int b) {
    int s = a + b;
    return (long)s;
}
static int sgn(int a, int b) {
    int s = a * b;
    return s < 0;
}
static long pick(int *p, int i, int j) {
    int k = i + j;
    return p[k];
}
static unsigned uwrap(unsigned a, unsigned b) { return a + b; }

int main(void) {
    int imax = 2147483647;
    int imin = -2147483647 - 1;
    if (sum4(imax, 1, imin, -1) != -1) return 1;
    if (widen(imin, -1) != 2147483647L) return 2;
    if (widen(2000000000, 2000000000) != -294967296L) return 3;
    if (sgn(-3, 4) != 1) return 4;
    if (sgn(imin, 2) != 0) return 5;
    if (uwrap(0xFFFFFFFFu, 2u) != 1u) return 6;
    int arr[5] = {10, 20, 30, 40, 50};
    if (pick(arr + 2, -1, -1) != 10) return 7;
    return 0;
}

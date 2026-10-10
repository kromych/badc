/* A frame that calls alloca and keeps its spill slots below a 4 KiB
   local array, past the frame pointer's unscaled reach, while the array
   itself is reached through one address. Fifteen values live across two
   calls round-trip through those slots. Returns 0 when the sums match. */

__attribute__((noinline)) static void touch(char *p, char *q) {
    ((volatile char *)p)[0] = 1;
    ((volatile char *)q)[0] = 2;
}

__attribute__((noinline)) static long f(long n) {
    char pad[4096];
    char *q = (char *)__builtin_alloca(n);
    long a0 = n * 3, a1 = n * 5, a2 = n * 7, a3 = n * 11, a4 = n * 13, a5 = n * 17,
         a6 = n * 19, a7 = n * 23, a8 = n * 29, a9 = n * 31, a10 = n * 37, a11 = n * 41,
         a12 = n * 43, a13 = n * 47, a14 = n * 53;
    touch(pad, q);
    long s = a0 + a1 + a2 + a3 + a4 + a5 + a6 + a7 + a8 + a9 + a10 + a11 + a12 + a13 + a14;
    touch(pad, q);
    s += a0 * a1 + a2 * a3 + a4 * a5 + a6 * a7 + a8 * a9 + a10 * a11 + a12 * a13 + a14;
    return s + pad[0] + q[0];
}

static long expect(long n) {
    static const long k[15] = {3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53};
    long s = 0;
    int i;
    for (i = 0; i < 15; i++) s += n * k[i];
    for (i = 0; i < 14; i += 2) s += (n * k[i]) * (n * k[i + 1]);
    return s + n * k[14] + 1 + 2;
}

int main(void) {
    if (f(2) != expect(2)) return 1;
    if (f(9) != expect(9)) return 2;
    return 0;
}

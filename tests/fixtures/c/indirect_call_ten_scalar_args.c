// Ten integer arguments through a function pointer: the first eight
// ride the integer argument registers and the ninth and tenth land in
// the host stack overflow slots (AAPCS64 6.4.1 stage C / SysV AMD64
// 3.2.3). A distinct positional weight per argument makes any slot
// permutation or missed overflow store change the result.

static long weight10(long a, long b, long c, long d, long e, long f, long g, long h, long i,
                     long j) {
    return a * 1 + b * 2 + c * 3 + d * 4 + e * 5 + f * 6 + g * 7 + h * 8 + i * 9 + j * 10;
}

typedef long (*w10)(long, long, long, long, long, long, long, long, long, long);

volatile long base = 1;

int main(void) {
    w10 p = weight10;
    long b0 = base;
    long r = p(b0, b0 + 1, b0 + 2, b0 + 3, b0 + 4, b0 + 5, b0 + 6, b0 + 7, b0 + 8, b0 + 9);
    if (r != 385) return 1; /* sum of k*k, k = 1..10 */
    long d = weight10(b0, b0 + 1, b0 + 2, b0 + 3, b0 + 4, b0 + 5, b0 + 6, b0 + 7, b0 + 8, b0 + 9);
    if (r != d) return 2;
    return 0;
}

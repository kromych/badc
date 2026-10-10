/* A frame that reserves its outgoing argument area once shares it
 * between a call with stack arguments and the binary128 conversions,
 * which save the registers they borrow at [sp, #0] (AAPCS64 Linux).
 * Fourteen values are computed before the conversions and read after
 * them, six of them in borrowed registers at -O, and the call that
 * follows stores its stack arguments in the same bytes. Returns 0
 * when every value matches; where long double is not binary128 the
 * conversions are plain moves and the same values result. */

long double ld[3] = {1.5L, 0.0L, 1e300L};
static volatile long va = 3, vb = 5;

static long weigh10(long a, long b, long c, long d, long e, long f, long g, long h, long i,
                    long j) {
    return a + 2 * b + 3 * c + 4 * d + 5 * e + 6 * f + 7 * g + 8 * h + 9 * i + 10 * j;
}

static long (*volatile p10)(long, long, long, long, long, long, long, long, long,
                            long) = weigh10;

static long weigh14(const long *t) {
    long s = 0;
    int i;
    for (i = 0; i < 14; i++) s += (i + 1) * t[i];
    return s;
}

__attribute__((noinline)) static long mix(long a, long b) {
    long t0 = a * 3, t1 = b * 5, t2 = a + b, t3 = a - b, t4 = a * b, t5 = a + 7, t6 = b + 9,
         t7 = a * 11, t8 = b * 13, t9 = a ^ b, t10 = a | 64, t11 = b << 3, t12 = a * a,
         t13 = b * b;
    double d = (double)ld[0];
    long s = t0 + 2 * t1 + 3 * t2 + 4 * t3 + 5 * t4 + 6 * t5 + 7 * t6 + 8 * t7 + 9 * t8 +
             10 * t9 + 11 * t10 + 12 * t11 + 13 * t12 + 14 * t13;
    ld[1] = d * 2.0;
    long u = t13 - t12 + t11 - t10 + t9 - t8 + t7;
    long r = p10(t0, t1, t2, t3, t4, t5, t6, s, u, b);
    double e = (double)ld[2];
    return r + s + (long)(d * 4.0) + (e > 1e299 ? 1 : 0);
}

int main(void) {
    long a = va, b = vb;
    long t[14] = {a * 3, b * 5, a + b, a - b, a * b, a + 7, b + 9,
                  a * 11, b * 13, a ^ b, a | 64, b << 3, a * a, b * b};
    long s = weigh14(t);
    long u = t[13] - t[12] + t[11] - t[10] + t[9] - t[8] + t[7];
    long want = weigh10(t[0], t[1], t[2], t[3], t[4], t[5], t[6], s, u, b) + s + 6 + 1;
    if (mix(a, b) != want) return 1;
    if (ld[1] != 3.0L) return 2;
    return 0;
}

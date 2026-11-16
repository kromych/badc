// Values one inner loop updates live through a second inner loop that
// never reads them, more of them than leave the second loop's own values a
// register: each keeps its value past the second loop, whichever loop holds
// the register meanwhile. The second loop leaves by its test or by a break,
// and a value is read past both exits. Each result is checked against the
// same computation over a volatile array. Returns 0 when every check passes;
// each failure returns a distinct code. The values are unsigned, so their
// arithmetic wraps (C17 6.2.5p9).

typedef unsigned long u;

__attribute__((noinline)) u direct(const unsigned char *a, const unsigned char *b, long n,
                                      long m, const u *o) {
    u x0 = o[0], x1 = o[1], x2 = o[2], x3 = o[3], x4 = o[4];
    u x5 = o[5], x6 = o[6], x7 = o[7], x8 = o[8], x9 = o[9];
    u k = 0;
    for (long r = 0; r < n; r++) {
        for (long j = 0; j < m; j++) {
            x0 += j;
            x1 ^= x0;
            x2 += x1;
            x3 ^= x2;
            x4 += x3;
            x5 ^= x4;
            x6 += x5;
            x7 ^= x6;
            x8 += x7;
            x9 ^= x8;
        }
        const unsigned char *p = a + r, *q = b;
        long len = 0;
        while (len < m) {
            if (*p++ != *q++)
                break;
            len++;
        }
        k += len * (r + 1);
        x0 ^= len;
    }
    return k + x0 + x1 * 3 + x2 * 5 + x3 * 7 + x4 * 9 + x5 * 11 + x6 * 13 + x7 * 15 + x8 * 17 +
           x9 * 19;
}

__attribute__((noinline)) u reference(const unsigned char *a, const unsigned char *b, long n,
                                         long m, const u *o) {
    volatile u x[10];
    for (int i = 0; i < 10; i++)
        x[i] = o[i];
    u k = 0;
    for (long r = 0; r < n; r++) {
        for (long j = 0; j < m; j++) {
            x[0] += j;
            for (int i = 1; i < 10; i++)
                x[i] = (i & 1) ? (x[i] ^ x[i - 1]) : (x[i] + x[i - 1]);
        }
        long len = 0;
        while (len < m && a[r + len] == b[len])
            len++;
        k += len * (r + 1);
        x[0] ^= len;
    }
    u s = k;
    for (int i = 0; i < 10; i++)
        s += x[i] * (2 * i + 1);
    return s;
}

// The second loop has two exits, each followed by its own read of a value
// the first loop updated.
__attribute__((noinline)) u two_exits(const unsigned char *a, long n, long m, const u *o) {
    u y0 = o[0], y1 = o[1], y2 = o[2], y3 = o[3], y4 = o[4], y5 = o[5];
    u y6 = o[6], y7 = o[7], y8 = o[8], y9 = o[9], y10 = o[10];
    u k = 0;
    for (long r = 0; r < n; r++) {
        for (long j = 0; j < m; j++) {
            y0 += j ^ y10;
            y1 += y0;
            y2 ^= y1;
            y3 += y2;
            y4 ^= y3;
            y5 += y4;
            y6 ^= y5;
            y7 += y6;
            y8 ^= y7;
            y9 += y8;
            y10 ^= y9;
        }
        const unsigned char *p = a + r;
        long i = 0;
        for (;;) {
            if (i >= m) {
                k += y3;
                break;
            }
            if (p[i] == 0) {
                k ^= y7;
                break;
            }
            i++;
        }
        k += i;
    }
    return k + y0 + y1 + y2 + y4 + y5 + y6 + y8 + y9 + y10;
}

__attribute__((noinline)) u two_exits_reference(const unsigned char *a, long n, long m,
                                                   const u *o) {
    volatile u y[11];
    for (int i = 0; i < 11; i++)
        y[i] = o[i];
    u k = 0;
    for (long r = 0; r < n; r++) {
        for (long j = 0; j < m; j++) {
            y[0] += j ^ y[10];
            for (int i = 1; i < 11; i++)
                y[i] = (i & 1) ? (y[i] + y[i - 1]) : (y[i] ^ y[i - 1]);
        }
        long i = 0;
        for (;;) {
            if (i >= m) {
                k += y[3];
                break;
            }
            if (a[r + i] == 0) {
                k ^= y[7];
                break;
            }
            i++;
        }
        k += i;
    }
    u s = k;
    for (int i = 0; i < 11; i++)
        if (i != 3 && i != 7)
            s += y[i];
    return s;
}

int main(void) {
    unsigned char a[96], b[48];
    for (int i = 0; i < 96; i++)
        a[i] = (unsigned char)((i * 7) % 5 == 0 ? 0 : 1 + i % 3);
    for (int i = 0; i < 48; i++)
        b[i] = (unsigned char)(1 + i % 3);
    u o[11];
    for (int i = 0; i < 11; i++)
        o[i] = 0x1234567 * (i + 1) ^ (i << 20);
    if (direct(a, b, 40, 40, o) != reference(a, b, 40, 40, o))
        return 1;
    if (direct(a, b, 7, 0, o) != reference(a, b, 7, 0, o))
        return 2;
    if (two_exits(a, 40, 40, o) != two_exits_reference(a, 40, 40, o))
        return 3;
    if (two_exits(a, 9, 3, o) != two_exits_reference(a, 9, 3, o))
        return 4;
    return 0;
}

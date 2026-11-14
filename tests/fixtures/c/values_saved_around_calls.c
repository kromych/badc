// More integer, floating and vector values live across a call than the
// target has callee-saved registers for: each keeps its value through the
// calls, whichever place holds it. A loop updates them all and calls out
// on some iterations; the result is checked against the same update over
// an array. Returns 0 when every check passes; each failure returns a
// distinct code.

typedef int i4 __attribute__((vector_size(16)));

__attribute__((noinline)) long touch(long x) { return x ^ 0x5a5a; }
__attribute__((noinline)) double scale(double x) { return x * 0.5 + 1.0; }
__attribute__((noinline)) i4 swap(i4 v) { return (i4){v[3], v[2], v[1], v[0]}; }

__attribute__((noinline)) long ints(const long *p, int n) {
    long a0 = p[0], a1 = p[1], a2 = p[2], a3 = p[3], a4 = p[4], a5 = p[5], a6 = p[6];
    long a7 = p[7], a8 = p[8], a9 = p[9], a10 = p[10], a11 = p[11], a12 = p[12], a13 = p[13];
    for (int i = 0; i < n; i++) {
        a0 += i;
        a1 ^= a0;
        a2 += a1;
        a3 ^= a2;
        a4 += a3;
        a5 ^= a4;
        a6 += a5;
        a7 ^= a6;
        a8 += a7;
        a9 ^= a8;
        a10 += a9;
        a11 ^= a10;
        a12 += a11;
        a13 ^= a12;
        if ((i & 7) == 0)
            a0 = touch(a0);
    }
    return a0 + a1 + a2 + a3 + a4 + a5 + a6 + a7 + a8 + a9 + a10 + a11 + a12 + a13;
}

__attribute__((noinline)) long ints_ref(const long *p, int n) {
    long a[14];
    for (int k = 0; k < 14; k++)
        a[k] = p[k];
    for (int i = 0; i < n; i++) {
        a[0] += i;
        for (int k = 1; k < 14; k++)
            a[k] = (k & 1) ? (a[k] ^ a[k - 1]) : (a[k] + a[k - 1]);
        if ((i & 7) == 0)
            a[0] = touch(a[0]);
    }
    long s = 0;
    for (int k = 0; k < 14; k++)
        s += a[k];
    return s;
}

__attribute__((noinline)) double doubles(const double *p, int n) {
    double d0 = p[0], d1 = p[1], d2 = p[2], d3 = p[3], d4 = p[4], d5 = p[5];
    double d6 = p[6], d7 = p[7], d8 = p[8], d9 = p[9], d10 = p[10], d11 = p[11];
    for (int i = 0; i < n; i++) {
        d0 += 1.0;
        d1 += d0;
        d2 += d1;
        d3 += d2;
        d4 += d3;
        d5 += d4;
        d6 += d5;
        d7 += d6;
        d8 += d7;
        d9 += d8;
        d10 += d9;
        d11 += d10;
        if ((i & 3) == 0)
            d0 = scale(d0);
    }
    return d0 + d1 + d2 + d3 + d4 + d5 + d6 + d7 + d8 + d9 + d10 + d11;
}

__attribute__((noinline)) double doubles_ref(const double *p, int n) {
    double d[12];
    for (int k = 0; k < 12; k++)
        d[k] = p[k];
    for (int i = 0; i < n; i++) {
        d[0] += 1.0;
        for (int k = 1; k < 12; k++)
            d[k] += d[k - 1];
        if ((i & 3) == 0)
            d[0] = scale(d[0]);
    }
    double s = 0;
    for (int k = 0; k < 12; k++)
        s += d[k];
    return s;
}

__attribute__((noinline)) i4 vectors(i4 v0, i4 v1, i4 v2, int n) {
    for (int i = 0; i < n; i++) {
        v0 += (i4){i, 1, 2, 3};
        v1 ^= v0;
        v2 += v1;
        if ((i & 1) == 0)
            v0 = swap(v0);
    }
    return v0 + v1 + v2;
}

int main(void) {
    long p[14];
    double q[12];
    for (int k = 0; k < 14; k++)
        p[k] = 1000 + k * 37;
    for (int k = 0; k < 12; k++)
        q[k] = 0.25 * k;
    volatile int n = 100;
    if (ints(p, n) != ints_ref(p, n))
        return 1;
    if (doubles(q, n) != doubles_ref(q, n))
        return 2;
    i4 a = {1, 2, 3, 4}, b = {5, 6, 7, 8}, c = {9, 10, 11, 12};
    i4 r = vectors(a, b, c, n);
    i4 v0 = a, v1 = b, v2 = c;
    for (int i = 0; i < n; i++) {
        i4 inc = {i, 1, 2, 3};
        for (int k = 0; k < 4; k++)
            v0[k] += inc[k];
        for (int k = 0; k < 4; k++)
            v1[k] ^= v0[k];
        for (int k = 0; k < 4; k++)
            v2[k] += v1[k];
        if ((i & 1) == 0)
            v0 = (i4){v0[3], v0[2], v0[1], v0[0]};
    }
    for (int k = 0; k < 4; k++)
        if (r[k] != v0[k] + v1[k] + v2[k])
            return 3;
    return 0;
}

// Floating values past the argument registers take the other volatile
// registers (d19..d31 on AArch64, xmm8..xmm12 on System V x86-64), which
// a callee then writes while its caller holds values across the call.
// Every value is an integer below 2^53, so the double arithmetic is exact
// and matches the long reference. Returns 0 when every result matches.

__attribute__((noinline)) static double spread(double a, double b) {
    double v0 = a + 1.0, v1 = a + 2.0, v2 = a + 3.0, v3 = a + 4.0;
    double v4 = b + 5.0, v5 = b + 6.0, v6 = b + 7.0, v7 = b + 8.0;
    double v8 = a * b, v9 = a - b, v10 = a * 3.0, v11 = b * 5.0;
    double v12 = a + b, v13 = b - a, v14 = a * 7.0, v15 = b * 9.0;
    return v0 * v1 + v2 * v3 + v4 * v5 + v6 * v7 + v8 * v9 + v10 * v11 +
           v12 * v13 + v14 * v15;
}

static long spread_ref(long a, long b) {
    return (a + 1) * (a + 2) + (a + 3) * (a + 4) + (b + 5) * (b + 6) +
           (b + 7) * (b + 8) + a * b * (a - b) + a * 3 * b * 5 +
           (a + b) * (b - a) + a * 7 * b * 9;
}

__attribute__((noinline)) static double across(double a, double b) {
    double k0 = a * 2.0, k1 = a * 3.0, k2 = a * 5.0, k3 = a * 7.0;
    double k4 = b * 2.0, k5 = b * 3.0, k6 = b * 5.0, k7 = b * 7.0;
    double k8 = a + b, k9 = a - b, k10 = a * b, k11 = a + 11.0;
    double s = spread(a, b) + spread(b, a);
    return s + k0 + k1 * 2.0 + k2 * 3.0 + k3 * 4.0 + k4 * 5.0 + k5 * 6.0 +
           k6 * 7.0 + k7 * 8.0 + k8 * 9.0 + k9 * 10.0 + k10 * 11.0 +
           k11 * 12.0;
}

static long across_ref(long a, long b) {
    return spread_ref(a, b) + spread_ref(b, a) + a * 2 + a * 3 * 2 +
           a * 5 * 3 + a * 7 * 4 + b * 2 * 5 + b * 3 * 6 + b * 5 * 7 +
           b * 7 * 8 + (a + b) * 9 + (a - b) * 10 + a * b * 11 +
           (a + 11) * 12;
}

static const long pairs[][2] = {{3, 5}, {-4, 9}, {1000, -77}, {0, 1}};

int main(void) {
    for (int i = 0; i < (int)(sizeof pairs / sizeof pairs[0]); i++) {
        long a = pairs[i][0], b = pairs[i][1];
        if (spread((double)a, (double)b) != (double)spread_ref(a, b))
            return 1 + 2 * i;
        if (across((double)a, (double)b) != (double)across_ref(a, b))
            return 2 + 2 * i;
    }
    return 0;
}

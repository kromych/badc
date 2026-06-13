// A function whose returned value is a floating-point constant must
// deliver it in the FP return register (C99 6.2.5p10 / 6.8.6.4): d0 on
// AAPCS64, xmm0 on System V / Win64. A bare constant materializes as an
// integer immediate in a GPR, and the return path keyed the result
// register off the producing instruction's register file rather than the
// declared return type, so the constant never reached the FP register and
// the caller read a stale value. The early `return 0.0` reached after a
// cancellation (the shape a precise-summation reducer uses) was the
// original symptom. `prime` leaves a non-zero double live in the FP return
// register before each call so a missing materialization is observable.
// Asserted by return code.

static double prime(double *v, int n) {
    double last = 0.0;
    for (int i = 0; i < n; i++)
        last = v[i];
    return last;
}

static double ret_zero(void) { return 0.0; }
static double ret_one(void) { return 1.0; }
static double ret_half(int unused) { return 0.5; }
static float ret_quarter_f(void) { return 0.25f; }

// Mirrors the reducer shape: a loop that decrements past every zero limb,
// then an early floating-constant return.
static double sum_zero(const long *acc, int n_limbs) {
    int n = n_limbs;
    while (n > 0 && acc[n - 1] == 0)
        n--;
    if (n == 0)
        return 0.0;
    return (double)acc[n - 1];
}

int main(void) {
    double dirty[2] = {1e308, -1e308};
    long acc[8] = {0, 0, 0, 0, 0, 0, 0, 0};

    prime(dirty, 2);
    if (ret_zero() != 0.0) return 1;
    prime(dirty, 2);
    if (ret_one() != 1.0) return 2;
    prime(dirty, 2);
    if (ret_half(7) != 0.5) return 3;
    prime(dirty, 2);
    if ((double)ret_quarter_f() != 0.25) return 4;
    prime(dirty, 2);
    if (sum_zero(acc, 8) != 0.0) return 5;
    return 0;
}

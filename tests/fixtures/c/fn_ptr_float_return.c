// A call through a function pointer whose return type is `float` yields a
// single-precision value (C99 6.2.5p10 / 6.3.1.8). The indirect-call result
// must be tagged single-precision so the result store reads the s-register
// view; otherwise it narrows the d-register a second time and the value is
// destroyed. A `double`-returning function pointer and `double` arguments
// are unaffected.

static float f_void(void) { return 2.5f; }
static float f_int(int n) { return n * 0.5f; }
static float f_double(double d) { return (float)(d + 1.0); }
static double d_int(int n) { return n * 0.25; }

int main(void) {
    float (*pv)(void) = f_void;
    if (pv() != 2.5f) return 1;

    float (*pi)(int) = f_int;
    if (pi(10) != 5.0f) return 2;

    float (*pd)(double) = f_double;
    if (pd(2.0) != 3.0f) return 3;

    // A second call to catch a stale FP-register dependence.
    if (pv() != 2.5f) return 4;

    // double return through a function pointer stays correct.
    double (*qd)(int) = d_int;
    if (qd(8) != 2.0) return 5;

    return 0;
}

/* A homogeneous floating-point aggregate passed in SIMD registers
   (AAPCS64 6.4.2) ahead of arguments the registers run out for: a pointer
   and three `int`s on the stack, which Apple's arm64 convention places at
   their own sizes. Each stack argument keeps its own width when the
   aggregate goes as its parts. The exit code names the first mismatch. */

#define NOINLINE __attribute__((noinline))

struct R { float x, y, w, h; };

static int target = 42;

NOINLINE long f(struct R r, long a, long b, long c, long d, long e, long g, long h, long k,
                int *p, int i, int j, int m) {
    if (p != &target)
        return 1;
    if (*p != 42 || i != -7 || j != 9 || m != -11)
        return 2;
    return (long)(r.x + r.y * 2 + r.w * 3 + r.h * 4) + a + b + c + d + e + g + h + k == 30 + 36 ? 0 : 3;
}

int main(void) {
    volatile float one = 1.0f;
    struct R r = { one, 2.0f * one, 3.0f * one, 4.0f * one };
    long n = (long)one;
    return (int)f(r, n, 2 * n, 3 * n, 4 * n, 5 * n, 6 * n, 7 * n, 8 * n, &target, -7, 9, -11);
}

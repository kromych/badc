// An int local passed to a long parameter in a stack-placed argument slot
// converts by sign extension (C17 6.3.1.3): the parameter holds the
// negative value whether the call reads the local from its frame home or
// from a register. Ten arguments place the last ones on the stack under the SysV
// x86-64 (six in registers), AAPCS64 (eight), and Microsoft x64 (four)
// conventions.
//
// Returns 0 on success, otherwise the number of the failing check.

__attribute__((noinline)) static long tail(long a, long b, long c, long d, long e, long f,
                                           long g, long h, long i, long j) {
    return a + b + c + d + e + f + g * 1000 + h * 100 + i * 10 + j;
}

__attribute__((noinline)) static long pick(int n, long k, long m, long p, long q, long r,
                                           long s, long t, long u, long last) {
    return last + n;
}

int main(int argc, char **argv) {
    (void)argv;
    int v = -argc;
    int w = -2 * argc;
    int x = -3 * argc;
    int y = -4 * argc;
    if (tail(0, 0, 0, 0, 0, 0, v, w, x, y) != -1234L * argc) {
        return 1;
    }
    int big = -2147483647 - (argc > 0);
    if (pick(0, 0, 0, 0, 0, 0, 0, 0, 0, big) != -2147483648L) {
        return 2;
    }
    return 0;
}

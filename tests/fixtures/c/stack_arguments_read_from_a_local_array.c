// A call whose stack-placed arguments are elements of a local array, as a
// register-setting helper passing a whole table does. Each value must be
// the one the element held when the argument was evaluated: one read and
// then overwritten before the call keeps the value read.

#include <stdarg.h>

__attribute__((noinline)) static long sum_weighted(int n, ...) {
    va_list ap;
    long s = 0;
    va_start(ap, n);
    for (int i = 0; i < n; i++)
        s += (long)(i + 1) * va_arg(ap, long);
    va_end(ap);
    return s;
}

int main(int argc, char **argv) {
    (void)argv;
    // A trip count the compiler cannot see keeps the array in memory.
    int n = argc > 0 ? 20 : 0;
    long tmp[20];
    for (int i = 0; i < n; i++)
        tmp[i] = 3 * i + 1;
    long first = tmp[0];
    tmp[0] = 1000;
    long s = sum_weighted(21, tmp[1], tmp[2], tmp[3], tmp[4], tmp[5], tmp[6], tmp[7],
                          tmp[8], tmp[9], tmp[10], tmp[11], tmp[12], tmp[13], tmp[14],
                          tmp[15], tmp[16], tmp[17], tmp[18], tmp[19], first, tmp[0]);
    long want = 0;
    for (int i = 1; i < 20; i++)
        want += (long)i * (3 * i + 1);
    want += 20L * 1 + 21L * 1000;
    return s == want ? 0 : 1;
}

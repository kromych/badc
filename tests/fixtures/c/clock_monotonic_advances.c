// POSIX clock_gettime + CLOCK_MONOTONIC. The clockid_t integer
// assignments are implementation-defined: Linux glibc / musl use
// MONOTONIC = 1, Apple libSystem uses MONOTONIC = 6, and a
// mismatched header would land on EINVAL with the timespec
// untouched. The fixture asserts the call succeeds, the timespec
// gets populated with a plausible monotonic value, and a second
// call observes a non-decreasing time.
//
// Returns 0 on success; distinct nonzero codes flag each failure
// mode for diagnostics.

#include <time.h>
#include <stdlib.h>

int main(void) {
    struct timespec t1;
    struct timespec t2;

    // Sentinel so we can tell whether clock_gettime actually wrote.
    t1.tv_sec = -1;
    t1.tv_nsec = -1;

    if (clock_gettime(CLOCK_MONOTONIC, &t1) != 0) return 1;
    if (t1.tv_sec == -1 && t1.tv_nsec == -1) return 2;
    if (t1.tv_sec < 0) return 3;
    if (t1.tv_nsec < 0 || t1.tv_nsec >= 1000000000) return 4;

    // Spin briefly so t2 strictly differs from t1 (or at minimum
    // is non-decreasing).
    volatile int spin = 0;
    for (int i = 0; i < 1000000; i++) spin = spin + 1;

    if (clock_gettime(CLOCK_MONOTONIC, &t2) != 0) return 5;
    if (t2.tv_sec < t1.tv_sec) return 6;
    if (t2.tv_sec == t1.tv_sec && t2.tv_nsec < t1.tv_nsec) return 7;

    return 0;
}

// C99 6.3.1.4: converting a floating value to an unsigned integer
// truncates toward zero using the unsigned target. A double in
// [2^63, 2^64) exceeds the signed 64-bit range, where a signed
// truncate instruction saturates to the integer indefinite. Narrower
// unsigned targets and signed targets keep the signed truncate.
#include <stdio.h>

int main(void) {
    double a = 1e19;                  // exact in double, > 2^63
    double b = 9223372036854775808.0; // 2^63
    double c = 1.8e19;
    double sm = 100.0;                // below 2^63, fast path
    double neg = -5.0;                // signed target

    if ((unsigned long long)a != 10000000000000000000ULL) {
        return 1;
    }
    if ((unsigned long long)b != 9223372036854775808ULL) {
        return 2;
    }
    if ((unsigned long long)c != 18000000000000000000ULL) {
        return 3;
    }
    if ((unsigned long long)sm != 100ULL) {
        return 4;
    }
    if ((long long)neg != -5) {
        return 5;
    }
    if ((unsigned int)sm != 100u) {
        return 6;
    }
    // Round-trip the sqlite3AtoF pattern: (u64)(double)v for v >= 2^63.
    unsigned long long v = 10000000000000000000ULL;
    if ((unsigned long long)(double)v != v) {
        return 7;
    }
    return 0;
}

// Locks C99 6.8.6.4p3: the value of a `return` expression is
// converted to the function's return type as if by assignment.
// An integer-typed `return` from a `double`-returning function
// must lift through the int-to-float conversion; landing the
// integer bit pattern in the FP slot makes a downstream
// `(double)x == 505.0` compare the bit pattern of 505 against
// 505.0 (different bit patterns) and lose.
//
// A function returns an int from a prototype declared to return a
// floating type; without the conversion a version check that reads
// the value as a double sees garbage (2.4950e-321) instead of the
// intended 505.0.

#include <stdio.h>
#include <string.h>

static double get_int_as_double(void) {
    return 505;
}

static double get_negative(void) {
    return -1;
}

int main(void) {
    double v = get_int_as_double();
    if (v != 505.0) return 1;
    if (v < 504.0 || v > 506.0) return 2;

    double n = get_negative();
    if (n != -1.0) return 3;
    if (n != (double)-1) return 4;

    // Sanity check that the bit pattern is the proper IEEE-754
    // representation: 505.0 = 0x407F900000000000.
    unsigned long long bits;
    memcpy(&bits, &v, sizeof(bits));
    if (bits != 0x407F900000000000ULL) return 5;
    return 0;
}

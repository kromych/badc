// Locks C99 6.5.15p5: a conditional expression with arithmetic arms
// converts both arms to the usual-arithmetic-conversions common type.
// The earlier lowering stored one arm through the other arm's store kind
// (an integer arm written as a double, etc.), so a mixed int / floating
// ternary read back garbage.
//
// Each failure returns a distinct nonzero code.

int main(void) {
    int c = 1, z = 0;
    // int / double -> double
    if ((c ? 1 : 2.0) != 1.0) return 11;
    if ((z ? 1 : 2.0) != 2.0) return 12;
    // double / int -> double (result type from the non-last arm)
    if ((c ? 1.0 : 2) != 1.0) return 13;
    if ((z ? 1.0 : 2) != 2.0) return 14;
    // float / double -> double (the float arm widens)
    if ((c ? 1.0f : 2.0) != 1.0) return 15;
    if ((z ? 1.0f : 2.0) != 2.0) return 16;
    // float / int -> float
    if ((c ? 1.0f : 2) != 1.0f) return 17;
    if ((z ? 1.0f : 2) != 2.0f) return 18;
    // pure integer arms are unaffected
    if ((c ? 10 : 20) != 10) return 21;
    long L = z ? 1 : 2L;
    if (L != 2) return 22;
    return 0;
}

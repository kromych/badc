// Locks C99 6.4.4.2 -- the floating-suffix is one of f / F / l / L.
// `f`/`F` type the constant `float`, `l`/`L` `long double` (which c5
// represents as double). 1.0 is exact in every precision, so the
// four spellings of the value must all land at the same bit pattern
// after conversion to double.
//
// Returns 0 only when every check passes; each failure path
// returns a distinct nonzero code.

int main(void) {
    double a = 1.0f;
    double b = 1.0F;
    double c = 1.0l;
    double d = 1.0L;
    if (a != b) return 11;
    if (a != c) return 12;
    if (a != d) return 13;
    if (a != 1.0) return 14;

    // Exponent-form with a long-double suffix must lex cleanly.
    double e = 1.5e10L;
    if (e != 1.5e10) return 15;

    // The disambiguator must still treat a bare integer with `L`
    // as a long integer, not a malformed float.
    long li = 7L;
    if (li != 7) return 16;

    return 0;
}

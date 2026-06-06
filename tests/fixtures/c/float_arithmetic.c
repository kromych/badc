// Double arithmetic end-to-end (C99 6.5 / 6.3.1.x). Exercises the
// Fadd/Fsub/Fmul/Fdiv/FCMP/FpCast pipeline at f64 precision. The
// single-precision `float` path is covered by float_single_precision.c
// and float_double_mix.c.

int main() {
    double a;
    double b;
    double c;
    int i;

    // Basic arithmetic.
    a = 1.5;
    b = 2.5;
    c = a + b;             // 4.0
    if (c != 4.0) return 1;

    c = b - a;             // 1.0
    if (c != 1.0) return 2;

    c = a * b;             // 3.75
    if (c != 3.75) return 3;

    c = b / a;             // 5/3 = 1.6666...
    if (c <= 1.6) return 4;
    if (c >= 1.7) return 5;

    // Unary minus.
    c = -a;                // -1.5
    if (c != -1.5) return 6;
    if (-c != 1.5) return 7;

    // Comparisons return ordinary 0/1 ints.
    if ((a < b) != 1) return 8;
    if ((a > b) != 0) return 9;
    if ((a == a) != 1) return 10;
    if ((a != b) != 1) return 11;
    if ((a <= a) != 1) return 12;
    if ((a >= b) != 0) return 13;

    // Casts: int <-> double round-trip.
    i = 7;
    a = (double)i;         // 7.0
    if (a != 7.0) return 14;
    a = a + 0.5;           // 7.5
    i = (int)a;            // truncates to 7
    if (i != 7) return 15;
    i = (int)(a + 0.5);    // 8.0 -> 8
    if (i != 8) return 16;

    // Negative truncation: (int)-1.7 == -1 (truncating, C semantics).
    a = -1.7;
    i = (int)a;
    if (i != -1) return 17;

    return 0;
}

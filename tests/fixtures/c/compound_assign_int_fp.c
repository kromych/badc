// C99 6.5.16.2: a compound assignment `E1 op= E2` performs the
// operation in the common type of E1 and E2, then converts the
// result to E1's type. When E1 is an integer lvalue and E2 is
// floating, the operation runs in floating point and the result is
// converted back to the integer type. Results are asserted by return
// code, matching the values a separate compiler produces.

int main(void) {
    long a = 10;
    a += 3.9; // 13.9 -> 13
    if (a != 13) return 1;

    long b = 10;
    b -= 2.5; // 7.5 -> 7
    if (b != 7) return 2;

    long c = 10;
    c *= 2.5; // 25.0 -> 25
    if (c != 25) return 3;

    long d = 100;
    d /= 3.0; // 33.33 -> 33
    if (d != 33) return 4;

    int e = 7;
    e += 2.9f; // float rhs: 9.9 -> 9
    if (e != 9) return 5;

    long f = -10;
    f += 100.7; // 90.7 -> 90
    if (f != 90) return 6;

    unsigned long g = 5;
    g *= 3.5; // 17.5 -> 17
    if (g != 17) return 7;

    short h = 100;
    h += 50.6; // 150.6 -> 150
    if (h != 150) return 8;

    // The reduced shape from the original report: a divisor in a
    // double drives an integer accumulator.
    long s = 100;
    double r = 3.0;
    s += 1 / r; // 100.333 -> 100
    if (s != 100) return 9;

    // A floating-point lvalue with an integer rhs must still work
    // (the operation runs in floating point throughout).
    double x = 1.5;
    int n = 3;
    x += n; // 4.5
    x *= 2;  // 9.0
    if (x != 9.0) return 10;

    return 0;
}

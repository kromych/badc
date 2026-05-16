// Locks IEEE 754 / C99 6.5.8p4 + 6.5.9p3 + footnote 96: a NaN
// compares unordered with everything, so `==` / `<` / `<=` /
// `>` / `>=` return 0 when either operand is NaN, and `!=`
// returns 1.
//
// x86_64's UCOMISD signals unordered by setting CF=1, ZF=1,
// and PF=1 simultaneously. A `setcc` keyed off ZF or CF alone
// (`E`, `Ne`, `B`, `Be`) reads the wrong bit -- the ordered
// path must mask against `setnp`, and `!=` must OR in `setp`.

#include <stdio.h>

int main(void) {
    double a = 0.0;
    double n = a / a;        // NaN
    double v = 5.0;          // non-NaN
    double inf = 1.0 / a;

    // `!=` must yield 1 on every NaN comparison.
    if (!(n != n)) return 1;
    if (!(n != v)) return 2;
    if (!(v != n)) return 3;
    if (!(n != 0.0)) return 4;

    // `==` must yield 0 on every NaN comparison.
    if (n == n) return 10;
    if (n == v) return 11;
    if (v == n) return 12;
    if (n == 0.0) return 13;

    // Relational ops are all false when an operand is NaN.
    if (n < v) return 20;
    if (n > v) return 21;
    if (n <= v) return 22;
    if (n >= v) return 23;
    if (v < n) return 24;
    if (v > n) return 25;
    if (v <= n) return 26;
    if (v >= n) return 27;
    if (n < n) return 28;
    if (n <= n) return 29;
    if (n >= n) return 30;

    // Sanity: ordered comparisons still resolve correctly,
    // and Inf is ordered.
    if (!(v < 6.0)) return 40;
    if (!(v == 5.0)) return 41;
    if (!(inf > v)) return 42;
    if (!(inf > 1.0e300)) return 43;
    if (inf != inf) return 44;
    return 0;
}

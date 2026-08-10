// C99 7.20.6.2: div / ldiv / lldiv return the quotient and remainder
// of an integer division as a small aggregate by value. The quotient
// truncates toward zero (C99 6.5.5p6), so quot * denom + rem == numer
// for either sign. <stdlib.h> provides these inline.
#include <stdlib.h>

// `volatile` keeps the operands runtime values, so the division and the
// aggregate return are emitted rather than folded.
static int rti(int v) { volatile int t = v; return t; }
static long rtl(long v) { volatile long t = v; return t; }
static long long rtll(long long v) { volatile long long t = v; return t; }

int main(void) {
    div_t a = div(rti(17), rti(5));
    if (a.quot != 3 || a.rem != 2) return 1;
    div_t b = div(rti(-17), rti(5));
    if (b.quot != -3 || b.rem != -2) return 2;
    if (b.quot * 5 + b.rem != -17) return 3;
    ldiv_t c = ldiv(rtl(100L), rtl(7L));
    if (c.quot != 14 || c.rem != 2) return 4;
    lldiv_t d = lldiv(rtll(1000LL), rtll(3LL));
    if (d.quot != 333 || d.rem != 1) return 5;
    return 0;
}

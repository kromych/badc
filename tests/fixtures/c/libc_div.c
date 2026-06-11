// C99 7.20.6.2: div / ldiv / lldiv return the quotient and remainder
// of an integer division as a small aggregate by value. The quotient
// truncates toward zero (C99 6.5.5p6), so quot * denom + rem == numer
// for either sign. <stdlib.h> provides these inline.
#include <stdlib.h>

int main(void) {
    div_t a = div(17, 5);
    if (a.quot != 3 || a.rem != 2) return 1;
    div_t b = div(-17, 5);
    if (b.quot != -3 || b.rem != -2) return 2;
    if (b.quot * 5 + b.rem != -17) return 3;
    ldiv_t c = ldiv(100L, 7L);
    if (c.quot != 14 || c.rem != 2) return 4;
    lldiv_t d = lldiv(1000LL, 3LL);
    if (d.quot != 333 || d.rem != 1) return 5;
    return 0;
}

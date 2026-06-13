// C99 7.12.12.1 fdim: positive difference, x - y if x > y else +0.
// 7.12.6.13 scalbn / scalbln: x * 2^n, provided inline through ldexp.
#include <math.h>

int main(void) {
    if (fdim(5.0, 3.0) != 2.0) return 1;
    if (fdim(3.0, 5.0) != 0.0) return 2;
    if (fdim(3.0, 3.0) != 0.0) return 3;
    if (scalbn(1.0, 3) != 8.0) return 4;
    if (scalbn(3.0, -1) != 1.5) return 5;
    if (scalbln(1.0, 4L) != 16.0) return 6;
    if (scalbnf(1.0f, 2) != 4.0f) return 7;
    if (fdimf(5.0f, 3.0f) != 2.0f) return 8;
    return 0;
}

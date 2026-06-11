// C99 7.20.6.1 labs / llabs and 7.8.2.1-4 imaxabs / imaxdiv /
// strtoimax / strtoumax. The absolute-value and division helpers
// reduce to a sign test and the / and % operators (quotient truncated
// toward zero, 6.5.5p6); the string conversions forward to the long
// long parsers. All provided inline by the headers.
#include <stdlib.h>
#include <inttypes.h>

int main(void) {
    if (labs(-7L) != 7) return 1;
    if (llabs(-9LL) != 9) return 2;
    if (labs(-2147483648L) != 2147483648L) return 3;
    if (imaxabs((intmax_t)-11) != 11) return 4;
    imaxdiv_t d = imaxdiv(-17, 5);
    if (d.quot != -3 || d.rem != -2) return 5;
    if (d.quot * 5 + d.rem != -17) return 6;
    if (strtoimax("12345", 0, 10) != 12345) return 7;
    if (strtoumax("ff", 0, 16) != 255) return 8;
    return 0;
}

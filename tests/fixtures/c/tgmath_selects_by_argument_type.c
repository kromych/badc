// C99 7.22p3: a type-generic macro calls the function of the type its
// generic arguments determine -- long double if any has that type, else
// double if any is double or an integer, else float -- and a parameter
// that is not generic (frexp's, ldexp's exponent) takes no part. 7.9:
// <iso646.h> spells the operators.
#include <iso646.h>
#include <tgmath.h>

#define KIND(e) _Generic((e), float: 1, double: 2, long double: 3, default: 0)

int main(void) {
    float f = 2.0f;
    const float cf = 0.5f;
    double d = 2.0;
    long double ld = 2.0L;
    int i = 2, e = 0;
    char c = 4;

    if (KIND(sqrt(f)) != 1 or KIND(sqrt(d)) != 2 or KIND(sqrt(ld)) != 3) return 1;
    if (KIND(sqrt(i)) != 2 or KIND(sqrt(c)) != 2 or KIND(sin(cf)) != 1) return 2;
    if (KIND(pow(f, f)) != 1 or KIND(pow(f, i)) != 2 or KIND(pow(f, d)) != 2) return 3;
    if (KIND(pow(d, ld)) != 3 or KIND(atan2(f, ld)) != 3 or KIND(fmax(i, i)) != 2) return 4;
    if (KIND(fma(f, f, f)) != 1 or KIND(fma(f, f, d)) != 2 or KIND(fma(f, ld, f)) != 3) return 5;
    if (KIND(ldexp(f, i)) != 1 or KIND(frexp(f, &e)) != 1 or KIND(ldexp(ld, 3)) != 3) return 6;
    if (sqrt(f) != (float)sqrt(2.0) or fabs(-ld) != 2.0L or pow(i, 3) != 8.0) return 7;
    if (frexp(8.0f, &e) != 0.5f or e != 4 or ldexp(cf, 2) != 2.0f) return 8;
    if (lround(2.5f) != 3 or ilogb(8.0) != 3 or floor(-f / 3) != -1.0f) return 9;
    if (not(1 bitand 3) or (5 xor 1) != 4 or (compl 0) != -1 or (1 not_eq 1)) return 10;
    i or_eq 4;
    i and_eq 6;
    i xor_eq 1;
    if (i != 7 or not (i > 0 and i < 8) or (2 bitor 1) != 3) return 11;
    return 0;
}

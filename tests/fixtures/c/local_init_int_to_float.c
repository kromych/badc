// C99 6.5.16.1p2: the RHS of an assignment is converted to the
// unqualified LHS type. For a float / double local with an
// integer-typed initializer (e.g. `float r = data[i];` where
// `data[i]` is `unsigned char`), the integer must be lifted to
// IEEE-754 representation before the store lands.
//
// The bytecode tier always emits the Fcvtif at the rhs site;
// the dual-emit captured `pending_local_init_ast` BEFORE
// `convert_assign_rhs` ran, so the Cast wrapper produced by
// the conversion never reached the walker. Walker saw the raw
// integer rvalue, stored it with `Store kind = F32`, and the
// IEEE-754 bit pattern of the float local became the integer
// bit pattern of the byte value -- a tiny denormal that
// effectively zeroes the float.
//
// Any code path that reads an integer pixel value into a
// float local (`float r = u8_pixel;`) hits this: the float
// local collapses to a denormal near zero instead of the
// integer's IEEE-754 conversion, and any subsequent
// floating-point arithmetic produces near-zero output.
//
// The pin: declare a float local with each conversion shape
// in the C99 menu and verify the resulting bit pattern.

#include <stdio.h>

int main(void) {
    unsigned char buf[4] = {42, 100, 200, 255};

    // unsigned char -> float
    float r = buf[0];
    if (r < 41.9f || r > 42.1f) {
        printf("FAIL u8->float: r=%f\n", (double)r);
        return 1;
    }

    // int -> float (positive)
    int i = 12345;
    float f1 = i;
    if (f1 < 12344.5f || f1 > 12345.5f) {
        printf("FAIL int->float: f1=%f\n", (double)f1);
        return 2;
    }

    // int -> double
    int j = -7;
    double d1 = j;
    if (d1 < -7.5 || d1 > -6.5) {
        printf("FAIL int->double: d1=%f\n", d1);
        return 3;
    }

    // unsigned -> float
    unsigned u = 4294967295u;
    float f2 = u;
    if (f2 < 4.29e9f || f2 > 4.30e9f) {
        printf("FAIL u32->float: f2=%f\n", (double)f2);
        return 4;
    }

    // float -> int (reverse direction)
    float v = 3.7f;
    int k = v;
    if (k != 3) {
        printf("FAIL float->int: k=%d\n", k);
        return 5;
    }

    // double -> int
    double w = -2.9;
    int m = w;
    if (m != -2) {
        printf("FAIL double->int: m=%d\n", m);
        return 6;
    }

    return 0;
}

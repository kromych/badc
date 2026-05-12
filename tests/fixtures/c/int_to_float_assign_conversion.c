// Regression for C99 6.5.16.1p2 assignment conversion: when the
// destination is a floating type and the rvalue is an integer
// (a very common case via `unsigned char` array reads), the
// integer bit pattern in `a` must be lifted to f64 with
// `Op::Fcvtif` before the store. Without the conversion, the
// stored slot read back later through a `float` load returns
// the raw integer bit pattern interpreted as a tiny denormal --
// every downstream FP computation sees ~0 and aggregates like
// JPEG's DCT collapse to zero output.

#include <stdio.h>

int main(void) {
    unsigned char data[3];
    data[0] = 10;
    data[1] = 100;
    data[2] = 200;

    // Local initializer: `float = uchar`.
    float r = data[0];
    float g = data[1];
    float b = data[2];
    if ((int)(r * 10) != 100) return 1;
    if ((int)(g * 10) != 1000) return 2;
    if ((int)(b * 10) != 2000) return 3;

    // Plain assignment to a float lvalue.
    float v;
    v = data[1];
    if ((int)(v * 100) != 10000) return 4;

    // Mixed FP arithmetic across the converted operand.
    float y = 0.299f * r + 0.587f * g + 0.114f * b - 128.0f;
    // Reference (using actual IEEE-754 f32 constants):
    //   0.299*10 + 0.587*100 + 0.114*200 - 128 = -43.5099...
    if (y > -43.0f || y < -44.0f) return 5;

    // Reverse direction: float lvalue holds an int converted
    // through the FP-arith path. Same conversion site fires on
    // re-store.
    int n = 7;
    float fn = n;
    if (fn != 7.0f) return 6;

    printf("int-to-float conversion OK\n");
    return 0;
}

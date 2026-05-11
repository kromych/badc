// Regression for 3D array indexing. c5 used to track only the
// immediately-inner dim on a symbol (`inner_array_size`), so for
// `T xs[A][B][C]` the third subscript fell back to a scalar
// load whose computed offset was off by a factor of B*C / 1. The
// indexing path now reads `array_dims` for the full shape and
// scales each of the N-1 leading subscripts by the right stride
// while keeping the result at pointer level. The innermost
// subscript still falls through to the regular sizeof + decay
// path.

#include <stdio.h>

static unsigned char tbl[2][3][4] = {
    { {1,2,3,4}, {5,6,7,8}, {9,10,11,12} },
    { {13,14,15,16}, {17,18,19,20}, {21,22,23,24} }
};

static int sum_row(unsigned char *row) {
    return row[0] + row[1] + row[2] + row[3];
}

int main(void) {
    // Two-subscript decay yields a pointer to the innermost row.
    if (sum_row(tbl[0][0]) != 1+2+3+4) return 1;
    if (sum_row(tbl[0][2]) != 9+10+11+12) return 2;
    if (sum_row(tbl[1][1]) != 17+18+19+20) return 3;

    // Three-subscript decay yields a scalar element.
    if (tbl[0][0][0] != 1) return 4;
    if (tbl[0][2][3] != 12) return 5;
    if (tbl[1][2][3] != 24) return 6;

    // Stride correctness on the outer index: the difference
    // between consecutive outer planes is B*C bytes.
    if (tbl[1][0][0] - tbl[0][0][0] != 12) return 7;

    // Stride correctness on the middle index: the difference
    // between consecutive rows in the same outer plane is C.
    if (tbl[0][1][0] - tbl[0][0][0] != 4) return 8;

    printf("3d-array OK\n");
    return 0;
}

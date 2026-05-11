// Regression: 2D float arrays initialised with one nested brace
// list per row, where each row provides fewer values than the
// inner dimension. C99 6.7.8p21 says any aggregate sub-object
// not explicitly initialised is initialised to zero, so the
// trailing slots of each short row must read back as 0.
//
// c5 used to flatten the nested brace lists without padding,
// so the second row's first value landed in row 0's fourth
// slot, the third row's first value landed in row 1's third
// slot, and the whole table was off-by-one per row from there
// on. A pointer indexed as `basis[row]` then read the wrong
// bytes for every row past the first.
//
// Two distinct value paths matter here:
//   * Integer literals (`1`, `-1`, `0`) in a float-typed slot
//     have to convert to f64 bits at write time (C99 6.3.1.4
//     implicit conversion of an int to a real-floating type).
//     c5's slot model uses 8-byte slots even for `float`, so
//     storing the raw `1` would leave bytes that read back as
//     a tiny denormal.
//   * Nested `{ row }` whose count is less than the inner
//     dim must be zero-padded so the next row starts on the
//     right stride.

#include <stdio.h>

static float basis[12][4] =
{
    {  1, 1, 0 },
    { -1, 1, 0 },
    {  1,-1, 0 },
    { -1,-1, 0 },
    {  1, 0, 1 },
    { -1, 0, 1 },
    {  1, 0,-1 },
    { -1, 0,-1 },
    {  0, 1, 1 },
    {  0,-1, 1 },
    {  0, 1,-1 },
    {  0,-1,-1 },
};

static const float expected[12][4] = {
    { 1, 1, 0, 0 },
    { -1, 1, 0, 0 },
    { 1, -1, 0, 0 },
    { -1, -1, 0, 0 },
    { 1, 0, 1, 0 },
    { -1, 0, 1, 0 },
    { 1, 0, -1, 0 },
    { -1, 0, -1, 0 },
    { 0, 1, 1, 0 },
    { 0, -1, 1, 0 },
    { 0, 1, -1, 0 },
    { 0, -1, -1, 0 },
};

int main(void) {
    int i, j;
    for (i = 0; i < 12; i++) {
        for (j = 0; j < 4; j++) {
            if (basis[i][j] != expected[i][j]) {
                fprintf(stderr,
                    "basis[%d][%d]=%f expected %f\n",
                    i, j, (double)basis[i][j], (double)expected[i][j]);
                return 1;
            }
        }
    }

    /* Touch the FP arithmetic path too -- a dot-product-style
     * fold across the columns confirms the stored bit patterns
     * survive being loaded back through ordinary FP math. */
    float sum = 0.0f;
    for (i = 0; i < 12; i++) {
        sum += basis[i][0] + basis[i][1] + basis[i][2];
    }
    /* Expected: column-0 sum = 0, column-1 sum = 0, column-2 sum = 0,
     * so total sum = 0. */
    if (sum != 0.0f) {
        fprintf(stderr, "column sum %f != 0\n", (double)sum);
        return 2;
    }
    return 0;
}

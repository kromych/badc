// Regression: 2D float arrays initialised with one nested brace
// list per row, where each row provides fewer values than the
// inner dimension. Standard C zero-fills the trailing slots.
//
// stb_perlin's gradient table is the canonical case:
//   static float basis[12][4] = {
//       {  1, 1, 0 },
//       { -1, 1, 0 },
//       ...
//   };
// The fourth column is intentionally absent (and reads as 0).
// c5 used to flatten the nested brace lists without padding,
// so the second row's first value landed in row 0's fourth
// slot, the third row's first value landed in row 1's third
// slot, and the whole table was off-by-one per row from there
// on. The Perlin grad function reads `basis[grad_idx][0..3]`
// and produced NaN (the misaligned bytes for some rows landed
// on accumulated junk).
//
// Two distinct value paths matter here:
//   * Integer literals (`1`, `-1`, `0`) in a float-typed slot
//     have to convert to f64 bits at write time. c5's slot
//     model uses 8-byte slots even for `float`, so storing
//     the raw `1` would leave bytes that read back as 5e-324.
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

    /* Touch the FP arithmetic path too, the way Perlin's
     * `grad[0]*x + grad[1]*y + grad[2]*z` does. */
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

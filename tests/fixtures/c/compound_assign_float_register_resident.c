// A float lvalue updated through compound assignment (C99 6.5.16.2)
// or `++` / `--` (6.5.2.4, 6.5.3.1) keeps its frame slot eligible for
// register promotion, the same as `x = x op k`: no address is taken,
// and the loop-carried value merges through an F32 phi. Asserted by
// return code.

int main(void) {
    float acc = 100.0f;
    float step = 1.0f;
    for (int i = 0; i < 8; i++) {
        acc -= 2.0f;
        acc += step;
        step++;
    }
    // acc = 100 - 8*2 + (1+2+...+8); every value is exact in f32.
    if (acc != 120.0f) return 1;
    if (step != 9.0f) return 2;

    float post = 0.5f;
    post--;
    if (post != -0.5f) return 3;

    // Double rhs: the operation runs in double and the result narrows
    // back to single precision before the store (C99 6.3.1.5).
    float m = 3.0f;
    m *= 4.0;
    m /= 2.0f;
    if (m != 6.0f) return 4;

    return 0;
}

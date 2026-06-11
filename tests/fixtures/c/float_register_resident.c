// Float parameters and locals stay in FP registers after the
// StoreLocal{F32} register promotion -- no stack round-trip -- and a
// `a * b + c` float expression contracts to a single FMA. C99 6.2.5p10
// (single precision) and 6.5p8 (contraction). The accumulator sums
// i for i in 0..9 = 45.
static float fma3(float a, float b, float c) { return a * b + c; }

int main(void) {
    float acc = 0.0f;
    for (int i = 0; i < 10; i++) {
        float x = (float)i * 0.5f;
        acc = fma3(x, 2.0f, acc);
    }
    return (int)acc;
}

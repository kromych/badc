// C99 6.5.15: a float-typed conditional expression yields one arm's
// value at single precision. The lowering stores each arm through the
// fused StoreLocal / LoadLocal F32 path so the synthetic merge slot
// stays mem2reg-promotable; the value must round-trip exactly at
// 32-bit precision (all constants below are f32-representable).

static float sel(int c, float a, float b) {
    float r = c ? a : b;
    return r;
}

int main(void) {
    if (sel(1, 1.5f, -2.5f) != 1.5f) return 1;
    if (sel(0, 1.5f, -2.5f) != -2.5f) return 2;

    float x = 3.25f;
    float y = (x > 0.0f ? x : -x) + (x < 0.0f ? -x : x); /* 2*|x| */
    if (y != 6.5f) return 3;

    int k = 2;
    float z = k == 0 ? 0.0f : k == 1 ? 10.0f : 20.0f;
    if (z != 20.0f) return 4;

    return 0;
}

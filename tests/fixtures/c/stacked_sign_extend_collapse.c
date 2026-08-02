// C99 6.3.1.3: converting a signed integer to a wider signed type keeps
// the value, so sign-extending an already sign-extended value of no
// greater width reproduces it and the second extension is redundant.
// Casting through a *narrower* type first is not redundant: the low
// bits survive and the sign is retaken at the shorter width. Both
// chains reach the mid-end as stacked sign-extensions; only the
// covering one may collapse. The consumers below read the upper half
// (64-bit return, signed compare, 64-bit store), so a wrong collapse
// changes the value. Inputs arrive through volatile objects so the
// chains survive constant folding. Expected exits cross-checked
// against cc. Returns 0 on success.

typedef long long i64;

static volatile i64 src = 0x1234567890abcdefLL;
static volatile int lhs = 2000000000;
static volatile int rhs = 2000000000;
static i64 sink;

static i64 widen_i8(i64 x) {
    signed char c = (signed char)x;
    int i = c;
    return i;
}
static i64 widen_i16(i64 x) {
    short s = (short)x;
    int i = s;
    return i;
}
static i64 narrow_i8(i64 x) {
    int i = (int)x;
    signed char c = (signed char)i;
    return c;
}
static i64 narrow_i16(i64 x) {
    int i = (int)x;
    short s = (short)i;
    return s;
}
static i64 widen_i32(int a, int b) {
    int s = a + b;
    i64 t = s;
    return t;
}
static int widen_i32_is_negative(int a, int b) {
    int s = a + b;
    i64 t = s;
    return t < 0;
}
static void widen_i32_to_sink(int a, int b) {
    int s = a + b;
    i64 t = s;
    sink = t;
}

int main(void) {
    i64 x = src;
    if (widen_i8(x) != -17LL) return 1;
    if (widen_i16(x) != -12817LL) return 2;
    if (narrow_i8(x) != -17LL) return 3;
    if (narrow_i16(x) != -12817LL) return 4;
    if (widen_i32(lhs, rhs) != -294967296LL) return 5;
    if (!widen_i32_is_negative(lhs, rhs)) return 6;
    widen_i32_to_sink(lhs, rhs);
    if (sink != -294967296LL) return 7;
    if (widen_i8(255) != -1LL) return 8;
    if (narrow_i8(255) != -1LL) return 9;
    if (widen_i16(-1) != -1LL) return 10;
    return 0;
}

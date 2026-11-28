// Two expressions that lower to one instruction shape over the same
// operands and differ in the width they are computed at are two values:
// a comparison of two `int` conversions against one of the `long long`s
// (C17 6.5.8p3), and a conversion to `float` against one to `double`
// (C17 6.3.1.4p2). Each bit of the result names a case that merged them.

double wide[4];
float narrow[4];
int low[4];
int full[4];

__attribute__((noinline)) int compare_twice(long long x, long long y) {
    return ((int)x < (int)y) + 2 * (x < y);
}

__attribute__((noinline)) void compare_in_a_loop(long long x, long long y, int n) {
    for (int i = 0; i < n; i++) {
        full[i] = x < y;
        low[i] = (int)x < (int)y;
    }
}

__attribute__((noinline)) void convert_narrow_first(long long x, int n) {
    for (int i = 0; i < n; i++) {
        narrow[i] = (float)x;
        wide[i] = (double)x;
    }
}

__attribute__((noinline)) void convert_wide_first(long long x, int n) {
    for (int i = 0; i < n; i++) {
        wide[i] = (double)x;
        narrow[i] = (float)x;
    }
}

__attribute__((noinline)) void compare_per_element(long long x, int *out) {
    int v[4] = {(int)x < 5, x < 5, (int)x < 5, x < 5};
    for (int i = 0; i < 4; i++)
        out[i] = v[i];
}

// Read at run time, so no call below has a constant argument.
volatile long long shift = 32;

int main(void) {
    long long high = 1LL << shift; // its low word is 0
    int bad = 0;
    if (compare_twice(high, 1) != 1)
        bad |= 1;
    compare_in_a_loop(high, 1, 4);
    if (low[3] != 1 || full[3] != 0)
        bad |= 2;
    // 2^24 + 1 is a double and not a float.
    convert_narrow_first((high >> 8) + 1, 4);
    if (wide[3] != 16777217.0 || narrow[3] != 16777216.0f)
        bad |= 4;
    // 2^60 + 2^36 + 1 rounds up to a float; as a double it is 2^60 + 2^36,
    // halfway between two floats, which rounds to even, down.
    convert_wide_first((high << 28) + (high << 4) + 1, 4);
    if (narrow[3] != 0x1.000002p60f)
        bad |= 8;
    int lanes[4];
    compare_per_element(high, lanes);
    if (lanes[0] != 1 || lanes[1] != 0 || lanes[2] != 1 || lanes[3] != 0)
        bad |= 16;
    return bad;
}

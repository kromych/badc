// A dense case set (>= 8 cases, >= 50% dense over the span) lowers to
// a jump table: a bias subtract, an unsigned bounds check to default,
// and an indexed branch through a text-embedded table. Every case must
// route to its block, a hole in the span and any out-of-range value
// (below the bias, above the span, negative) must reach default, and
// an unsigned discriminant biased near UINT_MAX must index correctly.

static int dense_signed(int x) {
    switch (x) {
        case 3:  return 1;
        case 4:  return 2;
        case 5:  return 3;
        case 6:  return 4;
        case 7:  return 5;
        case 8:  return 6;
        case 9:  return 7;
        case 10: return 8;
        case 11: return 9;
        case 12: return 10;
        case 13: return 11;
        case 14: return 12;
        // 15 is a hole: its table slot routes to default.
        case 16: return 13;
        case 17: return 14;
        case 18: return 15;
        case 19: return 16;
        default: return -1;
    }
}

static int dense_negative_bias(long long x) {
    switch (x) {
        case -6: return 1;
        case -5: return 2;
        case -4: return 3;
        case -3: return 4;
        case -2: return 5;
        case -1: return 6;
        case 0:  return 7;
        case 1:  return 8;
        case 2:  return 9;
        default: return -1;
    }
}

static int dense_unsigned_high(unsigned u) {
    switch (u) {
        case 0xfffffff6u: return 1;
        case 0xfffffff7u: return 2;
        case 0xfffffff8u: return 3;
        case 0xfffffff9u: return 4;
        case 0xfffffffau: return 5;
        case 0xfffffffbu: return 6;
        case 0xfffffffcu: return 7;
        case 0xfffffffdu: return 8;
        case 0xfffffffeu: return 9;
        case 0xffffffffu: return 10;
        default:          return -1;
    }
}

int main(void) {
    // Every real case value routes to its block.
    for (int i = 3; i <= 19; i++) {
        if (i == 15) continue;
        int want = i < 15 ? i - 2 : i - 3;
        if (dense_signed(i) != want) return 1;
    }
    // The hole and both out-of-range sides reach default.
    if (dense_signed(15) != -1) return 2;
    if (dense_signed(2) != -1) return 3;
    if (dense_signed(20) != -1) return 4;
    if (dense_signed(-1) != -1) return 5;
    if (dense_signed(-2147483647 - 1) != -1) return 6;
    if (dense_signed(2147483647) != -1) return 7;

    for (long long i = -6; i <= 2; i++) {
        if (dense_negative_bias(i) != (int)(i + 7)) return 8;
    }
    if (dense_negative_bias(-7) != -1) return 9;
    if (dense_negative_bias(3) != -1) return 10;
    if (dense_negative_bias(0x100000000ll) != -1) return 11;
    if (dense_negative_bias(-0x100000000ll) != -1) return 12;

    for (unsigned i = 0; i < 10; i++) {
        if (dense_unsigned_high(0xfffffff6u + i) != (int)(i + 1)) return 13;
    }
    if (dense_unsigned_high(0xfffffff5u) != -1) return 14;
    if (dense_unsigned_high(0u) != -1) return 15;
    if (dense_unsigned_high(0x7fffffffu) != -1) return 16;
    return 0;
}

// snapshot-flags: -fno-jump-tables
// `-fno-jump-tables`: case sets dense enough to table-dispatch stay on
// the compare tree, so the dispatch takes no indirect branch and no
// table reaches the image. Kernels built with retpoline or
// indirect-branch tracking pass the flag because a table dispatch is
// the indirect branch those configurations exist to avoid. The routing
// must be identical to the table form: every case to its block, a hole
// and every out-of-range value to default.

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
        // 15 is a hole: it reaches default like any unlisted value.
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

// Fall-through across arms still works without the table: control
// enters at the matched case and runs on until a break.
static int fallthrough_sum(int x) {
    int n = 0;
    switch (x) {
        case 0: n += 1;
        case 1: n += 2;
        case 2: n += 4;
        case 3: n += 8;
        case 4: n += 16;
        case 5: n += 32;
        case 6: n += 64;
        case 7: n += 128;
            break;
        default: n = -1;
    }
    return n;
}

int main(void) {
    for (int i = 3; i <= 19; i++) {
        if (i == 15) continue;
        int want = i < 15 ? i - 2 : i - 3;
        if (dense_signed(i) != want) return 1;
    }
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

    for (unsigned i = 0; i < 10; i++) {
        if (dense_unsigned_high(0xfffffff6u + i) != (int)(i + 1)) return 12;
    }
    if (dense_unsigned_high(0xfffffff5u) != -1) return 13;
    if (dense_unsigned_high(0u) != -1) return 14;

    // 255, 254, 252, 248, 240, 224, 192, 128 for cases 0..7.
    for (int i = 0; i <= 7; i++) {
        int want = 256 - (1 << i);
        if (fallthrough_sum(i) != want) return 15;
    }
    if (fallthrough_sum(8) != -1) return 16;
    return 0;
}

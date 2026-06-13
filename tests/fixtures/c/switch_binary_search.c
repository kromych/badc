// The switch dispatcher lowers to a balanced binary search over the
// sorted case values (O(log n) branches), so a many-case switch must
// still route every value to the correct block and fall to `default`
// for an unmatched value. Exercise sparse and negative signed cases,
// an unsigned discriminant whose values exceed INT_MAX, and `default`.

static int classify_signed(int x) {
    switch (x) {
        case -100: return 1;
        case -3:   return 2;
        case 0:    return 3;
        case 1:    return 4;
        case 7:    return 5;
        case 42:   return 6;
        case 1000: return 7;
        default:   return 0;
    }
}

static int classify_unsigned(unsigned u) {
    switch (u) {
        case 0u:          return 1;
        case 5u:          return 2;
        case 0x7fffffffu: return 3;
        case 0x80000000u: return 4; // exceeds INT_MAX; signed ordering would misplace it
        case 0xffffffffu: return 5;
        default:          return 0;
    }
}

int main(void) {
    // Each case value routes to its result; unmatched falls to default.
    if (classify_signed(-100) != 1) return 11;
    if (classify_signed(-3)   != 2) return 12;
    if (classify_signed(0)    != 3) return 13;
    if (classify_signed(1)    != 4) return 14;
    if (classify_signed(7)    != 5) return 15;
    if (classify_signed(42)   != 6) return 16;
    if (classify_signed(1000) != 7) return 17;
    if (classify_signed(-1)   != 0) return 18;
    if (classify_signed(8)    != 0) return 19;
    if (classify_signed(999)  != 0) return 20;

    if (classify_unsigned(0u)          != 1) return 31;
    if (classify_unsigned(5u)          != 2) return 32;
    if (classify_unsigned(0x7fffffffu) != 3) return 33;
    if (classify_unsigned(0x80000000u) != 4) return 34;
    if (classify_unsigned(0xffffffffu) != 5) return 35;
    if (classify_unsigned(1u)          != 0) return 36;
    if (classify_unsigned(0x80000001u) != 0) return 37;
    return 0;
}

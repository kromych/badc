// C99 6.8.4.2p1 + p5: the switch controlling expression is integer-
// promoted, then each case label is converted to that promoted type.
//
//   * unsigned int (4 bytes) promotes to itself, so a negative label
//     wraps modulo 2^32 and (uint32_t)-1 matches `case -1`.
//   * unsigned char / unsigned short promote to signed int, so a
//     negative label stays negative and never matches the zero-extended
//     (positive) discriminant -- it falls to default.
//   * a signed discriminant keeps the sign-extended value.

#include <stdint.h>

static int u32(uint32_t t) {
    switch (t) {
    case -1: return 100; // 0xFFFFFFFF
    case -2: return 200; // 0xFFFFFFFE
    case 5: return 5;
    default: return 999;
    }
}

static int u16(uint16_t t) {
    switch (t) {
    case -1: return 100; // promotes to int -1; never matches a uint16
    case 7: return 7;
    default: return 999;
    }
}

static int u8(uint8_t t) {
    switch (t) {
    case -1: return 100; // promotes to int -1; never matches a uint8
    case 3: return 3;
    default: return 999;
    }
}

static int s32(int32_t t) {
    switch (t) {
    case -1: return 100;
    case -2: return 200;
    default: return 999;
    }
}

int main(void) {
    // unsigned int: the negative label matches the wrapped value.
    if (u32((uint32_t)-1) != 100) return 1;
    if (u32((uint32_t)-2) != 200) return 2;
    if (u32(5) != 5) return 3;
    if (u32(0) != 999) return 4;

    // unsigned short / char promote to int: the negative label is dead.
    if (u16((uint16_t)-1) != 999) return 5;
    if (u16(7) != 7) return 6;
    if (u8((uint8_t)-1) != 999) return 7;
    if (u8(3) != 3) return 8;

    // Signed discriminant keeps working.
    if (s32(-1) != 100) return 9;
    if (s32(-2) != 200) return 10;
    if (s32(5) != 999) return 11;

    return 0;
}

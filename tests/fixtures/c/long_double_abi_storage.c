// A declared `long double` object takes the target ABI's storage
// format: IEEE binary128 on AAPCS64 ELF, x87 80-bit on System V
// x86-64, binary64 elsewhere. The compute path carries binary64, so a
// value stored into the object and read back must come out unchanged,
// and the object's bytes must carry the platform encoding -- every
// foreign reader decodes them that way.
//
// Returns 0 on success; a distinct nonzero code per failure mode.

#include <string.h>

typedef unsigned long long u64;

static const u64 VEC[] = {
    0x0000000000000000ULL, // +0
    0x8000000000000000ULL, // -0
    0x3ff0000000000000ULL, // 1.0
    0xc004000000000000ULL, // -2.5
    0x0000000000000001ULL, // smallest subnormal
    0x000fffffffffffffULL, // largest subnormal
    0x0010000000000000ULL, // smallest normal
    0x7fefffffffffffffULL, // DBL_MAX
    0x7ff0000000000000ULL, // +inf
    0xfff0000000000000ULL, // -inf
    0x4340000000000001ULL, // 2^53 + 2
    0x0008000000000001ULL, // subnormal at the normal edge
};

// A constant subscript past the scaled-immediate reach folds into the
// access displacement; the wide object moves as two 8-byte halves, so
// its displacement reaches half as far as the object size suggests.
static long double FAR[2200];

int main(void) {
    unsigned i;
    long double *p;
    long double x;
    double d, back;
    u64 in, out;
    unsigned char img[16];

    if (sizeof(long double) != __SIZEOF_LONG_DOUBLE__) return 1;
    if (_Alignof(long double) != __SIZEOF_LONG_DOUBLE__) return 2;

    for (i = 0; i < sizeof VEC / sizeof VEC[0]; i++) {
        in = VEC[i];
        memcpy(&d, &in, 8);
        x = d;
        back = (double)x;
        memcpy(&out, &back, 8);
        if (out != in) return 10 + (int)i;
    }

    // A NaN stays a NaN across the widening and the narrowing.
    in = 0x7ff8000000000000ULL;
    memcpy(&d, &in, 8);
    x = d;
    back = (double)x;
    memcpy(&out, &back, 8);
    if ((out & 0x7ff0000000000000ULL) != 0x7ff0000000000000ULL) return 3;
    if ((out & 0x000fffffffffffffULL) == 0) return 4;

    p = FAR;
    p[2100] = 0x1.8p+1;
    if ((double)p[2100] != 3.0) return 9;

#if __LDBL_MANT_DIG__ == 113
    // binary128: 1.0 is exponent 0x3fff over an implicit leading bit,
    // so only the top two bytes are set.
    x = 1.0L;
    memcpy(img, &x, 16);
    if (img[15] != 0x3f || img[14] != 0xff) return 5;
    for (i = 0; i < 14; i++) if (img[i] != 0) return 6;
    // 2^-1074 is subnormal in binary64 and normal in binary128:
    // exponent 16383 - 1074 = 0x3bcd, zero significand.
    in = 1;
    memcpy(&d, &in, 8);
    x = d;
    memcpy(img, &x, 16);
    if (img[15] != 0x3b || img[14] != 0xcd) return 7;
    for (i = 0; i < 14; i++) if (img[i] != 0) return 8;
#elif __LDBL_MANT_DIG__ == 64
    // x87 80-bit: 1.0 carries an explicit integer bit at byte 7.
    x = 1.0L;
    memcpy(img, &x, 16);
    if (img[7] != 0x80 || img[8] != 0xff || img[9] != 0x3f) return 5;
#else
    // binary64: the object is the double itself.
    x = 1.0L;
    memcpy(img, &x, 8);
    if (img[7] != 0x3f || img[6] != 0xf0) return 5;
#endif
    return 0;
}

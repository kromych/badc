// Subscripts whose index is a 32-bit value: `int` indices below zero
// through a pointer into the middle of an array, at every element size,
// and indices computed by arithmetic that wraps at 32 bits, where the
// register holding the index differs from the index above bit 31. An
// access that widens the index itself must read the low word only, and
// one that reads the register whole must find it widened. The exit code
// names the first check that fails.

#define NOINLINE __attribute__((noinline))

// Values the compiler cannot know, so no subscript folds to a constant.
static volatile int zero;
#define RT(k) ((k) + zero)

NOINLINE static long get8s(const signed char *a, int i) { return a[i]; }
NOINLINE static long get8u(const unsigned char *a, int i) { return a[i]; }
NOINLINE static long get16s(const short *a, int i) { return a[i]; }
NOINLINE static long get16u(const unsigned short *a, int i) { return a[i]; }
NOINLINE static long get32s(const int *a, int i) { return a[i]; }
NOINLINE static long get32u(const unsigned *a, int i) { return a[i]; }
NOINLINE static long get64(const long *a, int i) { return a[i]; }

NOINLINE static void put8(signed char *a, int i, int v) { a[i] = (signed char)v; }
NOINLINE static void put16(short *a, int i, int v) { a[i] = (short)v; }
NOINLINE static void put32(int *a, int i, int v) { a[i] = v; }
NOINLINE static void put64(long *a, int i, long v) { a[i] = v; }

NOINLINE static long getu(const int *a, unsigned i) { return a[i]; }
NOINLINE static void putu(long *a, unsigned i, long v) { a[i] = v; }

// The 64-bit sum of the two operands is 2^32 - 2; the index is -2.
NOINLINE static long wrapped_int(const int *mid, int x, int y) {
    int i = (int)((unsigned)x + (unsigned)y);
    return mid[i];
}

// The 64-bit sum is 2^32 + 2; the index is 2.
NOINLINE static long wrapped_unsigned(const long *a, unsigned x, unsigned y) { return a[x + y]; }

// The same index is a subscript and a 64-bit addend.
NOINLINE static long index_and_value(const int *mid, int x, int y) {
    int i = (int)((unsigned)x + (unsigned)y);
    return mid[i] + (long)i;
}

// The element is read and written through one index.
NOINLINE static void swap(int *mid, int i, int j) {
    int t = mid[i];
    mid[i] = mid[j];
    mid[j] = t;
}

// A descending `int` counter that ends below zero.
NOINLINE static long sum_down(const short *a, int n) {
    long s = 0;
    for (int j = n - 1; j >= 0; j--) s += a[j];
    return s;
}

// An `unsigned` counter whose sum with `start` wraps at 32 bits on every
// iteration.
NOINLINE static long sum_from(const unsigned char *a, unsigned start, unsigned first, unsigned n) {
    long s = 0;
    for (unsigned k = first; k < n; k++) s += a[start + k];
    return s;
}

int main(void) {
    static signed char s8[8] = {-128, -2, -1, 0, 1, 2, 126, 127};
    static unsigned char u8[8] = {0, 1, 127, 128, 129, 254, 255, 7};
    static short s16[8] = {-32768, -2, -1, 0, 1, 2, 32766, 32767};
    static unsigned short u16[8] = {0, 1, 32767, 32768, 32769, 65534, 65535, 7};
    static int s32[8] = {-2147483647 - 1, -2, -1, 0, 1, 2, 2147483646, 2147483647};
    static unsigned u32[8] = {0, 1, 2147483647u, 2147483648u, 2147483649u, 4294967294u, 4294967295u, 7};
    static long s64[8] = {-9223372036854775807L - 1, -2, -1, 0, 1, 2, 4294967296L, 9223372036854775807L};

    if (get8s(s8 + 7, RT(-7)) != -128 || get8s(s8 + 4, RT(-2)) != -1 || get8s(s8, RT(7)) != 127) return 1;
    if (get8u(u8 + 7, RT(-1)) != 255 || get8u(u8 + 8, RT(-5)) != 128) return 2;
    if (get16s(s16 + 7, RT(-7)) != -32768 || get16s(s16 + 4, RT(-2)) != -1) return 3;
    if (get16u(u16 + 7, RT(-1)) != 65535 || get16u(u16 + 8, RT(-5)) != 32768) return 4;
    if (get32s(s32 + 7, RT(-7)) != -2147483647 - 1 || get32s(s32 + 4, RT(-2)) != -1) return 5;
    if (get32u(u32 + 7, RT(-1)) != 4294967295L || get32u(u32 + 8, RT(-5)) != 2147483648L) return 6;
    if (get64(s64 + 7, RT(-7)) != -9223372036854775807L - 1 || get64(s64 + 8, RT(-2)) != 4294967296L) return 7;

    put8(s8 + 8, RT(-8), 200);
    put16(s16 + 8, RT(-8), 40000);
    put32(s32 + 8, RT(-8), -5);
    put64(s64 + 8, RT(-8), -6);
    if (s8[0] != -56 || s16[0] != -25536 || s32[0] != -5 || s64[0] != -6) return 8;
    if (s8[1] != -2 || s16[1] != -2 || s32[1] != -2 || s64[1] != -2) return 9;

    if (getu(s32, (unsigned)RT(7)) != 2147483647 || getu(s32, (unsigned)RT(1)) != -2) return 10;
    putu(s64, (unsigned)RT(3), 33);
    if (s64[3] != 33 || s64[2] != -1 || s64[4] != 1) return 11;

    if (wrapped_int(s32 + 4, RT(2147483647), RT(2147483647)) != -1) return 12;
    if (wrapped_int(s32 + 4, RT(-2147483647 - 1), RT(-2147483647 - 1)) != 1) return 13;
    if (wrapped_unsigned(s64, (unsigned)RT(-1), (unsigned)RT(3)) != -1) return 14;
    if (index_and_value(s32 + 4, RT(2147483647), RT(2147483647)) != -1 + -2L) return 15;
    if (index_and_value(s32 + 4, RT(1), RT(2)) != 2147483647L + 3) return 16;

    swap(s32 + 4, RT(-3), RT(3));
    if (s32[1] != 2147483647 || s32[7] != -2) return 17;

    if (sum_down(s16 + 1, RT(7)) != -2 + -1 + 0 + 1 + 2 + 32766 + 32767) return 18;
    if (sum_down(s16, RT(0)) != 0) return 19;
    if (sum_from(u8, (unsigned)RT(-4), (unsigned)RT(4), (unsigned)RT(8)) != 0 + 1 + 127 + 128) return 20;
    return 0;
}

// Division and modulo by a constant non-power-of-two divisor lower to a
// reciprocal multiply (C99 6.5.5p6 truncation toward zero for the signed
// forms). Each group compares that lowering against the hardware divide
// reached through a `volatile` divisor, over boundary and pseudorandom
// numerators at both widths and both signednesses. The numerators are
// computed at run time so no case constant-folds away.
// Returns 0 when every case matches; otherwise the group index, plus
// 100 when it was the modulo that disagreed.

#define NN 20

static long nums[NN];
static unsigned long unums[NN];
static int inums[NN];
static unsigned uinums[NN];
static int step;

static void fill(void) {
    unsigned long s = 0x9E3779B97F4A7C15UL;
    int i;
    nums[0] = 0;
    nums[1] = 1;
    nums[2] = -1;
    nums[3] = 2;
    nums[4] = -2;
    nums[5] = 2147483647L;
    nums[6] = -2147483647L - 1;
    nums[7] = 9223372036854775807L;
    nums[8] = -9223372036854775807L - 1;
    nums[9] = 1000000007L;
    nums[10] = -1000000007L;
    nums[11] = 4294967295L;
    for (i = 12; i < NN; i++) {
        s = s * 6364136223846793005UL + 1442695040888963407UL;
        nums[i] = (long)s;
    }
    for (i = 0; i < NN; i++) {
        unums[i] = (unsigned long)nums[i];
        inums[i] = (int)nums[i];
        uinums[i] = (unsigned)nums[i];
    }
}

// The divisor appears twice: as a literal, which takes the reciprocal
// multiply, and through a volatile object, which takes the hardware
// divide. A group whose two results differ returns its index.
#define CK(ARR, TY, D)                                                                             \
    do {                                                                                           \
        int i;                                                                                     \
        step++;                                                                                    \
        for (i = 0; i < NN; i++) {                                                                 \
            volatile TY vd = (D);                                                                  \
            TY n = ARR[i];                                                                         \
            if (n / (D) != n / vd) return step;                                                    \
            if (n % (D) != n % vd) return step + 100;                                              \
        }                                                                                          \
    } while (0)

int main(void) {
    fill();

    // int: positive, negative, powers of two, and the extremes. Divisor
    // -1 is excluded here because INT_MIN / -1 is undefined (6.5.5p6)
    // and traps on a 32-bit idiv; it is checked below in range.
    CK(inums, int, 3);
    CK(inums, int, 5);
    CK(inums, int, 6);
    CK(inums, int, 7);
    CK(inums, int, 10);
    CK(inums, int, 100);
    CK(inums, int, 1000);
    CK(inums, int, 65535);
    CK(inums, int, 65537);
    CK(inums, int, 2147483647);
    CK(inums, int, -3);
    CK(inums, int, -7);
    CK(inums, int, -100);
    CK(inums, int, -2147483647 - 1);
    CK(inums, int, 1);
    CK(inums, int, 8);
    CK(inums, int, -8);
    CK(inums, int, 1073741824);

    // unsigned int, including divisors above 2^31 where the only
    // quotients are 0 and 1.
    CK(uinums, unsigned, 3u);
    CK(uinums, unsigned, 7u);
    CK(uinums, unsigned, 10u);
    CK(uinums, unsigned, 14u);
    CK(uinums, unsigned, 100u);
    CK(uinums, unsigned, 1000u);
    CK(uinums, unsigned, 2147483647u);
    CK(uinums, unsigned, 2147483649u);
    CK(uinums, unsigned, 4294967291u);
    CK(uinums, unsigned, 1u);
    CK(uinums, unsigned, 16u);

    // long.
    CK(nums, long, 3L);
    CK(nums, long, 7L);
    CK(nums, long, 10L);
    CK(nums, long, 1000L);
    CK(nums, long, 1000000007L);
    CK(nums, long, 9223372036854775807L);
    CK(nums, long, -3L);
    CK(nums, long, -7L);
    CK(nums, long, -1000000007L);
    CK(nums, long, -9223372036854775807L - 1);
    CK(nums, long, 1L);
    CK(nums, long, 1024L);
    CK(nums, long, -1024L);

    // unsigned long.
    CK(unums, unsigned long, 3UL);
    CK(unums, unsigned long, 7UL);
    CK(unums, unsigned long, 10UL);
    CK(unums, unsigned long, 14UL);
    CK(unums, unsigned long, 1000000007UL);
    CK(unums, unsigned long, 9223372036854775809UL);
    CK(unums, unsigned long, 18446744073709551611UL);
    CK(unums, unsigned long, 1UL);
    CK(unums, unsigned long, 1024UL);

    // Divisor -1 over numerators whose negation is representable.
    {
        volatile int vi = -12345;
        volatile long vl = -1234567890123L;
        if (vi / -1 != 12345 || vi % -1 != 0) return 90;
        if (vl / -1 != 1234567890123L || vl % -1 != 0) return 91;
    }
    return 0;
}

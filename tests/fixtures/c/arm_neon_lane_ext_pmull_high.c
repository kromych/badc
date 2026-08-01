/* <arm_neon.h>: the lane read, the two-vector extract, the upper-lane
 * carryless multiply and the 128-bit reinterpretations -- the surface a
 * folded CRC over 128-bit lanes uses. Each result is checked against a
 * scalar model or against the low-lane intrinsic it must agree with.
 * Native-only on AArch64; elsewhere only the scalar model runs. */

#if defined(__aarch64__)
#include <arm_neon.h>

/* Carryless 64x64 -> 128 as a scalar model. */
static void clmul(unsigned long long a, unsigned long long b,
                  unsigned long long *lo, unsigned long long *hi) {
    int j;
    *lo = 0;
    *hi = 0;
    for (j = 0; j < 64; j++) {
        if ((b >> j) & 1) {
            *lo ^= a << j;
            if (j) {
                *hi ^= a >> (64 - j);
            }
        }
    }
}

typedef union {
    poly128_t v;
    unsigned long long q[2];
} P128;
#endif

int main(void) {
#if defined(__aarch64__)
    static const unsigned long long av[2] = {0xF00DFACEDEADBEEFull,
                                             0x0123456789ABCDEFull};
    static const unsigned long long bv[2] = {0x1122334455667788ull,
                                             0x99AABBCCDDEEFF00ull};
    uint64x2_t a = vld1q_u64(av);
    uint64x2_t b = vld1q_u64(bv);
    unsigned long long lo, hi;

    /* Lane read: both lanes of a 2 x 64-bit vector. */
    if (vgetq_lane_u64(a, 0) != av[0] || vgetq_lane_u64(a, 1) != av[1]) {
        return 1;
    }

    /* Extract: the 128-bit window starting one element into a:b. */
    {
        uint64x2_t e = vextq_u64(a, b, 1);
        if (vgetq_lane_u64(e, 0) != av[1] || vgetq_lane_u64(e, 1) != bv[0]) {
            return 2;
        }
        e = vextq_u64(a, b, 0);
        if (vgetq_lane_u64(e, 0) != av[0] || vgetq_lane_u64(e, 1) != av[1]) {
            return 3;
        }
    }

    /* The upper-lane product must equal the low-lane one over lane 1. */
    {
        P128 u, w;
        u.v = vmull_high_p64(vreinterpretq_p64_u64(a), vreinterpretq_p64_u64(b));
        w.v = vmull_p64((poly64_t)av[1], (poly64_t)bv[1]);
        clmul(av[1], bv[1], &lo, &hi);
        if (u.q[0] != lo || u.q[1] != hi) {
            return 4;
        }
        if (u.q[0] != w.q[0] || u.q[1] != w.q[1]) {
            return 5;
        }
    }

    /* The reinterpretations keep the bits. */
    {
        uint64x2_t r = vreinterpretq_u64_u8(vreinterpretq_u8_u64(a));
        if (vgetq_lane_u64(r, 0) != av[0] || vgetq_lane_u64(r, 1) != av[1]) {
            return 6;
        }
        r = vreinterpretq_u64_p128(vreinterpretq_p128_u64(b));
        if (vgetq_lane_u64(r, 0) != bv[0] || vgetq_lane_u64(r, 1) != bv[1]) {
            return 7;
        }
        r = vreinterpretq_u64_p64(vreinterpretq_p64_u64(a));
        if (vgetq_lane_u64(r, 0) != av[0]) {
            return 8;
        }
    }
#endif
    return 42;
}

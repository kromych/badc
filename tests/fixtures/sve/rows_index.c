/* The ACLE SVE svindex over every integer type, checked against scalar C:
 * lane i is base + i * step, wrapping in the lane's width, with a base and
 * a step each a constant in and past INDEX's immediate range (-16 to 15)
 * or a variable. The exit status is the vector length in 128-bit
 * granules. */
#include <arm_sve.h>

static int8_t o8[256];
static uint16_t o16[128];
static int32_t o32[64];
static uint64_t o64[32];

static volatile int64_t vbase = -77, vstep = 1000003;

#define CHECK(code, T, out, b, cnt, sv, base, step)                       \
    do {                                                                  \
        svst1(svptrue_##b(), out, sv(base, step));                        \
        for (int i = 0; i < (int)cnt(); i++)                              \
            if (out[i] != (T)((uint64_t)(T)(base) + (uint64_t)i * (uint64_t)(T)(step))) \
                return code;                                              \
    } while (0)

int main(void) {
    int64_t b = vbase, s = vstep;
    CHECK(1, int8_t, o8, b8, svcntb, svindex_s8, 0, 1);
    CHECK(2, int8_t, o8, b8, svcntb, svindex_s8, -16, 15);
    CHECK(3, int8_t, o8, b8, svcntb, svindex_s8, 127, -17);
    CHECK(4, int8_t, o8, b8, svcntb, svindex_s8, b, s);
    CHECK(5, uint16_t, o16, b16, svcnth, svindex_u16, 16, -1);
    CHECK(6, uint16_t, o16, b16, svcnth, svindex_u16, b, 3);
    CHECK(7, uint16_t, o16, b16, svcnth, svindex_u16, 65535, s);
    CHECK(8, int32_t, o32, b32, svcntw, svindex_s32, -5, b);
    CHECK(9, int32_t, o32, b32, svcntw, svindex_s32, 2147483647, 1);
    CHECK(10, int32_t, o32, b32, svcntw, svindex_s32, s, s);
    CHECK(11, uint64_t, o64, b64, svcntd, svindex_u64, 0xFFFFFFFFFFFFFFF0ull, 15);
    CHECK(12, uint64_t, o64, b64, svcntd, svindex_u64, b, 0x100000000ull);
    CHECK(13, uint64_t, o64, b64, svcntd, svindex_u64, 7, s);
    return (int)(svcntb() / 16);
}

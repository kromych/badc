/* The ACLE SVE shifts by a vector of counts and by a scalar: svlsl over
 * signed and unsigned lanes, svlsr over unsigned and svasr over signed
 * ones, in the merging, zeroing and don't-care forms, each checked against
 * scalar C. A count of the lane width or more shifts every bit out, or the
 * sign in. The exit status is the vector length in 128-bit granules. */
#include <arm_sve.h>

#define N 77

static int32_t a32[N], r32[N];
static uint32_t c32[N];
static uint8_t a8[N], c8[N], r8[N];
static int16_t a16[N], r16[N];
static uint16_t c16[N];
static uint64_t a64[N], c64[N], r64[N];

static void fill(void) {
    for (int i = 0; i < N; i++) {
        a32[i] = (int32_t)((uint32_t)i * 2654435761u);
        c32[i] = (uint32_t)(i * 7 % 41);
        a8[i] = (uint8_t)(i * 37 + 1);
        c8[i] = (uint8_t)(i * 3 % 11);
        a16[i] = (int16_t)(i * 997 - 30000);
        c16[i] = (uint16_t)(i % 19);
        a64[i] = (uint64_t)i * 0x9E3779B97F4A7C15ull;
        c64[i] = (uint64_t)(i * 5 % 70);
    }
    c32[5] = 0xFFFFFFFFu;
    c16[6] = 0x8001u;
}

static int32_t shl32(int32_t x, uint32_t n) {
    return n >= 32 ? 0 : (int32_t)((uint32_t)x << n);
}

static int64_t asr(int64_t x, uint64_t n, uint64_t bits) {
    if (n >= bits)
        n = bits - 1;
    return x < 0 ? ~(~x >> n) : x >> n;
}

/* Word lanes governed by the odd counts: the merging forms keep a, the
 * zeroing forms zero. */
static int words(void) {
    for (int op = 0; op < 6; op++) {
        for (int i = 0; i < N; i += (int)svcntw()) {
            svbool_t pg = svwhilelt_b32(i, N);
            svint32_t a = svld1(pg, &a32[i]);
            svuint32_t c = svld1(pg, &c32[i]);
            svbool_t odd = svcmpne_n_u32(pg, svand_n_u32_x(pg, c, 1), 0);
            svint32_t r;
            switch (op) {
            case 0: r = svlsl_s32_m(odd, a, c); break;
            case 1: r = svasr_z(odd, a, c); break;
            case 2: r = svasr_x(pg, a, c); break;
            case 3: r = svlsl_n_s32_z(odd, a, 5); break;
            case 4: r = svasr_n_s32_m(odd, a, 40); break;
            default: r = svlsl_x(pg, a, c); break;
            }
            svst1(pg, &r32[i], r);
        }
        for (int i = 0; i < N; i++) {
            int32_t a = a32[i], want;
            uint32_t c = c32[i];
            int on = (c & 1) != 0;
            switch (op) {
            case 0: want = on ? shl32(a, c) : a; break;
            case 1: want = on ? (int32_t)asr(a, c, 32) : 0; break;
            case 2: want = (int32_t)asr(a, c, 32); break;
            case 3: want = on ? shl32(a, 5) : 0; break;
            case 4: want = on ? (int32_t)asr(a, 40, 32) : a; break;
            default: want = shl32(a, c); break;
            }
            if (r32[i] != want)
                return 10 + op;
        }
    }
    return 0;
}

/* Bytes and doublewords unsigned, halfwords signed. */
static int other_widths(void) {
    for (int i = 0; i < N; i += (int)svcntb()) {
        svbool_t pg = svwhilelt_b8(i, N);
        svuint8_t a = svld1(pg, &a8[i]), c = svld1(pg, &c8[i]);
        svbool_t big = svcmpgt_n_u8(pg, a, 100);
        svst1(pg, &r8[i], svlsl_m(big, svlsr_x(pg, a, c), svdup_n_u8(1)));
    }
    for (int i = 0; i < N; i += (int)svcnth()) {
        svbool_t pg = svwhilelt_b16(i, N);
        svint16_t a = svld1(pg, &a16[i]);
        svuint16_t c = svld1(pg, &c16[i]);
        svst1(pg, &r16[i], svasr_s16_z(svcmplt_n_s16(pg, a, 0), a, c));
    }
    for (int i = 0; i < N; i += (int)svcntd()) {
        svbool_t pg = svwhilelt_b64(i, N);
        svuint64_t a = svld1(pg, &a64[i]), c = svld1(pg, &c64[i]);
        svst1(pg, &r64[i], sveor_x(pg, svlsl_u64_x(pg, a, c), svlsr_n_u64_x(pg, a, 61)));
    }
    for (int i = 0; i < N; i++) {
        unsigned a = a8[i], c = c8[i];
        unsigned s = c >= 8 ? 0 : a >> c;
        if (r8[i] != (uint8_t)(a > 100 ? s << 1 : s))
            return 30;
        int16_t h = a16[i];
        if (r16[i] != (h < 0 ? (int16_t)asr(h, c16[i], 16) : 0))
            return 31;
        uint64_t x = a64[i], n = c64[i];
        if (r64[i] != ((n >= 64 ? 0 : x << n) ^ x >> 61))
            return 32;
    }
    return 0;
}

int main(void) {
    fill();
    int r = words();
    if (!r)
        r = other_widths();
    if (r)
        return r;
    return (int)(svcntb() / 16);
}

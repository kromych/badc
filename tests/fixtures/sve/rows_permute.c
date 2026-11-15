/* The ACLE SVE permutes and lane moves, whose lanes cross the whole
 * vector: svzip1, svzip2, svuzp1, svuzp2, svtrn1 and svtrn2 of two
 * vectors, svrev, svext at lane indices inside and past the vector,
 * svdup_lane with an index inside and past it, and svreinterpret between
 * integer and floating types, each checked against the lanes scalar C
 * computes for the run's vector length. The exit status is the vector
 * length in 128-bit granules. */
#include <arm_sve.h>

static uint8_t a8[256], b8[256], r8[256];
static int16_t a16[128], b16[128], r16[128];
static int32_t a32[64], r32[64];
static double ad[32], bd[32], rd[32];

static void fill(void) {
    for (int i = 0; i < 256; i++) {
        a8[i] = (uint8_t)(i * 7 + 1);
        b8[i] = (uint8_t)(200 - i * 3);
    }
    for (int i = 0; i < 128; i++) {
        a16[i] = (int16_t)(i * 301 - 9000);
        b16[i] = (int16_t)(7000 - i * 77);
    }
    for (int i = 0; i < 64; i++)
        a32[i] = (int32_t)((uint32_t)i * 2654435761u);
    for (int i = 0; i < 32; i++) {
        ad[i] = (double)i * 1.5 - 7.0;
        bd[i] = 100.0 - (double)i;
    }
}

/* The six interleaves of byte lanes. */
static int bytes(void) {
    int n = (int)svcntb(), h = n / 2;
    svbool_t all = svptrue_b8();
    svuint8_t a = svld1(all, a8), b = svld1(all, b8);
    for (int op = 0; op < 6; op++) {
        svuint8_t r;
        switch (op) {
        case 0: r = svzip1(a, b); break;
        case 1: r = svzip2_u8(a, b); break;
        case 2: r = svuzp1(a, b); break;
        case 3: r = svuzp2_u8(a, b); break;
        case 4: r = svtrn1_u8(a, b); break;
        default: r = svtrn2(a, b); break;
        }
        svst1(all, r8, r);
        for (int i = 0; i < n; i++) {
            int k = i / 2, odd = i & 1, u = 2 * i + (op == 3);
            uint8_t want;
            switch (op) {
            case 0: want = odd ? b8[k] : a8[k]; break;
            case 1: want = odd ? b8[h + k] : a8[h + k]; break;
            case 2:
            case 3: want = u < n ? a8[u] : b8[u - n]; break;
            case 4: want = odd ? b8[i - 1] : a8[i]; break;
            default: want = odd ? b8[i] : a8[i + 1]; break;
            }
            if (r8[i] != want)
                return 10 + op;
        }
    }
    return 0;
}

/* The halfword lanes reversed and extracted from lane k on, an index of
 * the vector's lanes or more taking the first vector whole. */
static int ext16(svint16_t r, int k) {
    int n = (int)svcnth();
    svst1(svptrue_b16(), r16, r);
    for (int i = 0; i < n; i++) {
        int j = k < n ? i + k : i;
        if (r16[i] != (j < n ? a16[j] : b16[j - n]))
            return 1;
    }
    return 0;
}

static int halfwords(void) {
    int n = (int)svcnth();
    svbool_t all = svptrue_b16();
    svint16_t a = svld1(all, a16), b = svld1(all, b16);
    svst1(all, r16, svrev(a));
    for (int i = 0; i < n; i++)
        if (r16[i] != a16[n - 1 - i])
            return 20;
    if (ext16(svext_s16(a, b, 0), 0) || ext16(svext(a, b, 1), 1) || ext16(svext(a, b, 5), 5))
        return 21;
    if (ext16(svext_s16(a, b, 7), 7) || ext16(svext(a, b, 64), 64) || ext16(svext(a, b, 127), 127))
        return 22;
    return 0;
}

/* A word lane in every lane, zero for an index past the vector. */
static int dup32(svint32_t a, uint32_t k) {
    int n = (int)svcntw();
    svst1(svptrue_b32(), r32, svdup_lane(a, k));
    for (int i = 0; i < n; i++)
        if (r32[i] != (k < (uint32_t)n ? a32[k] : 0))
            return 1;
    return 0;
}

static int words(void) {
    int n = (int)svcntw();
    svint32_t a = svld1(svptrue_b32(), a32);
    if (dup32(a, 0) || dup32(a, 3) || dup32(a, (uint32_t)n - 1))
        return 30;
    if (dup32(a, (uint32_t)n) || dup32(a, 1000) || dup32(a, UINT32_MAX))
        return 31;
    svst1(svptrue_b32(), r32, svdup_lane_s32(a, 1));
    if (r32[n - 1] != a32[1])
        return 32;
    return 0;
}

/* Floating lanes moved as bits: the doublewords as bytes and back, and
 * an extraction of floating lanes. */
static int bits(void) {
    int n = (int)svcntd();
    svbool_t all = svptrue_b64();
    svfloat64_t a = svld1(all, ad), b = svld1(all, bd);
    svst1(svptrue_b8(), r8, svreinterpret_u8_f64(a));
    const unsigned char *p = (const unsigned char *)ad;
    for (int i = 0; i < 8 * n; i++)
        if (r8[i] != p[i])
            return 40;
    svint64_t x = svreinterpret_s64(a);
    svst1(all, rd, svreinterpret_f64_s64(svadd_x(svptrue_b64(), x, svdup_n_s64(0))));
    for (int i = 0; i < n; i++)
        if (rd[i] != ad[i])
            return 41;
    svst1(all, rd, svext_f64(a, b, 1));
    for (int i = 0; i < n; i++)
        if (rd[i] != (i + 1 < n ? ad[i + 1] : bd[0]))
            return 42;
    return 0;
}

int main(void) {
    fill();
    int r = bytes();
    if (!r)
        r = halfwords();
    if (!r)
        r = words();
    if (!r)
        r = bits();
    if (r)
        return r;
    return (int)(svcntb() / 16);
}

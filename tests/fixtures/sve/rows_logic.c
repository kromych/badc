/* The ACLE SVE logic, select and test intrinsics over arrays whose length
 * is no multiple of the vector length: svand, svorr and sveor in the
 * merging, zeroing and don't-care forms and with a scalar operand, the
 * predicate logic svand_b_z to svnot_b_z, svsel of vectors and of
 * predicates, and svptest_any, svptest_first and svptest_last, each
 * checked against the same computation in scalar C. The exit status is
 * the vector length in 128-bit granules. */
#include <arm_sve.h>

#define N 77

static uint32_t a32[N], b32[N], r32[N];
static int8_t a8[N], b8[N], r8[N];
static uint64_t a64[N], b64[N], r64[N];
static int16_t a16[N], b16[N], r16[N];
static float af[N], bf[N], rf[N];
static double ad[N], bd[N], rd[N];

static void fill(void) {
    for (int i = 0; i < N; i++) {
        a32[i] = (uint32_t)i * 2654435761u;
        b32[i] = ~((uint32_t)i * 40503u);
        a8[i] = (int8_t)((i * 37) % 256 - 128);
        b8[i] = (int8_t)((i * 11 + 5) % 256 - 128);
        a64[i] = (uint64_t)i * 0x9E3779B97F4A7C15ull;
        b64[i] = a64[i] >> 7 ^ 0xFFFF0000FFFFull;
        a16[i] = (int16_t)(i * 300 - 9000);
        b16[i] = (int16_t)(4000 - i * i * 3);
        af[i] = (float)i * 0.5f - 11.0f;
        bf[i] = 7.25f - (float)i * 0.25f;
        ad[i] = (double)i * 1.25 - 40.0;
        bd[i] = 3.0 - (double)i * 0.5;
    }
}

/* r = a & b, a | b, a ^ b by the predication forms, governed by the odd
 * lanes of b: the merging form keeps a in the others, the zeroing form
 * zeroes them. */
static int vectors32(void) {
    for (int op = 0; op < 9; op++) {
        for (int i = 0; i < N; i += (int)svcntw()) {
            svbool_t pg = svwhilelt_b32(i, N);
            svuint32_t a = svld1(pg, &a32[i]);
            svuint32_t b = svld1_u32(pg, &b32[i]);
            svbool_t odd = svcmpne_n_u32(pg, svand_n_u32_x(pg, b, 1), 0);
            svuint32_t r;
            switch (op) {
            case 0: r = svand_u32_m(odd, a, b); break;
            case 1: r = svand_z(odd, a, b); break;
            case 2: r = svand_x(pg, a, b); break;
            case 3: r = svorr_n_u32_m(odd, a, 0x80000001u); break;
            case 4: r = svorr_u32_z(odd, a, b); break;
            case 5: r = svorr_x(pg, a, b); break;
            case 6: r = sveor_m(odd, a, b); break;
            case 7: r = sveor_n_u32_z(odd, a, 0xFFFFu); break;
            default: r = sveor_x(pg, a, svdup_n_u32(0x5A5A5A5Au)); break;
            }
            svst1(pg, &r32[i], r);
        }
        for (int i = 0; i < N; i++) {
            uint32_t a = a32[i], b = b32[i], want;
            int on = (b & 1) != 0;
            switch (op) {
            case 0: want = on ? a & b : a; break;
            case 1: want = on ? a & b : 0; break;
            case 2: want = a & b; break;
            case 3: want = on ? a | 0x80000001u : a; break;
            case 4: want = on ? a | b : 0; break;
            case 5: want = a | b; break;
            case 6: want = on ? a ^ b : a; break;
            case 7: want = on ? a ^ 0xFFFFu : 0; break;
            default: want = a ^ 0x5A5A5A5Au; break;
            }
            if (r32[i] != want)
                return 10 + op;
        }
    }
    return 0;
}

/* Byte and doubleword lanes: a signed compare governs, svsel picks. */
static int other_widths(void) {
    for (int i = 0; i < N; i += (int)svcntb()) {
        svbool_t pg = svwhilelt_b8(i, N);
        svint8_t a = svld1(pg, &a8[i]), b = svld1(pg, &b8[i]);
        svbool_t lt = svcmplt(pg, a, b);
        svint8_t x = sveor_s8_z(lt, a, b);
        svst1(pg, &r8[i], svorr_m(lt, svsel_s8(lt, x, a), svdup_n_s8(1)));
    }
    for (int i = 0; i < N; i += (int)svcntd()) {
        svbool_t pg = svwhilelt_b64((uint64_t)i, (uint64_t)N);
        svuint64_t a = svld1(pg, &a64[i]), b = svld1_u64(pg, &b64[i]);
        svbool_t gt = svcmpgt(pg, a, b);
        svst1(pg, &r64[i], svsel(gt, sveor_x(pg, a, b), svand_n_u64_z(pg, b, 0xF0F0F0F0F0F0F0F0ull)));
    }
    for (int i = 0; i < N; i++) {
        int8_t a = a8[i], b = b8[i];
        int8_t want = a < b ? (int8_t)((a ^ b) | 1) : a;
        if (r8[i] != want)
            return 30;
        uint64_t x = a64[i], y = b64[i];
        if (r64[i] != (x > y ? x ^ y : y & 0xF0F0F0F0F0F0F0F0ull))
            return 31;
    }
    return 0;
}

/* The predicate logic on halfword compares, each result stored as ones
 * and zeros through svsel; the select of predicates. */
static int predicates(void) {
    for (int op = 0; op < 9; op++) {
        for (int i = 0; i < N; i += (int)svcnth()) {
            svbool_t pg = svwhilelt_b16(i, N);
            svint16_t a = svld1(pg, &a16[i]), b = svld1(pg, &b16[i]);
            svbool_t pa = svcmpgt_n_s16(pg, a, 0), pb = svcmplt(pg, a, b);
            svbool_t r;
            switch (op) {
            case 0: r = svand_b_z(pg, pa, pb); break;
            case 1: r = svorr_b_z(pg, pa, pb); break;
            case 2: r = sveor_z(pg, pa, pb); break;
            case 3: r = svbic_b_z(pg, pa, pb); break;
            case 4: r = svorn_z(pg, pa, pb); break;
            case 5: r = svnand_b_z(pg, pa, pb); break;
            case 6: r = svnor_b_z(pg, pa, pb); break;
            case 7: r = svnot_b_z(pg, pa); break;
            default: r = svsel_b(svcmpne_n_s16(pg, b, 1000), pa, pb); break;
            }
            svst1(pg, &r16[i], svsel(r, svdup_n_s16(1), svdup_n_s16(0)));
        }
        for (int i = 0; i < N; i++) {
            int pa = a16[i] > 0, pb = a16[i] < b16[i], want;
            switch (op) {
            case 0: want = pa & pb; break;
            case 1: want = pa | pb; break;
            case 2: want = pa ^ pb; break;
            case 3: want = pa & !pb; break;
            case 4: want = pa | !pb; break;
            case 5: want = !(pa & pb); break;
            case 6: want = !(pa | pb); break;
            case 7: want = !pa; break;
            default: want = b16[i] != 1000 ? pa : pb; break;
            }
            if (r16[i] != want)
                return 40 + op;
        }
    }
    return 0;
}

/* svptest over each step's lanes: whether any is set, the first, the
 * last; over every bit of svptrue_b8 a not sets the odd bits. */
static int tests(void) {
    int step = (int)svcnth();
    for (int i = 0; i < N; i += step) {
        svbool_t pg = svwhilelt_b16(i, N);
        svint16_t a = svld1(pg, &a16[i]);
        svbool_t pa = svcmpgt_n_s16(pg, a, 0);
        int any = 0, end = i + step < N ? i + step : N;
        for (int k = i; k < end; k++)
            any |= a16[k] > 0;
        if (svptest_any(pg, pa) != any)
            return 60;
        if (svptest_first(pg, pa) != (a16[i] > 0))
            return 61;
        if (svptest_last(pg, pa) != (a16[end - 1] > 0))
            return 62;
        svbool_t all = svptrue_b8();
        svbool_t na = svnot_b_z(all, pa);
        if (!svptest_any(all, na) || !svptest_last(all, na))
            return 63;
        if (svptest_first(all, na) != (a16[i] <= 0))
            return 64;
        svbool_t none = svbic_b_z(pg, pa, pa);
        if (svptest_any(pg, none) || svptest_first(none, pa) || svptest_last(none, pa))
            return 65;
    }
    return 0;
}

/* svsel of floating lanes: the larger of a and b, the lanes not taken
 * negated. */
static int floats(void) {
    for (int i = 0; i < N; i += (int)svcntw()) {
        svbool_t pg = svwhilelt_b32(i, N);
        svfloat32_t a = svld1(pg, &af[i]), b = svld1_f32(pg, &bf[i]);
        svst1(pg, &rf[i], svsel_f32(svcmpge(pg, a, b), a, svmul_n_f32_x(pg, b, -1.0f)));
    }
    for (int i = 0; i < N; i += (int)svcntd()) {
        svbool_t pg = svwhilelt_b64(i, N);
        svfloat64_t a = svld1(pg, &ad[i]), b = svld1(pg, &bd[i]);
        svst1(pg, &rd[i], svsel(svcmplt(pg, a, b), b, a));
    }
    for (int i = 0; i < N; i++) {
        if (rf[i] != (af[i] >= bf[i] ? af[i] : -bf[i]))
            return 70;
        if (rd[i] != (ad[i] < bd[i] ? bd[i] : ad[i]))
            return 71;
    }
    return 0;
}

int main(void) {
    fill();
    int r = vectors32();
    if (!r)
        r = other_widths();
    if (!r)
        r = predicates();
    if (!r)
        r = tests();
    if (!r)
        r = floats();
    if (r)
        return r;
    return (int)(svcntb() / 16);
}

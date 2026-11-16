/* A function that takes or returns an SVE value preserves z8-z23 and
 * p4-p15 whole for its caller, under the SVE procedure call standard. The
 * caller here is `probe`, in assembly: it fills the registers, calls the
 * function and counts those that changed. One callee reaches a function of
 * the base standard, which may change every one of them but the low halves
 * of z8-z15; another keeps its values in them. The exit status is the
 * vector length in 128-bit granules. */
#include <arm_sve.h>

__asm__(".text\n"
        ".globl probe\n"
        ".type probe, %function\n"
        /* int probe(svint8_t (*f)(svint8_t), void *arg): the count of
         * z8-z23 and p4-p15 that differ after f(*arg); the result
         * is stored back through arg. */
        "probe:\n"
        "  stp x29, x30, [sp, #-48]!\n"
        "  mov x29, sp\n"
        "  stp x19, x20, [sp, #16]\n"
        "  stp d8, d9, [sp, #32]\n"
        "  mov x19, x1\n"
        "  sub sp, sp, #64\n"
        "  stp d10, d11, [sp]\n"
        "  stp d12, d13, [sp, #16]\n"
        "  stp d14, d15, [sp, #32]\n"
        "  mov x16, x0\n"
        "  ldr z0, [x19]\n"
        "  dup z8.b, #8\n  dup z9.b, #9\n  dup z10.b, #10\n  dup z11.b, #11\n"
        "  dup z12.b, #12\n  dup z13.b, #13\n  dup z14.b, #14\n  dup z15.b, #15\n"
        "  dup z16.b, #16\n  dup z17.b, #17\n  dup z18.b, #18\n  dup z19.b, #19\n"
        "  dup z20.b, #20\n  dup z21.b, #21\n  dup z22.b, #22\n  dup z23.b, #23\n"
        "  ptrue p4.b, vl1\n  ptrue p5.h, vl2\n  ptrue p6.s, vl3\n  ptrue p7.d, vl1\n"
        "  ptrue p8.b, vl5\n  ptrue p9.b, vl6\n  ptrue p10.b, vl7\n  ptrue p11.b, vl8\n"
        "  ptrue p12.h\n  ptrue p13.s\n  ptrue p14.d\n  ptrue p15.b\n"
        "  blr x16\n"
        "  str z0, [x19]\n"
        "  mov w20, #0\n"
        "  ptrue p1.b\n"
        "  .irp n, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23\n"
        "  dup z31.b, #\\n\n"
        "  cmpne p0.b, p1/z, z\\n\\().b, z31.b\n"
        "  cinc w20, w20, ne\n"
        "  .endr\n"
        "  ptrue p2.b, vl1\n  eors p0.b, p1/z, p4.b, p2.b\n  cinc w20, w20, ne\n"
        "  ptrue p2.h, vl2\n  eors p0.b, p1/z, p5.b, p2.b\n  cinc w20, w20, ne\n"
        "  ptrue p2.s, vl3\n  eors p0.b, p1/z, p6.b, p2.b\n  cinc w20, w20, ne\n"
        "  ptrue p2.d, vl1\n  eors p0.b, p1/z, p7.b, p2.b\n  cinc w20, w20, ne\n"
        "  ptrue p2.b, vl5\n  eors p0.b, p1/z, p8.b, p2.b\n  cinc w20, w20, ne\n"
        "  ptrue p2.b, vl6\n  eors p0.b, p1/z, p9.b, p2.b\n  cinc w20, w20, ne\n"
        "  ptrue p2.b, vl7\n  eors p0.b, p1/z, p10.b, p2.b\n  cinc w20, w20, ne\n"
        "  ptrue p2.b, vl8\n  eors p0.b, p1/z, p11.b, p2.b\n  cinc w20, w20, ne\n"
        "  ptrue p2.h\n  eors p0.b, p1/z, p12.b, p2.b\n  cinc w20, w20, ne\n"
        "  ptrue p2.s\n  eors p0.b, p1/z, p13.b, p2.b\n  cinc w20, w20, ne\n"
        "  ptrue p2.d\n  eors p0.b, p1/z, p14.b, p2.b\n  cinc w20, w20, ne\n"
        "  ptrue p2.b\n  eors p0.b, p1/z, p15.b, p2.b\n  cinc w20, w20, ne\n"
        "  mov w0, w20\n"
        "  ldp d10, d11, [sp]\n"
        "  ldp d12, d13, [sp, #16]\n"
        "  ldp d14, d15, [sp, #32]\n"
        "  add sp, sp, #64\n"
        "  ldp d8, d9, [sp, #32]\n"
        "  ldp x19, x20, [sp, #16]\n"
        "  ldp x29, x30, [sp], #48\n"
        "  ret\n"
        ".size probe, .-probe\n"
        /* A function of the base standard that changes every z and p
         * register it may: all but the low 64 bits of z8-z15. */
        ".globl scramble\n"
        ".type scramble, %function\n"
        "scramble:\n"
        "  stp d8, d9, [sp, #-64]!\n"
        "  stp d10, d11, [sp, #16]\n"
        "  stp d12, d13, [sp, #32]\n"
        "  stp d14, d15, [sp, #48]\n"
        "  .irp n, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31\n"
        "  dup z\\n\\().b, #-86\n"
        "  .endr\n"
        "  .irp n, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15\n"
        "  pfalse p\\n\\().b\n"
        "  .endr\n"
        "  ldp d10, d11, [sp, #16]\n"
        "  ldp d12, d13, [sp, #32]\n"
        "  ldp d14, d15, [sp, #48]\n"
        "  ldp d8, d9, [sp], #64\n"
        "  ret\n"
        ".size scramble, .-scramble\n");

int probe(svint8_t (*f)(svint8_t), void *arg);
void scramble(void);

static unsigned char buf[256], keep[32][256];

/* Reaches a function of the base standard. */
svint8_t across(svint8_t x) {
    scramble();
    return x;
}

/* Holds more vectors than z0-z7 and z24-z31 keep. */
svint8_t many(svint8_t x) {
    svint8_t v0 = *(svint8_t *)keep[0], v1 = *(svint8_t *)keep[1], v2 = *(svint8_t *)keep[2];
    svint8_t v3 = *(svint8_t *)keep[3], v4 = *(svint8_t *)keep[4], v5 = *(svint8_t *)keep[5];
    svint8_t v6 = *(svint8_t *)keep[6], v7 = *(svint8_t *)keep[7], v8 = *(svint8_t *)keep[8];
    svint8_t v9 = *(svint8_t *)keep[9], v10 = *(svint8_t *)keep[10], v11 = *(svint8_t *)keep[11];
    svint8_t v12 = *(svint8_t *)keep[12], v13 = *(svint8_t *)keep[13], v14 = *(svint8_t *)keep[14];
    svint8_t v15 = *(svint8_t *)keep[15], v16 = *(svint8_t *)keep[16], v17 = *(svint8_t *)keep[17];
    svint8_t v18 = *(svint8_t *)keep[18], v19 = *(svint8_t *)keep[19], v20 = *(svint8_t *)keep[20];
    svbool_t p0 = *(svbool_t *)keep[21], p1 = *(svbool_t *)keep[22], p2 = *(svbool_t *)keep[23];
    svbool_t p3 = *(svbool_t *)keep[24], p4 = *(svbool_t *)keep[25], p5 = *(svbool_t *)keep[26];
    *(svint8_t *)keep[20] = v0; *(svint8_t *)keep[19] = v1; *(svint8_t *)keep[18] = v2;
    *(svint8_t *)keep[17] = v3; *(svint8_t *)keep[16] = v4; *(svint8_t *)keep[15] = v5;
    *(svint8_t *)keep[14] = v6; *(svint8_t *)keep[13] = v7; *(svint8_t *)keep[12] = v8;
    *(svint8_t *)keep[11] = v9; *(svint8_t *)keep[10] = v10; *(svint8_t *)keep[9] = v11;
    *(svint8_t *)keep[8] = v12; *(svint8_t *)keep[7] = v13; *(svint8_t *)keep[6] = v14;
    *(svint8_t *)keep[5] = v15; *(svint8_t *)keep[4] = v16; *(svint8_t *)keep[3] = v17;
    *(svint8_t *)keep[2] = v18; *(svint8_t *)keep[1] = v19; *(svint8_t *)keep[0] = v20;
    *(svbool_t *)keep[26] = p0; *(svbool_t *)keep[25] = p1; *(svbool_t *)keep[24] = p2;
    *(svbool_t *)keep[23] = p3; *(svbool_t *)keep[22] = p4; *(svbool_t *)keep[21] = p5;
    return x;
}

/* Holds more predicates than p0-p6 and p8-p13 keep: those in slots are
 * read as the second operand of svorr_z, or govern svadd_m. */
svint8_t preds(svint8_t x) {
    svbool_t pg = svptrue_b8();
    svbool_t c0 = svcmpgt(pg, x, svdup_n_s8(0)), c1 = svcmpgt(pg, x, svdup_n_s8(1));
    svbool_t c2 = svcmpgt(pg, x, svdup_n_s8(2)), c3 = svcmpgt(pg, x, svdup_n_s8(3));
    svbool_t c4 = svcmpgt(pg, x, svdup_n_s8(4)), c5 = svcmpgt(pg, x, svdup_n_s8(5));
    svbool_t c6 = svcmpgt(pg, x, svdup_n_s8(6)), c7 = svcmpgt(pg, x, svdup_n_s8(7));
    svbool_t c8 = svcmpgt(pg, x, svdup_n_s8(8)), c9 = svcmpgt(pg, x, svdup_n_s8(9));
    svbool_t c10 = svcmpgt(pg, x, svdup_n_s8(10)), c11 = svcmpgt(pg, x, svdup_n_s8(11));
    svbool_t c12 = svcmpgt(pg, x, svdup_n_s8(12)), c13 = svcmpgt(pg, x, svdup_n_s8(13));
    svbool_t c14 = svcmpgt(pg, x, svdup_n_s8(14)), c15 = svcmpgt(pg, x, svdup_n_s8(15));
    svbool_t any = svorr_z(pg, c0, pg);
    any = svorr_z(pg, c1, any); any = svorr_z(pg, c2, any); any = svorr_z(pg, c3, any);
    any = svorr_z(pg, c4, any); any = svorr_z(pg, c5, any); any = svorr_z(pg, c6, any);
    any = svorr_z(pg, c7, any); any = svorr_z(pg, c8, any); any = svorr_z(pg, c9, any);
    any = svorr_z(pg, c10, any); any = svorr_z(pg, c11, any); any = svorr_z(pg, c12, any);
    any = svorr_z(pg, c13, any); any = svorr_z(pg, c14, any); any = svorr_z(pg, c15, any);
    return svadd_m(any, x, svdup_n_s8(0));
}

svint8_t govern(svint8_t x) {
    svbool_t pg = svptrue_b8();
    svint8_t d = svdup_n_s8(0);
    svbool_t c0 = svcmpgt(pg, x, svdup_n_s8(0)), c1 = svcmpgt(pg, x, svdup_n_s8(1));
    svbool_t c2 = svcmpgt(pg, x, svdup_n_s8(2)), c3 = svcmpgt(pg, x, svdup_n_s8(3));
    svbool_t c4 = svcmpgt(pg, x, svdup_n_s8(4)), c5 = svcmpgt(pg, x, svdup_n_s8(5));
    svbool_t c6 = svcmpgt(pg, x, svdup_n_s8(6)), c7 = svcmpgt(pg, x, svdup_n_s8(7));
    svbool_t c8 = svcmpgt(pg, x, svdup_n_s8(8)), c9 = svcmpgt(pg, x, svdup_n_s8(9));
    svbool_t c10 = svcmpgt(pg, x, svdup_n_s8(10)), c11 = svcmpgt(pg, x, svdup_n_s8(11));
    svbool_t c12 = svcmpgt(pg, x, svdup_n_s8(12)), c13 = svcmpgt(pg, x, svdup_n_s8(13));
    svbool_t c14 = svcmpgt(pg, x, svdup_n_s8(14)), c15 = svcmpgt(pg, x, svdup_n_s8(15));
    svint8_t r = svadd_m(c0, x, d);
    r = svadd_m(c1, r, d); r = svadd_m(c2, r, d); r = svadd_m(c3, r, d);
    r = svadd_m(c4, r, d); r = svadd_m(c5, r, d); r = svadd_m(c6, r, d);
    r = svadd_m(c7, r, d); r = svadd_m(c8, r, d); r = svadd_m(c9, r, d);
    r = svadd_m(c10, r, d); r = svadd_m(c11, r, d); r = svadd_m(c12, r, d);
    r = svadd_m(c13, r, d); r = svadd_m(c14, r, d); r = svadd_m(c15, r, d);
    return r;
}

int main(void) {
    for (int i = 0; i < 256; i++)
        buf[i] = (unsigned char)(i * 13 + 5);
    for (int k = 0; k < 32; k++)
        for (int i = 0; i < 256; i++)
            keep[k][i] = (unsigned char)(k * 29 + i);
    if (probe(across, buf) != 0)
        return 100;
    if (probe(many, buf) != 0)
        return 101;
    if (probe(preds, buf) != 0)
        return 104;
    if (probe(govern, buf) != 0)
        return 105;
    /* The argument came back, and `many` reversed the objects. */
    for (int i = 0; i < 256; i++)
        if (buf[i] != (unsigned char)(i * 13 + 5))
            return 102;
    if (keep[0][0] != (unsigned char)(20 * 29) || keep[20][1] != 1)
        return 103;
    /* The vector length, as far as a vector copy reaches. */
    for (int i = 0; i < 256; i++)
        buf[i] = 0;
    *(svint8_t *)buf = *(svint8_t *)keep[31];
    int vl = 0;
    while (vl < 256 && buf[vl] == keep[31][vl])
        vl++;
    return vl / 16;
}

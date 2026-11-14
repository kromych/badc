/* More SVE values live at once than there are registers: forty vectors
 * and twenty predicates, each loaded from its own pointer before any is
 * stored back, in reverse order, once across a call. The vectors outnumber
 * the 32 Z registers and the predicates the P registers that hold values;
 * the rest take slots of the VL-scaled frame region. The exit status is
 * the vector length in 128-bit granules. */
#include <arm_sve.h>

#define X20(m) \
    m(0) m(1) m(2) m(3) m(4) m(5) m(6) m(7) m(8) m(9) m(10) m(11) m(12) m(13) m(14) m(15) \
    m(16) m(17) m(18) m(19)
#define X40(m) \
    X20(m) m(20) m(21) m(22) m(23) m(24) m(25) m(26) m(27) m(28) m(29) m(30) m(31) m(32) \
    m(33) m(34) m(35) m(36) m(37) m(38) m(39)

#define LZ(i) svint8_t z##i = *src[i];
#define SZ(i) *dst[39 - (i)] = z##i;
#define LP(i) svbool_t p##i = *psrc[i];
#define SP(i) *pdst[19 - (i)] = p##i;

void reverse(svint8_t *const *src, svint8_t *const *dst, svbool_t *const *psrc,
             svbool_t *const *pdst, void (*f)(void)) {
    X40(LZ)
    X20(LP)
    if (f)
        f();
    X40(SZ)
    X20(SP)
}

static int calls;

static void touch(void) { calls++; }

static unsigned char in[40][256], out[40][256], pin[20][32], pout[20][32];

static int check(void) {
    int vl = 0;
    while (vl < 256 && out[39][vl] == in[0][vl])
        vl++;
    int pl = vl / 8;
    for (int i = 0; i < 40; i++)
        for (int k = 0; k < 256; k++)
            if (out[39 - i][k] != (k < vl ? in[i][k] : 0))
                return -1;
    for (int i = 0; i < 20; i++)
        for (int k = 0; k < 32; k++)
            if (pout[19 - i][k] != (k < pl ? pin[i][k] : 0))
                return -2;
    return vl;
}

int main(void) {
    svint8_t *src[40], *dst[40];
    svbool_t *psrc[20], *pdst[20];
    for (int i = 0; i < 40; i++) {
        for (int k = 0; k < 256; k++)
            in[i][k] = (unsigned char)(i * 37 + k * 3 + 1 + (k == 0));
        src[i] = (svint8_t *)in[i];
        dst[i] = (svint8_t *)out[i];
    }
    for (int i = 0; i < 20; i++) {
        for (int k = 0; k < 32; k++)
            pin[i][k] = (unsigned char)(i * 13 + k * 5 + 2);
        psrc[i] = (svbool_t *)pin[i];
        pdst[i] = (svbool_t *)pout[i];
    }
    reverse(src, dst, psrc, pdst, 0);
    int vl = check();
    if (vl <= 0 || vl % 16 != 0)
        return 100 - vl;
    for (int i = 0; i < 40; i++)
        for (int k = 0; k < 256; k++)
            out[i][k] = 0;
    for (int i = 0; i < 20; i++)
        for (int k = 0; k < 32; k++)
            pout[i][k] = 0;
    reverse(src, dst, psrc, pdst, touch);
    if (check() != vl || calls != 1)
        return 103;
    return vl / 16;
}

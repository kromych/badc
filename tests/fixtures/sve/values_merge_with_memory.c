/* SVE values merge where control flow joins, and mix with objects whose
 * address is taken and with a variable-length array, which keep their
 * storage. The exit status is the vector length in 128-bit granules. */
#include <arm_sve.h>

/* Selects one of three vectors by `k` through branches, copies it through
 * an object whose address escapes into a variable-length array's frame,
 * and fills a predicate in a nested loop scope. */
void pick(svint32_t *dst, svint32_t *const *src, svbool_t *pdst, svbool_t *const *psrc, int k,
          int n, void (*f)(svint32_t *)) {
    svint32_t v;
    svbool_t p = *psrc[0];
    if (k == 0)
        v = *src[0];
    else if (k == 1)
        v = *src[1];
    else
        v = *src[2];
    unsigned char vla[n];
    for (int i = 0; i < n; i++)
        vla[i] = (unsigned char)i;
    svint32_t kept = v;
    f(&kept);
    for (int i = 0; i < n; i++) {
        svbool_t q = *psrc[i % 3];
        for (int j = 0; j < 2; j++) {
            svbool_t r = q;
            if (vla[i] == (unsigned char)(n - 1) && j == 1)
                p = r;
        }
    }
    *dst = kept;
    *pdst = p;
}

static int seen;
static unsigned char expect;

static void note(svint32_t *x) { seen += *(unsigned char *)x == expect; }

static unsigned char in[3][256], out[256], pin[3][32], pout[32];

static int same(const unsigned char *a, const unsigned char *b, int n) {
    int k = 0;
    while (k < n && a[k] == b[k])
        k++;
    return k;
}

int main(void) {
    svint32_t *src[3];
    svbool_t *psrc[3];
    for (int i = 0; i < 3; i++) {
        for (int k = 0; k < 256; k++)
            in[i][k] = (unsigned char)(i * 61 + k * 7 + 1);
        for (int k = 0; k < 32; k++)
            pin[i][k] = (unsigned char)(i * 29 + k * 3 + 5);
        src[i] = (svint32_t *)in[i];
        psrc[i] = (svbool_t *)pin[i];
    }
    int vl = 0;
    for (int k = 0; k < 3; k++) {
        for (int n = 1; n <= 4; n++) {
            for (int i = 0; i < 256; i++)
                out[i] = 0;
            for (int i = 0; i < 32; i++)
                pout[i] = 0;
            expect = in[k][0];
            pick((svint32_t *)out, src, (svbool_t *)pout, psrc, k, n, note);
            int got = same(out, in[k], 256);
            if (vl == 0)
                vl = got;
            if (got != vl || vl % 16 != 0 || (vl < 256 && out[vl] != 0))
                return 100 + k;
            int p = same(pout, pin[(n - 1) % 3], 32);
            if (p != vl / 8 || (p < 32 && pout[p] != 0))
                return 110 + n;
        }
    }
    return seen == 12 ? vl / 16 : 120;
}

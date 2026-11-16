/* SVE objects take the vector length of storage, an eighth of it for a
 * predicate, and assignment copies them whole, across a call and through
 * `&x`. The exit status is the vector length in 128-bit granules. */
#include <arm_sve.h>

static void touch(void) {}

void copy(svint32_t *dst, svint32_t *src, void (*f)(void)) {
    svint32_t x = *src;
    svint32_t *px = &x;
    f();
    *dst = *px;
}

void copyp(svbool_t *dst, svbool_t *src, int n) {
    for (int i = 0; i < n; i++) {
        svbool_t p, q;
        p = *src;
        q = p;
        *dst = q;
    }
}

static int same(const unsigned char *a, const unsigned char *b) {
    int n = 0;
    while (n < 256 && a[n] == b[n])
        n++;
    return n;
}

int main(void) {
    unsigned char a[256], b[256], c[256];
    for (int i = 0; i < 256; i++) {
        a[i] = (unsigned char)(i * 7 + 1);
        b[i] = c[i] = 0;
    }
    copy((svint32_t *)b, (svint32_t *)a, touch);
    copyp((svbool_t *)c, (svbool_t *)a, 3);
    int vl = same(a, b), pl = same(a, c);
    return vl % 16 == 0 && pl * 8 == vl ? vl / 16 : 100 + pl;
}

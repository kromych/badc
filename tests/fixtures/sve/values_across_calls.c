/* SVE vectors and predicates whose address is not taken are values. Here
 * they live across calls, which preserve no Z or P register in full, and
 * swap through a loop, a cycle of phis. The exit status is the vector
 * length in 128-bit granules. */
#include <arm_sve.h>

static int calls;

static void touch(void) { calls++; }

void swap(svint32_t *a, svint32_t *b, svbool_t *p, svbool_t *q, int n, void (*f)(void)) {
    svint32_t x = *a, y = *b;
    svbool_t s = *p, t = *q;
    for (int i = 0; i < n; i++) {
        svint32_t z = x;
        svbool_t u = s;
        x = y;
        y = z;
        f();
        s = t;
        t = u;
    }
    f();
    *a = x;
    *b = y;
    *p = s;
    *q = t;
}

static unsigned char a[256], b[256], p[256], q[256];

static void fill(void) {
    for (int i = 0; i < 256; i++) {
        a[i] = (unsigned char)(i * 7 + 1);
        b[i] = (unsigned char)(i * 5 + 2);
        p[i] = (unsigned char)(i * 3 + 3);
        q[i] = (unsigned char)(i * 11 + 4);
    }
}

/* The leading bytes of `x` that hold `y`'s pattern. */
static int run(const unsigned char *x, int k) {
    int n = 0;
    while (n < 256 && x[n] == (unsigned char)(n * k + (k == 7 ? 1 : k == 5 ? 2 : k == 3 ? 3 : 4)))
        n++;
    return n;
}

int main(void) {
    fill();
    swap((svint32_t *)a, (svint32_t *)b, (svbool_t *)p, (svbool_t *)q, 3, touch);
    /* Swapped: a holds b's first vector, b a's; p q's first predicate. */
    int vl = run(b, 7), pl = run(q, 3);
    if (run(a, 5) != vl || run(p, 11) != pl || calls != 4)
        return 100;
    if (vl % 16 != 0 || pl * 8 != vl || (vl < 256 && a[vl] != (unsigned char)(vl * 7 + 1)))
        return 101;
    fill();
    swap((svint32_t *)a, (svint32_t *)b, (svbool_t *)p, (svbool_t *)q, 4, touch);
    if (run(a, 7) != 256 || run(b, 5) != 256 || run(p, 3) != 256 || run(q, 11) != 256)
        return 102;
    return vl / 16;
}

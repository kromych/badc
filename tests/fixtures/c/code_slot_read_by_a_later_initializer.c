/* A later initializer reading a `const` slot that holds a function's address,
 * with and without an offset, gets that function: one declared before the
 * slot and defined after it included. Constant folds over such a read
 * compare and subtract as over the function itself. `first` takes the first
 * entry pc, so no stale pc can pass for another function. Returns 0. */
#include <stdint.h>

typedef long (*fn)(void);

static long first(void) { return 0; }
static long fe(void);
static long fb(void);
static long fc(void);
static long fd(void);

static const struct {
    int k;
    fn f;
    char *p;
} ce = {1, fe, (char *)fe + 4};
static void *const cp = (void *)fb;
static char *const cpb = (char *)fb + 8;
static const struct {
    fn f;
    char *p;
} cs = {fc, (char *)fc + 12};
static char *const ca[2] = {(char *)fd + 1, (char *)fd + 2};

static long fe(void) { return 5; }
static long fb(void) { return 2; }
static long fc(void) { return 3; }

static fn qe = ce.f;
static void *q = cp;
static char *qb = cpb;
static char *qcp = cs.p;
static fn qcf = cs.f;
static char *qd = ca[1];
static int eq = ce.f == fe;
static int eq_first = ce.f == first;
static long diff = ce.p - (char *)fe;

static long fd(void) { return 4; }

#define D(p, f) ((long)((uintptr_t)(p) - (uintptr_t)(f)))

int main(void) {
    if (first() != 0 || qe != fe || ce.f != fe || qe() != 5) {
        return 1;
    }
    if (q != (void *)fb || ((fn)q)() != 2 || D(qb, fb) != 8 || D(cpb, fb) != 8) {
        return 2;
    }
    if (D(qcp, fc) != 12 || qcf != fc || qcf() != 3) {
        return 3;
    }
    if (D(qd, fd) != 2 || D(ca[1], fd) != 2 || fd() != 4) {
        return 4;
    }
    if (eq != 1 || eq_first != 0 || diff != 4) {
        return 5;
    }
    return 0;
}

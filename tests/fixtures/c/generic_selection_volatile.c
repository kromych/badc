/* C11 6.5.1.1p2: the control expression undergoes lvalue conversion,
   which drops the top-level qualifier, so a `volatile`-qualified object
   selects the association its unqualified type names. That covers the
   qualifier on a scalar (`volatile int`) and on a pointer object
   (`T *volatile`). Pointer level and signedness stay significant. */
static volatile int vi;
static volatile unsigned uv;
static int i;
static int *volatile vp = &i;
static int *pp = &i;
static int **ppp = &pp;

int main(void) {
    if (_Generic(vi, int: 1, unsigned: 2, default: 0) != 1) {
        return 1;
    }
    if (_Generic(uv, int: 1, unsigned: 2, default: 0) != 2) {
        return 2;
    }
    if (_Generic(vp, int *: 1, int **: 2, default: 0) != 1) {
        return 3;
    }
    if (_Generic(pp, int *: 1, int **: 2, default: 0) != 1) {
        return 4;
    }
    if (_Generic(ppp, int *: 1, int **: 2, default: 0) != 2) {
        return 5;
    }
    return 0;
}

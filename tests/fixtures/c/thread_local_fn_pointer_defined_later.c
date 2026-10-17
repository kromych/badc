/* A `_Thread_local` function pointer initialised with a function declared
 * before the object and defined after it holds that definition's address
 * (C11 6.7.9p4: an address constant), as a static-storage pointer does:
 * scalar and aggregate initializers, internal and external linkage, and a
 * byte offset past the function's address. */
typedef long (*fn)(void);

static long fb(void) { return 50; }
static long f0(void);
long f1_ext(void);
static long f2(void);

static _Thread_local fn tl0 = f0;
static _Thread_local fn tl1 = f1_ext;
static _Thread_local fn tl_tab[2] = {f2, f0};
static _Thread_local struct {
    int k;
    fn f;
} tl_s = {7, f2};
static _Thread_local char *tl_off[3] = {(char *)fb + 4, (char *)f2 + 8, (char *)f1_ext - 2};

static long f0(void) { return 100; }
long f1_ext(void) { return 200; }
static long f2(void) { return 300; }

int main(void) {
    return !(tl0() == 100 && tl1() == 200 && tl_tab[0]() == 300 && tl_tab[1]() == 100 &&
             tl_s.k == 7 && tl_s.f() == 300 && fb() == 50 && tl_off[0] - (char *)fb == 4 &&
             tl_off[1] - (char *)f2 == 8 && tl_off[2] - (char *)f1_ext == -2);
}

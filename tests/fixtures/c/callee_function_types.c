// A call converts each argument to the parameter type of its callee
// expression's function type (C99 6.5.2.2p7), whatever form the callee
// takes, and promotes past the prototype or without one (6.5.2.2p6). Each
// `twice`-shaped callee here receives the int 3, which only a conversion
// to `double` doubles to 6.0.

#include <stdarg.h>

static double twice(double x) { return x * 2; }
static double half(double x) { return x / 2; }
static double (*getfp(void))(double) { return twice; }
typedef double (*unary_t)(double);
static unary_t getfp_t(void) { return twice; }
static double (*(*getgetfp(void))(void))(double) { return getfp; }
static long vsum(int n, ...)
{
    va_list ap;
    va_start(ap, n);
    long s = 0;
    for (int i = 0; i < n; i++)
        s += va_arg(ap, int);
    va_end(ap);
    return s;
}
static long (*getvsum(void))(int, ...) { return vsum; }
static double kr_twice(x) double x; { return x * 2; }
static double (*getkr(void))() { return kr_twice; }

struct ops { double (*op)(double); double (*tab[2])(double); };
struct maker { double (*(*get)(void))(double); unary_t (*get_t)(void); };
static struct ops ops = { twice, { twice, half } };
static struct maker makers = { getfp, getfp_t };
static double (*table[2])(double) = { twice, half };
typedef double (*(*maker_t)(void))(double);
typedef unary_t (*maker2_t)(void);

static double use(double (*(*g)(void))(double)) { return g()(3); }
static double use_t(maker2_t g) { return g()(3); }

static int callee_forms(void)
{
    double (*f)(double) = twice;
    double (**pf)(double) = &f;
    struct ops *po = &ops;
    int k = 1, r = 0;
    if ((*f)(3) != 6.0) r |= 1;
    if ((*twice)(3) != 6.0) r |= 2;
    if ((k ? f : twice)(3) != 6.0) r |= 4;
    if ((0, f)(3) != 6.0) r |= 8;
    if (getfp()(3) != 6.0) r |= 16;
    if (table[1](3) != 1.5) r |= 32;
    if ((*table[0])(3) != 6.0) r |= 64;
    if (ops.op(3) != 6.0) r |= 128;
    if (po->tab[1](3) != 1.5) r |= 256;
    if ((*pf)(3) != 6.0) r |= 512;
    if (pf[0](3) != 6.0) r |= 1024;
    if ((**twice)(3) != 6.0) r |= 2048;
    if ((&twice)(3) != 6.0) r |= 4096;
    if ((k ? table[0] : table[1])(3) != 6.0) r |= 8192;
    if ((f = half)(3) != 1.5) r |= 16384;
    return r;
}

static int result_types(void)
{
    int r = 0;
    double (*(*lp)(void))(double) = getfp;
    void *vp = (void *)getfp;
    if (getfp_t()(3) != 6.0) r |= 1;
    if (getgetfp()()(3) != 6.0) r |= 2;
    if (lp()(3) != 6.0) r |= 4;
    if (makers.get()(3) != 6.0) r |= 8;
    if (makers.get_t()(3) != 6.0) r |= 16;
    maker_t mk = getfp;
    if (mk()(3) != 6.0) r |= 32;
    maker2_t mk2 = getfp_t;
    if (mk2()(3) != 6.0) r |= 64;
    if (use(getfp) != 6.0) r |= 128;
    if (use_t(getfp_t) != 6.0) r |= 256;
    {
        typedef double (*(*bmaker_t)(void))(double);
        bmaker_t b = getfp;
        if (b()(3) != 6.0) r |= 512;
    }
    __typeof__(getfp) *tg = getfp;
    if (tg()(3) != 6.0) r |= 1024;
    __typeof__(mk) mk3 = mk;
    if (mk3()(3) != 6.0) r |= 2048;
    if (getvsum()(3, 1, 2, 3) != 6) r |= 4096;
    if (getkr()(1.5f) != 3.0) r |= 8192;
    if (((double (*(*)(void))(double))vp)()(3) != 6.0) r |= 16384;
    if (((maker_t)vp)()(3) != 6.0) r |= 32768;
    __typeof__((maker_t)vp) mk4 = getfp;
    if (mk4()(3) != 6.0) r |= 65536;
    __typeof__(makers.get) mk5 = getfp;
    if (mk5()(3) != 6.0) r |= 131072;
    return r;
}

int main(void)
{
    if (callee_forms() != 0) return 1;
    if (result_types() != 0) return 2;
    return 0;
}

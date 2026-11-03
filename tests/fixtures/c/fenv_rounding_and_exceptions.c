// C99 7.6 and Annex F: each operation rounds in the current direction and
// raises the exceptions IEC 60559 defines, for binary64 and binary32,
// conversions, sqrt, fma and the functions that round in the current
// direction; the environment functions save and restore it. A value prints
// as its bits, the raised exceptions as letters.

#include <fenv.h>
#include <float.h>
#include <math.h>
#include <stdio.h>
#include <string.h>

static void flags(void) {
    int f = fetestexcept(FE_ALL_EXCEPT);
    printf(" %s%s%s%s%s%s\n", f & FE_INVALID ? "v" : "", f & FE_DIVBYZERO ? "z" : "",
           f & FE_OVERFLOW ? "o" : "", f & FE_UNDERFLOW ? "u" : "", f & FE_INEXACT ? "x" : "",
           f ? "" : "-");
    feclearexcept(FE_ALL_EXCEPT);
}

static void d(const char *name, double v) {
    unsigned long long b;
    memcpy(&b, &v, sizeof b);
    printf("%s %016llx", name, b);
    flags();
}

static void f(const char *name, float v) {
    unsigned int b;
    memcpy(&b, &v, sizeof b);
    printf("%s %08x", name, b);
    flags();
}

static void i(const char *name, long long v) {
    printf("%s %lld", name, v);
    flags();
}

static volatile double one = 1.0, three = 3.0, dmax = DBL_MAX, dmin = DBL_MIN, zero = 0.0;
static volatile double tiny = 0x1p-1074, half = 2.5, m_half = -2.5, sub = 0x1.8p-1070;
static volatile double near1 = 0x1.0000000000001p-537, tenth = 0.1, x375 = 3.75;
static volatile double up = 0x1.0000000000001p-511, dn = 0x1.ffffffffffffep-512;
static volatile float fone = 1.0f, fthree = 3.0f, flt_max = FLT_MAX, flt_min = FLT_MIN;
static volatile float fup = 0x1.000002p-63f, fdn = 0x1.fffffcp-64f, fhalf = 2.5f;
static volatile long long big = (1LL << 53) + 1;
static volatile unsigned long long ubig = 0x8000000000000801ULL;
static volatile int i24 = 16777217;

int main(void) {
    static const int modes[] = {FE_TONEAREST, FE_UPWARD, FE_DOWNWARD, FE_TOWARDZERO};
    static const char *names[] = {"nearest", "upward", "downward", "towardzero"};
    feclearexcept(FE_ALL_EXCEPT);
    for (int m = 0; m < 4; m++) {
        int failed = fesetround(modes[m]);
        printf("%s %d %d\n", names[m], failed, fegetround() == modes[m]);
        d("div", one / three);
        d("div-", -one / three);
        d("add", one + 0x1p-60);
        d("sum0", one - one);
        d("sum-0", zero + -zero);
        d("ovf", dmax * 2);
        d("ovf-", -dmax * 2);
        d("max+", dmax + dmax * 0x1p-54);
        d("tiny/2", tiny * 0.5);
        d("-tiny/2", -tiny * 0.5);
        d("subprod", near1 * near1 * 0x1p-1000);
        d("subquot", dmin / three);
        d("subdiff", sub - 0x1p-1074);
        d("sqrt", sqrt(three));
        d("fma", fma(one / 3, three, -one));
        d("fmasub", fma(sub, 0x1p-3, tiny));
        f("fdiv", fone / fthree);
        f("fovf", flt_max * fthree);
        f("fsub", flt_min / fthree);
        f("fsqrt", sqrtf(fthree));
        f("ffma", fmaf(fone / fthree, fthree, -fone));
        f("i2f", (float)i24);
        d("ll2d", (double)big);
        f("ll2f", (float)big);
        d("ull2d", (double)ubig);
        f("d2f", (float)tenth);
        f("d2fovf", (float)dmax);
        f("d2fsub", (float)dmin);
        d("ld", (double)(long double)tenth);
        d("ld+", (double)((long double)tenth + (long double)one));
        i("d2i", (long long)half);
        i("d2u", (long long)(unsigned)x375);
        d("rint", rint(half));
        d("rint-", rint(m_half));
        d("nearbyint", nearbyint(m_half));
        f("rintf", rintf(fhalf));
        i("lrint", lrint(m_half));
        i("llrint", llrint(half));
        i("lrintf", lrintf(fhalf));
        printf("printf %.1f %.0f %.1f %.3e %.4g %.2a %.20f\n", 0.25, 2.5, -0.25, one / three,
               -one / three, one / three, one / three);
        feclearexcept(FE_ALL_EXCEPT);
    }
    fesetround(FE_TONEAREST);
    d("tiny-after", up * dn);
    d("to-min", dmin * 0x1.fffffffffffffp-1);
    f("ftiny-after", fup * fdn);
    {
        fenv_t env;
        fexcept_t saved;
        fesetround(FE_UPWARD);
        feraiseexcept(FE_INEXACT);
        printf("fegetenv %d", fegetenv(&env));
        flags();
        fesetround(FE_TONEAREST);
        printf("fesetenv %d %d", fesetenv(&env), fegetround() == FE_UPWARD);
        flags();
        feraiseexcept(FE_DIVBYZERO);
        printf("feholdexcept %d %d", feholdexcept(&env), fegetround() == FE_UPWARD);
        flags();
        feraiseexcept(FE_INVALID);
        printf("feupdateenv %d", feupdateenv(&env));
        flags();
        feraiseexcept(FE_DIVBYZERO | FE_INVALID);
        printf("fegetexceptflag %d", fegetexceptflag(&saved, FE_DIVBYZERO));
        flags();
        printf("fesetexceptflag %d", fesetexceptflag(&saved, FE_ALL_EXCEPT));
        flags();
        feraiseexcept(FE_INEXACT);
        printf("fesetenv-dfl %d %d", fesetenv(FE_DFL_ENV), fegetround() == FE_TONEAREST);
        flags();
        printf("fesetround-bad %d %d", fesetround(-1) != 0, fegetround() == FE_TONEAREST);
        flags();
    }
    {
        static const int each[] = {FE_INVALID, FE_DIVBYZERO, FE_OVERFLOW, FE_UNDERFLOW, FE_INEXACT};
        for (int k = 0; k < 5; k++) {
            feraiseexcept(each[k]);
            printf("raise%d", k);
            flags();
        }
    }
    {
        unsigned long long sbits = 0x7ff0000000000001ULL;
        volatile double snan;
        memcpy((void *)&snan, &sbits, sizeof sbits);
        volatile double r = snan + one;
        (void)r;
        printf("snan+1");
        flags();
        volatile int eq = snan == snan;
        printf("snan== %d", eq);
        flags();
        volatile double q = zero / zero;
        volatile int lt = q < one, ne = q != q;
        printf("qnan %d %d", lt, ne);
        flags();
        volatile double inf = one / zero;
        d("1/0", inf);
        volatile double nan_ = inf - inf;
        (void)nan_;
        printf("inf-inf");
        flags();
        volatile double s = sqrt(-one);
        (void)s;
        printf("sqrt-1");
        flags();
        volatile long long c = (long long)(dmax * 0.5);
        (void)c;
        printf("d2ll-ovf");
        flags();
    }
    return 0;
}

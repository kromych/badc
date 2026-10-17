// The calling convention is part of a function type, so every form that
// derives a type from one carries it: typeof of an object, a function or
// its address, __auto_type, an old-style parameter declaration, va_arg, a
// cast, _Generic, a conditional, a comma, a statement expression, a call's
// result, a member and an element. Each call reaches a callee on the
// convention the derived type names.
// snapshot-budget: exempt
#include <stdarg.h>
typedef long long ll;
#define MSF __attribute__((ms_abi))
#define SVF __attribute__((sysv_abi))
#define NOINLINE __attribute__((noinline))

MSF NOINLINE ll msf(ll a, ll b) { return a * 5 + b; }
SVF NOINLINE ll svf(ll a, ll b) { return a * 3 - b; }

typedef ll (MSF *msfn)(ll, ll);
typedef ll (SVF *svfn)(ll, ll);
msfn gm = msf;
svfn gs = svf;
msfn gm2 = msf;
svfn tab[2] = {svf, svf};
struct holder {
    msfn m;
    svfn s;
} hold = {msf, svf};
NOINLINE svfn get_svf(void) { return gs; }

NOINLINE ll via_typeof(ll a, ll b) {
    __typeof__(gm) t1 = gm;
    __typeof__(gs) t2 = gs;
    __typeof__(svf) *t3 = svf;
    __typeof__(&msf) t4 = msf;
    return t1(a, b) * 1000000 + t2(a, b) * 10000 + t3(a, b) * 100 + t4(a, b);
}
NOINLINE ll via_auto(ll a, ll b) {
    __auto_type t1 = gm;
    __auto_type t2 = gs;
    return t1(a, b) * 100 + t2(a, b);
}
ll via_old_style(f, g, a, b) msfn f; ll (SVF *g)(ll, ll); ll a, b; { return f(a, b) * 100 + g(a, b); }
NOINLINE ll via_va_arg(int n, ...) {
    va_list ap;
    va_start(ap, n);
    msfn f = va_arg(ap, msfn);
    ll r = f(4, 3) * 100 + va_arg(ap, svfn)(4, 3);
    va_end(ap);
    return r + n - 2;
}
NOINLINE ll via_cast(ll a, ll b) {
    void *vp = (void *)gs;
    return ((svfn)vp)(a, b) * 100 + ((msfn)(void *)gm)(a, b);
}
NOINLINE ll via_expression_forms(ll a, ll b, int c) {
    ll r = (c ? gm : gm2)(a, b);
    r = r * 100 + (0, gs)(a, b);
    r = r * 100 + ({ gm; })(a, b);
    r = r * 100 + get_svf()(a, b);
    r = r * 100 + _Generic(a, default: gm)(a, b);
    r = r * 100 + __builtin_choose_expr(1, gs, 0)(a, b);
    return r;
}
NOINLINE ll via_objects(ll a, ll b, int i) {
    return tab[i](a, b) * 10000 + hold.m(a, b) * 100 + hold.s(a, b) + (*gm)(a, b) - 23;
}

int main(void) {
    if (via_typeof(4, 3) != 23090923) return 1;
    if (via_auto(4, 3) != 2309) return 2;
    if (via_old_style(msf, svf, 4, 3) != 2309) return 3;
    if (via_va_arg(2, gm, gs) != 2309) return 4;
    if (via_cast(4, 3) != 923) return 5;
    if (via_expression_forms(4, 3, 1) != 230923092309LL) return 6;
    if (via_objects(4, 3, 1) != 92309) return 7;
    return 0;
}

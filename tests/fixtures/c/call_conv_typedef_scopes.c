// Typedef chains and block-scope shadowing of names whose types name a
// calling convention: each binding's own convention holds in its scope
// (C99 6.2.1p4) and the outer one's again after it ends.
// snapshot-budget: exempt
typedef long long ll;
#define MSF __attribute__((ms_abi))
#define SVF __attribute__((sysv_abi))
#define NOINLINE __attribute__((noinline))

MSF NOINLINE ll msf(ll a, ll b) { return a * 5 + b; }
SVF NOINLINE ll svf(ll a, ll b) { return a * 3 - b; }
NOINLINE ll plainf(ll a, ll b) { return a * 2 + b; }

typedef ll (MSF *T)(ll, ll);
typedef T T2;
typedef T2 T3;
T gm = msf;
ll (SVF *gsv)(ll, ll) = svf;
ll (*gp)(ll, ll) = plainf;

NOINLINE int depths(ll a, ll b) {
    T x = msf;
    if (x(a, b) != 23) return 1;
    {
        typedef ll (SVF *T)(ll, ll);
        T y = svf;
        if (y(a, b) != 9) return 2;
        {
            typedef ll (*T)(ll, ll);
            T z = plainf;
            if (z(a, b) != 11) return 3;
            {
                typedef T3 T;
                T w = msf;
                if (w(a, b) != 23) return 4;
            }
            T z2 = plainf;
            if (z2(a, b) != 11) return 5;
        }
        T y2 = svf;
        if (y2(a, b) != 9) return 6;
    }
    T x2 = msf;
    T3 x3 = msf;
    return x2(a, b) + x3(a, b) != 46 ? 7 : 0;
}

NOINLINE ll shadow_global(ll a, ll b) {
    ll (SVF *gm)(ll, ll) = svf;
    ll (MSF *gsv)(ll, ll) = msf;
    ll (*gp)(ll, ll) = plainf;
    return gm(a, b) * 10000 + gsv(a, b) * 100 + gp(a, b);
}
NOINLINE ll after_shadow(ll a, ll b) { return gm(a, b) * 10000 + gsv(a, b) * 100 + gp(a, b); }
NOINLINE ll param_shadow(ll (SVF *gm)(ll, ll), ll a, ll b) { return gm(a, b); }

NOINLINE ll extern_past_local(ll a, ll b) {
    ll r = 0;
    ll (SVF *gm)(ll, ll) = svf;
    r += gm(a, b);
    {
        extern T gm;
        r += 100 * gm(a, b);
        {
            ll (*gm)(ll, ll) = plainf;
            r += 10000 * gm(a, b);
        }
        r += 1000000 * gm(a, b);
    }
    return r + 100000000 * gm(a, b);
}

NOINLINE ll typedef_over_object(ll a, ll b) {
    ll r;
    {
        typedef int gm;
        gm k = 2;
        r = k;
    }
    return r * 100 + gm(a, b);
}

NOINLINE ll typedef_rebind(ll a, ll b) {
    typedef ll (MSF *F)(ll, ll);
    ll r = 0;
    for (int i = 0; i < 2; i++) {
        typedef ll (*F)(ll, ll);
        F p = plainf;
        r += p(a, b);
    }
    F q = msf;
    return r * 100 + q(a, b);
}

NOINLINE ll list_mix(ll a, ll b) {
    T p = msf, *pp = &p;
    ll (*q)(ll, ll) = plainf, (SVF *s)(ll, ll) = svf;
    return (*pp)(a, b) * 10000 + q(a, b) * 100 + s(a, b);
}

int main(void) {
    int r = depths(4, 3);
    if (r) return r;
    if (shadow_global(4, 3) != 92311) return 10;
    if (after_shadow(4, 3) != 230911) return 11;
    if (param_shadow(svf, 4, 3) != 9) return 12;
    if (extern_past_local(4, 3) != 923112309) return 13;
    if (typedef_over_object(4, 3) != 223) return 14;
    if (typedef_rebind(4, 3) != 2223) return 15;
    if (list_mix(4, 3) != 231109) return 16;
    return 0;
}

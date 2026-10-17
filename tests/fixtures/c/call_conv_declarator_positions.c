// A calling-convention attribute in each position of a declaration or a
// type name (GNU attribute syntax): among the declaration specifiers it
// names the function type every declarator leads to, after a declarator
// that declarator's, inside a parenthesized declarator or after its `*`
// the function type the signature after the group spells. Each call goes
// through a pointer whose type names its callee's convention.
// snapshot-budget: exempt
typedef long long ll;
#define MSF __attribute__((ms_abi))
#define SVF __attribute__((sysv_abi))
#define NOINLINE __attribute__((noinline))

MSF NOINLINE ll msf(ll a, ll b) { return a * 5 + b; }
SVF NOINLINE ll svf(ll a, ll b) { return a * 3 - b; }
NOINLINE ll plainf(ll a, ll b) { return a * 2 + b; }
MSF NOINLINE ll msf6(ll a, ll b, ll c, ll d, ll e, ll f) { return a + 2 * b + 3 * c + 4 * d + 5 * e + 6 * f; }
SVF NOINLINE ll svf6(ll a, ll b, ll c, ll d, ll e, ll f) { return a - 2 * b + 3 * c - 4 * d + 5 * e - 6 * f; }
MSF NOINLINE double msd(int a, double b, int c, double d) { return a + b * 10 + c * 100 + d * 1000; }
SVF NOINLINE double svd(int a, double b, int c, double d) { return a - b * 10 + c * 100 - d * 1000; }

typedef ll (MSF *msfn)(ll, ll);
typedef ll (SVF *svfn)(ll, ll);
typedef MSF ll msft(ll, ll);
typedef ll svft(ll, ll) SVF;
typedef ll (*msfn_trailing)(ll, ll) MSF;
msfn gm = msf;
svfn gs = svf;
void *volatile gv;

NOINLINE int positions(ll a, ll b) {
    MSF ll (*p1)(ll, ll) = msf;
    if (p1(a, b) != 23) return 1;
    ll MSF (*p2)(ll, ll) = msf;
    if (p2(a, b) != 23) return 2;
    ll (*p3)(ll, ll) MSF = msf;
    if (p3(a, b) != 23) return 3;
    ll (MSF *p4)(ll, ll) = msf;
    if (p4(a, b) != 23) return 4;
    ll (*MSF p5)(ll, ll) = msf;
    if (p5(a, b) != 23) return 5;
    msft *p6 = msf;
    if (p6(a, b) != 23) return 6;
    svft *p7 = svf;
    if (p7(a, b) != 9) return 7;
    static ll (MSF *p8)(ll, ll) = msf;
    if (p8(a, b) != 23) return 8;
    msfn_trailing p9 = msf;
    if (p9(a, b) != 23) return 9;
    SVF ll (*q1)(ll, ll) = svf, (*q2)(ll, ll) = svf;
    if (q1(a, b) + 100 * q2(a, b) != 909) return 10;
    ll (SVF *r1)(ll, ll) = svf, (*r2)(ll, ll) = plainf;
    if (r1(a, b) * 100 + r2(a, b) != 911) return 11;
    ll (*s1)(ll, ll) SVF = svf, (*s2)(ll, ll) = plainf;
    if (s1(a, b) * 100 + s2(a, b) != 911) return 12;
    ll (*s3)(ll, ll) = plainf, (SVF *s4)(ll, ll) = svf;
    if (s3(a, b) * 100 + s4(a, b) != 1109) return 13;
    ll (MSF *arr[2])(ll, ll) = {msf, msf};
    if (arr[1](a, b) != 23) return 14;
    struct {
        ll (MSF *f)(ll, ll);
        svfn g;
    } st = {msf, svf};
    if (st.f(a, b) * 100 + st.g(a, b) != 2309) return 15;
    ll (MSF **pp)(ll, ll) = &p4;
    if ((*pp)(a, b) != 23) return 16;
    if (((msfn){msf})(a, b) != 23) return 17;
    ll (MSF *m6)(ll, ll, ll, ll, ll, ll) = msf6;
    if (m6(1, 2, 3, 4, 5, 6) != 91) return 18;
    ll (SVF *s6)(ll, ll, ll, ll, ll, ll) = svf6;
    if (s6(1, 2, 3, 4, 5, 6) != -21) return 19;
    double (MSF *md)(int, double, int, double) = msd;
    if (md(1, 2.5, 3, 4.5) != 1 + 25 + 300 + 4500) return 20;
    double (SVF *sd)(int, double, int, double) = svd;
    if (sd(1, 2.5, 3, 4.5) != 1 - 25 + 300 - 4500) return 21;
    for (ll (MSF *f1)(ll, ll) = msf, i = 0; i < 1; i++)
        if (f1(a, b) != 23) return 22;
    if (({ ll (SVF *se)(ll, ll) = svf; se(a, b); }) != 9) return 23;
    [[gnu::ms_abi]] ll (*c23)(ll, ll) = msf;
    if (c23(a, b) != 23) return 24;
    return 0;
}

// Casts to a type name naming a convention in its specifiers or in its
// abstract declarator.
NOINLINE int casts(ll a, ll b) {
    gv = (void *)msf;
    if (((ll (MSF *)(ll, ll))gv)(a, b) != 23) return 31;
    if (((MSF ll (*)(ll, ll))gv)(a, b) != 23) return 32;
    if (((msfn)gv)(a, b) != 23) return 33;
    gv = (void *)svf;
    if (((ll (*SVF)(ll, ll))gv)(a, b) != 9) return 34;
    if (((svft *)gv)(a, b) != 9) return 35;
    return 0;
}

int main(void) {
    int r = positions(4, 3);
    return r ? r : casts(4, 3);
}

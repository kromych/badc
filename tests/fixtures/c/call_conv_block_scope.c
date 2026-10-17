// Calls through block-scope declarations whose type names a calling
// convention: pointers through a typedef or with the attribute in the
// declarator, a static, a later declarator of a list, a typedef shadowing
// one with a convention, and prototypes of external functions with the
// attribute leading, trailing, through a function typedef, after an asm
// label and over several declarators. The callee reads its arguments where
// its own convention puts them.
// snapshot-budget: exempt
typedef long long ll;
#define MSF __attribute__((ms_abi))
#define SVF __attribute__((sysv_abi))
#define NOINLINE __attribute__((noinline))

MSF NOINLINE ll msf(ll a, ll b) { return a * 5 + b; }
SVF NOINLINE ll svf(ll a, ll b) { return a * 3 - b; }
NOINLINE ll plainf(ll a, ll b) { return a * 2 + b; }

typedef ll (MSF *msfn)(ll, ll);
typedef ll (SVF *svfn)(ll, ll);
typedef MSF ll msft(ll, ll);
typedef SVF ll svft(ll, ll);
msfn volatile gm = msf;
svfn volatile gs = svf;
ll (*volatile gp)(ll, ll) = plainf;

// ms_ext(a, b) = 7a + b on the Microsoft x64 convention, sv_ext(a, b) =
// 7a - b on System V's, and ms5 / sv5(a..e) = a + 2b + 3c + 4d + 5e, the
// fifth on the stack past ms5's shadow space; no file-scope declaration
// names them.
#if defined(__x86_64__)
__asm__(".text\n"
        ".globl ms_ext\nms_ext:\n\tleaq (%rdx,%rcx,8), %rax\n\tsubq %rcx, %rax\n\tret\n"
        ".globl sv_ext\nsv_ext:\n\tleaq (,%rdi,8), %rax\n\tsubq %rdi, %rax\n\tsubq %rsi, %rax\n\tret\n"
        ".globl ms5\nms5:\n\tmovq %rcx, %rax\n\tleaq (%rax,%rdx,2), %rax\n\tleaq (%r8,%r8,2), %r10\n"
        "\taddq %r10, %rax\n\tleaq (%rax,%r9,4), %rax\n\tmovq 40(%rsp), %r10\n\tleaq (%r10,%r10,4), %r10\n"
        "\taddq %r10, %rax\n\tret\n"
        ".globl sv5\nsv5:\n\tmovq %rdi, %rax\n\tleaq (%rax,%rsi,2), %rax\n\tleaq (%rdx,%rdx,2), %r10\n"
        "\taddq %r10, %rax\n\tleaq (%rax,%rcx,4), %rax\n\tleaq (%r8,%r8,4), %r10\n\taddq %r10, %rax\n\tret\n");
#else
ll ms_ext(ll a, ll b) { return a * 7 + b; }
ll sv_ext(ll a, ll b) { return a * 7 - b; }
ll ms5(ll a, ll b, ll c, ll d, ll e) { return a + 2 * b + 3 * c + 4 * d + 5 * e; }
ll sv5(ll a, ll b, ll c, ll d, ll e) { return a + 2 * b + 3 * c + 4 * d + 5 * e; }
#endif

NOINLINE ll via_typedef(ll a, ll b) {
    msfn m = gm;
    svfn s = gs;
    return m(a, b) * 100 + s(a, b);
}
NOINLINE ll via_declarator(ll a, ll b) {
    ll (MSF *m)(ll, ll) = gm;
    ll (SVF *s)(ll, ll) = gs;
    return m(a, b) * 100 + s(a, b);
}
NOINLINE ll via_static(ll a, ll b) {
    static msfn m;
    m = gm;
    return m(a, b);
}
NOINLINE ll via_list(ll a, ll b) {
    svfn x = 0, s = gs;
    (void)x;
    return s(a, b);
}
NOINLINE ll after_declarator(ll a, ll b) {
    ll (MSF *m)(ll, ll) = gm;
    typedef ll (*plain)(ll, ll);
    plain p = gp;
    ll (*q)(ll, ll) = gp;
    return m(a, b) * 10000 + p(a, b) * 100 + q(a, b);
}
NOINLINE ll shadowed(ll a, ll b) {
    ll r;
    {
        typedef ll (*msfn)(ll, ll);
        msfn p = gp;
        svfn gm = gs;
        r = p(a, b) * 100 + gm(a, b);
    }
    msfn m = gm;
    return m(a, b) * 10000 + r;
}
NOINLINE ll leading_and_trailing(ll a, ll b) {
    MSF ll ms_ext(ll, ll);
    ll sv_ext(ll, ll) SVF;
    return ms_ext(a, b) * 100 + sv_ext(a, b);
}
NOINLINE ll with_extern(void) {
    extern MSF ll ms5(ll, ll, ll, ll, ll);
    extern ll sv5(ll, ll, ll, ll, ll) SVF;
    return ms5(1, 2, 3, 4, 5) * 100 + sv5(1, 2, 3, 4, 5);
}
NOINLINE ll through_function_typedef(ll a, ll b) {
    msft ms_ext;
    svft sv_ext;
    return ms_ext(a, b) * 100 + sv_ext(a, b);
}
NOINLINE ll after_asm_label(ll a, ll b) {
    SVF ll other_sv(ll, ll) __asm__("sv_ext");
    ll other_ms(ll, ll) __asm__("ms_ext") MSF;
    return other_ms(a, b) * 100 + other_sv(a, b);
}
NOINLINE ll over_a_list(ll a, ll b) {
    ll (MSF *p)(ll, ll) = gm, sv_ext(ll, ll) SVF;
    return p(a, b) * 100 + sv_ext(a, b);
}

int main(void) {
    if (via_typedef(4, 3) != 2309) return 1;
    if (via_declarator(4, 3) != 2309) return 2;
    if (via_static(4, 3) != 23) return 3;
    if (via_list(4, 3) != 9) return 4;
    if (after_declarator(4, 3) != 231111) return 5;
    if (shadowed(4, 3) != 231109) return 6;
    if (leading_and_trailing(4, 3) != 3125) return 7;
    if (with_extern() != 5555) return 8;
    if (through_function_typedef(4, 3) != 3125) return 9;
    if (after_asm_label(4, 3) != 3125) return 10;
    if (over_a_list(4, 3) != 2325) return 11;
    return 0;
}

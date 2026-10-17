// A typedef of a pointer to a function on a named calling convention
// carries the convention to the function it points to, not to a function or
// pointer declared with it as its result type: the getters here are on the
// target's own convention, the calls through what they return on the named
// one. Declared at file and block scope, through the typedef and with the
// attribute in a nested declarator.
// snapshot-budget: exempt
typedef long long ll;
#define MSF __attribute__((ms_abi))
#define SVF __attribute__((sysv_abi))
#define NOINLINE __attribute__((noinline))

MSF NOINLINE ll msf(ll a, ll b) { return a * 5 + b; }
SVF NOINLINE ll svf(ll a, ll b) { return a * 3 - b; }

typedef ll (MSF *msfn)(ll, ll);
typedef ll (SVF *svfn)(ll, ll);

// get_ms(k) returns msf when k == 7 and get_sv(k) svf when k == 8, else a
// null pointer, reading k where the target's own convention passes it.
#if defined(__x86_64__)
#if defined(_WIN32)
#define ARG0 "%rcx"
#else
#define ARG0 "%rdi"
#endif
__asm__(".text\n.globl get_ms\nget_ms:\n\txorl %eax, %eax\n\tcmpq $7, " ARG0 "\n\tjne 1f\n"
        "\tleaq msf(%rip), %rax\n1:\n\tret\n"
        ".globl get_sv\nget_sv:\n\txorl %eax, %eax\n\tcmpq $8, " ARG0 "\n\tjne 1f\n"
        "\tleaq svf(%rip), %rax\n1:\n\tret\n");
#else
msfn get_ms(ll k) { return k == 7 ? msf : 0; }
svfn get_sv(ll k) { return k == 8 ? svf : 0; }
#endif

NOINLINE msfn lookup(ll k) { return k == 7 ? msf : 0; }
NOINLINE svfn lookup2(ll k) { return k == 8 ? svf : 0; }

NOINLINE ll block_prototypes(ll a, ll b) {
    msfn get_ms(ll);
    svfn get_sv(ll);
    msfn f = get_ms(7);
    return (f ? f(a, b) : -1) * 100 + (get_sv(8) ? get_sv(8)(a, b) : -1);
}
NOINLINE ll block_pointers(ll a, ll b) {
    msfn get_ms(ll);
    svfn get_sv(ll);
    msfn (*g1)(ll) = get_ms;
    svfn (*g2)(ll) = get_sv;
    msfn (*tab[1])(ll) = {get_ms};
    return g1(7)(a, b) * 10000 + g2(8)(a, b) * 100 + tab[0](7)(a, b) - 23;
}
NOINLINE ll nested_declarator(ll a, ll b) {
    ll (MSF *(*getter)(ll))(ll, ll) = lookup;
    ll (SVF *(*getter2)(ll))(ll, ll) = lookup2;
    return getter(7)(a, b) * 100 + getter2(8)(a, b);
}
msfn (*g_getter)(ll) = lookup;
msfn get_ms(ll);
NOINLINE ll file_scope(ll a, ll b) {
    return g_getter(7)(a, b) * 10000 + get_ms(7)(a, b) * 100 + lookup2(8)(a, b);
}
NOINLINE ll through_parameter(msfn (*g)(ll), ll a) { return g(7)(a, 3); }

int main(void) {
    if (block_prototypes(4, 3) != 2309) return 1;
    if (block_pointers(4, 3) != 230900) return 2;
    if (nested_declarator(4, 3) != 2309) return 3;
    if (file_scope(4, 3) != 232309) return 4;
    if (through_parameter(get_ms, 4) != 23) return 5;
    return 0;
}

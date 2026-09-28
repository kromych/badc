// A naked function reads its arguments where the convention left them, so
// the object a pointer argument names must hold what the caller stored before
// the call, though no instruction of the callee's body names the parameter.
// gcc takes the C definition: at -O0 it stores the register parameters of a
// naked function into its caller's frame.
typedef long long ll;
struct pair { ll a, b; };

#if (defined(__clang__) || !defined(__GNUC__)) && !defined(_MSC_VER) \
    && (defined(__aarch64__) || defined(__x86_64__))
#if defined(__aarch64__)
__attribute__((naked, noinline)) static ll second(const struct pair *p) {
    __asm__("ldr x0, [x0, #8]\n\tret");
}
#elif defined(_WIN32)
__attribute__((naked, noinline)) static ll second(const struct pair *p) {
    __asm__("movq 8(%rcx), %rax\n\tret");
}
#else
__attribute__((naked, noinline)) static ll second(const struct pair *p) {
    __asm__("movq 8(%rdi), %rax\n\tret");
}
#endif
#else
static ll second(const struct pair *p) { return p->b; }
#endif

static volatile ll src_a = 0x1111, src_b = 0x2222;

int main(void) {
    struct pair p;
    p.a = src_a;
    p.b = src_b;
    if (second(&p) != 0x2222) return 1;
    struct pair q[2];
    q[1].a = src_b * 5;
    q[1].b = src_a * 3;
    if (second(&q[1]) != 0x3333) return 2;
    return 0;
}

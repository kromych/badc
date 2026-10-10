// A Microsoft x64 function calls a System V function pointer that is also
// an argument; the System V marshal loads the 16-byte struct into rdi:rsi
// (AMD64 psABI 3.2.3), which the caller owes its own caller (main).
#define NOINLINE __attribute__((noinline))
typedef unsigned long long u64;
typedef void (*GP)(void);
struct s2 { u64 a, b; };
typedef u64 (__attribute__((sysv_abi)) *SF)(struct s2, GP);

static GP seen;
static volatile u64 g[4] = {1, 2, 3, 4};

NOINLINE __attribute__((sysv_abi)) u64 callee(struct s2 s, GP p) {
    seen = p;
    return s.a * 3 + s.b;
}

NOINLINE u64 caller(SF f, u64 c) { return f((struct s2){c, 7}, (GP)f); }

int main(void) {
    u64 x = g[0], y = g[1], z = g[2], w = g[3];
    u64 r = caller(callee, x);
    return (r == 10 && x + y * 10 + z * 100 + w * 1000 == 4321 && seen == (GP)callee) ? 0 : 1;
}

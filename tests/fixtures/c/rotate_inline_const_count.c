// A static rotate helper called with constant counts: after inlining
// the counts are immediates behind a callee-narrows extend, so the
// constant folder plus the rotate pass must produce the
// immediate-form rotate (rorq $n / ror #n, pinned by the asm
// snapshots) rather than the register-count sequence. Exit 0 when
// the mixed value matches the reference.

typedef unsigned long long u64;

static u64 R(u64 x, int c) { return (x >> c) | (x << (64 - c)); }
static u64 mix(u64 x) { return R(x, 28) ^ R(x, 34) ^ R(x, 39); }

int main(void) {
    volatile u64 seed = 0x0123456789abcdefULL;
    if (mix(seed) != 0xb7c57a100c7ec1abULL) return 1;
    return 0;
}

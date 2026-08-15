// The sign query a widely used min()/max() macro set puts to
// `__builtin_constant_p`: whether an operand is statically
// non-negative. No operand here is ever an immediate -- the loop guard
// is what settles the sign of the counter, so the query is answered by
// the range that guard implies rather than by constant propagation.
//
// `__types_ok` mixes a signed operand with an unsigned one, which the
// macro set rejects unless one of them is known non-negative. Under
// `len > 0` it is, so the assert arm is unreachable; without the range
// fact `__is_nonneg` reads 0, the arm stays live, and `minmax_bug` is
// referenced.
//
// `minmax_bug` is declared and never defined, so linking is the
// assertion. gcc links this at -O1 and above and fails to at -O0.

extern void minmax_bug(void);

#define statically_true(x) (__builtin_constant_p(x) && (x))
#define is_signed_type(type) (((type)(-1)) < (type)1)
#define __is_nonneg(ux) statically_true((long long)(ux) >= 0)
#define __sign_use(ux) (is_signed_type(typeof(ux)) ? \
        (2 + __is_nonneg(ux)) : (1 + 2 * (sizeof(ux) < 4)))
#define __types_ok(ux, uy) (__sign_use(ux) & __sign_use(uy))
#define MIN(x, y) ({                            \
        __auto_type ux = (x);                   \
        __auto_type uy = (y);                   \
        if (!__types_ok(ux, uy)) minmax_bug();  \
        ux < uy ? ux : uy;                      \
    })

// Read through a volatile cell, so no pass forwards a constant into the
// loop guard.
static volatile int in_len;

static unsigned long drain(int len) {
    unsigned long chunks = 0;
    while (len > 0) {
        unsigned int n = MIN(len, 4096UL);
        chunks += n;
        len -= n;
    }
    return chunks;
}

int main(void) {
    in_len = 10000;
    if (drain(in_len) != 10000ul)
        return 1;
    in_len = 1;
    if (drain(in_len) != 1ul)
        return 2;
    in_len = 0;
    if (drain(in_len) != 0ul)
        return 3;
    return 0;
}

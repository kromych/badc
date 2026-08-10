// An implementation builtin that folds to an integer constant expression
// (C99 6.6p10) is equally a constant expression as an aggregate
// initializer element and as a scalar initializer. The aggregate-element
// value parser owns symbol relocations, not a builtin set, so it defers to
// the constant-expression evaluator; a name that evaluator cannot fold is
// still rejected as undeclared.
//
// Each builtin is asserted as a scalar initializer, as a struct-array
// element member value, through a designator, as a plain array element,
// and as an enum value, so a capability difference between those entry
// points fails instead of passing at one of them. Returns 0 on success.

struct off {
    int a;
    int b;
};
struct entry {
    int v;
    const char *n;
};

static const int s_ffs = __builtin_ffs(1 << 0);
static const int s_clz = __builtin_clz(1u << 3);
static const int s_ctz = __builtin_ctz(1u << 3);
static const int s_pop = __builtin_popcount(0xf);
static const int s_par = __builtin_parity(0x7);
static const int s_cp = __builtin_constant_p(3);
static const int s_off = __builtin_offsetof(struct off, b);

// Struct-array elements, positional and designated. The trailing `- 1` on
// the first pins that the whole operator chain folds, not just the call.
static const struct entry e_pos[] = {
    { __builtin_ffs(1 << 0) - 1, "a" },
    { __builtin_clz(1u << 3), "b" },
    { __builtin_ctz(1u << 3), "c" },
};
static const struct entry e_desig[] = {
    [0] = { .v = __builtin_popcount(0xf), .n = "d" },
    [1] = { .v = __builtin_parity(0x7), .n = "e" },
    [2] = { .v = __builtin_constant_p(3), .n = "f" },
};
// Plain array elements and the wide variants.
static const int a_vals[] = {
    __builtin_ffsll(1LL << 5),
    __builtin_clzll(1ULL << 3),
    __builtin_ctzll(1ULL << 3),
    __builtin_popcountll(0xfULL),
    __builtin_bswap16(0x0102),
    __builtin_offsetof(struct off, b),
};
enum {
    EV_FFS = __builtin_ffs(1 << 4),
    EV_POP = __builtin_popcount(0xff),
};

int main(void) {
    if (s_ffs != 1) return 1;
    if (s_clz != 28) return 2;
    if (s_ctz != 3) return 3;
    if (s_pop != 4) return 4;
    if (s_par != 1) return 5;
    if (s_cp != 1) return 6;
    if (s_off != (int)sizeof(int)) return 7;

    if (e_pos[0].v != 0 || e_pos[0].n[0] != 'a') return 8;
    if (e_pos[1].v != 28) return 9;
    if (e_pos[2].v != 3) return 10;

    if (e_desig[0].v != 4 || e_desig[0].n[0] != 'd') return 11;
    if (e_desig[1].v != 1) return 12;
    if (e_desig[2].v != 1) return 13;

    if (a_vals[0] != 6) return 14;
    if (a_vals[1] != 60) return 15;
    if (a_vals[2] != 3) return 16;
    if (a_vals[3] != 4) return 17;
    if (a_vals[4] != 0x0201) return 18;
    if (a_vals[5] != (int)sizeof(int)) return 19;

    if (EV_FFS != 5) return 20;
    if (EV_POP != 8) return 21;

    // Block scope, static storage: the same values through the same
    // element positions.
    {
        static const struct entry b_pos[] = {
            { __builtin_ffs(1 << 0) - 1, "a" },
            { __builtin_clz(1u << 3), "b" },
        };
        static const int b_vals[] = {
            __builtin_ctz(1u << 3),
            __builtin_popcount(0xf),
        };
        if (b_pos[0].v != 0 || b_pos[1].v != 28) return 22;
        if (b_vals[0] != 3 || b_vals[1] != 4) return 23;
    }
    return 0;
}

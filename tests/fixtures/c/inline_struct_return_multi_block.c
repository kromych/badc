/* A struct-returning helper whose body branches -- parameter-dependent
   build-time-assert guards ahead of the result -- inlines at every call
   site, and the returned fields reach the caller as the constants the
   site's argument implies. Three consumer shapes: fields read right
   after the call, a field read past an intervening call and branch (so
   the read sits in a block the writes only dominate), and a whole-struct
   copy into a local whose fields are then read. Field widths and
   signedness cover the load forms the promotion must reproduce: a signed
   and an unsigned 32-bit field, a narrow signed and unsigned field, and
   a 64-bit field. Asserted by return code. */

struct Reg {
    unsigned function;
    int reg;
    unsigned short idx;
    signed char lvl;
    unsigned char flag;
    long long mask;
};

static const struct Reg table[4] = {
    {1u, 3, 0, -2, 200, 0x1122334455667788LL},
    {7u, 1, 1, -1, 201, 0x00000000ffffffffLL},
    {0x80000001u, 0, 2, 0, 202, -1LL},
    {0xdu, 2, 3, 1, 203, 0LL},
};

static int guard_hit;
static void build_assert(void) { guard_hit = 1; }
#define BUILD_ASSERT(c)                                                        \
    do {                                                                       \
        if (c) build_assert();                                                 \
    } while (0)

static __attribute__((always_inline)) unsigned leaf_of(unsigned feature) {
    unsigned leaf = feature / 32u;
    BUILD_ASSERT(leaf == 9u);
    BUILD_ASSERT(leaf >= sizeof(table) / sizeof(table[0]));
    BUILD_ASSERT(table[leaf].function == 0u);
    return leaf;
}

static __attribute__((always_inline)) struct Reg reg_of(unsigned feature) {
    return table[leaf_of(feature)];
}

/* Not inlinable at the call sites below (it is the intervening call that
   pushes the later field read into another block). */
int reg_slot(const int *entries, unsigned function);
int reg_slot(const int *entries, unsigned function) {
    return function == 0u ? -1 : entries[function % 4u];
}

static __attribute__((always_inline)) long long
probe(const int *entries, unsigned feature) {
    const struct Reg r = reg_of(feature);
    int slot = reg_slot(entries, r.function);
    if (slot < 0) return -1;
    /* r.reg, r.idx, r.lvl, r.flag and r.mask are read here, after the
       call and the branch above. */
    return (long long)slot + r.reg + r.idx + r.lvl + r.flag + (r.mask & 0xffff);
}

static __attribute__((always_inline)) long long direct(unsigned feature) {
    struct Reg r = reg_of(feature);
    struct Reg c = r;
    return (long long)r.function + c.reg + c.idx + c.lvl + c.flag + (c.mask >> 48);
}

int main(void) {
    static const int entries[4] = {10, 20, 30, 40};
    long long acc = 0;

    /* feature 0 -> leaf 0: function 1, reg 3, idx 0, lvl -2, flag 200,
       mask low 16 bits 0x7788 = 30600; slot = entries[1] = 20. */
    if (probe(entries, 0u) != 20 + 3 + 0 - 2 + 200 + 30600) return 1;
    /* leaf 1: function 7, reg 1, idx 1, lvl -1, flag 201, mask low
       0xffff = 65535; slot = entries[3] = 40. */
    if (probe(entries, 32u) != 40 + 1 + 1 - 1 + 201 + 65535) return 2;
    /* leaf 3: function 0xd, reg 2, idx 3, lvl 1, flag 203, mask 0;
       slot = entries[1] = 20. */
    if (probe(entries, 96u) != 20 + 2 + 3 + 1 + 203 + 0) return 3;

    /* Whole-struct copy consumer: function 1, reg 3, idx 0, lvl -2,
       flag 200, mask >> 48 = 0x1122 = 4386. */
    acc = direct(0u);
    if (acc != 1 + 3 + 0 - 2 + 200 + 4386) return 4;
    /* leaf 2: function 0x80000001, reg 0, idx 2, lvl 0, flag 202,
       mask -1 >> 48 = -1. */
    acc = direct(64u);
    if (acc != (long long)0x80000001u + 0 + 2 + 0 + 202 - 1) return 5;

    /* A runtime-computed feature takes the same path with no constant
       to fold; the values must still be right. */
    {
        volatile unsigned f = 32u;
        if (probe(entries, f) != 40 + 1 + 1 - 1 + 201 + 65535) return 6;
    }
    return guard_hit ? 7 : 0;
}

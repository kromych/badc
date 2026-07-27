// C99 6.5.2.5 whole-element compound literal `(T){ ... }` written with a
// leading type qualifier. C99 6.7.7p1 makes a type-name a
// specifier-qualifier-list, so `(const T){ ... }` names the same type as
// `(T){ ... }` and is equally a whole-element initializer.
//
// Every element position is exercised at file scope, at block scope with
// static storage (C99 6.2.4p3), and at block scope with automatic storage,
// because those routed through separate initializer parsers and diverged:
// a qualified literal was accepted at file scope and rejected at block
// scope. Each shape is asserted at all three scopes so a future
// divergence fails instead of passing at one of them.
//
// C99 6.7.8p20 brace elision is the counter-case: a literal naming a
// DIFFERENT type initializes the element's first member and must not be
// taken as the whole element. Returns 0 on success.

typedef struct {
    unsigned reg;
} reg_t;

struct tagged {
    unsigned reg;
};

union pair {
    int i;
    unsigned u;
};

struct inner {
    int x;
    int y;
};
struct outer {
    struct inner in;
    int z;
};

// File scope: designated, positional, ranged, deferred-size, 2-D.
static const reg_t f_desig[2] = {
    [0] = (const reg_t){ .reg = 1 },
    [1] = (const reg_t){ .reg = 2 },
};
static const reg_t f_pos[2] = { (const reg_t){ 3 }, (const reg_t){ 4 } };
static const struct tagged f_tag[2] = { [1] = (const struct tagged){ .reg = 5 } };
static const union pair f_union[1] = { (const union pair){ .i = 6 } };
static const reg_t f_group[1] = { ((const reg_t){ .reg = 7 }) };
static const reg_t f_range[3] = { [0 ... 2] = (const reg_t){ .reg = 8 } };
static const reg_t f_deferred[] = {
    (const reg_t){ 9 }, (const reg_t){ 10 }, (const reg_t){ 11 },
};
static const reg_t f_2d[2][2] = {
    { (const reg_t){ 12 }, (const reg_t){ 13 } },
    { (const reg_t){ 14 }, (const reg_t){ 15 } },
};
static const reg_t f_2d_desig[2][2] = { [1][1] = (const reg_t){ 16 } };
static const reg_t f_trailing_qual[1] = { (reg_t const){ 17 } };
// Brace elision: `(struct inner)` names the first member's type, not the
// element's, so it fills `.in` and `18` fills `.z`.
static const struct outer f_elide[1] = { (const struct inner){ 1, 2 }, 18 };
static const struct outer f_member[1] = {
    { .in = (const struct inner){ 3, 4 }, .z = 19 },
};

// A struct whose flexible array member (C99 6.7.2.1p18, as extended by
// common practice) holds compound-literal elements.
struct look {
    const char *key;
    unsigned n;
};
struct table {
    const char *dev;
    struct look entries[];
};
static const struct table f_flex = {
    .dev = "d0",
    .entries = { (const struct look){ .key = "k", .n = 20 }, { } },
};

static int file_scope_values(void) {
    if (f_desig[0].reg != 1 || f_desig[1].reg != 2) return 1;
    if (f_pos[0].reg != 3 || f_pos[1].reg != 4) return 2;
    if (f_tag[1].reg != 5) return 3;
    if (f_union[0].i != 6) return 4;
    if (f_group[0].reg != 7) return 5;
    if (f_range[0].reg != 8 || f_range[2].reg != 8) return 6;
    if (f_deferred[0].reg != 9 || f_deferred[2].reg != 11) return 7;
    if (f_2d[0][0].reg != 12 || f_2d[1][1].reg != 15) return 8;
    if (f_2d_desig[1][1].reg != 16) return 9;
    if (f_trailing_qual[0].reg != 17) return 10;
    if (f_elide[0].in.x != 1 || f_elide[0].in.y != 2 || f_elide[0].z != 18) return 11;
    if (f_member[0].in.y != 4 || f_member[0].z != 19) return 12;
    if (f_flex.entries[0].n != 20 || f_flex.entries[0].key[0] != 'k') return 13;
    return 0;
}

// Block scope, static storage: the same shapes, same expected values.
static int block_static_values(void) {
    static const reg_t desig[2] = {
        [0] = (const reg_t){ .reg = 1 },
        [1] = (const reg_t){ .reg = 2 },
    };
    static const reg_t pos[2] = { (const reg_t){ 3 }, (const reg_t){ 4 } };
    static const struct tagged tag[2] = { [1] = (const struct tagged){ .reg = 5 } };
    static const union pair un[1] = { (const union pair){ .i = 6 } };
    static const reg_t group[1] = { ((const reg_t){ .reg = 7 }) };
    static const reg_t range[3] = { [0 ... 2] = (const reg_t){ .reg = 8 } };
    static const reg_t deferred[] = {
        (const reg_t){ 9 }, (const reg_t){ 10 }, (const reg_t){ 11 },
    };
    static const reg_t two_d[2][2] = {
        { (const reg_t){ 12 }, (const reg_t){ 13 } },
        { (const reg_t){ 14 }, (const reg_t){ 15 } },
    };
    static const reg_t two_d_desig[2][2] = { [1][1] = (const reg_t){ 16 } };
    static const reg_t trailing[1] = { (reg_t const){ 17 } };
    static const struct outer elide[1] = { (const struct inner){ 1, 2 }, 18 };
    static const struct outer member[1] = {
        { .in = (const struct inner){ 3, 4 }, .z = 19 },
    };

    if (desig[0].reg != 1 || desig[1].reg != 2) return 21;
    if (pos[0].reg != 3 || pos[1].reg != 4) return 22;
    if (tag[1].reg != 5) return 23;
    if (un[0].i != 6) return 24;
    if (group[0].reg != 7) return 25;
    if (range[0].reg != 8 || range[2].reg != 8) return 26;
    if (deferred[0].reg != 9 || deferred[2].reg != 11) return 27;
    if (two_d[0][0].reg != 12 || two_d[1][1].reg != 15) return 28;
    if (two_d_desig[1][1].reg != 16) return 29;
    if (trailing[0].reg != 17) return 30;
    if (elide[0].in.x != 1 || elide[0].in.y != 2 || elide[0].z != 18) return 31;
    if (member[0].in.y != 4 || member[0].z != 19) return 32;
    return 0;
}

// Block scope, automatic storage: the same shapes again.
static int block_auto_values(void) {
    const reg_t desig[2] = {
        [0] = (const reg_t){ .reg = 1 },
        [1] = (const reg_t){ .reg = 2 },
    };
    const reg_t pos[2] = { (const reg_t){ 3 }, (const reg_t){ 4 } };
    const struct tagged tag[2] = { [1] = (const struct tagged){ .reg = 5 } };
    const union pair un[1] = { (const union pair){ .i = 6 } };
    const reg_t group[1] = { ((const reg_t){ .reg = 7 }) };
    const reg_t range[3] = { [0 ... 2] = (const reg_t){ .reg = 8 } };
    const reg_t deferred[] = {
        (const reg_t){ 9 }, (const reg_t){ 10 }, (const reg_t){ 11 },
    };
    const reg_t two_d[2][2] = {
        { (const reg_t){ 12 }, (const reg_t){ 13 } },
        { (const reg_t){ 14 }, (const reg_t){ 15 } },
    };
    const reg_t trailing[1] = { (reg_t const){ 17 } };
    const struct outer elide[1] = { (const struct inner){ 1, 2 }, 18 };
    const struct outer member[1] = {
        { .in = (const struct inner){ 3, 4 }, .z = 19 },
    };

    if (desig[0].reg != 1 || desig[1].reg != 2) return 41;
    if (pos[0].reg != 3 || pos[1].reg != 4) return 42;
    if (tag[1].reg != 5) return 43;
    if (un[0].i != 6) return 44;
    if (group[0].reg != 7) return 45;
    if (range[0].reg != 8 || range[2].reg != 8) return 46;
    if (deferred[0].reg != 9 || deferred[2].reg != 11) return 47;
    if (two_d[0][0].reg != 12 || two_d[1][1].reg != 15) return 48;
    if (trailing[0].reg != 17) return 50;
    if (elide[0].in.x != 1 || elide[0].in.y != 2 || elide[0].z != 18) return 51;
    if (member[0].in.y != 4 || member[0].z != 19) return 52;
    return 0;
}

int main(void) {
    int rc = file_scope_values();
    if (rc) return rc;
    rc = block_static_values();
    if (rc) return rc;
    return block_auto_values();
}

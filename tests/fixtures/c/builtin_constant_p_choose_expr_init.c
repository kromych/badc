/* A static initializer element selected by `__builtin_choose_expr` on
 * `__builtin_constant_p`, the shape of the kernel's PIN_GROUP macro: an
 * integer operand takes the constant arm, an array operand the address
 * arm, whose value is a relocation, and a floating arm keeps its value.
 * gcc and clang accept the same source and exit 0. */

struct pin_group {
    const char *name;
    unsigned mode;
    const unsigned *modes;
    double scale;
};

#define PIN_GROUP(n, m, s)                                                   \
    {                                                                        \
        .name = (n),                                                         \
        .mode = __builtin_choose_expr(__builtin_constant_p((m)), (m), 0),    \
        .modes = __builtin_choose_expr(__builtin_constant_p((m)),            \
                                       ((void *)0), (m)),                    \
        .scale = __builtin_choose_expr(__builtin_constant_p((s)), (s), 1.0), \
    }

static const unsigned alt_modes[] = { 2, 3, 5 };

static const struct pin_group groups[] = {
    PIN_GROUP("fixed", 7, 2.5),
    PIN_GROUP("table", alt_modes, 0.5),
};

int main(void) {
    if (groups[0].mode != 7) return 1;
    if (groups[0].modes != (void *)0) return 2;
    if (groups[0].scale != 2.5) return 3;
    if (groups[1].mode != 0) return 4;
    if (groups[1].modes != alt_modes) return 5;
    if (groups[1].modes[2] != 5) return 6;
    if (groups[1].scale != 0.5) return 7;
    if (groups[1].name[0] != 't') return 8;

    /* The same selection in a block-scope initializer. */
    struct pin_group local = PIN_GROUP("local", alt_modes, 1.5);
    if (local.mode != 0) return 9;
    if (local.modes != alt_modes) return 10;
    if (local.scale != 1.5) return 11;
    struct pin_group fixed = PIN_GROUP("fixed", 9, 3.5);
    if (fixed.mode != 9) return 12;
    if (fixed.modes != (void *)0) return 13;
    if (fixed.scale != 3.5) return 14;
    return 0;
}

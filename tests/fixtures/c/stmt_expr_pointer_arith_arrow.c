// A GNU statement expression whose last operation is pointer arithmetic
// keeps the pointer result type, so `({ ...; p - 1; })->field` resolves
// through the single-level struct pointer (C99 6.5.6p8). The Linux
// `task_pt_regs` shape -- `({ ...; (struct regs *)x - 1; })->cs` -- needs
// this. Returns 0 on success.

struct regs {
    int cs;
    int ss;
};

int main(void) {
    struct regs r[2] = { { 11, 12 }, { 21, 22 } };
    struct regs *p = &r[1];

    // Last expression is `p - 1` (pointer minus int): the statement
    // expression's value type is `struct regs *`, so `->cs` reads r[0].
    int cs = ({ p - 1; })->cs;
    if (cs != 11) return 1;

    // Cast then subtraction, exactly the kernel macro shape.
    unsigned long long a = (unsigned long long)&r[1];
    int cs2 = ({ ((struct regs *)a) - 1; })->cs;
    if (cs2 != 11) return 2;

    // Subscript through the same statement-expression pointer.
    if (({ p - 1; })[1].ss != 22) return 3;

    // The `+` direction was already correct; guard it against regression.
    int ss = ({ (p - 1) + 1; })->ss;
    if (ss != 22) return 4;

    // A pointer difference in a statement expression is an integer, not a
    // pointer -- the same root as the pointer-plus-integer node type.
    int v[8];
    int *e = &v[5];
    int *b = &v[1];
    if (_Generic(({ e - b; }), int: 1, long: 1, long long: 1, default: 0) != 1)
        return 5;
    if (({ e - b; }) != 4) return 6;
    return 0;
}

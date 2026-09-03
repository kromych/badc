// C99 6.7.8p6: an array designator `[constant-expression]`, and the GNU
// `[lo ... hi]` range, select the element the following value initializes;
// 6.7.8p19 lets a later designator overwrite what an earlier one wrote.
// One parser reads the subscript for file scope, block scope, a block-scope
// static and a compound literal, so each form resolves the same way at
// every one of them. Returns 0, distinct non-zero per failure.

struct pair {
    int a, b;
};

struct holder {
    int v[4];
};

int g_scalar[6] = { [0 ... 3] = 7, [2] = 9 };
struct pair g_rows[2][3] = { [1][2].a = 5, [0][1] = { 3, 4 }, [1][2].b = 6 };
struct pair g_range[4] = { [0 ... 2] = { 1, 2 }, [1].b = 9 };
struct holder g_member = { .v[1 ... 2] = 3, .v[2] = 4 };

static int sum4(const int *p) {
    return p[0] + p[1] + p[2] + p[3];
}

static int scalar_forms(void) {
    int local[6] = { [0 ... 3] = 7, [2] = 9 };
    static int slocal[6] = { [0 ... 3] = 7, [2] = 9 };
    int *literal = (int[6]){ [0 ... 3] = 7, [2] = 9 };

    // The range fills [0, 3]; the later single designator replaces [2].
    if (g_scalar[0] + g_scalar[2] + g_scalar[3] + g_scalar[4] != 23) return 1;
    if (local[0] + local[2] + local[3] + local[4] != 23) return 2;
    if (slocal[0] + slocal[2] + slocal[3] + slocal[4] != 23) return 3;
    if (literal[0] + literal[2] + literal[3] + literal[4] != 23) return 4;
    // Outside the range stays zero.
    if (g_scalar[4] || local[4] || slocal[4] || literal[4]) return 5;
    if (g_scalar[2] != 9 || local[2] != 9 || slocal[2] != 9) return 6;
    return 0;
}

static int nested_struct_array(void) {
    struct pair local[2][3] = { [1][2].a = 5, [0][1] = { 3, 4 }, [1][2].b = 6 };
    static struct pair slocal[2][3] = { [1][2].a = 5, [0][1] = { 3, 4 }, [1][2].b = 6 };
    struct pair *literal = (struct pair[4]){ [0 ... 2] = { 1, 2 }, [1].b = 9 };

    if (g_rows[1][2].a + g_rows[1][2].b + g_rows[0][1].a + g_rows[0][1].b != 18) return 7;
    if (local[1][2].a + local[1][2].b + local[0][1].a + local[0][1].b != 18) return 8;
    if (slocal[1][2].a + slocal[1][2].b + slocal[0][1].a + slocal[0][1].b != 18) return 9;
    if (g_rows[0][0].a || g_rows[1][0].b) return 10;
    if (local[0][0].a || local[1][0].b) return 11;
    // A range over the outer dimension, then one member of one element.
    if (g_range[0].b + g_range[1].b + g_range[2].b + g_range[3].b != 13) return 12;
    if (literal[0].b + literal[1].b + literal[2].b + literal[3].b != 13) return 13;
    if (g_range[3].a || literal[3].a) return 14;
    return 0;
}

static int member_array_forms(void) {
    struct holder local = { .v[1 ... 2] = 3, .v[2] = 4 };
    static struct holder slocal = { .v[1 ... 2] = 3, .v[2] = 4 };
    struct holder *literal = &(struct holder){ .v[1 ... 2] = 3, .v[2] = 4 };

    if (sum4(g_member.v) != 7) return 15;
    if (sum4(local.v) != 7) return 16;
    if (sum4(slocal.v) != 7) return 17;
    if (sum4(literal->v) != 7) return 18;
    if (g_member.v[0] || local.v[0] || slocal.v[0] || literal->v[0]) return 19;
    if (g_member.v[2] != 4 || local.v[2] != 4) return 20;
    return 0;
}

int main(void) {
    int rc = scalar_forms();
    if (rc) return rc;
    rc = nested_struct_array();
    if (rc) return rc;
    return member_array_forms();
}

// A zero-initialized local aggregate (C99 6.7.8p19/p21) is filled by
// stores, not copied from a staged template: no data object is emitted
// for it, so a unit whose only aggregate initializers are zero needs no
// writable data at all. A vDSO link script discards `.bss`, so a
// relocation into it from `.text` fails the link.
//
// Covers what must keep copying: a non-zero template, a template past
// the inline fill bound, and one whose zero bytes are a placeholder a
// relocation fills in. Asserted by return code.

typedef unsigned int u32;

static int zero_array(void) {
    u32 counter[2] = { 0 };
    return counter[0] == 0 && counter[1] == 0;
}

struct s { int a, b, c; };

static int zero_struct(void) {
    struct s v = { 0 };
    return v.a == 0 && v.b == 0 && v.c == 0;
}

// Omitted entries take zero; the named one takes its value.
static int partial_struct(void) {
    struct s v = { .b = 5 };
    return v.a == 0 && v.b == 5 && v.c == 0;
}

// Non-constant element: a zero prelude, then the per-element stores.
static int runtime_element(int n) {
    int a[4] = { n, 0, 0, 0 };
    return a[0] == n && a[1] == 0 && a[2] == 0 && a[3] == 0;
}

// Past the inline fill bound: the copy is kept, and the template is
// immutable data.
static int big_zero(void) {
    char buf[512] = { 0 };
    int i;

    for (i = 0; i < 512; i++)
        if (buf[i])
            return 0;
    return 1;
}

static int nonzero_template(void) {
    u32 a[4] = { 1, 2, 3, 4 };
    return a[0] == 1 && a[1] == 2 && a[2] == 3 && a[3] == 4;
}

static int seven(void) { return 7; }

// Zero staged bytes a relocation fills in: eliding the copy would leave
// a null pointer.
static int relocated_template(void) {
    struct fns { int (*fn)(void); int pad; } v = { seven, 0 };
    return v.fn() == 7 && v.pad == 0;
}

static int label_template(int n) {
    void *tbl[] = { &&L0, &&L1 };
    goto *tbl[n];
L0:
    return 10;
L1:
    return 20;
}

int main(void) {
    if (!zero_array()) return 1;
    if (!zero_struct()) return 2;
    if (!partial_struct()) return 3;
    if (!runtime_element(9)) return 4;
    if (!big_zero()) return 5;
    if (!nonzero_template()) return 6;
    if (!relocated_template()) return 7;
    if (label_template(0) != 10) return 8;
    if (label_template(1) != 20) return 9;
    return 0;
}

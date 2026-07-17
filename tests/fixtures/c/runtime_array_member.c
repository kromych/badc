// C99 6.7.8p13: struct members that are arrays, initialized at local scope
// by brace lists containing non-constant (runtime) elements. Previously
// rejected ("non-constant array-field initializer"). The enclosing struct
// slot is zero-seeded, so positions left unwritten stay zero (6.7.8p21).

struct OneD {
    int v[4];
    int tag;
};

struct TwoD {
    int m[2][3];
    int tag;
};

int main(void) {
    volatile int x = 10;

    // 1D, fully initialized, followed by a scalar field.
    struct OneD a = {{x, x + 1, x + 2, x + 3}, x + 100};
    if (a.v[0] != 10 || a.v[1] != 11 || a.v[2] != 12 || a.v[3] != 13) return 1;
    if (a.tag != 110) return 2;

    // 1D, partial: tail elements must be zero.
    struct OneD b = {{x, x + 1}, x};
    if (b.v[0] != 10 || b.v[1] != 11) return 3;
    if (b.v[2] != 0 || b.v[3] != 0) return 4;
    if (b.tag != 10) return 5;

    // 2D braced, mixed constant and runtime elements.
    struct TwoD c = {{{x, 1, x + 2}, {3, x + 4, 5}}, 7};
    if (c.m[0][0] != 10 || c.m[0][1] != 1 || c.m[0][2] != 12) return 6;
    if (c.m[1][0] != 3 || c.m[1][1] != 14 || c.m[1][2] != 5) return 7;
    if (c.tag != 7) return 8;

    // 2D partial rows: unwritten positions zero.
    struct TwoD d = {{{x}}, x + 1};
    if (d.m[0][0] != 10 || d.m[0][1] != 0 || d.m[0][2] != 0) return 9;
    if (d.m[1][0] != 0 || d.m[1][1] != 0 || d.m[1][2] != 0) return 10;
    if (d.tag != 11) return 11;

    // Brace elision: flat list fills the array member row-major, then the
    // next field.
    struct TwoD e = {x, x + 1, x + 2, x + 3, x + 4, x + 5, x + 6};
    if (e.m[0][0] != 10 || e.m[0][1] != 11 || e.m[0][2] != 12) return 12;
    if (e.m[1][0] != 13 || e.m[1][1] != 14 || e.m[1][2] != 15) return 13;
    if (e.tag != 16) return 14;

    // Designated array member, partial.
    struct OneD f = {.tag = x + 1, .v = {x, x + 2}};
    if (f.v[0] != 10 || f.v[1] != 12 || f.v[2] != 0 || f.v[3] != 0) return 15;
    if (f.tag != 11) return 16;

    return 0;
}

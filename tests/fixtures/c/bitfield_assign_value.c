// C99 6.5.16p3: a bitfield assignment expression has the value stored in
// the field converted to its declared type -- the right-aligned masked
// value (sign-extended for a signed field), not the storage word with the
// field shifted into place. A chained assignment to adjacent fields of one
// storage unit must observe the inner store rather than read a stale word.

struct S {
    unsigned int a : 1, b : 1, c : 3;
    signed int s : 4;
};

int main(void) {
    struct S x = {0};

    // Assignment-as-rvalue: the masked logical value, not the
    // word-positioned bits. `b` sits at bit offset 1, so a wrong lowering
    // would yield 1<<1 = 2.
    int v = (x.b = 1);
    if (v != 1) return 1;
    // `c` is a 3-bit field at offset 2; a wrong lowering would yield 5<<2.
    int w = (x.c = 5);
    if (w != 5) return 2;

    // Assigning wider than the field stores the low bits, and the
    // expression value is that truncation.
    int t = (x.c = 13);
    if (t != 5 || x.c != 5) return 3;

    // Chained assignment to adjacent fields of one storage unit: the outer
    // read-modify-write must observe the inner store.
    struct S y = {0};
    y.a = y.b = 1;
    if (y.a != 1 || y.b != 1) return 4;

    // A signed bitfield assignment value sign-extends from the field width.
    int sv = (x.s = -3);
    if (sv != -3 || x.s != -3) return 5;

    return 0;
}

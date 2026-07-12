/* C99 6.5.16.1p1 with 6.3.2.1p2: struct assignment requires compatible
 * unqualified types; lvalue conversion drops qualifiers from the right
 * operand, so a volatile- or const-qualified source assigns to a plain
 * destination (and a volatile destination accepts a plain source). */
typedef struct {
    int a, b;
} S;

static S g;
static volatile S gv;

static void from_volatile(volatile S *p) { g = *p; }
static void from_const(const S *p) { g = *p; }
static void to_volatile(const S *p) { gv = *p; }

int main(void) {
    volatile S vs = {3, 4};
    const S cs = {5, 6};

    from_volatile(&vs);
    if (g.a != 3 || g.b != 4)
        return 1;

    from_const(&cs);
    if (g.a != 5 || g.b != 6)
        return 2;

    to_volatile(&cs);
    if (gv.a != 5 || gv.b != 6)
        return 3;

    /* Cast-through-volatile-pointer copy of a plain object. */
    S dst;
    S src = {7, 8};
    dst = *(volatile S *)&src;
    if (dst.a != 7 || dst.b != 8)
        return 4;
    return 0;
}

/* A const-qualified scalar arithmetic object with a constant initializer
   folds where a case label, a static_assert, a designator index, or a
   static initializer needs a constant (GCC, GNU mode at -O). Type
   dimensions never fold: an array bound over such an object stays a VLA. */
typedef unsigned int u32;

static unsigned classify(u32 rate) {
    u32 const link_rate_hbr2 = 540000;
    u32 const link_rate_hbr3 = 810000;
    switch (rate) {
    case link_rate_hbr3:
        return 6;
    case link_rate_hbr2:
        return 4;
    case 162000:
    case 270000:
        return 2;
    default:
        return 0;
    }
}

static unsigned arith_and_chain(unsigned r) {
    const unsigned a = 5;
    const unsigned b = a * 2;
    _Static_assert(sizeof(a) == 4, "recorded const keeps its type");
    switch (r) {
    case b:          /* 10 */
        return 1;
    case b + 1:      /* 11 */
        return 2;
    case 20 ... 29:  /* GNU range */
        return 3;
    default:
        return 0;
    }
}

static unsigned shadowed(unsigned r) {
    const unsigned h = 1;
    {
        const unsigned h = 2;
        switch (r) {
        case h: /* inner: 2 */
            return 9;
        default:
            break;
        }
    }
    switch (r) {
    case h: /* outer: 1 */
        return 8;
    default:
        return 0;
    }
}

static int desig_and_static_init(void) {
    const int i = 2;
    static int from_const = i * 500; /* static init reads the const object */
    static int copy;                 /* runtime-set below */
    int a[4] = { [i] = 9, [i - 1] = 5 };
    struct s { int m[4]; } v = { .m[i] = 7 };
    static const int si = 3;
    _Static_assert(si == 3, "static const folds too");
    copy = a[i];
    return a[2] == 9 && a[1] == 5 && a[0] == 0 && v.m[2] == 7 && from_const == 1000
        && copy == 9;
}

static int stays_vla(void) {
    const int n = 4;
    int a[n]; /* not folded: variably sized, sizeof computed at run time */
    for (int k = 0; k < n; k++)
        a[k] = k;
    return (int)(sizeof a / sizeof a[0]) == 4 && a[3] == 3;
}

int main(void) {
    if (classify(810000) != 6) return 1;
    if (classify(540000) != 4) return 2;
    if (classify(162000) != 2) return 3;
    if (classify(1) != 0) return 4;
    if (arith_and_chain(10) != 1) return 5;
    if (arith_and_chain(11) != 2) return 6;
    if (arith_and_chain(25) != 3) return 7;
    if (shadowed(2) != 9) return 8;
    if (shadowed(1) != 8) return 9;
    if (!desig_and_static_init()) return 10;
    if (!stays_vla()) return 11;
    return 0;
}

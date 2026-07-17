/* A statement expression re-enters statement parsing from inside an
 * expression. An aggregate local initializer inside the block must not
 * disturb the enclosing expression's operand bookkeeping: the enclosing
 * assignment previously popped a residual entry and dropped itself, so
 * the store never ran and the block's declarations never executed. */
struct out {
    unsigned m;
    unsigned n;
};

static unsigned deposit(unsigned reg) {
    /* Bitfield aggregate inside the block of an assignment RHS. */
    reg = ({
        struct {
            unsigned f : 4;
        } tmp = {.f = 5};
        (reg & ~0xfu) | tmp.f;
    });
    return reg;
}

int main(void) {
    int r1;
    r1 = ({
        int k[2] = {1, 2};
        k[1];
    });

    int r2;
    r2 = ({
        struct {
            unsigned v : 1;
        } b = {.v = 1};
        unsigned t;
        t = 7 + b.v;
        (int)t;
    });

    int r3;
    r3 = ({
        int k[2] = {1, 2};
        (int)sizeof(k[0]);
    });

    struct out s = {1, 2};
    s.m = ({
        struct {
            unsigned a : 3;
            unsigned b : 5;
        } f = {.a = 2, .b = 9};
        (unsigned)(f.a + f.b);
    });

    if (r1 != 2)
        return 1;
    if (r2 != 8)
        return 2;
    if (r3 != 4)
        return 3;
    if (s.m != 11 || s.n != 2)
        return 4;
    if (deposit(0xa0) != 0xa5)
        return 5;
    return 0;
}

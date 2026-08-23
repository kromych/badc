// A `!` operand of a short-circuit chain is already 0/1, so no term
// is re-normalized before the chain tests it, and each term's zero
// test branches on the tested register itself. C99 6.5.13/6.5.14:
// the operators yield 0 or 1 and evaluate left to right; 6.5.3.3p5:
// `!E` is `(0 == E)`.

static volatile unsigned long opaque = ~0UL;
static volatile unsigned long len = 0;
static volatile unsigned int flags = 0;
static int object;
static volatile int have_buffer = 0;

static int check(unsigned long o, void *buffer, unsigned long l, unsigned int f) {
    if (o == ~0UL && !buffer && !l && !f) {
        return 1;
    }
    if (o > 100) {
        return 2;
    }
    return 3;
}

int main(void) {
    void *buf = have_buffer ? (void *)&object : (void *)0;
    if (check(opaque, buf, len, flags) != 1) {
        return 1;
    }
    if (check(opaque, &object, len, flags) != 2) {
        return 2;
    }
    if (check(7, buf, len, flags) != 3) {
        return 3;
    }
    if (check(opaque, buf, 8, flags) != 2) {
        return 4;
    }
    if (check(opaque, buf, len, 2) != 2) {
        return 5;
    }
    return 0;
}

/* A by-value aggregate parameter the host ABI does not put in one or two
   integer registers still inlines: the SSA call carries the address of the
   caller's object whatever the class, and the splice copies the bytes into
   the parameter's relocated cell exactly as the prologue does out of line.

   `struct big` is 40 bytes: System V AMD64 MEMORY class (3.2.3), AAPCS64
   by-reference (6.8.2), Win64 by implicit reference.

   `clobber` writes through a pointer that names the same object the
   aggregate argument does. C99 6.5.2.2p4 gives the parameter the argument's
   value as of the call, so the copy has to precede the body's stores; a
   splice that bound the parameter to the caller's object instead would read
   the stored values back. */

struct big {
    long a, b, c, d, e;
};

static struct big g;

static __attribute__((always_inline)) long sum(struct big v) {
    return v.a + v.b * 2 + v.c * 4 + v.d * 8 + v.e * 16;
}

static __attribute__((always_inline)) long clobber(struct big v, struct big *p) {
    p->a = 99;
    p->e = 77;
    return v.a * 10000 + v.b * 1000 + v.c * 100 + v.d * 10 + v.e;
}

static __attribute__((always_inline)) long pick(struct big x, struct big y, int which) {
    return which ? x.c : y.d;
}

static __attribute__((always_inline)) long find(struct big v, long target) {
    if (v.a == target) {
        return 1;
    }
    if (v.c == target) {
        return 3;
    }
    if (v.e == target) {
        return 5;
    }
    return 0;
}

static __attribute__((noinline)) long weigh(struct big v, long k) {
    return v.b * k;
}

/* The parameter's cell is filled by the splice and then handed on by value
   to a call the splice keeps, so the nested call marshals it from the
   relocated cell. */
static __attribute__((always_inline)) long forward(struct big v, long k) {
    return weigh(v, k) + v.a;
}

static __attribute__((noinline)) long use_sum(struct big *p) {
    return sum(*p);
}

static __attribute__((noinline)) long use_forward(struct big *p, long k) {
    return forward(*p, k);
}

static __attribute__((noinline)) long use_clobber(void) {
    return clobber(g, &g);
}

static __attribute__((noinline)) long use_pick(struct big *x, struct big *y, int which) {
    return pick(*x, *y, which);
}

static __attribute__((noinline)) long use_find(struct big *p, long target) {
    return find(*p, target);
}

int main(void) {
    struct big v = {1, 2, 3, 4, 5};

    if (use_sum(&v) != 1 + 4 + 12 + 32 + 80) {
        return 1;
    }
    if (v.a != 1 || v.e != 5) {
        return 2;
    }

    g = v;
    if (use_clobber() != 12345) {
        return 3;
    }
    if (g.a != 99 || g.e != 77 || g.b != 2) {
        return 4;
    }

    struct big w = {10, 20, 30, 40, 50};
    if (use_pick(&v, &w, 1) != 3) {
        return 5;
    }
    if (use_pick(&v, &w, 0) != 40) {
        return 6;
    }

    if (use_find(&v, 3) != 3) {
        return 7;
    }
    if (use_find(&v, 5) != 5) {
        return 8;
    }
    if (use_find(&v, 2) != 0) {
        return 9;
    }

    if (use_forward(&v, 7) != 15) {
        return 10;
    }
    return 0;
}

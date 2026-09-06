/* By-value aggregate parameters the host ABI classes into the
   floating-point bank, or into more register slots than an integer pair,
   inline the same way an integer pair does: the argument is the address of
   the caller's object and the splice copies the bytes into the parameter's
   relocated cell.

   `dpair` is two SSE eightbytes on System V AMD64 (3.2.3) and a two-member
   HFA on AAPCS64 (6.8.2); `dquad` is a four-member HFA on AAPCS64 and
   MEMORY class on System V; `mixed` takes one INTEGER and one SSE
   eightbyte on System V and the general-purpose pair on AAPCS64. */

struct dpair {
    double x, y;
};

struct dquad {
    double a, b, c, d;
};

struct mixed {
    long i;
    double d;
};

static struct dpair gp;

static __attribute__((always_inline)) double pair_sum(struct dpair p) {
    return p.x + p.y * 2;
}

static __attribute__((always_inline)) double quad_sum(struct dquad q) {
    return q.a + q.b * 2 + q.c * 4 + q.d * 8;
}

static __attribute__((always_inline)) double mixed_sum(struct mixed m) {
    return (double)m.i + m.d;
}

static __attribute__((always_inline)) double pair_clobber(struct dpair p, struct dpair *q) {
    q->x = 100;
    q->y = 200;
    return p.x * 10 + p.y;
}

static __attribute__((noinline)) double use_pair(struct dpair *p) {
    return pair_sum(*p);
}

static __attribute__((noinline)) double use_quad(struct dquad *q) {
    return quad_sum(*q);
}

static __attribute__((noinline)) double use_mixed(struct mixed *m) {
    return mixed_sum(*m);
}

static __attribute__((noinline)) double use_pair_clobber(void) {
    return pair_clobber(gp, &gp);
}

int main(void) {
    struct dpair p = {1.5, 2.5};
    if (use_pair(&p) != 6.5) {
        return 1;
    }

    struct dquad q = {1, 2, 3, 4};
    if (use_quad(&q) != 1 + 4 + 12 + 32) {
        return 2;
    }

    struct mixed m = {7, 0.25};
    if (use_mixed(&m) != 7.25) {
        return 3;
    }

    gp = p;
    if (use_pair_clobber() != 17.5) {
        return 4;
    }
    if (gp.x != 100 || gp.y != 200) {
        return 5;
    }
    return 0;
}

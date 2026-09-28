/* An aggregate a call returns lands in its destination. A result returned
   through a hidden pointer (a 32-byte struct) is built in place when the
   destination is a local the callee cannot reach -- a fresh object, or a
   local whose address escapes only after the call -- and through a
   temporary when the callee can reach the destination: through a global
   holding its address, through an argument, through a pointer the
   destination was reached by, or across a loop iteration that published
   its address. A result returned in registers is stored into its
   destination after the call, pointer destinations included. Each case
   checks every member; the exit code names the first mismatch. A 64-bit
   field or value is `long long`: `long` is 32 bits under LLP64. */

#define NOINLINE __attribute__((noinline))

struct S { long long a, b, c, d; };
struct P { long long a, b; };
struct Q { int a, b; };

static struct S *gp;
static struct P *gpp;
static volatile long long sink;

NOINLINE struct S make(long long x) {
    struct S r = {x, x + 1, x + 2, x + 3};
    return r;
}

NOINLINE struct P makep(long long x) {
    struct P r = {x, x * 2};
    return r;
}

NOINLINE struct Q makeq(int x) {
    struct Q r = {x, -x};
    return r;
}

/* Reads the destination through the global while it builds the result. */
NOINLINE struct S rotate_global(void) {
    struct S r;
    r.a = gp->d;
    r.b = gp->a;
    r.c = gp->b;
    r.d = gp->c;
    return r;
}

/* Reads the destination through its argument. */
NOINLINE struct S rotate_arg(const struct S *p) {
    struct S r;
    r.a = p->d;
    r.b = p->a;
    r.c = p->b;
    r.d = p->c;
    return r;
}

/* Writes the destination through the global, then returns a result. */
NOINLINE struct S clobber_global(void) {
    gp->a = 100;
    gp->d = 400;
    return make(7);
}

/* The register-class counterpart, reading the destination through a global. */
NOINLINE struct P swap_global(void) {
    struct P r = {gpp->b, gpp->a};
    return r;
}

NOINLINE long long use(const struct S *s) { return s->a + 10 * s->b + 100 * s->c + 1000 * s->d; }
NOINLINE long long usep(const struct P *p) { return p->a + 10 * p->b; }

static int same(const struct S *s, long long a, long long b, long long c, long long d) {
    return s->a == a && s->b == b && s->c == c && s->d == d;
}

NOINLINE int fresh(void) {
    struct S s = make(1);
    return same(&s, 1, 2, 3, 4) && use(&s) == 4321;
}

NOINLINE int assign_local(void) {
    struct S s;
    s = make(5);
    return use(&s) == 5 + 60 + 700 + 8000;
}

NOINLINE int through_pointer(struct S *a) {
    *a = make(9);
    return same(a, 9, 10, 11, 12);
}

NOINLINE int escaped_to_global(void) {
    struct S s = {1, 2, 3, 4};
    gp = &s;
    s = rotate_global();
    return same(&s, 4, 1, 2, 3);
}

NOINLINE int escaped_as_argument(void) {
    struct S s = {1, 2, 3, 4};
    s = rotate_arg(&s);
    return same(&s, 4, 1, 2, 3);
}

NOINLINE int clobbered_then_assigned(void) {
    struct S s = {1, 2, 3, 4};
    gp = &s;
    s = clobber_global();
    return same(&s, 7, 8, 9, 10);
}

/* The address published in one iteration reaches the next call. */
NOINLINE int escape_across_iterations(void) {
    struct S s = {1, 2, 3, 4};
    int i, ok = 1;
    for (i = 0; i < 3; i++) {
        s = i ? rotate_global() : make(1);
        ok &= i == 0 ? same(&s, 1, 2, 3, 4) : i == 1 ? same(&s, 4, 1, 2, 3) : same(&s, 3, 4, 1, 2);
        gp = &s;
    }
    return ok;
}

NOINLINE int pointer_to_local(void) {
    struct S s = {1, 2, 3, 4};
    struct S *p = &s;
    gp = p;
    *p = rotate_global();
    return same(&s, 4, 1, 2, 3);
}

NOINLINE int regs_through_pointer(struct P *a) {
    *a = makep(3);
    return a->a == 3 && a->b == 6;
}

NOINLINE int regs_fresh(void) {
    struct P p = makep(4);
    return usep(&p) == 4 + 80;
}

NOINLINE int regs_in_registers(void) {
    struct P p = makep(6);
    struct Q q = makeq(7);
    return p.a + p.b == 18 && q.a == 7 && q.b == -7;
}

NOINLINE int regs_escaped(void) {
    struct P p = {1, 2};
    gpp = &p;
    p = swap_global();
    return p.a == 2 && p.b == 1;
}

NOINLINE long long member_of_call(void) { return make(20).c + makep(30).b; }

int main(void) {
    struct S out;
    struct P outp;
    if (!fresh()) {
        return 1;
    }
    if (!assign_local()) {
        return 2;
    }
    if (!through_pointer(&out)) {
        return 3;
    }
    if (!escaped_to_global()) {
        return 4;
    }
    if (!escaped_as_argument()) {
        return 5;
    }
    if (!clobbered_then_assigned()) {
        return 6;
    }
    if (!escape_across_iterations()) {
        return 7;
    }
    if (!pointer_to_local()) {
        return 8;
    }
    if (!regs_through_pointer(&outp)) {
        return 9;
    }
    if (!regs_fresh()) {
        return 10;
    }
    if (!regs_in_registers()) {
        return 11;
    }
    if (!regs_escaped()) {
        return 12;
    }
    if (member_of_call() != 22 + 60) {
        return 13;
    }
    sink = out.a + outp.a;
    return 0;
}

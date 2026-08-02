// C99 6.5.2.2p4: a by-value parameter holds the argument's value as of
// the call, so a write the callee makes to the caller's object is not
// visible through the parameter. The parameter's frame cell is filled
// by the prologue, which no instruction of the body performs; a splice
// that removes the prologue has to reproduce that copy rather than bind
// the cell to the caller's argument address, which would alias the two.
//
// Three routes reach the caller's object from inside the callee: a
// pointer parameter naming it, a global pointer, and a write to the
// parameter itself (a modifiable lvalue, C99 6.7.5.3p7).

struct s {
    unsigned char f0;
    unsigned char f1;
};

static struct s *gp;

static struct s via_arg(struct s *p, struct s v, unsigned long long k) {
    struct s rv = {0};
    p->f0 = (unsigned char)((((unsigned long long)p->f0 + 0x5f4477ull) >> 7) + k);
    rv.f0 = v.f0;
    return rv;
}

static int via_global(struct s v) {
    gp->f0 = 99;
    return v.f0;
}

static int via_param_write(struct s v) {
    v.f0 = 42;
    return v.f0;
}

// Two by-value parameters of one call, both naming the object the
// pointer parameter writes: each needs its own cell and its own copy.
static int two_copies(struct s a, struct s b, struct s *p) {
    p->f0 = 55;
    return a.f0 * 10 + b.f0;
}

static struct s go;

static int global_by_value(struct s v) {
    go.f0 = 77;
    return v.f0;
}

int main(void) {
    struct s o = {0};

    o.f0 = 0x11;
    if (via_arg(&o, o, 3).f0 != 0x11) return 1;
    if (o.f0 != 140) return 2;

    o.f0 = 7;
    gp = &o;
    if (via_global(o) != 7) return 3;
    if (o.f0 != 99) return 4;

    o.f0 = 8;
    if (via_param_write(o) != 42) return 5;
    if (o.f0 != 8) return 6;

    o.f0 = 3;
    if (two_copies(o, o, &o) != 33) return 7;
    if (o.f0 != 55) return 8;

    go.f0 = 4;
    if (global_by_value(go) != 4) return 9;
    if (go.f0 != 77) return 10;

    return 0;
}

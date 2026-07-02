/* SysV mixed SSE/INTEGER eightbyte aggregates: the integer eightbyte
   target GPR may still be another argument's pending source, so the
   aggregate loads must join the parallel-move ordering. */
struct DL { double d; long l; };
struct LD { long l; double d; };
struct DD { double a; double b; };

static int take3(struct DL s, long x, struct LD t, double f, struct DD u) {
    if (s.d != 2.5 || s.l != 7) return 1;
    if (x != 4) return 2;
    if (t.l != 11 || t.d != 0.5) return 3;
    if (f != 1.25) return 4;
    if (u.a != 3.5 || u.b != 4.5) return 5;
    return 0;
}

int docall(long x, struct DL *p, struct LD *q, struct DD *r, double f) {
    return take3(*p, x, *q, f, *r);
}

int main(void) {
    struct DL s; struct LD t; struct DD u;
    s.d = 2.5; s.l = 7;
    t.l = 11; t.d = 0.5;
    u.a = 3.5; u.b = 4.5;
    return docall(4, &s, &t, &u, 1.25);
}

// C99 6.7.8p20: braces may be elided around an aggregate element of an
// array member, whose members then take the next initializers of the
// same list -- in a static object and in an automatic one, with constant
// and run-time values, braced and unbraced elements mixed. Each check
// exits with its own code; success returns 0.

struct M { float m0, m1; };
struct V { struct M p[2]; float z; };
struct W { int n; struct M q[2]; };
static struct V sv = { 1, 2, 3, 4, 5 };
static struct V sm = { {1, 2, 3, 4}, 5 };
static struct V sn = { 1, 2, {3, 4}, 5 };
static struct W sw = { 7, 1, 2, 3 };
static struct V s0 = { 0 };
static int check(const struct V *v, float a, float b, float c, float d, float e) {
    return v->p[0].m0 == a && v->p[0].m1 == b && v->p[1].m0 == c && v->p[1].m1 == d && v->z == e;
}
int main(void) {
    float x = 1;
    struct V lv = { 1, 2, 3, 4, 5 };
    struct V lr = { x, 2, 3, 4, 5 };
    struct V lm = { {x, 2, 3, x + 3}, 5 };
    struct W lw = { 7, x, 2, 3 };
    struct V l0 = { 0 };
    if (!check(&sv, 1, 2, 3, 4, 5)) return 1;
    if (!check(&sm, 1, 2, 3, 4, 5)) return 2;
    if (!check(&sn, 1, 2, 3, 4, 5)) return 3;
    if (sw.n != 7 || sw.q[0].m0 != 1 || sw.q[0].m1 != 2 || sw.q[1].m0 != 3 || sw.q[1].m1 != 0) return 4;
    if (!check(&s0, 0, 0, 0, 0, 0)) return 5;
    if (!check(&lv, 1, 2, 3, 4, 5)) return 6;
    if (!check(&lr, 1, 2, 3, 4, 5)) return 7;
    if (!check(&lm, 1, 2, 3, 4, 5)) return 8;
    if (lw.n != 7 || lw.q[0].m0 != 1 || lw.q[0].m1 != 2 || lw.q[1].m0 != 3 || lw.q[1].m1 != 0) return 9;
    if (!check(&l0, 0, 0, 0, 0, 0)) return 10;
    return 0;
}

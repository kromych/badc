/* Two-register aggregates passed by value (System V AMD64 3.2.3, AAPCS64
   6.4.2) where the argument registers run out partway: an aggregate that
   no longer fits goes wholly to the stack while a later scalar or a later
   mixed-class aggregate still takes a register. The arguments are built
   from constants, read through a pointer and computed, so the values
   reaching the call are defined in every order around it; a call through
   a pointer stages its target beside them. Each result is
   checked against scalar arithmetic; the exit code names the first
   mismatch. A 64-bit field is `long long`: `long` is 32 bits under LLP64. */

#define NOINLINE __attribute__((noinline))

typedef long long ll;
struct P { ll a, b; };
struct DL { double d; ll l; };
struct LD { ll l; double d; };
struct DD { double x, y; };

NOINLINE ll tail(ll r1, ll r2, ll r3, ll r4, ll r5, struct P a, struct DL b, struct P c) {
    return r1 + r2 * 2 + r3 * 3 + r4 * 4 + r5 * 5 + a.a * 6 + a.b * 7 + (ll)b.d * 8 + b.l * 9
           + c.a * 10 + c.b * 11;
}

NOINLINE ll four(struct P a, struct P b, struct P c, struct P d) {
    return a.a + a.b * 2 + b.a * 3 + b.b * 4 + c.a * 5 + c.b * 6 + d.a * 7 + d.b * 8;
}

NOINLINE double fp(struct DD a, struct DD b, struct DD c, struct DD d, struct DD e, struct LD f) {
    return a.x + a.y * 2 + b.x * 3 + b.y * 4 + c.x * 5 + c.y * 6 + d.x * 7 + d.y * 8 + e.x * 9
           + e.y * 10 + (double)f.l * 11 + f.d * 12;
}

NOINLINE struct P make(ll a, ll b) { return (struct P){ a, b }; }

struct fns {
    ll (*tail)(ll, ll, ll, ll, ll, struct P, struct DL, struct P);
};

int main(void) {
    static struct fns table = { tail };
    struct fns *volatile f = &table;
    struct P arr[3] = { { 5, 6 }, { 7, 8 }, { 9, 10 } };
    struct P *p = &arr[1];
    volatile ll k = 3;
    if (tail(1, 2, 3, 4, 5, (struct P){ 6, 7 }, (struct DL){ 8.0, 9 }, p[1]) != 485)
        return 1;
    if (tail(k, k + 1, k * 2, 4, 5, p[-1], (struct DL){ (double)k, k }, (struct P){ k, 11 })
        != 3 + 8 + 18 + 16 + 25 + 30 + 42 + 24 + 27 + 30 + 121)
        return 2;
    if (four((struct P){ 1, 2 }, make(3, 4), p[0], (struct P){ k, k + 5 }) != 1 + 4 + 9 + 16 + 35 + 48 + 21 + 64)
        return 3;
    if (f->tail(1, 2, 3, 4, 5, (struct P){ 6, 7 }, (struct DL){ 8.0, 9 }, p[1]) != 485)
        return 4;
    struct DD d = { 1.5, 2.5 };
    double r = fp(d, (struct DD){ 3.0, 4.0 }, d, (struct DD){ 0.5, 0.25 }, d, (struct LD){ 2, 1.5 });
    if (r != 1.5 + 5.0 + 9.0 + 16.0 + 7.5 + 15.0 + 3.5 + 2.0 + 13.5 + 25.0 + 22.0 + 18.0)
        return 5;
    return 0;
}

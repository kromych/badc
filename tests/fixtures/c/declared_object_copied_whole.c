// A declared object initialized and then copied whole is built in the
// destination at -O. The destination's address is set after the
// initializer's writes, and a write through a pointer into the object
// addresses it at the offset from the object's base. Returns 0 when every
// check passes.

#include <stdint.h>

#pragma pack(1)
struct S1 {
    unsigned f0 : 1;
};
#pragma pack()

struct In {
    int x, y;
};
struct Mid {
    int k;
    struct In in[2];
};
struct Big {
    long pad[6];
    struct Mid m[2];
};

static struct S1 g_104 = {0};
static struct S1 g_105 = {0};
static struct Big g;
static volatile int one = 1, four = 4, five = 5, seven = 7;

__attribute__((noinline)) static void chain(int bit)
{
    struct S1 l_101 = {0};
    l_101.f0 = bit;
    {
        struct S1 l_102[1] = {{0}};
        g_105 = (g_104 = (l_102[0] = l_101));
    }
}

__attribute__((noinline)) static void to_global(int v)
{
    struct Big t[1] = {{.m[1].in[1].y = v, .m[0].in[0] = {v + 1, v + 2}, .m[1].k = v + 3}};
    g = t[0];
}

__attribute__((noinline)) static int to_local(int v)
{
    struct Big t[1] = {{.m[0].k = v, .m[1].in[0].x = v + 1}};
    struct Big u[1];
    u[0] = t[0];
    return u[0].m[0].k * 100 + u[0].m[1].in[0].x + (int)u[0].pad[5];
}

__attribute__((noinline)) static void through_member(struct Big *p, int v)
{
    struct Big t[1] = {{{0}}};
    struct Mid *q = &t[0].m[1];
    q->in[1].y = v;
    q->k = v + 1;
    *p = t[0];
}

int main(void)
{
    g_104.f0 = 0;
    g_105.f0 = 0;
    chain(one);
    if (g_104.f0 != 1 || g_105.f0 != 1) return 1;
    g.pad[0] = 99;
    g.m[1].in[1].x = 99;
    to_global(five);
    if (g.pad[0] != 0 || g.m[1].in[1].x != 0) return 2;
    if (g.m[1].in[1].y != 5 || g.m[0].in[0].x != 6 || g.m[0].in[0].y != 7 || g.m[1].k != 8)
        return 3;
    if (to_local(four) != 405) return 4;
    struct Big l;
    l.pad[2] = 99;
    l.m[1].in[1].y = 99;
    through_member(&l, seven);
    if (l.pad[2] != 0) return 5;
    if (l.m[1].in[1].y != 7 || l.m[1].k != 8 || l.m[0].k != 0) return 6;
    return 0;
}

/* Brace elision (C99 6.7.8p20) into a union's anonymous first member, into
 * an anonymous union inside a struct, and into members of automatic
 * aggregates with non-constant values; a value of a member's own type
 * initializes it whole (p13). */
typedef union {
    struct { unsigned char i[3]; unsigned char t; };
    unsigned int v;
} H;

struct G { int a; union { short s; int w; }; int z; };

struct K { unsigned a, b; };
struct C { struct K key; int store; const void *p; };
struct P { struct C c; int type; };
struct F { int op; struct P prop; };

const H h = { 1, 0, 0, 0x40 };
const struct G g = { 1, 2, 3 };
const struct K K1 = { 1, 2 };

static int run(int n) {
    H a[2] = { n, 2, 3, 4, 5 };
    struct G l = { n, n + 1, n + 2 };
    struct K k = { n, n * 2 };
    const struct F f[] = {
        { 1, { 0 } },
        { 2, { { K1, 3, 0 }, 4 } },
        { 3, n, n + 1, 5, 0, 6 },
        { 4, { { k } } },
    };
    if (a[0].i[0] != n || a[0].t != 4 || a[1].i[0] != 5 || a[1].t != 0) return 1;
    if (l.a != n || l.s != n + 1 || l.z != n + 2) return 2;
    if (f[0].op != 1 || f[0].prop.c.key.a != 0 || f[0].prop.type != 0) return 3;
    if (f[1].prop.c.key.b != 2 || f[1].prop.c.store != 3 || f[1].prop.type != 4) return 4;
    if (f[2].prop.c.key.a != n || f[2].prop.c.key.b != n + 1) return 5;
    if (f[2].prop.c.store != 5 || f[2].prop.c.p || f[2].prop.type != 6) return 6;
    if (f[3].prop.c.key.b != n * 2) return 7;
    return 0;
}

int main(void) {
    if (h.i[0] != 1 || h.i[1] != 0 || h.t != 0x40) return 10;
    if (g.a != 1 || g.s != 2 || g.z != 3) return 11;
    return run(7);
}

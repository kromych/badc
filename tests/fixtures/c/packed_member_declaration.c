// An attribute among a member declaration's specifiers, before or after the
// type, applies to every member the declaration declares (GCC, clang):
// `packed` drops each one's alignment to 1 and `aligned` raises each one. A
// packed bit-field sits at the next bit, whatever unit it straddles; the PE
// targets take the MS layout, where it takes a whole unit of its type at an
// alignment of 1 (clang for the windows-msvc triples). Every write reads
// back without disturbing a neighbour. Each failure returns a distinct code.

#include <stddef.h>
#include <string.h>

struct one { char c; __attribute__((packed)) int b; };
struct two { char c; __attribute__((packed)) int a, b; char d; };
struct after { char c; int __attribute__((packed)) a, b; char d; };
struct group_aligned { char c; int __attribute__((aligned(8))) a, b; };
struct bits { char c; __attribute__((packed)) int b : 30; char d; };
struct mixed { char c; int a : 20; __attribute__((packed)) int b : 20; char d; };
struct wide { char c; __attribute__((packed)) long long b : 40; char d; };

#if defined(_WIN32)
#define MIXED_D 12
#define MIXED_SIZE 16
#define WIDE_D 9
#else
#define MIXED_D 6
#define MIXED_SIZE 8
#define WIDE_D 6
#endif

static int check_one(struct one *p, int v) {
    p->b = v;
    return p->b == v && p->c == 7;
}

int main(void) {
    if (sizeof(struct one) != 5 || offsetof(struct one, b) != 1 || _Alignof(struct one) != 1) return 1;
    if (sizeof(struct two) != 10 || offsetof(struct two, b) != 5 || offsetof(struct two, d) != 9) return 2;
    if (sizeof(struct after) != 10 || offsetof(struct after, b) != 5) return 3;
    if (sizeof(struct group_aligned) != 24 || offsetof(struct group_aligned, b) != 16) return 4;
    if (sizeof(struct bits) != 6 || offsetof(struct bits, d) != 5) return 5;
    if (sizeof(struct mixed) != MIXED_SIZE || offsetof(struct mixed, d) != MIXED_D) return 6;
    if (sizeof(struct wide) != WIDE_D + 1 || offsetof(struct wide, d) != WIDE_D) return 7;

    // The packed member's bytes follow the char with no padding.
    struct one o[2];
    memset(o, 0, sizeof o);
    o[0].c = 7;
    o[1].c = 7;
    if (!check_one(&o[1], 0x11223344)) return 10;
    unsigned char *raw = (unsigned char *)o;
    if (raw[5] != 7 || raw[6] != 0x44 || raw[9] != 0x11) return 11;
    if (!check_one(&o[0], -5) || o[1].b != 0x11223344) return 12;

    struct two t;
    memset(&t, 0, sizeof t);
    t.c = 1;
    t.a = 0x01020304;
    t.b = -7;
    t.d = 9;
    if (t.c != 1 || t.a != 0x01020304 || t.b != -7 || t.d != 9) return 13;

    // A bit-field straddling its type's unit reads back whole.
    struct bits x;
    memset(&x, 0, sizeof x);
    x.c = 1;
    x.d = 2;
    x.b = -123456789;
    if (x.c != 1 || x.b != -123456789 || x.d != 2) return 20;
    x.b = 0x1fffffff;
    if (x.c != 1 || x.b != 0x1fffffff || x.d != 2) return 21;

    struct mixed m;
    memset(&m, 0, sizeof m);
    m.c = 3;
    m.a = -0x7ffff;
    m.b = 0x7ffff;
    m.d = 4;
    if (m.c != 3 || m.a != -0x7ffff || m.b != 0x7ffff || m.d != 4) return 22;
    m.b = -1;
    if (m.a != -0x7ffff || m.b != -1 || m.d != 4) return 23;

    struct wide w;
    memset(&w, 0, sizeof w);
    w.c = 5;
    w.d = 6;
    w.b = 0x7fffffffffLL;
    if (w.c != 5 || w.b != 0x7fffffffffLL || w.d != 6) return 24;
    w.b = -0x123456789LL;
    if (w.c != 5 || w.b != -0x123456789LL || w.d != 6) return 25;
    return 0;
}

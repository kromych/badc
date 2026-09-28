// An attribute list may follow a bit-field's width (GCC, clang) and applies
// to that declarator alone: `aligned(N)` places the field on an N-byte
// boundary and raises the aggregate's alignment, `packed` places it at the
// next bit. Before the type the same request applies to every declarator,
// and an unnamed bit-field takes it too. The PE targets take the MS layout
// (clang for the windows-msvc triples), where an unnamed bit-field raises
// the aggregate's alignment as on Linux/AArch64. Every write reads back
// without disturbing a neighbour. Each failure returns a distinct code.

#include <stddef.h>
#include <string.h>

struct after { char c; int b : 4 __attribute__((aligned(8))), e : 4; char d; };
struct lead { char c; __attribute__((aligned(8))) int b : 4, e : 4; char d; };
struct packed30 { char c; int b : 30 __attribute__((packed)); char d; };
struct wide { char c; long long b : 40 __attribute__((aligned(16))); char d; };
struct unnamed { char c; int : 4 __attribute__((aligned(8))); char d; };
struct gap { char c; int : 30 __attribute__((packed)); char d; };
union pu { char c; int b : 12 __attribute__((packed)); };
struct holder { union pu u; char sentinel; };

#if defined(_WIN32)
#define MS 1
#else
#define MS 0
#endif
#if defined(_WIN32) || (defined(__aarch64__) && !defined(__APPLE__))
#define UNNAMED_SIZE 16
#else
#define UNNAMED_SIZE 10
#endif

int main(void) {
    if (sizeof(struct after) != 16 || _Alignof(struct after) != 8) return 1;
    if (offsetof(struct after, d) != (MS ? 12 : 9)) return 2;
    if (sizeof(struct lead) != (MS ? 16 : 24) || offsetof(struct lead, d) != (MS ? 12 : 17)) return 3;
    if (sizeof(struct packed30) != 6 || _Alignof(struct packed30) != 1) return 4;
    if (offsetof(struct packed30, d) != 5) return 5;
    if (sizeof(struct wide) != 32 || _Alignof(struct wide) != 16) return 6;
    if (offsetof(struct wide, d) != (MS ? 24 : 21)) return 7;
    if (sizeof(struct unnamed) != UNNAMED_SIZE || offsetof(struct unnamed, d) != (MS ? 12 : 9)) return 8;
    if (sizeof(struct gap) != 6 || offsetof(struct gap, d) != 5) return 9;
    if (sizeof(union pu) != (MS ? 4 : 2) || _Alignof(union pu) != 1) return 10;

    // The aligned field opens byte 8 and its unaligned peer follows it.
    struct after a;
    memset(&a, 0, sizeof a);
    a.c = 1;
    a.d = 2;
    a.b = -3;
    a.e = 5;
    if (((unsigned char *)&a)[8] != 0x5d) return 20;
    if (a.c != 1 || a.b != -3 || a.e != 5 || a.d != 2) return 21;

    struct lead l;
    memset(&l, 0, sizeof l);
    l.c = 3;
    l.d = 4;
    l.b = 7;
    l.e = -8;
    if (l.c != 3 || l.b != 7 || l.e != -8 || l.d != 4) return 22;

    struct packed30 p;
    memset(&p, 0, sizeof p);
    p.c = 5;
    p.d = 6;
    p.b = -123456789;
    if (p.c != 5 || p.b != -123456789 || p.d != 6) return 23;
    p.b = 0x1fffffff;
    if (p.c != 5 || p.b != 0x1fffffff || p.d != 6) return 24;

    struct wide w;
    memset(&w, 0, sizeof w);
    w.c = 7;
    w.d = 8;
    w.b = -0x123456789LL;
    if (w.c != 7 || w.b != -0x123456789LL || w.d != 8) return 25;
    if (((unsigned char *)&w)[16] != 0x77) return 26;

    struct unnamed n;
    memset(&n, 0, sizeof n);
    n.c = 9;
    n.d = 10;
    if (n.c != 9 || n.d != 10) return 27;

    // The packed member's bytes are the union's; the next member stays.
    struct holder h;
    memset(&h, 0, sizeof h);
    h.sentinel = 11;
    h.u.b = 0x7ff;
    if (h.u.b != 0x7ff || h.sentinel != 11) return 28;
    h.u.c = 0x12;
    if (h.u.b != 0x712 || h.sentinel != 11) return 29;
    h.u.b = -2048;
    if (h.u.b != -2048 || h.u.c != 0 || h.sentinel != 11) return 30;
    return 0;
}

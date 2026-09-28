// A bit-field takes its declared type's alignment, a typedef's included. In
// GCC's layout the aggregate takes it raised or lowered, the field may not
// cross a boundary of it beyond its type's size, and a field whose type is
// aligned beyond its size moves to that alignment's next boundary; clang,
// and so macOS, leaves such a field in place. The PE targets take the MS
// layout, where only a raise counts. Every write reads back without
// disturbing a neighbour. Each failure returns a distinct code.

#include <stddef.h>
#include <string.h>

typedef int a8 __attribute__((aligned(8)));
typedef int a1 __attribute__((aligned(1)));
typedef long long l4 __attribute__((aligned(4)));
typedef short s8 __attribute__((aligned(8)));

struct raised { char c; a8 b : 3; char d; };
struct lowered { char c; a1 b : 30; char d; };
struct lowered64 { char c; l4 b : 40; char d; };
struct pair { char c; a8 b : 3, e : 30; char d; };
struct shorts { char c; s8 b : 4; char d; };
union lu { char c; a1 b : 3; };
struct holder { union lu u; char sentinel; };

#if defined(_WIN32)
#define MS 1
#define CLANG 0
#elif defined(__APPLE__)
#define MS 0
#define CLANG 1
#else
#define MS 0
#define CLANG 0
#endif

int main(void) {
    if (sizeof(struct raised) != (CLANG ? 8 : 16) || _Alignof(struct raised) != 8) return 1;
    if (offsetof(struct raised, d) != (MS ? 12 : CLANG ? 2 : 9)) return 2;
    if (sizeof(struct lowered) != (MS ? 12 : 6) || _Alignof(struct lowered) != (MS ? 4 : 1)) return 3;
    if (offsetof(struct lowered, d) != (MS ? 8 : 5)) return 4;
    if (sizeof(struct lowered64) != (MS ? 24 : 8) || offsetof(struct lowered64, d) != (MS ? 16 : 6)) return 5;
    if (sizeof(struct pair) != (CLANG ? 16 : 24) || offsetof(struct pair, d) != (CLANG ? 12 : 20)) return 6;
    if (sizeof(struct shorts) != (CLANG ? 8 : 16)) return 7;
    if (offsetof(struct shorts, d) != (MS ? 10 : CLANG ? 2 : 9)) return 8;
    if (sizeof(union lu) != (MS ? 4 : 1) || _Alignof(union lu) != 1) return 9;

    struct raised r;
    memset(&r, 0, sizeof r);
    r.c = 1;
    r.d = 2;
    r.b = -3;
    if (r.c != 1 || r.b != -3 || r.d != 2) return 10;

    struct lowered l;
    memset(&l, 0, sizeof l);
    l.c = 3;
    l.d = 4;
    l.b = -123456789;
    if (l.c != 3 || l.b != -123456789 || l.d != 4) return 11;
    l.b = 0x1fffffff;
    if (l.c != 3 || l.b != 0x1fffffff || l.d != 4) return 12;

    struct lowered64 w;
    memset(&w, 0, sizeof w);
    w.c = 5;
    w.d = 6;
    w.b = -0x123456789LL;
    if (w.c != 5 || w.b != -0x123456789LL || w.d != 6) return 13;

    struct pair p;
    memset(&p, 0, sizeof p);
    p.c = 7;
    p.d = 8;
    p.b = 3;
    p.e = -0x1234567;
    if (p.c != 7 || p.b != 3 || p.e != -0x1234567 || p.d != 8) return 14;

    struct shorts s;
    memset(&s, 0, sizeof s);
    s.c = 9;
    s.d = 10;
    s.b = -8;
    if (s.c != 9 || s.b != -8 || s.d != 10) return 15;

    // A field of the lowered type ends one byte short of the element's end;
    // its access stays inside the element.
    struct lowered arr[2];
    memset(arr, 0, sizeof arr);
    arr[0].d = 12;
    arr[1].c = 13;
    arr[0].b = -1;
    if (arr[0].d != 12 || arr[1].c != 13 || arr[0].b != -1) return 16;

    struct holder h;
    memset(&h, 0, sizeof h);
    h.sentinel = 11;
    h.u.b = -4;
    if (h.u.b != -4 || h.sentinel != 11) return 17;
    return 0;
}

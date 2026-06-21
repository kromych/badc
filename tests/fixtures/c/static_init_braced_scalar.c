// C99 6.7.9p11: a scalar member's initializer may be enclosed in braces.
// Nested aggregates carry this through, the shape produced by macros such
// as Python's PyVarObject_HEAD_INIT (`{ { { refcnt }, type }, size }`).

struct inner { long rc; void *type; };
struct outer { struct inner base; long size; };
struct flat { int x; int *p; };

int g = 7;

struct outer o = { { { (long)(3L << 30) | (5L << 16) }, &g }, 0 };
struct flat f = { {42}, {&g} };

int main(void) {
    if (o.base.rc != ((long)(3L << 30) | (5L << 16))) return 1;
    if (o.base.type != &g) return 2;
    if (f.x != 42) return 3;
    if (f.p != &g) return 4;
    // Block scope too.
    struct flat b = { {9}, {&g} };
    if (b.x != 9 || b.p != &g) return 5;
    return 0;
}

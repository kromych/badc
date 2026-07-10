// An array-of-struct element may be initialized by a single expression of
// the element's struct type (C99 6.7.9p13): the whole object is copied, not
// elided into the first scalar field. The runtime-init path treated a
// struct-typed element as brace elision and stored the source's address into
// the first field, leaving the rest zero. The shape arises in
// `T args[3] = { element, make(i), source };`-style code. Scalar
// brace elision (`{a, b, c, d}` filling consecutive fields) must still fill
// fields in order. Asserted by return code.

#include <stdint.h>

typedef struct {
    void *ptr;
    int64_t tag;
} V;

static V make(int64_t t) {
    V v;
    v.ptr = (void *)0x2222;
    v.tag = t;
    return v;
}

struct Pair {
    int a, b;
};

int main(void) {
    V element = {(void *)0x1111, 1};
    V source = {(void *)0x3333, 3};

    // Whole-struct element copies: lvalues and a struct-returning call.
    V one[1] = {element};
    if (one[0].ptr != (void *)0x1111 || one[0].tag != 1) return 1;

    V many[3] = {element, make(7), source};
    if (many[0].ptr != (void *)0x1111 || many[0].tag != 1) return 2;
    if (many[1].ptr != (void *)0x2222 || many[1].tag != 7) return 3;
    if (many[2].ptr != (void *)0x3333 || many[2].tag != 3) return 4;

    // Trailing positions are zero-filled (C99 6.7.9p21).
    V partial[2] = {element};
    if (partial[1].ptr != (void *)0 || partial[1].tag != 0) return 5;

    // Scalar brace elision is unchanged: values fill fields in order.
    int x = 10;
    struct Pair p[2] = {x, 2, 3, 4};
    if (p[0].a != 10 || p[0].b != 2 || p[1].a != 3 || p[1].b != 4) return 6;

    return 0;
}

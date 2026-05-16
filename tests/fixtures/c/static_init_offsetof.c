// C99 6.6: a constant expression in a static initializer must
// fold at translation time. The standard `offsetof` macro in
// `<stddef.h>` expands to `((size_t)((char*)&((T*)0)->m - (char*)0))`
// -- a chain of casts plus a pointer-difference of an
// address-of-field-on-null. The whole expression must reduce to
// the field's byte offset.
//
// Returns 0 only when every check passes; each failure path
// returns a distinct nonzero code.

#include <stddef.h>

struct s {
    int   a;
    char  b;
    long  c;
    char  pad;
    short d;
};

// Folded at parse time and packed into the data segment as a
// sequence of unsigned char bytes.
static const unsigned char offsets[] = {
    offsetof(struct s, a),
    offsetof(struct s, b),
    offsetof(struct s, c),
    offsetof(struct s, pad),
    offsetof(struct s, d),
};

int main(void) {
    if (offsets[0] != 0)  return 1;
    if (offsets[1] != 4)  return 2;
    if (offsets[2] != 8)  return 3;
    if (offsets[3] != 16) return 4;
    if (offsets[4] != 18) return 5;
    return 0;
}

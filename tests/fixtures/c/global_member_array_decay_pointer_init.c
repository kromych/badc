/* C99 6.3.2.1p3 + 6.6: a file-scope pointer initialized with a bare array
   sub-object of a global (`p = g.member`) decays to the address of the
   member's first element, an address constant. Covers a union member at
   offset 0 and a struct member at a non-zero offset. A pointer-valued
   member instead is a non-constant load and stays rejected. */

struct data {
    int x;
    int y;
};

union store {
    struct data d[2];
    unsigned char page[64];
};

struct outer {
    long header;
    struct data d[2];
};

static union store the_store;
static struct outer o;

struct data *p = the_store.d;
struct data *q = o.d;

int main(void) {
    the_store.d[0].x = 11;
    the_store.d[1].y = 22;
    if (p != &the_store.d[0])
        return 1;
    if (p[0].x != 11 || p[1].y != 22)
        return 2;
    o.d[0].x = 33;
    if (q != &o.d[0] || q[0].x != 33)
        return 3;
    return 0;
}

// C11 6.7.2.1p13: an anonymous struct flattened into the enclosing
// aggregate may take a brace-enclosed sub-initializer that fills its
// members in order. The Win32 LARGE_INTEGER shape (an anonymous struct
// as a union's first member) is the canonical use site.

union U {
    struct {
        unsigned lo;
        int hi;
    };
    long long q;
};

struct S {
    struct {
        int a;
        int b;
    };
    int c;
};

static union U gu = {{7, 9}};
static struct S gs = {{1, 2}, 3};

int main(void) {
    // First member of the union is the anonymous struct.
    if (!(gu.lo == 7 && gu.hi == 9)) return 1;
    // Anonymous struct flattened into a struct, brace-initialized.
    if (!(gs.a == 1 && gs.b == 2 && gs.c == 3)) return 2;
    // The runtime path shares the same aggregate walker.
    union U lu = {{4, 5}};
    if (!(lu.lo == 4 && lu.hi == 5)) return 3;
    struct S ls = {{8, 6}, 2};
    if (!(ls.a == 8 && ls.b == 6 && ls.c == 2)) return 4;
    return 0;
}

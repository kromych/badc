// A function-pointer typedef used to declare several variables in one
// declaration gives every declarator the pointed-to function's return
// type, not just the first. A call through a later declarator whose
// result type defaulted to int would truncate a wider (64-bit) return.

typedef long long (*llfn)(void);
typedef void *(*pfn)(void *);

static long long wide(void) { return 0x123456789LL; }
static void *ident(void *p) { return p; }

int main(void) {
    llfn a, b;
    a = wide;
    b = wide;
    if (a() != 0x123456789LL) return 1;
    if (b() != 0x123456789LL) return 2;

    pfn p, q;
    int x = 0;
    p = ident;
    q = ident;
    if (p(&x) != &x) return 3;
    if (q(&x) != &x) return 4;

    // Struct fields declared in one declaration share the typedef
    // prefix; the second field's call result must keep the return
    // type, too.
    struct {
        llfn f, g;
    } s;
    s.f = wide;
    s.g = wide;
    if (s.f() != 0x123456789LL) return 5;
    if (s.g() != 0x123456789LL) return 6;
    return 0;
}

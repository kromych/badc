// C11 6.5.1.1 generic selection `_Generic`. Covers type dispatch,
// `default`, the unevaluated-non-selected rule, pointer-to-struct
// dispatch, a single-association form, and use in static initializers
// (both integer and address winners). Each check exits with a distinct
// non-zero code on failure; success returns 0.

#define KIND(x) _Generic((x), int: 1, long: 2, double: 3, char *: 4, default: 0)

typedef struct M { int a; } M;
typedef struct S { int b; } S;
#define PICK(x) _Generic((x), M *: 10, S *: 20, default: 99)

int calls;
int touched(void) {
    calls++;
    return -1;
}
int chosen(void) {
    return 7;
}

// Static initializers: integer winner and address winner.
struct Base {
    int tag;
};
struct A {
    struct Base base;
};
struct B {
    struct Base base;
};
struct A opA = {{10}};
struct B opB = {{20}};
#define OUTOP(T, V) _Generic(V, T: &(V).base)

static int int_tab[] = {
    _Generic(0, int: 100, default: 0),
    _Generic(0L, int: 100, long: 200),
};
static const struct Base *const addr_tab[] = {
    OUTOP(struct A, opA),
    OUTOP(struct B, opB),
};

int main(void) {
    int i = 0;
    long l = 0;
    double d = 0;
    char *s = 0;
    if (KIND(i) != 1 || KIND(l) != 2 || KIND(d) != 3 || KIND(s) != 4) {
        return 1;
    }

    // No association matches the controlling type -> default.
    struct M *pm = 0;
    if (KIND(pm) != 0) {
        return 2;
    }

    // Pointer-to-struct dispatch distinguishes distinct struct types.
    M m;
    S sv;
    if (PICK(&m) != 10 || PICK(&sv) != 20 || PICK(i) != 99) {
        return 3;
    }

    // Non-selected associations are not evaluated.
    calls = 0;
    int r = _Generic(i, int: chosen(), default: touched());
    if (r != 7 || calls != 0) {
        return 4;
    }

    // `default` before a matching type name still loses to the match.
    int before = _Generic(i, default: 55, int: 66);
    if (before != 66) {
        return 5;
    }

    // Static initializers.
    if (int_tab[0] != 100 || int_tab[1] != 200) {
        return 6;
    }
    if (addr_tab[0]->tag != 10 || addr_tab[1]->tag != 20) {
        return 7;
    }

    return 0;
}

// C99 6.2.1p4 + 6.2.4p3: a block-scope `static` that shadows a
// same-named file-scope `extern` declaration is a distinct object with
// its own static storage; same-named statics in sibling scopes and in
// different functions are all distinct. A prior bug re-resolved every
// reference through the shared per-name symbol slot after scope exit
// restored the extern binding (the kernel's or51132.c against
// `sections.h`'s `extern char _data[]`), so the emitted object lost
// every definition and carried one undefined `_data` global.
//
// Each check returns a distinct nonzero code; success returns 0.

typedef unsigned char u8;

extern char _data[]; // never referenced; the name collision alone triggered it

static int sink(const u8 *p, int n) {
    int s = 0;
    for (int i = 0; i < n; i++)
        s = s * 16 + p[i];
    return s;
}

// Opaque callee: the address of each array must materialize.
static int (*volatile call)(const u8 *, int) = sink;

// The or51132 shape: same-named statics in statement expressions under
// sibling `if` arms.
static int stmt_expr_arms(int pick) {
    if (pick)
        return ({ static const u8 _data[] = {1, 2}; call(_data, (int)sizeof(_data)); });
    return ({ static const u8 _data[] = {3, 4, 5}; call(_data, (int)sizeof(_data)); });
}

// A function-body static plus same-named statics in `switch` arms.
static int switch_arms(int pick) {
    static const u8 _data[] = {9};
    switch (pick) {
    case 0: {
        static const u8 _data[] = {6, 7};
        return call(_data, 2);
    }
    case 1: {
        static const u8 _data[] = {8};
        return call(_data, 1);
    }
    default:
        return call(_data, 1);
    }
}

// Address forms: a scalar static-pointer initializer, a brace-list
// element, an element address, and a nested same-named shadow.
static int addr_forms(void) {
    static const u8 _data[] = {10, 11, 12};
    static const u8 *p = _data;
    static const u8 *tab[] = {_data, &_data[2]};
    int r = call(p, 3);
    r += call(&_data[1], 2);
    r += call(tab[1], 1);
    {
        static const u8 _data[] = {13};
        r += call(_data, 1);
    }
    r += call(tab[0], 1);
    return r;
}

int main(void) {
    if (stmt_expr_arms(1) != 18)
        return 1;
    if (stmt_expr_arms(0) != 837)
        return 2;
    if (switch_arms(0) != 103)
        return 3;
    if (switch_arms(1) != 8)
        return 4;
    if (switch_arms(2) != 9)
        return 5;
    if (addr_forms() != 2971)
        return 6;
    return 0;
}

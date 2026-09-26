// Argument checking must survive a redeclaration that supplies no
// parameter information of its own (C99 6.2.7p4): the composite type
// keeps the list, so a call past it is still diagnosed.

typedef struct { unsigned val; } wrap;

unsigned take_wrap(wrap w);
unsigned take_wrap(wrap w) { return w.val; }
// Redeclared through the defined function's own type.
extern typeof(take_wrap) take_wrap;

unsigned add2(unsigned a, unsigned b) { return a + b; }
// The empty-list spelling in a non-defining declarator.
unsigned add2();

typedef unsigned noproto_fn();
unsigned add3(unsigned a, unsigned b, unsigned c) { return a + b + c; }
// Redeclared through a function-type typedef with an empty list.
extern noproto_fn add3;

int main(void) {
    wrap w;
    w.val = 1u;
    if (take_wrap(w, 1u, 2u) != 1u) return 1;  // warn: expected 1
    if (add2(1u, 2u, 3u) != 3u) return 2;      // warn: expected 2
    if (add3(1u, 2u, 3u, 4u) != 6u) return 3;  // warn: expected 3
    return 0;
}

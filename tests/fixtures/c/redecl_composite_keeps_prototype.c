// C99 6.2.7p4: the composite type of two compatible declarations of the
// same function keeps the parameter type list. A redeclaration that
// supplies no parameter information of its own -- a declarator through a
// function-type specifier (`typeof(f)`, a function-type typedef), or the
// empty-list spelling in a non-defining declarator (6.7.5.3p14) -- must
// not erase the list a prior declaration or definition established.
//
// The recorded list is also what puts a by-value aggregate argument in
// address form at the call site: with no list the walker loads the
// object's single eightbyte into a machine word instead, so losing it
// changes the lowering of every call to the redeclared function. The SSA
// snapshot pins the form.

typedef struct { unsigned val; } wrap;
typedef struct { unsigned lo, hi; } pairw;

unsigned take_wrap(wrap w);
unsigned take_wrap(wrap w) { return w.val + 1u; }
// Redeclared through the defined function's own type.
extern typeof(take_wrap) take_wrap;

typedef unsigned wrap_fn(wrap);
unsigned take_wrap2(wrap w);
unsigned take_wrap2(wrap w) { return w.val + 2u; }
// Redeclared through a function-type typedef naming the same type.
extern wrap_fn take_wrap2;

// Redeclared through the function type of another function; the specifier
// carries the parameter list, so the first declaration of this name is a
// full prototype.
extern typeof(take_wrap) take_wrap3;
unsigned take_wrap3(wrap w) { return w.val + 3u; }

unsigned long long take_pairw(pairw p);
unsigned long long take_pairw(pairw p) {
    return ((unsigned long long) p.hi << 32) | p.lo;
}
// The empty-list spelling in a non-defining declarator.
unsigned long long take_pairw();

// A name whose first declaration is the empty-list spelling has no
// parameter information; the later prototype supplies it.
unsigned add2();
unsigned add2(unsigned a, unsigned b);
unsigned add2(unsigned a, unsigned b) { return a + b; }

int main(void) {
    wrap w;
    w.val = 41u;
    if (take_wrap(w) != 42u) return 1;
    if (take_wrap2(w) != 43u) return 2;
    if (take_wrap3(w) != 44u) return 3;

    w.val = 0u;
    if (take_wrap(w) != 1u) return 4;

    pairw p;
    p.lo = 0x01234567u;
    p.hi = 0x89abcdefu;
    if (take_pairw(p) != 0x89abcdef01234567ULL) return 5;

    if (add2(20u, 22u) != 42u) return 6;
    return 0;
}

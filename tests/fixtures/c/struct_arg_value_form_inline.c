// A by-value structure argument reaches a call in one of two forms: the
// address of the caller's copy, or -- when the callee's declared
// parameter list is not in scope at the call site -- the object's single
// eightbyte loaded into a machine word. A callee inlined at a value-form
// site reads its parameter's members off the bound operand, so the
// splice has to bind an address in both forms; binding the word makes
// every member read dereference the payload.
//
// `extern typeof(f) f;` after the definition once erased the parameter
// list and put these calls in the value form. The composite type (C99
// 6.2.7p4) keeps the list, so the sites below are the address form and
// pin that: a redeclaration through a function-type specifier must not
// change the lowering of a call to the redeclared function. The
// value-form recovery in the splice stays as the guard for a callee
// whose parameter list the unit never supplies.

typedef struct { unsigned val; } kuid_t;
typedef struct { unsigned char a, b, c; } triple;
typedef struct { unsigned lo, hi; } pair;
typedef struct { unsigned long w[2]; } wide;

static inline unsigned val_of(kuid_t k) { return k.val; }

unsigned take_kuid(kuid_t k);
unsigned take_kuid(kuid_t k) { return val_of(k); }
extern typeof(take_kuid) take_kuid;

unsigned take_triple(triple t);
unsigned take_triple(triple t) {
    return (unsigned) t.a | ((unsigned) t.b << 8) | ((unsigned) t.c << 16);
}
extern typeof(take_triple) take_triple;

unsigned long take_pair(pair p);
unsigned long take_pair(pair p) {
    return ((unsigned long) p.hi << 32) | p.lo;
}
extern typeof(take_pair) take_pair;

// Larger than one eightbyte: stays in address form, so it exercises the
// path the value-form recovery must leave alone.
unsigned long take_wide(wide w);
unsigned long take_wide(wide w) { return w.w[0] + w.w[1]; }
extern typeof(take_wide) take_wide;

static unsigned sink;

int main(void) {
    kuid_t k = {0u};
    if (take_kuid(k) != 0u) return 1;
    k.val = 0xdeadbeefu;
    if (take_kuid(k) != 0xdeadbeefu) return 2;

    // Root's uid is zero, the case where dereferencing the payload
    // faults rather than reading a wrong value.
    for (unsigned i = 0; i < 4u; i++) {
        kuid_t v = {i};
        if (take_kuid(v) != i) return 3;
    }

    triple t = {0x11, 0x22, 0x33};
    if (take_triple(t) != 0x332211u) return 4;

    pair p = {0x01234567u, 0x89abcdefu};
    if (take_pair(p) != 0x89abcdef01234567UL) return 5;

    wide w = {{7UL, 35UL}};
    if (take_wide(w) != 42UL) return 6;

    // The argument's own evaluation must still happen once.
    sink = 0;
    kuid_t s = {5u};
    if (take_kuid(s) != 5u) return 7;
    if (sink != 0u) return 8;
    return 0;
}

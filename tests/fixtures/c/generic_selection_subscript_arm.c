// A `_Generic` association expression that contains a subscript
// (`&obj->arr[i]`) must not confuse the association scanner: the lexer
// emits a distinct token for a subscript `[`, so the balanced-bracket scan
// has to count it or it stops early and reports "no association matches".

typedef struct M { int a; } M;
typedef struct N { int b; } N;
typedef struct L { void *o; } L;

struct H { M ms[4]; N ns[4]; };

static L *as_m(void *p) { (void)p; return (L *) 1; }
static L *as_n(void *p) { (void)p; return (L *) 2; }

#define PICK(x) _Generic((x), \
    L *: (L *)(x), \
    void *: (L *)0, \
    M *: as_m((&(x)[0])), \
    N *: as_n((&(x)[0])))

int main(void) {
    struct H h;
    if (PICK(&h.ms[0]) != (L *) 1) return 1;   /* M* arm */
    if (PICK(&h.ns[2]) != (L *) 2) return 2;   /* N* arm */
    return 0;
}

// A function pointer held in static storage and initialized with a function
// name must compare equal to that function's address (C99 6.5.9p6: two
// pointers compare equal if they point to the same function). The value must
// also be callable. This has to hold for a plain global, a struct member, and
// an array element, and it must agree with a pointer produced by a runtime
// store of the same function reference.

int f(void) { return 7; }
int g(void) { return 9; }

int (*gp)(void) = f;                     // global, static initializer
struct S { int (*fp)(void); };
struct S s = { g };                      // struct member, static initializer
int (*tab[2])(void) = { f, g };          // array, static initializers

int main(void) {
    // Identity: a static-initialized function pointer equals the symbol.
    if (gp != f) return 1;
    if (s.fp != g) return 2;
    if (tab[0] != f || tab[1] != g) return 3;

    // Callable through each static-initialized pointer.
    if (gp() != 7) return 4;
    if (s.fp() != 9) return 5;
    if (tab[0]() != 7 || tab[1]() != 9) return 6;

    // Agreement with a runtime store of the same reference.
    int (*lp)(void) = f;
    if (lp != gp || lp != tab[0]) return 7;
    gp = g;
    if (gp != g || gp != s.fp || gp != tab[1]) return 8;
    if (gp() != 9) return 9;

    // Distinct functions stay distinct.
    if (f == g) return 10;
    return 0;
}

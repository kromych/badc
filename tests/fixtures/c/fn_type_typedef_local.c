// A pointer to a function-type typedef is a function pointer (one level),
// distinct from a pointer to a function-pointer typedef (two levels).
// C99 6.7.7 / 6.3.2.1. The first `*` over a function-type typedef forms
// the pointer-to-function; over a function-pointer typedef it adds a
// level. Exercised through a local variable, including a struct return.

typedef struct {
    long u;
    long tag;
} V;

// Function-TYPE typedef.
typedef V VFunc(int);
// Function-POINTER typedef.
typedef V (*VFuncPtr)(int);

static V make(int x) {
    V v = {x, x * 2};
    return v;
}

int main(void) {
    // Pointer to a function-type typedef == a function pointer; the call
    // returns the struct.
    VFunc *f = make;
    V r = f(7);
    if (r.u != 7 || r.tag != 14) return 1;

    // The bare function-type typedef as a variable also decays to a
    // function pointer.
    VFunc *g = make;
    if (g(3).u != 3) return 2;

    // A function-pointer typedef variable calls directly.
    VFuncPtr p = make;
    if (p(4).tag != 8) return 3;

    // A pointer to a function-pointer typedef is two levels: dereference
    // once to reach the function pointer.
    VFuncPtr *pp = &p;
    if ((*pp)(5).u != 5) return 4;
    return 0;
}

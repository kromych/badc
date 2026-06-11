// A struct returned by value from a call through a function pointer
// follows the same return ABI as a direct call (AAPCS64 6.9 / System V
// AMD64 3.2.3 / Win64). An 8-byte aggregate is register-returned on
// every target, so this runs on all native lanes. Larger aggregates use
// the same path on AAPCS64 and SysV; the Win64 out-pointer class for an
// indirect return is a separate case.

typedef struct {
    int a;
    int b;
} Pair;

static Pair make(int x) {
    Pair p = {x, x * 2};
    return p;
}

// Function pointer held in a struct field, the common dispatch-table
// shape.
typedef struct {
    Pair (*fn)(int);
} Table;

int main(void) {
    // Through a plain function-pointer variable.
    Pair (*fp)(int) = make;
    Pair r = fp(7);
    if (r.a != 7 || r.b != 14) return 1;

    // Through a struct-field function pointer.
    Table t;
    t.fn = make;
    Pair s = t.fn(10);
    if (s.a != 10 || s.b != 20) return 2;

    // The result feeds straight into an expression.
    if (fp(3).a + t.fn(3).b != 3 + 6) return 3;
    return 0;
}

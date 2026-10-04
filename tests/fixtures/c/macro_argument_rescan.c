// Locks C99 6.10.3.4: the substituted body of a function-like
// macro is rescanned for further macro replacement. When a
// macro parameter receives a function-like macro name as its
// argument and that name only becomes a call after substitution
// (the source token following the parameter is `(`, supplied
// inside the body), the rescan must fire it.
//
// A dispatch macro `op_arith(L, add_int, num_add)` whose body has
// `iop(L, iv1, imm)` relies on this: `iop` gets substituted with
// `add_int`, which is itself a function-like macro
// `intop(+, a, b)`. Without the rescan the emitted source still reads
// `add_int(L, iv1, imm)` and the compiler reports an unknown function.

#define ADD(a, b) ((a) + (b))
#define SUB(a, b) ((a) - (b))
#define APPLY(op, x, y) op(x, y)
#define APPLY2(f, op, x, y) f(op, x, y)

int main(void) {
    if (APPLY(ADD, 3, 4) != 7) return 1;
    if (APPLY(SUB, 10, 6) != 4) return 2;
    if (APPLY2(APPLY, ADD, 100, 23) != 123) return 3;
    return 0;
}

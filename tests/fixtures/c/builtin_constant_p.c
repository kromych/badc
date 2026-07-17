/* GCC `__builtin_constant_p(x)`: an `int`, 1 when the operand folds to a
 * compile-time constant, else 0. The operand is unevaluated. It must be
 * usable in a constant-expression context -- driving `__builtin_choose_expr`
 * to pick a compile-time branch, sizing an array, or feeding a
 * `_Static_assert` -- so a stub that always reports 0 silently disables
 * every such compile-time test. */
#include <limits.h>

/* Constant operands fold to 1, and the result is itself a constant
 * expression usable by `_Static_assert`. */
_Static_assert(__builtin_constant_p(42) == 1, "an integer literal is constant");
_Static_assert(__builtin_constant_p(1 + 2 * 3) == 1, "constant arithmetic folds");
_Static_assert(__builtin_constant_p(INT_MAX) == 1, "a macro constant folds");

/* A non-constant operand reports 0 even in a constant-expression context,
 * and the surrounding fold continues: the transient "not a constant" state
 * must not leak out and poison the outer expression. */
static int global_obj;
_Static_assert(__builtin_constant_p(global_obj) == 0, "a global is not constant");
_Static_assert(__builtin_constant_p(global_obj) + 5 == 5, "0 folds; outer expr still folds");

/* The builtin as `__builtin_choose_expr`'s condition (a constant
 * expression): a constant operand selects the first arm at compile time. */
#define PICK(x) __builtin_choose_expr(__builtin_constant_p(x), 111, 222)
_Static_assert(PICK(7) == 111, "constant operand selects the first arm");

int main(void) {
    /* Constant operands report 1. */
    if (__builtin_constant_p(100) != 1) return 1;
    if (__builtin_constant_p(2 << 10) != 1) return 2;
    /* A runtime operand reports 0 and is not evaluated. */
    volatile int rt = 7;
    if (__builtin_constant_p(rt) != 0) return 3;
    if (rt != 7) return 4;
    /* The result is an `int`. */
    if (sizeof(__builtin_constant_p(1)) != sizeof(int)) return 5;
    if (global_obj != 0) return 6;
    /* A constant-expression array dimension driven by the builtin folds. */
    int dim_probe[__builtin_constant_p(100) + 1];
    if (sizeof(dim_probe) / sizeof(dim_probe[0]) != 2) return 7;
    /* choose_expr picks the runtime arm for a non-constant operand and the
     * constant arm for a constant one. */
    if (PICK(rt) != 222) return 8;
    if (PICK(50) != 111) return 9;
    return 0;
}

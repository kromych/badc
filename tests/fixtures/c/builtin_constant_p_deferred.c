// __builtin_constant_p answers late: 0 before the SSA folds run, and 1
// once inlining substitutes a constant argument. Every assertion below
// holds in both modes, so the exit code is 0 with and without -O.

// Kept out of line so the guard's runtime arm stays a real call.
static int slow_double(int n) { return n + n; }

// Both arms compute the same value: the guard resolves differently per
// mode while the result does not.
static inline int dbl(int n) {
    return __builtin_constant_p(n) ? n * 2 : slow_double(n);
}

static inline int is_const(int x) { return __builtin_constant_p(x); }
static inline int is_const_nested(int x) { return is_const(x); }

int main(void) {
    int rc = 0;
    volatile int rt = 21;
    int touched = 0;

    // A parse-time constant answers 1 in every mode.
    if (__builtin_constant_p(7) != 1) rc |= 1;
    if (__builtin_constant_p(3 + 4) != 1) rc |= 2;
    if (__builtin_constant_p(1.5) != 1) rc |= 4;

    // A volatile object is never a constant, through an inline call too.
    if (__builtin_constant_p(rt) != 0) rc |= 8;
    if (is_const(rt) != 0) rc |= 16;
    if (is_const_nested(rt) != 0) rc |= 32;

    // The operand is unevaluated: a side effect in it never happens.
    if (__builtin_constant_p(touched++) != 0) rc |= 64;
    if (touched != 0) rc |= 128;

    // The answer is 0 or 1 and nothing else, whichever mode resolves it.
    if ((unsigned)is_const(9) > 1u) rc |= 256;

    // Agreeing guard arms: the constant argument takes the folded arm
    // under -O and the call arm without it, for the same value.
    if (dbl(9) != 18) rc |= 512;
    if (dbl(rt) != 42) rc |= 1024;

    return rc;
}

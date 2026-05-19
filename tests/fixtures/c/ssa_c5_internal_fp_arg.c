/* C99 6.7.6.3 / 6.5.2.2: a function with a `double` parameter
   reads it from the argument-passing slot the caller laid down.
   c5's internal calling convention routes every argument through
   integer arg registers as its raw 8-byte bit pattern -- the
   callee's prologue spills only the int_arg_regs into its
   cdecl slots, so the SSA emit's caller-side marshalling at
   `Op::Jsr` must not route an FP value through xmm registers
   (which the System V C ABI would). The exposed bug: lua's
   LTfloatint(double f, long long i) computed `f < (double)i`
   off the spill of an uninitialised xmm0 -> rdi byte pattern. */

#include <stdio.h>

static int lt_float_int(double f, long long i) {
    return f < (double)i;
}

static int le_float_int(double f, long long i) {
    return f <= (double)i;
}

int main(int argc, char **argv) {
    (void)argv;
    long long n = 100 + argc - argc;
    double half = 50.5 + (argc - argc);
    if (lt_float_int(half, n) != 1) return 1;
    if (lt_float_int(150.5, n) != 0) return 2;
    if (le_float_int((double)n, n) != 1) return 3;
    if (le_float_int((double)n + 0.5, n) != 0) return 4;
    printf("OK\n");
    return 0;
}

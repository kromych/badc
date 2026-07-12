// C99 6.2.1p4: an inner-scope declaration that reuses an outer name
// hides it for the inner scope only; the outer binding reappears
// unchanged at scope exit. A function-pointer parameter or block-scope
// local that reuses a function name must not replace the function's
// recorded signature -- a leaked non-variadic prototype would misroute
// the variadic tail on stack-packing ABIs.
#include <stdarg.h>

static int sum(int n, ...) {
    va_list ap;
    int s = 0, i;
    va_start(ap, n);
    for (i = 0; i < n; i++) {
        s += va_arg(ap, int);
    }
    va_end(ap);
    return s;
}

// Prototype whose fn-ptr parameters shadow `sum` and `exit` with
// unrelated non-variadic signatures.
void uses_fnptr_param(int (*sum)(int a, int b), void (*exit)(long code));

// Block-scope fn-ptr local shadowing `sum` with yet another signature.
static int shadow_in_block(void) {
    long (*sum)(long x);
    sum = 0;
    return sum == 0 ? 1 : 0;
}

int main(void) {
    if (shadow_in_block() != 1) {
        return 1;
    }
    // The variadic call must still pass its tail per the variadic ABI.
    if (sum(3, 10, 20, 30) != 60) {
        return 2;
    }
    return 0;
}

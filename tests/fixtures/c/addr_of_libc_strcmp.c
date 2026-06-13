// Taking the address of an integer-returning library function (strcmp) and
// calling through the pointer. Unlike the floating-point libm case, strcmp
// takes and returns integers, exercising the integer-register address-of
// import path. The address resolves to the import's shared PLT stub, so a
// call through the pointer computes the same result as a direct call
// (C99 6.5.2.2). Asserted by return code.
//
// Run under the native and JIT paths only. The SSA interpreter resolves
// library calls by name and does not call a library function through a
// pointer taken from its address.

#include <string.h>

int main(void) {
    int (*cmp)(const char *, const char *) = strcmp;

    if (cmp("abc", "abc") != 0) return 1;
    if (cmp("abc", "abd") >= 0) return 2;
    if (cmp("abd", "abc") <= 0) return 3;

    // A direct call must agree with the call through the pointer.
    if (strcmp("xy", "xy") != cmp("xy", "xy")) return 4;

    return 0;
}

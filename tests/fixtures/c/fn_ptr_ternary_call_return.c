// Calling a function pointer produced by an expression rather than a
// declared variable -- here a conditional selecting one of two
// functions -- must use the callee's real return type. A bare function
// name decays to a pointer whose result type is the function's return
// type (C99 6.3.2.1p4); a non-`int` return must not narrow to `int`.
// Surfaced by CPython's `(field_present ? f : g)(&spec)` returning a
// truncated `PyObject *`.

#include <stdio.h>

__attribute__((noinline)) static void *fa(void *x) { return x; }
__attribute__((noinline)) static void *fb(void *x) { return x; }
__attribute__((noinline)) static long ga(long x) { return x + 1; }
__attribute__((noinline)) static long gb(long x) { return x + 2; }

int main(void) {
    void *p = (void *) 0x123456789ULL;
    int cond = 1;
    // Pointer return: must keep all 64 bits.
    void *r = (cond ? fa : fb)(p);
    // Wide integer return through the same shape.
    long n = (cond ? ga : gb)(0x1234567890L);
    if (r != p) {
        printf("FAIL r=%p\n", r);
        return 1;
    }
    if (n != 0x1234567891L) {
        printf("FAIL n=%ld\n", n);
        return 2;
    }
    printf("ok r=%p n=%ld\n", r, n);
    return 0;
}

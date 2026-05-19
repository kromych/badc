// SSA-emit regression: x86_64 VaArg / VaStart / VaCopy used RAX as
// the scratch for the cursor-advance, but the SSA allocator
// includes RAX in its caller_gprs pool. When the allocator parked
// the va_arg result in RAX, the subsequent `lea rax, [rd+16]`
// overwrote the just-loaded cursor with cursor+16 before it could
// be returned. Pool path was unaffected because it pinned the
// cursor in r10 and read it back out of there.
//
// The visible symptom: a variadic loop summing N longs returned
// 10 + 20 + <stack residue> instead of 10 + 20 + 30. Switching the
// scratch to r10 (outside both SSA pool banks on SysV and Win64)
// fixes it. VaStart and VaCopy had the same aliasing risk and
// were repaired in the same change.

#include <stdarg.h>

static long var_sum(int n, ...) {
    va_list ap;
    va_start(ap, n);
    long s = 0;
    int i;
    for (i = 0; i < n; i++) s += va_arg(ap, long);
    va_end(ap);
    return s;
}

static long var_one(int n, ...) {
    va_list ap;
    va_start(ap, n);
    long r = va_arg(ap, long);
    va_end(ap);
    return r;
}

int main(void) {
    if (var_sum(3, 10L, 20L, 30L) != 60) return 1;
    if (var_sum(5, 1L, 2L, 3L, 4L, 5L) != 15) return 2;
    if (var_one(1, 42L) != 42) return 3;
    return 0;
}

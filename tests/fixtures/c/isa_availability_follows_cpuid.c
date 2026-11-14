// The MSVC runtime's `__isa_available` and `__isa_enabled`, which code
// compiled for it reads: the highest level of <isa_availability.h> the
// processor and the OS support, and one bit per level from SSE2 up. Exits
// 0 when they agree with CPUID; off Windows/x86-64 the unit checks nothing.

#if defined(_WIN32) && defined(__x86_64__)
#include <intrin.h>

extern int __isa_available;
extern long __isa_enabled;

int main(void) {
    int r[4];
    __cpuid(r, 1);
    long enabled = __isa_enabled;
    if (!(enabled & 1 << 1) || (enabled & 1) || (enabled >> 7))
        return 1;
    if (!(enabled & 1 << 2) != !(r[2] & 1 << 20))
        return 2;
    if ((enabled & 1 << 3) && !(r[2] & 1 << 28))
        return 3;
    int top = 6;
    while (!(enabled & 1L << top))
        top--;
    return __isa_available == top ? 0 : 4;
}
#else
int main(void) { return 0; }
#endif

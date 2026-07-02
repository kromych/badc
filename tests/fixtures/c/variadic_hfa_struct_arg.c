/* A variadic HFA composite: Windows aarch64 passes it in the integer
   bank (SIMD/FP registers are unavailable to variadic composites).
   TODO: the AAPCS64/SysV register-save va_arg reads every aggregate
   from the general area; an HFA composite rides the vector area and
   needs per-member composition, so this fixture is not yet registered
   for the native_elf / native_elf_x64 lanes. */
#include <stdarg.h>

struct P { double x, y; };

static double sum(int n, ...) {
    va_list ap;
    va_start(ap, n);
    struct P p = va_arg(ap, struct P);
    va_end(ap);
    return p.x + p.y;
}

int main(void) {
    struct P p;
    p.x = 1.5;
    p.y = 2.25;
    return sum(1, p) == 3.75 ? 0 : 1;
}

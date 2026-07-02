#include <stdarg.h>
#include <stdio.h>

struct S { long x, y; };

/* Seven eightbyte-consuming named+leading variadic args leave one GPR
   in the save area; the two-eightbyte struct then straddles and must
   come from the overflow stack (AAPCS64 B.5), as must the tail. */
static long take(int n, ...) {
    va_list ap;
    va_start(ap, n);
    for (int i = 0; i < 6; i++) {
        (void)va_arg(ap, long);
    }
    struct S s = va_arg(ap, struct S);
    long tail = va_arg(ap, long);
    va_end(ap);
    if (s.x != 111 || s.y != 222) return 1;
    if (tail != 777) return 2;
    return 0;
}

int main(void) {
    struct S s;
    s.x = 111;
    s.y = 222;
    return (int)take(1, 2L, 3L, 4L, 5L, 6L, 7L, s, 777L);
}

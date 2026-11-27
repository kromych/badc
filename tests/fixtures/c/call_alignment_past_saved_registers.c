// snapshot-budget: exempt
/* A function whose frame is only its saved registers keeps the stack
   16-byte aligned at its calls (System V AMD64 3.2.2), for an odd and an
   even number of values live across them. The callee checks an
   `_Alignas(16)` local and formats a double. The exit code names the
   first function with a misaligned call. */

#include <stdint.h>
#include <stdio.h>

#define NOINLINE __attribute__((noinline))

NOINLINE int aligned_here(double d) {
    _Alignas(16) volatile char buf[32];
    int n = snprintf((char *)buf, sizeof buf, "%.3f", d);
    return ((uintptr_t)buf & 15) == 0 && n == 5;
}

NOINLINE long live1(long a) { return aligned_here(1.5) + aligned_here(2.5) + a; }

NOINLINE long live2(long a, long b) { return aligned_here(1.5) + aligned_here(2.5) + a + b; }

NOINLINE long live3(long a, long b, long c) {
    return aligned_here(1.5) + aligned_here(2.5) + a + b + c;
}

NOINLINE long live4(long a, long b, long c, long d) {
    return aligned_here(1.5) + aligned_here(2.5) + a + b + c + d;
}

NOINLINE long live5(long a, long b, long c, long d, long e) {
    return aligned_here(1.5) + aligned_here(2.5) + a + b + c + d + e;
}

NOINLINE long live6(long a, long b, long c, long d, long e, long f) {
    return aligned_here(1.5) + aligned_here(2.5) + a + b + c + d + e + f;
}

int main(void) {
    if (live1(1) != 3)
        return 1;
    if (live2(1, 2) != 5)
        return 2;
    if (live3(1, 2, 3) != 8)
        return 3;
    if (live4(1, 2, 3, 4) != 12)
        return 4;
    if (live5(1, 2, 3, 4, 5) != 17)
        return 5;
    if (live6(1, 2, 3, 4, 5, 6) != 23)
        return 6;
    return 0;
}

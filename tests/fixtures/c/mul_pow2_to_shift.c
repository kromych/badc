// Mul by a positive power of two collapses to a left shift in
// `Build::binop_imm`. The result must be byte-identical to the
// underlying multiplication for signed and unsigned operands;
// C99 6.5.5 specifies the result of `*` on overflow as UB for
// signed and modulo-2^N for unsigned, which is what `<<` produces.
#include <stdio.h>

int main(void) {
    int x  = 7;
    unsigned int ux = 7u;
    long lx = 7L;
    unsigned long ulx = 7UL;

    int a = x * 2;        // 14
    int b = x * 4;        // 28
    int c = x * 8;        // 56
    int d = x * 16;       // 112
    int e = x * 1024;     // 7168
    unsigned int ua = ux * 2;     // 14
    unsigned int ub = ux * 256;   // 1792
    long la = lx * 32;            // 224
    unsigned long ula = ulx * 65536UL; // 458752

    long total = a + b + c + d + e + ua + ub + la + (long)ula;
    // 14+28+56+112+7168+14+1792+224+458752 = 468160
    printf("%ld\n", total);
    return total == 468160L ? 0 : 1;
}

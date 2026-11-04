/* A 32-bit division whose operands become constants late at -O, after a
   copy is forwarded: the divisor `(g.a ^ g.b) - -20u` is 20 in unsigned
   arithmetic (C99 6.2.5p9), and the quotient and remainder are those of
   the 32-bit values, for the unsigned and the int forms. */

struct pair { unsigned a, b; };
int e;

__attribute__((noinline)) static unsigned urem(void) {
    struct pair f = { e, e }, g = f;
    return 87 % ((g.a ^ g.b) - -20u);
}

__attribute__((noinline)) static unsigned udiv(void) {
    struct pair f = { e, e }, g = f;
    return 1000u / ((g.a ^ g.b) - -20u);
}

__attribute__((noinline)) static unsigned udiv_wide(void) {
    struct pair f = { e, e }, g = f;
    return 0xfffffff0u / ((g.a ^ g.b) + 0x10u);
}

__attribute__((noinline)) static int sdiv(void) {
    struct pair f = { e, e }, g = f;
    return -87 / (int)((g.a ^ g.b) + 4u);
}

__attribute__((noinline)) static int srem(void) {
    struct pair f = { e, e }, g = f;
    return -87 % (int)((g.a ^ g.b) + 4u);
}

int main(void) {
    if (urem() != 7)
        return 1;
    if (udiv() != 50)
        return 2;
    if (udiv_wide() != 0xfffffffu)
        return 3;
    if (sdiv() != -21)
        return 4;
    if (srem() != -3)
        return 5;
    return 0;
}

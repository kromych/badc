/* C99 6.5.16.2p3: `E1 op= E2` computes `E1 op E2`, so divide and
   remainder run in the 6.3.1.8 common type of both operands -- at
   its width and signedness -- and the result converts back to E1's
   type. `unsigned x /= -2` divides 0xFFFFFFFF by 0xFFFFFFFE at 32
   bits; `int x /= 2u` divides unsigned. */
int main(void) {
    unsigned q = 0xffffffffu;
    q /= -2;
    if (q != 1) {
        return 1;
    }
    unsigned q2 = 0xffffffffu;
    q2 %= -2;
    if (q2 != 1) {
        return 2;
    }
    int d = -2;
    d /= 2u;
    if (d != 2147483647) {
        return 3;
    }
    int e = -7;
    e %= 3;
    if (e != -1) {
        return 4;
    }
    /* 64-bit unsigned lvalue: full-width divide, no masking. */
    unsigned long long big = 0xFFFFFFFFFFFFFFFFULL;
    big /= 3;
    if (big != 6148914691236517205ULL) {
        return 5;
    }
    /* Sub-int unsigned lvalue promotes to signed int: 255 / -2. */
    unsigned char uc = 255;
    uc /= -2;
    if (uc != 129) {
        return 6;
    }
    return 0;
}

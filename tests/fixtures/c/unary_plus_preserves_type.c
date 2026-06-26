/* C99 6.5.3.3p2: unary `+` yields the integer-promoted operand type. An
   operand of rank int or above keeps its type, so the width and
   signedness survive; forcing `int` would run a following relational or
   width-sensitive operator on the wrong type. */

int main(void) {
    unsigned long z = 0;
    signed char y = -1;
    /* C99 6.3.1.8: y converts to unsigned long (0xFFFF...FFFF), so the
       comparison is unsigned and 0 >= that is false. */
    if ((+z >= y) != 0) {
        return 1;
    }
    /* The plain comparison is already unsigned; both must agree. */
    if ((z >= y) != 0) {
        return 2;
    }
    long long w = 0x100000000LL;
    /* Unary + must keep the 64-bit width, not truncate to int. */
    if (+w != 0x100000000LL) {
        return 3;
    }
    return 0;
}

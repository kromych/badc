// A constant condition reads a signed operand of an unsigned operator as
// the unsigned common type (C99 6.3.1.8p1, 6.3.1.3p2): -2 is 0xFFFFFFFE as
// an `unsigned int`, so 4294967295u >= -2 holds, 4294967295u / -2 is 1 and
// 4294967295u % -2 is 1. Each condition selects a branch, a `?:` arm or a
// loop trip at translation time and must agree with the same operator on
// variables. The exit status is the number of the first check that fails.
int main(void) {
    volatile unsigned big = 4294967295u;
    volatile int neg2 = -2;
    if (4294967295u >= -2) {
    } else {
        return 1;
    }
    if (!(4294967295u >= -2))
        return 2;
    if (((4294967295u >= -2) ? 1 : 2) != 1)
        return 3;
    if (!(-2 <= 4294967294u))
        return 4;
    if (!(4294967295u / -2))
        return 5;
    if ((4294967295u % -2) != 1)
        return 6;
    if (((4294967295u / -2) ? 3 : 4) != 3)
        return 7;
    for (; 4294967295u < -2;)
        return 8;
    if ((0u > -1) != 0 || (1u < -1) != 1)
        return 9;
    if ((4294967295u >= -2) != (big >= (unsigned)neg2) || (4294967295u % -2) != big % neg2)
        return 10;
    return 0;
}

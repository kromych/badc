/* C99 6.5.9p3 + 6.5.8p6: when an operand of an equality or
   relational operator is NaN, the operator yields 0 for `==`, `<`,
   `<=`, `>`, `>=` and 1 for `!=`. ucomisd signals an unordered
   compare by setting ZF=PF=CF=1, so a bare `setb` / `sete` /
   `setbe` would disagree with the standard. The SSA emit's FP
   compare must AND the result with `setnp` (parity-flag clear)
   for ordered comparisons and OR with `setp` for `!=`. */

#include <stdio.h>

static double nan_value(void) {
    double zero = 0.0;
    return zero / zero;
}

int main(void) {
    double n = nan_value();
    int fail = 0;
    if (n < 0.0)   fail |= 0x01;   /* < NaN */
    if (n > 0.0)   fail |= 0x02;   /* > NaN */
    if (n <= 0.0)  fail |= 0x04;   /* <= NaN */
    if (n >= 0.0)  fail |= 0x08;   /* >= NaN */
    if (n == 0.0)  fail |= 0x10;   /* == NaN */
    if (!(n != 0.0)) fail |= 0x20; /* != NaN must be true */
    if (n < n)     fail |= 0x40;   /* NaN < NaN */
    if (n == n)    fail |= 0x80;   /* NaN == NaN */
    if (fail) {
        printf("FAIL mask=0x%x\n", fail);
        return 1;
    }
    printf("OK\n");
    return 0;
}

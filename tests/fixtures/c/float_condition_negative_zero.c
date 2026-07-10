// A floating value used as a controlling expression is compared against
// 0.0 (C99 6.8.4.1 / 6.8.5 / 6.5.13 / 6.5.14): `-0.0` is false because
// `-0.0 == 0.0`. Testing the register bits directly would read the
// sign bit and treat `-0.0` as true, hanging `while (-0.0)`. A real-world
// shape is a `while (m)` loop over a `-0.0` constant, which must
// terminate on the first test.

#include <stdio.h>

int main(void) {
    double nz = -0.0;
    double z = 0.0;
    int fails = 0;

    if (nz) fails |= 1;          /* if */
    if (!(z == nz)) fails |= 2;  /* -0.0 == 0.0 */

    int iters = 0;
    while (nz) {                 /* must not loop */
        if (++iters > 2) break;
    }
    if (iters != 0) fails |= 4;

    for (; nz;) { fails |= 8; break; }  /* for */

    int t = nz ? 1 : 0;          /* conditional */
    if (t != 0) fails |= 16;

    if (nz && 1) fails |= 32;    /* && operand */
    if (nz || 0) fails |= 64;    /* || operand */

    if (fails) {
        printf("FAIL mask=%d\n", fails);
        return 1;
    }
    printf("ok\n");
    return 0;
}

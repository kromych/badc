/* An unsigned remainder `n % i` of int values converted to unsigned
   (C99 6.3.1.3p2: -1 becomes UINT_MAX), lowered to `n - (n / i) * i`
   with a 32-bit division whose operands no longer carry their zero
   extension, and rebuilt as one remainder once an address computation
   reads the result. The rebuilt remainder divides the 32-bit values. */

#include <stdio.h>

int b, d, n;
int c[8];
int i = 7;

static inline __attribute__((always_inline)) void index_by(unsigned f) {
    for (unsigned g = 0; g < 8; g++)
        b = c[f & (4 & d) & 7];
}

int main(void) {
    for (unsigned g = 0; g < 8; g++)
        n = -1;
    unsigned acc = n;
    acc = acc % i;
    index_by(acc);
    printf("%u\n", acc);
    return acc != 3;
}

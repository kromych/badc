// C99 7.12.11.3 nextafter: the next representable value after x toward
// y. 7.12.6.5 ilogb: the integer exponent of x (floor(log2|x|) for a
// normal value).
#include <math.h>

int main(void) {
    if (nextafter(1.0, 2.0) <= 1.0) return 1;
    if (nextafter(1.0, 0.0) >= 1.0) return 2;
    if (nextafter(1.0, 1.0) != 1.0) return 3;
    if (ilogb(8.0) != 3) return 4;
    if (ilogb(1.0) != 0) return 5;
    if (ilogb(0.25) != -2) return 6;
    if (nextafterf(1.0f, 2.0f) <= 1.0f) return 7;
    if (ilogbf(16.0f) != 4) return 8;
    return 0;
}

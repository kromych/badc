// C99 7.12.9.3/4 nearbyint / rint round to an integer value in
// floating-point format under the current (round-to-nearest-even)
// mode; 7.12.9.7 lround / llround round halfway cases away from zero
// and return an integer type.
#include <math.h>

int main(void) {
    if (nearbyint(2.5) != 2.0) return 1;
    if (nearbyint(3.5) != 4.0) return 2;
    if (rint(2.5) != 2.0) return 3;
    if (lround(2.5) != 3) return 4;
    if (lround(-2.5) != -3) return 5;
    if (lround(2.4) != 2) return 6;
    if (llround(1000000000000LL + 0.5) != 1000000000001LL) return 7;
    if (nearbyintf(2.5f) != 2.0f) return 8;
    if (rintf(3.5f) != 4.0f) return 9;
    return 0;
}

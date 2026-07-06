// C99 6.5.2.2p6: a `float` argument to a variadic function undergoes
// the default argument promotion to `double`; an `f`-suffixed literal
// (6.4.4.2p4) rides the same path. The formatted text pins the exact
// promoted values, including the single-precision rounding of 0.1f.

#include <stdio.h>
#include <string.h>

int main(void) {
    char buf[64];
    snprintf(buf, sizeof buf, "%.1f %.8f", 1.5f, 0.1f);
    if (strcmp(buf, "1.5 0.10000000") != 0) return 1;
    return 0;
}

// C99 7.20.1.3: strtof converts the initial portion of the string, sets
// *endp past the consumed prefix and returns a `float`.

#include <stdlib.h>

int main(void) {
    char *end;
    double v = strtof("3.5xyz", &end);
    if (v != 3.5) {
        return 1;
    }
    if (*end != 'x') {
        return 2;
    }
    if (strtof("-0.25", 0) != -0.25) {
        return 3;
    }
    return 0;
}

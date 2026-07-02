// C99 7.20.1.3: strtof converts the initial portion of the string and
// sets *endp past the consumed prefix. c5 aliases `float` to `double`,
// so the header binds strtof to the target's double-returning strtod;
// a binding to libc's float-returning strtof leaves the wrong register
// width behind the double-typed prototype.

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

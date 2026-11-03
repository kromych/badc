#include <string.h>

// -Wint-conversion is an error by default, as in gcc 14; the pragma
// lowers it to the warning this fixture checks.
#pragma GCC diagnostic warning "-Wint-conversion"

int main() {
    int *p;
    p = 5; // warn: integer assigned to pointer (5 isn't NULL)
    return 0;
}

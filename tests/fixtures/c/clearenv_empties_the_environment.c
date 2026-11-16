// glibc's clearenv, which its <stdlib.h> declares, removes every variable
// from the environment. Linux only; elsewhere the fixture returns 0.
// Asserted by return code.

#include <stdlib.h>

int main(void) {
#ifdef __linux__
    if (setenv("BADC_CLEARENV_PROBE", "1", 1) != 0) return 1;
    if (clearenv() != 0) return 2;
    if (getenv("BADC_CLEARENV_PROBE") != NULL) return 3;
    if (setenv("BADC_CLEARENV_PROBE", "2", 1) != 0) return 4;
    const char *v = getenv("BADC_CLEARENV_PROBE");
    if (v == NULL || v[0] != '2') return 5;
#endif
    return 0;
}

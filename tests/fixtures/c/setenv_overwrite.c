#include <stdlib.h>

// POSIX setenv (IEEE Std 1003.1): overwrite==0 leaves an existing
// binding untouched; overwrite!=0 replaces it. Verified through getenv.
int main(void) {
    setenv("BADC_T_SETENV_OW", "first", 1);
    setenv("BADC_T_SETENV_OW", "second", 0); /* must not clobber */
    if (getenv("BADC_T_SETENV_OW")[0] != 'f') {
        return 1;
    }
    setenv("BADC_T_SETENV_OW", "third", 1); /* must clobber */
    if (getenv("BADC_T_SETENV_OW")[0] != 't') {
        return 2;
    }
    return 0;
}

#include <stdlib.h>

#ifdef _WIN32
// Windows declares no setenv (mingw-w64 does not), so a portable program
// supplies its own over the C runtime's _putenv_s.
static int setenv(const char *name, const char *value, int overwrite) {
    if (!overwrite && getenv(name)) {
        return 0;
    }
    return _putenv_s(name, value);
}
#endif

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

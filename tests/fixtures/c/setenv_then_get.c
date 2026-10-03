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

int main() {
    char *v;
    setenv("C4RS_TEST_SETENV", "Z", 1);
    v = getenv("C4RS_TEST_SETENV");
    if (v == 0) return 1;
    return v[0]; // 'Z' = 90
}

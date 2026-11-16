// On Windows x64, msvcrt.dll exports `_environ` as data, so `&_environ` is
// the address of the vector getenv searches. Exits 0 when the vector read
// through that address holds an entry getenv finds; elsewhere the unit
// checks nothing.

#include <stdlib.h>
#include <string.h>

int main(void) {
#if defined(_WIN32) && defined(__x86_64__)
    char ***p = &_environ;
    if (*p != _environ || !*p || !**p)
        return 1;
    const char *entry = **p, *eq = strchr(entry, '=');
    if (!eq || eq == entry)
        return 2;
    char name[256];
    size_t n = (size_t)(eq - entry);
    if (n >= sizeof name)
        return 0;
    memcpy(name, entry, n);
    name[n] = 0;
    const char *value = getenv(name);
    return value && strcmp(value, eq + 1) == 0 ? 0 : 3;
#else
    return 0;
#endif
}

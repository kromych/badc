// dlopen(NULL) opens the global symbol scope: dlsym on its handle, and on
// RTLD_DEFAULT, finds a function of a library the program has loaded; a name
// no module defines yields NULL and a dlerror text; dlclose releases it.
#include <dlfcn.h>
#include <stddef.h>

typedef size_t (*length_fn)(const char *);

int main(void) {
    void *scope = dlopen(NULL, RTLD_NOW);
    if (!scope)
        return 1;
    length_fn len = (length_fn)dlsym(scope, "strlen");
    if (!len || len("global") != 6)
        return 2;
    len = (length_fn)dlsym(RTLD_DEFAULT, "strlen");
    if (!len || len("scope") != 5)
        return 3;
    dlerror();
    if (dlsym(scope, "no_module_defines_this_name") || !dlerror())
        return 4;
    return dlclose(scope) == 0 ? 0 : 5;
}

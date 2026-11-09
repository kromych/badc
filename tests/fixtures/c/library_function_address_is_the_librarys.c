// A C-library function's address, taken in code and stored in a static
// slot, is one address (C99 6.5.9p6), and on POSIX the one the library
// exports, as dlsym reports it. Windows binds an import to its module and
// two modules may export the name, so there the slot is compared with
// code's address alone. Exits 0 when the addresses agree.

#include <dlfcn.h>
#include <stdio.h>

int (*slot)(const char *) = puts;

int main(void) {
#ifndef _WIN32
    void *exported = dlsym(RTLD_DEFAULT, "puts");
    if (!exported)
        return 1;
    if ((void *)puts != exported)
        return 2;
#endif
    return (void *)slot == (void *)puts ? 0 : 3;
}

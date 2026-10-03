// POSIX <dlfcn.h> results: dlclose returns 0 on success, and dlerror
// reports a failed dlopen or dlsym once, as text without a newline, then
// returns NULL until the next failure; successful calls report nothing.
// The exit code names the first check that fails.
#include <dlfcn.h>
#include <string.h>

#if defined(_WIN32)
#define LIB "kernel32.dll"
#define SYM "GetTickCount"
#elif defined(__APPLE__)
#define LIB "/usr/lib/libSystem.B.dylib"
#define SYM "getpid"
#else
#define LIB "libc.so.6"
#define SYM "getpid"
#endif

static int reported(const char *text) { return text && *text && !strchr(text, '\n'); }

int main(void) {
    void *h;
    if (dlopen("badc-no-such-library.so", RTLD_NOW)) return 1;
    if (!reported(dlerror())) return 2;
    if (dlerror()) return 3;
    h = dlopen(LIB, RTLD_NOW);
    if (!h) return 4;
    if (!dlsym(h, SYM)) return 5;
    if (dlerror()) return 6;
    if (dlsym(h, "badc_no_such_symbol")) return 7;
    if (!reported(dlerror())) return 8;
    if (dlerror()) return 9;
    if (dlclose(h) != 0) return 10;
    if (dlerror()) return 11;
    return 0;
}

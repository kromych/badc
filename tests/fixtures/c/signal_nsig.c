// <signal.h> must define NSIG to the host libc's value. Code sizes
// per-signal tables by it (`T table[NSIG]`), so a wrong value shifts
// every field placed after such a table in a containing struct, and a
// badc object disagrees with a system-toolchain object on that struct's
// layout. Darwin counts through SIGUSR2 (32), glibc reserves the
// realtime range (65), the Windows CRT stops at SIGABRT (23).

#include <signal.h>

int main(void) {
#if defined(__APPLE__)
    if (NSIG != 32) return 1;
#elif defined(__linux__)
    if (NSIG != 65) return 2;
    if (_NSIG != 65) return 3;
#elif defined(_WIN32)
    if (NSIG != 23) return 4;
#endif
    // A table sized by NSIG must place a trailing field at the host's
    // offset, not 512 bytes off (a wrong NSIG desynchronizes the layout
    // of any struct that embeds such a table).
    struct { int slot[NSIG]; long after; } t;
    if ((char *) &t.after - (char *) &t < (long) (NSIG * sizeof(int)))
        return 5;
    return 0;
}

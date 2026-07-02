/* A static initializer naming a variadic libc function resolves to the
   sys trampoline; the trampoline must forward the variadic tail (stack
   region, and al on System V), which only a frameless jump preserves. */
#include <stdio.h>
#include <string.h>

typedef int (*psn)(char *, unsigned long, const char *, ...);
psn table[2] = { snprintf, snprintf };

int main(void) {
    char buf[64];
    buf[0] = 0;
    table[1](buf, sizeof buf, "%d %s %d", 42, "mid", 99);
    if (strcmp(buf, "42 mid 99") != 0) {
        return 1;
    }
    return 0;
}

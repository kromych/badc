/* A call through a cast fn-pointer type uses the cast's prototype
   (C99 6.5.2.2p7): the variadic tail must marshal per the host
   variadic convention even when the pointer's declared type says
   nothing (the sqlite-style syscall dispatch table shape). */
#include <stdio.h>
#include <string.h>

typedef void (*fnp)(void);
static fnp table[1] = { (fnp)snprintf };

int main(void) {
    char buf[32];
    buf[0] = 0;
    int n = ((int (*)(char *, unsigned long, const char *, ...))table[0])(
        buf, sizeof buf, "%d %s %d", 4, "mid", 9);
    if (n != 7) {
        return 1;
    }
    if (strcmp(buf, "4 mid 9") != 0) {
        return 2;
    }
    return 0;
}

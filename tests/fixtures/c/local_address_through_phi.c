// A local array's address that is the base of an indexed store and also the
// value a join takes: the join's copy reads the address from its register.

#include <string.h>

static char *last;

__attribute__((noinline)) static long fill(char *b, long n) {
    memcpy(b, "/usr/bin/tool", 13);
    return n > 13 ? 13 : n;
}

__attribute__((noinline)) static char *keep(char *s) {
    last = s;
    return s;
}

__attribute__((noinline)) static int dir_length(const char *fallback) {
    char *p = 0;
    char buf[64];
    long n = fill(buf, sizeof buf - 1);
    if (n > 0) {
        buf[n] = 0;
        p = buf;
    }
    if (!p && fallback)
        p = keep((char *)fallback);
    return p ? (int)strlen(keep(p)) : -1;
}

int main(void) {
    return dir_length("x") == 13 && last != 0 ? 0 : 1;
}

// C99 7.19.6.5p3: on truncation snprintf returns the length the
// output would have had and NUL-terminates what fits (size > 0);
// with size 0 nothing is written. 7.19.6.12p3 gives vsnprintf the
// same contract. msvcrt's _snprintf / _vsnprintf return -1 and omit
// the NUL, so on Windows the standard spellings resolve to the
// conforming wrappers in the auto-linked runtime.

#include <stdio.h>
#include <string.h>
#include <stdarg.h>

static int wrap(char *buf, int size, char *fmt, ...) {
    va_list ap;
    int n;
    va_start(ap, fmt);
    n = vsnprintf(buf, size, fmt, ap);
    va_end(ap);
    return n;
}

int main(void) {
    char buf[8];
    memset(buf, 'A', sizeof(buf));
    if (snprintf(buf, 4, "%d", 123456) != 6) {
        return 1;
    }
    if (strcmp(buf, "123") != 0) {
        return 2;
    }
    if (snprintf(0, 0, "%s", "hello") != 5) {
        return 3;
    }
    memset(buf, 'A', sizeof(buf));
    if (wrap(buf, 4, "%d", 987654) != 6) {
        return 4;
    }
    if (strcmp(buf, "987") != 0) {
        return 5;
    }
    if (snprintf(buf, 8, "%d", 42) != 2 || strcmp(buf, "42") != 0) {
        return 6;
    }
    return 0;
}

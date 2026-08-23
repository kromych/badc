// Locks the overlapping element copy against the memcpy rewrite. An
// ascending loop whose destination sits above its source re-reads the
// bytes it already wrote and replicates a pattern; `memcpy` has no such
// result (C99 7.21.2.1 forbids overlapping objects) and `memmove` would
// copy the original bytes instead. Both directions and the same-array
// subscript form are checked.
//
// Each failure returns a distinct nonzero code.

#include <string.h>

static char buf[32];

// Destination above the source: every read past the overlap sees a
// byte this loop already stored.
static void copy_up(char *d, const char *s, int n) {
    for (int i = 0; i < n; i++) {
        d[i] = s[i];
    }
}

// Destination below the source: the ascending order reads each byte
// before any store can reach it.
static void copy_down(char *d, const char *s, int n) {
    for (int i = 0; i < n; i++) {
        d[i] = s[i];
    }
}

// The same array through one name, at a fixed distance.
static void replicate(int dist, int n) {
    for (int i = 0; i < n; i++) {
        buf[i + dist] = buf[i];
    }
}

int main(void) {
    memset(buf, 0, sizeof buf);
    memcpy(buf, "abc", 3);
    copy_up(buf + 3, buf, 9);
    if (memcmp(buf, "abcabcabcabc", 12) != 0) {
        return 1;
    }

    memset(buf, 0, sizeof buf);
    memcpy(buf, "0123456789", 10);
    copy_down(buf, buf + 3, 7);
    if (memcmp(buf, "3456789789", 10) != 0) {
        return 2;
    }

    memset(buf, 0, sizeof buf);
    memcpy(buf, "xy", 2);
    replicate(2, 10);
    if (memcmp(buf, "xyxyxyxyxyxy", 12) != 0) {
        return 3;
    }
    return 0;
}

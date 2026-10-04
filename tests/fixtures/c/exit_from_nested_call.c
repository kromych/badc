// exit from a nested call ends the program after the atexit handlers have
// run (C99 7.20.4.3), and `_exit` from a handler ends it at once with its own
// status (POSIX). The exit status is 3: a skipped handler leaves 2, and a
// return from main 4 or 5.
#include <stdlib.h>
#include <unistd.h>

static void handler(void) { _exit(3); }

static int descend(int n) {
    volatile char frame[64];
    frame[0] = (char)n;
    if (n == 0)
        exit(2);
    return descend(n - 1) + frame[0];
}

int main(void) {
    atexit(handler);
    return descend(8) == 0 ? 4 : 5;
}

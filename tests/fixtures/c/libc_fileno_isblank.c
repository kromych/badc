// POSIX.1 fileno: the file descriptor backing a stream (1 for stdout,
// 2 for stderr in a fresh process). C99 7.4.1.3 isblank: space or
// horizontal tab in the C locale, provided inline.
#include <stdio.h>
#include <ctype.h>

int main(void) {
    if (fileno(stdout) != 1) return 1;
    if (fileno(stderr) != 2) return 2;
    if (!isblank(' ')) return 3;
    if (!isblank('\t')) return 4;
    if (isblank('A')) return 5;
    if (isblank('\n')) return 6;
    return 0;
}

#include <stdlib.h>

// Octal integer literals (`0644` is octal `420`, not decimal
// `644`). Until #58's lexer fix, c5 read every leading-zero
// number as decimal and silently passed wrong file modes /
// permission bits / sqlite-flag constants. sqlite's own VFS
// uses `osOpen(zPath, flags, 0644)` to create database files,
// so this regression made every newly-created sqlite db come
// out with mode `1204` (decimal `644` re-encoded as octal)
// instead of `0644`.
//
// Each `0644`-style literal here is checked against the
// hand-computed decimal equivalent so a future regression
// shows up immediately.

int main() {
    if (0644 != 420) return 1;
    if (0777 != 511) return 2;
    if (0100 != 64) return 3;
    if (00 != 0) return 4;
    if (07 != 7) return 5;
    // Mixed octal + bitwise still works.
    if ((0644 | 0100) != 0744) return 6;
    if ((0644 & 0700) != 0600) return 7;
    if (~0644 != ~420) return 8;
    return 42;
}

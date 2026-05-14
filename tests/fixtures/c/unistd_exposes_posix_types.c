// Locks the POSIX-2017 contract: `<unistd.h>` makes `ssize_t`,
// `size_t`, `off_t`, `pid_t`, `uid_t`, `gid_t` visible. POSIX
// allows the header to satisfy the contract by including
// `<sys/types.h>` and every shipping libc does it that way; c5
// follows the same arrangement.
//
// Returns 0 only when every check passes; each failure path
// returns a distinct nonzero code so a regression points at the
// failing type.

#include <unistd.h>

int main(void) {
    ssize_t  n   = -1;
    size_t   sz  = 1;
    off_t    off = 2;
    pid_t    pid = 3;
    uid_t    uid = 4;
    gid_t    gid = 5;

    // The types must be wide enough for their POSIX contracts:
    // ssize_t / off_t are pointer-width (8 bytes on every c5
    // target); pid_t / uid_t / gid_t are 4 bytes.
    if (sizeof(n)   != 8) return 11;
    if (sizeof(sz)  != 8) return 12;
    if (sizeof(off) != 8) return 13;
    if (sizeof(pid) != 4) return 14;
    if (sizeof(uid) != 4) return 15;
    if (sizeof(gid) != 4) return 16;
    return 0;
}

// Bundled POSIX headers used by Unix programs: sys/select.h (the fd_set type
// and its bitmap macros), grp.h (struct group), and sys/utsname.h (struct
// utsname; POSIX only, so its check is excluded on Windows). Sizes that are
// identical on every target are asserted; the fd_set macros are exercised.
// Asserted by return code.

#include <stddef.h>
#include <sys/select.h>
#include <grp.h>
#ifndef _WIN32
#include <sys/utsname.h>
#endif

int main(void) {
    if (sizeof(fd_set) != 128) return 1;
    fd_set fds;
    FD_ZERO(&fds);
    FD_SET(3, &fds);
    FD_SET(40, &fds);
    if (!FD_ISSET(3, &fds) || !FD_ISSET(40, &fds)) return 2;
    if (FD_ISSET(4, &fds)) return 3;
    FD_CLR(3, &fds);
    if (FD_ISSET(3, &fds)) return 4;

    if (sizeof(struct group) != 32) return 5;
    if (offsetof(struct group, gr_gid) != 16) return 6;
    if (offsetof(struct group, gr_mem) != 24) return 7;

#ifndef _WIN32
    // struct utsname's per-field length is target-specific, but the fields are
    // always present and writable.
    struct utsname u;
    u.sysname[0] = 'x';
    u.nodename[0] = 'y';
    if (u.sysname[0] != 'x' || u.nodename[0] != 'y') return 8;
#endif
    return 0;
}

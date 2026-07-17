// sysconf(_SC_PAGESIZE) must return the system page size. The numeric
// _SC_PAGESIZE selector differs between Darwin (29) and Linux (30); a
// wrong value makes glibc/Darwin return a garbage result, which breaks
// callers that align to the page size (e.g. memory-mapped I/O). The
// page size is a positive power of two -- 4096 on Linux, 16384 on macOS
// arm64.
//
// The full sysconf(3) selector table must be present, not just the few
// selectors a given program happened to need: code that builds a name
// table whose entries are each gated on `#ifdef _SC_*` silently drops a
// name when a selector is missing, so a later lookup of that name fails.
#include <unistd.h>

#if !defined(_SC_ARG_MAX) || !defined(_SC_CHILD_MAX) || \
    !defined(_SC_CLK_TCK) || !defined(_SC_NGROUPS_MAX) || \
    !defined(_SC_OPEN_MAX) || !defined(_SC_IOV_MAX) || \
    !defined(_SC_NPROCESSORS_CONF) || !defined(_SC_NPROCESSORS_ONLN) || \
    !defined(_SC_PAGESIZE) || !defined(_SC_VERSION) || \
    !defined(_SC_GETPW_R_SIZE_MAX) || !defined(_SC_TTY_NAME_MAX)
#error "sysconf selector table incomplete"
#endif

// confstr(3) and pathconf(3) selectors share the same table machinery and
// the same header gap.
#if !defined(_CS_PATH) || !defined(_PC_LINK_MAX) || \
    !defined(_PC_NAME_MAX) || !defined(_PC_PATH_MAX)
#error "confstr/pathconf selector table incomplete"
#endif

int main(void) {
    long pg = sysconf(_SC_PAGESIZE);
    if (pg <= 0) {
        return 1;
    }
    if ((pg & (pg - 1)) != 0) {
        return 2;
    }
    if (pg < 4096 || pg > 1048576) {
        return 3;
    }
    // _SC_IOV_MAX is 1024 on both Darwin and Linux; a wrong selector value
    // would make libc return -1 (unsupported) or a garbage figure.
    long iov = sysconf(_SC_IOV_MAX);
    if (iov < 16) {
        return 4;
    }
    // A few more limits the table must now expose, all strictly positive.
    if (sysconf(_SC_OPEN_MAX) <= 0) {
        return 5;
    }
    if (sysconf(_SC_NPROCESSORS_ONLN) <= 0) {
        return 6;
    }
    if (sysconf(_SC_CLK_TCK) <= 0) {
        return 7;
    }
    // pathconf selector reaches libc: _PC_NAME_MAX of the root is positive.
    if (pathconf("/", _PC_NAME_MAX) <= 0) {
        return 8;
    }
    return 0;
}

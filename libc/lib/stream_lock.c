// A msvcrt.dll stream's lock on Windows, which exports no _lock_file: as its
// stdio and mingw-w64's do, _lock(16 + n) and _IOLOCKED for the n-th of the
// twenty static streams, else the CRITICAL_SECTION after the FILE. Elsewhere
// the file is empty; the link offers it like an archive member.

#ifdef _WIN32

#include <stddef.h>
#include <stdio.h>
#include <windows.h>

#pragma dylib(msvcrt, "msvcrt.dll")
#pragma binding(msvcrt::__c5_msvcrt_lock, "_lock")
#pragma binding(msvcrt::__c5_msvcrt_unlock, "_unlock")
void __c5_msvcrt_lock(int locknum);
void __c5_msvcrt_unlock(int locknum);

struct iobuf {
    char *ptr;
    int cnt;
    char *base;
    int flag;
    int file;
    int charbuf;
    int bufsiz;
    char *tmpfname;
};

static int static_stream(FILE *f) {
    ptrdiff_t d = (char *)f - (char *)__iob_func();
    if (d < 0 || d >= 20 * (ptrdiff_t)sizeof(struct iobuf) || d % sizeof(struct iobuf))
        return -1;
    return (int)(d / (ptrdiff_t)sizeof(struct iobuf));
}

void __c5_lock_stream(FILE *f) {
    int n = static_stream(f);
    if (n < 0) {
        EnterCriticalSection((CRITICAL_SECTION *)((struct iobuf *)f + 1));
        return;
    }
    __c5_msvcrt_lock(16 + n);
    ((struct iobuf *)f)->flag |= 0x8000;
}

void __c5_unlock_stream(FILE *f) {
    int n = static_stream(f);
    if (n < 0) {
        LeaveCriticalSection((CRITICAL_SECTION *)((struct iobuf *)f + 1));
        return;
    }
    ((struct iobuf *)f)->flag &= ~0x8000;
    __c5_msvcrt_unlock(16 + n);
}

#endif

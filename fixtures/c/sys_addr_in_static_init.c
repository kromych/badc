// Address of a libc binding inside a static struct
// initializer. sqlite's `aSyscall[]` table is the in-the-wild
// shape: a static array of `{ name, fn-ptr, default-fn-ptr }`
// where each `fn-ptr` is the address of a libc symbol (open,
// close, read, lstat, ...). Until #58's per-Sys trampoline
// fix, c5 wrote `0` into every `sqlite3_syscall_ptr` slot --
// any `osOpen(...)` / `osClose(...)` macro then dispatched
// through a NULL function pointer and SIGSEGV'd on first use.
//
// The fixture mimics the structure: a 3-field struct with a
// NULL slot in the middle (matches sqlite's
// `posix_fallocate`-not-available conditional). Calls each
// non-NULL slot through a function-pointer cast and validates
// the result. The trailing /etc/hosts read confirms the
// trampoline forwards args + return values correctly through
// JsrExt's macOS-arm64 register packing.

#include <stdlib.h>
#include <unistd.h>
#include <stdio.h>

typedef int (*sys_ptr)();

struct entry {
    char *name;
    sys_ptr current;
    sys_ptr def;
};

static struct entry calls[] = {
    { "open",   (sys_ptr)open,   0 },
    { "close",  (sys_ptr)close,  0 },
    { "access", (sys_ptr)access, 0 },
    { "no_op",  (sys_ptr)0,      0 },
    { "read",   (sys_ptr)read,   0 },
};

#define osOpen   ((int(*)(char *, int, int))calls[0].current)
#define osClose  ((int(*)(int))calls[1].current)
#define osAccess ((int(*)(char *, int))calls[2].current)
#define osRead   ((int(*)(int, char *, int))calls[4].current)

int main(void) {
    if (osAccess("/etc/hosts", 4) != 0) { return 1; }
    int fd = osOpen("/etc/hosts", 0, 0);
    if (fd < 0) { return 2; }
    char buf[4];
    int n = osRead(fd, buf, 4);
    osClose(fd);
    if (n != 4) { return 3; }
    return 42;
}

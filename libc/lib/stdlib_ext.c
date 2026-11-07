// aligned_alloc, quick_exit and at_quick_exit, and mkstemp and mkdtemp, on
// the Windows targets, which msvcrt does not define; mkstemp and mkdtemp as
// libmingwex defines them over msvcrt: the template's trailing run of six or
// more X's takes random letters and digits until `_open` or `_mkdir` creates
// the name. Elsewhere the file is empty; the link offers it like an archive
// member.

#ifdef _WIN32

#include <errno.h>
#include <fcntl.h>
#include <io.h>
#include <stdlib.h>
#include <string.h>

#pragma dylib(msvcrt, "msvcrt.dll")
#pragma binding(msvcrt::rand_s, "rand_s")
int rand_s(unsigned int *value);

#define ATTEMPTS 65536

// The start of the trailing X's, or NULL with EINVAL when fewer than six.
static char *run_of_xs(char *templ) {
    size_t len = templ ? strlen(templ) : 0;
    char *x;
    if (len < 6 || memcmp(templ + len - 6, "XXXXXX", 6)) {
        errno = EINVAL;
        return NULL;
    }
    for (x = templ + len - 6; x > templ && x[-1] == 'X'; x--)
        ;
    return x;
}

static void fill(char *x) {
    static const char letters[] =
        "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    for (; *x; x++) {
        unsigned int r;
        if (rand_s(&r))
            r = (unsigned int)rand();
        *x = letters[r % (sizeof letters - 1)];
    }
}

int mkstemp(char *templ) {
    char *x = run_of_xs(templ);
    int i;
    for (i = 0; x && i < ATTEMPTS; i++) {
        int fd;
        fill(x);
        fd = _open(templ, O_RDWR | O_CREAT | O_EXCL | O_BINARY, 0600);
        if (fd >= 0 || errno != EEXIST)
            return fd;
    }
    return -1;
}

char *mkdtemp(char *templ) {
    char *x = run_of_xs(templ);
    int i;
    for (i = 0; x && i < ATTEMPTS; i++) {
        fill(x);
        if (mkdir(templ) == 0)
            return templ;
        if (errno != EEXIST)
            return NULL;
    }
    return NULL;
}


// C17 7.22.3.1: msvcrt's `malloc` returns blocks aligned to 16 on both
// targets, which `free` releases; it has no block of a wider alignment that
// `free` can release, so such an alignment is refused as 7.22.3.1p3 allows.
void *aligned_alloc(size_t alignment, size_t size) {
    if (alignment == 0 || (alignment & (alignment - 1)) || alignment > 16) {
        errno = EINVAL;
        return NULL;
    }
    return malloc(size);
}

// C17 7.22.4.3 and 7.22.4.7: at least 32 handlers, run last first by
// `quick_exit`, which then ends the process as `_Exit` does.
#define QUICK_EXIT_HANDLERS 32
static void (*quick_handlers[QUICK_EXIT_HANDLERS])(void);
static int quick_count;
static _Atomic int quick_lock;

int at_quick_exit(void (*handler)(void)) {
    int registered = 0;
    while (__atomic_exchange_n(&quick_lock, 1, __ATOMIC_ACQUIRE))
        ;
    if (quick_count < QUICK_EXIT_HANDLERS) {
        quick_handlers[quick_count++] = handler;
        registered = 1;
    }
    __atomic_store_n(&quick_lock, 0, __ATOMIC_RELEASE);
    return !registered;
}

_Noreturn void quick_exit(int status) {
    while (__atomic_exchange_n(&quick_lock, 1, __ATOMIC_ACQUIRE))
        ;
    int n = quick_count;
    __atomic_store_n(&quick_lock, 0, __ATOMIC_RELEASE);
    while (n > 0)
        quick_handlers[--n]();
    _Exit(status);
}

#endif

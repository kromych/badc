// mkstemp and mkdtemp on the Windows targets, as libmingwex defines them over
// msvcrt: the template's trailing run of six or more X's takes random letters
// and digits until `_open` or `_mkdir` creates the name. Elsewhere the file is
// empty; the link offers it like an archive member.

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

#endif

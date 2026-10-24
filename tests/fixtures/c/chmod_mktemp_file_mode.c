// mktemp replaces a template's trailing XXXXXX with a name no file has,
// and chmod clears and sets the owner's write permission, which stat
// reports: POSIX on Unix, and the CRT's read-only attribute on Windows,
// where mingw-w64's <io.h> declares both under these names.

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/stat.h>
#include <unistd.h>

static int owner_writes(const char *name) {
#ifdef _WIN32
    // TODO(#1651): struct stat is not msvcrt's there; _stati64's struct is.
    struct _stati64 st;
    if (_stati64(name, &st))
        return -1;
#else
    struct stat st;
    if (stat(name, &st))
        return -1;
#endif
    return (st.st_mode & 0200) != 0;
}

int main(void) {
    char name[] = "chmodXXXXXX";
    FILE *f;
    if (mktemp(name) != name || !strcmp(name, "chmodXXXXXX") || strlen(name) != 11)
        return 1;
    if (!(f = fopen(name, "w")))
        return 2;
    fclose(f);
    if (chmod(name, 0400) || owner_writes(name) != 0)
        return 3;
    if (chmod(name, 0600) || owner_writes(name) != 1)
        return 4;
    return remove(name) ? 5 : 0;
}

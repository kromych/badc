// macOS chflags(2) with the SDK's st_flags bits: UF_IMMUTABLE set on a file
// reads back through stat's unsigned st_flags and refuses an open for
// writing; clearing the flags with fchflags lets the file be removed. Other
// targets have no file flags and run an empty main.
#ifdef __APPLE__
#include <errno.h>
#include <fcntl.h>
#include <stdlib.h>
#include <sys/stat.h>
#include <unistd.h>

int main(void) {
    char path[] = "/tmp/badc_chflags_XXXXXX";
    struct stat st;
    int fd = mkstemp(path), r = 0;

    if (fd < 0) return 1;
    if ((UF_SETTABLE & UF_IMMUTABLE) == 0 || (SF_SETTABLE & SF_IMMUTABLE) == 0) r = 2;
    else if (chflags(path, UF_IMMUTABLE | UF_NODUMP) != 0) r = 3;
    else if (stat(path, &st) != 0) r = 4;
    else if ((st.st_flags & (UF_IMMUTABLE | UF_NODUMP)) != (UF_IMMUTABLE | UF_NODUMP)) r = 5;
    else if ((__typeof__(st.st_flags))-1 < 0 || sizeof st.st_flags != 4) r = 6;
    else if (open(path, O_WRONLY) >= 0 || errno != EPERM) r = 7;
    if (fchflags(fd, 0) != 0 && r == 0) r = 8;
    if (lchflags(path, 0) != 0 && r == 0) r = 9;
    close(fd);
    if (unlink(path) != 0 && r == 0) r = 10;
    return r;
}
#else
int main(void) { return 0; }
#endif

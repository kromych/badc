// On Windows struct stat and struct _stat have msvcrt's _stat64i32 layout,
// which stat, fstat, _stat and _wstat fill: a 16-bit mode at offset 6, a
// 32-bit size at 20 and 64-bit times from 24. struct _stati64 and struct
// stat64 have _stat64's, with a 64-bit size at 24.

#ifdef _WIN32
#include <fcntl.h>
#include <io.h>
#include <stddef.h>
#include <stdio.h>
#include <sys/stat.h>
#include <wchar.h>

int main(void) {
    struct stat st;
    struct _stat sb;
    struct _stati64 si;
    struct stat64 s64;
    FILE *f;
    int fd, rc = 0;
    if (sizeof st != 48 || sizeof sb != 48 || sizeof si != 56 || sizeof s64 != 56)
        return 1;
    if (offsetof(struct stat, st_mode) != 6 || offsetof(struct stat, st_size) != 20 ||
        offsetof(struct stat, st_mtime) != 32)
        return 2;
    if (offsetof(struct _stati64, st_size) != 24 || offsetof(struct _stati64, st_mtime) != 40)
        return 3;
    if (!(f = fopen("stat_probe.txt", "wb")))
        return 4;
    fwrite("abc", 1, 3, f);
    fclose(f);
    if (stat("stat_probe.txt", &st) || !S_ISREG(st.st_mode) || st.st_size != 3 ||
        st.st_mtime <= 0)
        rc = 5;
    else if (_stat("stat_probe.txt", &sb) || sb.st_size != 3 ||
             (sb.st_mode & _S_IFMT) != _S_IFREG)
        rc = 6;
    else if (_stati64("stat_probe.txt", &si) || si.st_size != 3 || si.st_mtime != st.st_mtime)
        rc = 7;
    else if (_wstat(L"stat_probe.txt", &sb) || sb.st_size != 3)
        rc = 8;
    else if ((fd = _open("stat_probe.txt", _O_RDONLY)) < 0)
        rc = 9;
    else {
        if (fstat(fd, &st) || st.st_size != 3 || !S_ISREG(st.st_mode))
            rc = 10;
        _close(fd);
    }
    remove("stat_probe.txt");
    if (rc)
        return rc;
    if (mkdir("stat_probe.dir"))
        return 11;
    if (stat("stat_probe.dir", &st) || !S_ISDIR(st.st_mode) || S_ISREG(st.st_mode))
        rc = 12;
    else if (stat64("stat_probe.dir", &s64) || !S_ISDIR(s64.st_mode))
        rc = 13;
    rmdir("stat_probe.dir");
    return rc;
}
#else
int main(void) { return 0; }
#endif

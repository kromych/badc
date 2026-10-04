// utime sets a file's modification time, which stat reads back. On Windows
// <utime.h> also carries the C runtime's _utime and struct _utimbuf, as
// mingw-w64's does, which set it the same way. The exit code names the
// first check that fails.
#include <stdio.h>
#include <stdlib.h>
#include <sys/stat.h>
#include <time.h>
#include <unistd.h>
#include <utime.h>

static char path[512];

static long long mtime_of(void) {
#ifdef _WIN32
    struct _stati64 st;
    if (_stati64(path, &st) != 0) return -1;
#else
    struct stat st;
    if (stat(path, &st) != 0) return -1;
#endif
    return (long long)st.st_mtime;
}

int main(void) {
    const char *tmp = getenv("TMPDIR");
    struct utimbuf t = {1000000000, 1200000000};
    FILE *f;
    int rc = 0;
    if (!tmp) tmp = getenv("TEMP");
    if (!tmp) tmp = "/tmp";
    snprintf(path, sizeof path, "%s/badc_utime_%ld_%d", tmp, (long)time(NULL), rand());
    if (!(f = fopen(path, "w"))) return 1;
    fclose(f);
    if (utime(path, &t) != 0) rc = 2;
    if (!rc && mtime_of() != 1200000000) rc = 3;
#ifdef _WIN32
    {
        struct _utimbuf u = {1100000000, 1300000000};
        if (!rc && _utime(path, &u) != 0) rc = 4;
        if (!rc && mtime_of() != 1300000000) rc = 5;
    }
#endif
    unlink(path);
    return rc;
}

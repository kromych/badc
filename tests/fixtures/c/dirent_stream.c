// A directory stream lists what a directory holds: in a fresh directory of
// two files, readdir returns ".", ".." and both names once each, rewinddir
// and seekdir return to the positions telldir gave, and opendir refuses a
// missing path (ENOENT) and a file (ENOTDIR). Windows takes mingw-w64's
// <dirent.h>, which libc/lib/dirent_ext.c defines. The exit code names the
// first check that fails.
#include <dirent.h>
#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <unistd.h>
#if defined(_WIN32)
#define MKDIR(p) mkdir(p)
#else
#include <sys/stat.h>
#define MKDIR(p) mkdir(p, 0700)
#endif

static char dir[512], path[600];

static const char *in_dir(const char *name) {
    snprintf(path, sizeof path, "%s/%s", dir, name);
    return path;
}

// The entries a read to the end returns: a bit per expected name, and the
// count of entries.
static int scan(DIR *d, int *seen) {
    int n = 0;
    struct dirent *e;
    *seen = 0;
    while ((e = readdir(d)) != NULL) {
        n++;
        if (!strcmp(e->d_name, ".")) *seen |= 1;
        if (!strcmp(e->d_name, "..")) *seen |= 2;
        if (!strcmp(e->d_name, "one.txt")) *seen |= 4;
        if (!strcmp(e->d_name, "two.dat")) *seen |= 8;
    }
    return n;
}

int main(void) {
    const char *tmp = getenv("TMPDIR");
    FILE *f;
    DIR *d;
    int seen, rc = 0;
    long mark;
    struct dirent *e;
    if (!tmp) tmp = getenv("TEMP");
    if (!tmp) tmp = "/tmp";
    snprintf(dir, sizeof dir, "%s/badc_dirent_%ld_%d", tmp, (long)time(NULL), rand());
    if (MKDIR(dir) != 0) return 1;
    if (!(f = fopen(in_dir("one.txt"), "w"))) return 2;
    fclose(f);
    if (!(f = fopen(in_dir("two.dat"), "w"))) return 3;
    fclose(f);

    if (!(d = opendir(dir))) {
        rc = 4;
    } else {
        if (scan(d, &seen) != 4 || seen != 15) rc = 5;
        rewinddir(d);
        if (!rc && (scan(d, &seen) != 4 || seen != 15)) rc = 6;
        rewinddir(d);
        if (!rc && !(e = readdir(d))) rc = 7;
        mark = telldir(d);
        if (!rc && !(e = readdir(d))) rc = 8;
        if (!rc) {
            char second[260];
            strcpy(second, e->d_name);
            seekdir(d, mark);
            e = readdir(d);
            if (!e || strcmp(e->d_name, second)) rc = 9;
        }
        if (closedir(d) != 0 && !rc) rc = 10;
    }
    errno = 0;
    if (!rc && (opendir(in_dir("missing")) || errno != ENOENT)) rc = 11;
    errno = 0;
    if (!rc && (opendir(in_dir("one.txt")) || errno != ENOTDIR)) rc = 12;

    unlink(in_dir("one.txt"));
    unlink(in_dir("two.dat"));
    rmdir(dir);
    return rc;
}

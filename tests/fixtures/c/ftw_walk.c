// ftw (POSIX file-tree walk) calls a program callback for a directory and
// then for each entry below it, with the entry's path, its stat and a type
// flag, and a nonzero callback result ends the walk as ftw's result. A
// fresh directory of three files and a subdirectory holding one is walked
// whole, then stopped at its first file, then walked once removed. On
// Windows ftw is mingw-w64's, which libc/lib/ftw_ext.c defines.

#include <ftw.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/stat.h>
#include <unistd.h>
#ifdef _WIN32
#define MKDIR(p) mkdir(p)
#else
#define MKDIR(p) mkdir(p, 0700)
#endif

static int dirs, files, root_first;
static char root[512];

static int visit(const char *path, const struct stat *sb, int flag) {
    (void)sb;
    if (dirs + files == 0)
        root_first = flag == FTW_D && !strcmp(path, root);
    if (flag == FTW_D)
        dirs++;
    else if (flag == FTW_F)
        files++;
    else
        return 100 + flag;
    return 0;
}

static int stop_at_file(const char *path, const struct stat *sb, int flag) {
    (void)path;
    (void)sb;
    return flag == FTW_F ? 42 : 0;
}

static int make_file(const char *path) {
    FILE *f = fopen(path, "w");
    if (!f)
        return -1;
    fclose(f);
    return 0;
}

int main(void) {
    const char *tmp = getenv("TMPDIR");
    char path[600];
    int i, rc = 0;
    if (!tmp)
        tmp = getenv("TEMP");
    if (!tmp)
        tmp = "/tmp";
    snprintf(root, sizeof root, "%s/badc_ftwXXXXXX", tmp);
    if (!mkdtemp(root))
        return 1;
    for (i = 0; i < 3; i++) {
        snprintf(path, sizeof path, "%s/f%d", root, i);
        if (make_file(path))
            return 2;
    }
    snprintf(path, sizeof path, "%s/sub", root);
    if (MKDIR(path))
        return 3;
    snprintf(path, sizeof path, "%s/sub/g", root);
    if (make_file(path))
        return 4;

    if (ftw(root, visit, 16) != 0 || dirs != 2 || files != 4 || !root_first)
        rc = 5;
    if (!rc && ftw(root, stop_at_file, 16) != 42)
        rc = 6;

    remove(path);
    snprintf(path, sizeof path, "%s/sub", root);
    rmdir(path);
    for (i = 0; i < 3; i++) {
        snprintf(path, sizeof path, "%s/f%d", root, i);
        remove(path);
    }
    rmdir(root);
    if (!rc && ftw(root, visit, 16) != -1)
        rc = 7;
    return rc;
}

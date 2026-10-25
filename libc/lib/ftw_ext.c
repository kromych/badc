// ftw on the Windows targets, as libmingwex defines it: a preorder walk over
// <dirent.h> joining paths with `/`, reporting FTW_D, FTW_F, FTW_DNR or
// FTW_NS, ending at a nonzero callback result and failing with -1 for a root
// it cannot stat. Elsewhere the file is empty; the link offers it like an
// archive member.

#ifdef _WIN32

#include <dirent.h>
#include <ftw.h>
#include <stdlib.h>
#include <string.h>
#include <sys/stat.h>

typedef int (*visit_fn)(const char *, const struct stat *, int);

static int walk(const char *path, visit_fn fn, int root) {
    struct stat st;
    struct dirent *e;
    DIR *dir;
    size_t len = strlen(path);
    int rc;
    memset(&st, 0, sizeof st);
    if (stat(path, &st))
        return root ? -1 : fn(path, &st, FTW_NS);
    if (!S_ISDIR(st.st_mode))
        return fn(path, &st, FTW_F);
    if (!(dir = opendir(path)))
        return fn(path, &st, FTW_DNR);
    rc = fn(path, &st, FTW_D);
    while (!rc && (e = readdir(dir))) {
        size_t n = strlen(e->d_name);
        size_t sep = len && path[len - 1] != '/' && path[len - 1] != '\\';
        char *child;
        if (!strcmp(e->d_name, ".") || !strcmp(e->d_name, ".."))
            continue;
        if (!(child = malloc(len + sep + n + 1))) {
            rc = -1;
            break;
        }
        memcpy(child, path, len);
        if (sep)
            child[len] = '/';
        memcpy(child + len + sep, e->d_name, n + 1);
        rc = walk(child, fn, 0);
        free(child);
    }
    closedir(dir);
    return rc;
}

int ftw(const char *path, visit_fn fn, int nopenfd) {
    (void)nopenfd;
    return walk(path, fn, 1);
}

#endif

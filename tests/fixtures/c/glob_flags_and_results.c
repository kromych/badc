// glob(3) through the C library's glob_t and flag values: a pattern over
// files this program creates matches them in sorted order, GLOB_MARK marks
// a directory, a pattern matching nothing returns GLOB_NOMATCH or, with
// GLOB_NOCHECK, the pattern itself, and GLOB_APPEND extends the vector.
//
// Returns 0 on success, otherwise the number of the failing check.

#include <fcntl.h>
#include <glob.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/stat.h>
#include <unistd.h>

static char dir[64];

static void path(char *out, size_t n, const char *name) {
    snprintf(out, n, "%s/%s", dir, name);
}

static int create(const char *name) {
    char p[128];
    path(p, sizeof p, name);
    int fd = open(p, O_WRONLY | O_CREAT | O_TRUNC, 0600);
    return fd < 0 ? -1 : close(fd);
}

static int is(const char *got, const char *name) {
    char p[128];
    path(p, sizeof p, name);
    return strcmp(got, p) == 0;
}

static int run(void) {
    char pat[128];
    glob_t g;
    path(pat, sizeof pat, "*.txt");
    if (glob(pat, 0, 0, &g) != 0) {
        return 2;
    }
    int ok = g.gl_pathc == 2 && is(g.gl_pathv[0], "a.txt") && is(g.gl_pathv[1], "b.txt");
    globfree(&g);
    if (!ok) {
        return 3;
    }
    path(pat, sizeof pat, "s*");
    if (glob(pat, GLOB_MARK, 0, &g) != 0) {
        return 4;
    }
    ok = g.gl_pathc == 1 && is(g.gl_pathv[0], "sub/");
    globfree(&g);
    if (!ok) {
        return 5;
    }
    path(pat, sizeof pat, "*.none");
    if (glob(pat, 0, 0, &g) != GLOB_NOMATCH) {
        return 6;
    }
    if (glob(pat, GLOB_NOCHECK, 0, &g) != 0 || g.gl_pathc != 1 || strcmp(g.gl_pathv[0], pat)) {
        return 7;
    }
    path(pat, sizeof pat, "a*");
    if (glob(pat, GLOB_APPEND, 0, &g) != 0) {
        return 8;
    }
    ok = g.gl_pathc == 2 && is(g.gl_pathv[1], "a.txt");
    globfree(&g);
    return ok ? 0 : 9;
}

int main(void) {
    // A directory of its own per run: runs in one process share a pid.
    snprintf(dir, sizeof dir, "/tmp/badc-glob-XXXXXX");
    if (!mkdtemp(dir)) {
        return 1;
    }
    char sub[128];
    path(sub, sizeof sub, "sub");
    if (create("b.txt") || create("a.txt") || mkdir(sub, 0700)) {
        return 1;
    }
    int rc = run();
    char p[128];
    path(p, sizeof p, "a.txt");
    unlink(p);
    path(p, sizeof p, "b.txt");
    unlink(p);
    rmdir(sub);
    rmdir(dir);
    return rc;
}

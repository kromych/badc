// <fts.h> file-hierarchy traversal and the <sys/types.h> route to
// `fd_set`. The FTSENT layout differs between the BSD (macOS) and glibc
// targets; the fields a caller reads (fts_info, fts_path, fts_pathlen,
// fts_statp) must land at the platform's offsets, so reading them back
// after a walk verifies the layout. `fd_set` must be visible through
// <sys/types.h> alone -- glibc exposes it there, and POSIX code that
// omits <sys/select.h> relies on it. Run native and JIT only: the SSA
// interpreter has no fts shim. Asserted by return code.

#include <fts.h>
#include <sys/types.h>
#include <string.h>

int main(void) {
    // fd_set reached through <sys/types.h> without <sys/select.h>.
    fd_set mask;
    char *p = (char *) &mask;
    p[0] = 0;

    char dot[] = ".";
    char *paths[2];
    paths[0] = dot;
    paths[1] = 0;

    FTS *f = fts_open(paths, FTS_PHYSICAL | FTS_NOCHDIR, 0);
    if (f == 0) {
        return 1;
    }
    // The first entry is always the traversal root itself, returned as a
    // pre-order directory regardless of the directory's contents.
    FTSENT *e = fts_read(f);
    if (e == 0) {
        return 2;
    }
    if (e->fts_info != FTS_D) {
        return 3;
    }
    if (e->fts_path == 0 || e->fts_path[0] != '.') {
        return 4;
    }
    if (e->fts_pathlen != (unsigned short) strlen(e->fts_path)) {
        return 5;
    }
    fts_close(f);
    return 0;
}

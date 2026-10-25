// POSIX.1-2008: <sys/stat.h> declares chmod, fchmod, fchmodat, fstatat,
// futimens, mkdir, mkdirat, mkfifo, mkfifoat, umask and utimensat, <unistd.h>
// the directory-relative fchownat, unlinkat, linkat, symlinkat, readlinkat
// and faccessat, and <stdio.h> renameat, each with its POSIX type. Their
// addresses take those types, and a round of calls in a fresh directory
// creates, stats, times, links, reads, renames and removes its entries.
// snapshot-budget: exempt

#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/stat.h>
#include <unistd.h>

int (*const p_chmod)(const char *, mode_t) = chmod;
int (*const p_fchmod)(int, mode_t) = fchmod;
int (*const p_fchmodat)(int, const char *, mode_t, int) = fchmodat;
int (*const p_fstatat)(int, const char *restrict, struct stat *restrict, int) = fstatat;
int (*const p_futimens)(int, const struct timespec[2]) = futimens;
int (*const p_mkdir)(const char *, mode_t) = mkdir;
int (*const p_mkdirat)(int, const char *, mode_t) = mkdirat;
int (*const p_mkfifo)(const char *, mode_t) = mkfifo;
int (*const p_mkfifoat)(int, const char *, mode_t) = mkfifoat;
mode_t (*const p_umask)(mode_t) = umask;
int (*const p_utimensat)(int, const char *, const struct timespec[2], int) = utimensat;
int (*const p_fchownat)(int, const char *, uid_t, gid_t, int) = fchownat;
int (*const p_unlinkat)(int, const char *, int) = unlinkat;
int (*const p_linkat)(int, const char *, int, const char *, int) = linkat;
int (*const p_symlinkat)(const char *, int, const char *) = symlinkat;
ssize_t (*const p_readlinkat)(int, const char *restrict, char *restrict, size_t) = readlinkat;
int (*const p_faccessat)(int, const char *, int, int) = faccessat;
int (*const p_renameat)(int, const char *, int, const char *) = renameat;

int main(void) {
    char dir[] = "/tmp/badc-at-XXXXXX", buf[16];
    struct stat st;
    struct timespec times[2] = {{1000000000, 0}, {1000000000, 500}};
    if (!mkdtemp(dir))
        return 1;
    int d = open(dir, O_RDONLY);
    if (d < 0 || mkdirat(d, "sub", 0700) || mkfifoat(d, "pipe", 0600))
        return 2;
    int f = openat(d, "file", O_CREAT | O_WRONLY, 0600);
    if (f < 0 || futimens(f, times) || fchmod(f, 0640) || close(f))
        return 3;
    if (fstatat(d, "file", &st, 0) || (st.st_mode & 0777) != 0640 || st.st_mtime != 1000000000)
        return 4;
    if (utimensat(d, "sub", times, 0) || fchmodat(d, "sub", 0750, 0) ||
        faccessat(d, "file", R_OK, 0))
        return 5;
    if (symlinkat("file", d, "link") || readlinkat(d, "link", buf, sizeof buf) != 4 ||
        memcmp(buf, "file", 4))
        return 6;
    if (linkat(d, "file", d, "hard", 0) || renameat(d, "hard", d, "moved") ||
        fstatat(d, "moved", &st, 0) || st.st_nlink != 2)
        return 7;
    if (fchownat(d, "moved", getuid(), getgid(), 0))
        return 8;
    static const char *names[] = {"moved", "link", "file", "pipe"};
    for (unsigned i = 0; i < 4; ++i)
        if (unlinkat(d, names[i], 0))
            return 9;
    mode_t old = umask(022);
    if (umask(old) != 022 || unlinkat(d, "sub", AT_REMOVEDIR) || close(d))
        return 10;
    return rmdir(dir) ? 11 : 0;
}

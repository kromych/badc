// The XSI interfaces of POSIX.1-2008 the C library provides, each through
// its POSIX header: nftw, the Bessel functions, the System V signal calls,
// tempnam, the radix-64 and 48-bit generator families, initstate /
// setstate, memccpy, ffs, getpriority / setpriority, mknod / mknodat,
// utimes / futimes, tcgetsid, getdate, gethostid and swab, and the XSI
// conformance macros of <unistd.h>. The generators' and the signals'
// process-wide state keeps it out of the JIT table, whose fixtures share a
// process.
// snapshot-budget: exempt

#include <errno.h>
#include <fcntl.h>
#include <ftw.h>
#include <math.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <strings.h>
#include <sys/resource.h>
#include <sys/stat.h>
#include <sys/time.h>
#include <termios.h>
#include <time.h>
#include <unistd.h>

#if !defined(_XOPEN_UNIX) || _XOPEN_UNIX <= 0 || _XOPEN_VERSION < 600
#error "the XSI option is not advertised"
#endif

static int entries, depth_last;

static int visit(const char *path, const struct stat *sb, int flag, struct FTW *f) {
    (void)sb;
    ++entries;
    if (f->base <= 0 || strcmp(path + f->base, f->level ? "n" : strrchr(path, '/') + 1))
        return 1;
    depth_last = flag == FTW_DP && f->level == 0;
    return 0;
}

static int files(void) {
    char dir[64], node[96], fifo[96];
    struct timeval tv[2] = {{1000000000, 0}, {1000000000, 0}};
    struct stat st;
    int fd;
    strcpy(dir, "/tmp/xsiXXXXXX");
    if (!mkdtemp(dir))
        return 1;
    snprintf(node, sizeof node, "%s/n", dir);
    snprintf(fifo, sizeof fifo, "%s/f", dir);
    if (mknod(node, S_IFIFO | 0600, 0) || mknodat(AT_FDCWD, fifo, S_IFIFO | 0600, 0))
        return 2;
    if (stat(node, &st) || !S_ISFIFO(st.st_mode))
        return 3;
    if (utimes(node, tv) || stat(node, &st) || st.st_mtime != 1000000000)
        return 4;
    if ((fd = open(dir, O_RDONLY)) < 0 || futimes(fd, tv) || close(fd))
        return 5;
    unlink(fifo);
    entries = 0;
    if (nftw(dir, visit, 4, FTW_DEPTH | FTW_PHYS) || entries != 2 || !depth_last)
        return 6;
    unlink(node);
    rmdir(dir);
    return 0;
}

static int numbers(void) {
    unsigned short x[3] = {1, 2, 3}, y[3] = {1, 2, 3};
    unsigned short param[7] = {1, 2, 3, 0xe66d, 0xdeec, 0x5, 0xb};
    char state[64], *old;
    if (j0(0.0) != 1.0 || j1(0.0) != 0.0 || jn(2, 0.0) != 0.0)
        return 10;
    if (fabs(y0(1.0) - 0.088256964215677) > 1e-12 || fabs(y1(1.0) + 0.781212821300289) > 1e-12 ||
        fabs(yn(2, 1.0) + 1.650682606816254) > 1e-12)
        return 11;
    if (a64l("./") != 64 || strcmp(l64a(64), "./"))
        return 12;
    seed48(y);
    double d = erand48(x);
    if (d < 0 || d >= 1 || d != drand48() || nrand48(x) != lrand48() || jrand48(x) != mrand48())
        return 13;
    lcong48(param);
    if (lrand48() < 0)
        return 14;
    if (!(old = initstate(7, state, sizeof state)) || setstate(old) != state)
        return 15;
    return 0;
}

static int strings_and_process(void) {
    char out[8] = {0}, swapped[5] = {0};
    char *p;
    int prio;
    if ((p = memccpy(out, "ab,cd", ',', sizeof out)) != out + 3 || strcmp(out, "ab,"))
        return 20;
    if (ffs(0) != 0 || ffs(0x10) != 5)
        return 21;
    swab("abcd", swapped, 4);
    if (strcmp(swapped, "badc"))
        return 22;
    errno = 0;
    prio = getpriority(PRIO_PROCESS, 0);
    if (errno || prio < -20 || prio > 20 || setpriority(PRIO_PROCESS, 0, prio))
        return 23;
    if ((p = tempnam(NULL, "xsi")) == NULL)
        return 24;
    free(p);
    (void)gethostid();
    int pipefd[2];
    if (pipe(pipefd) || tcgetsid(pipefd[0]) != -1 || errno != ENOTTY)
        return 25;
    close(pipefd[0]);
    close(pipefd[1]);
    unsetenv("DATEMSK");
    if (getdate("noon") != NULL || getdate_err != 1)
        return 26;
    return 0;
}

static int signals(void) {
    sigset_t now;
    if (sighold(SIGUSR1) || sigprocmask(SIG_BLOCK, NULL, &now) || !sigismember(&now, SIGUSR1))
        return 30;
    if (sigrelse(SIGUSR1) || sigprocmask(SIG_BLOCK, NULL, &now) || sigismember(&now, SIGUSR1))
        return 31;
    if (sigignore(SIGUSR2) || raise(SIGUSR2))
        return 32;
    if (sigset(SIGUSR2, SIG_DFL) != SIG_IGN)
        return 33;
    int (*pause_on)(int) = sigpause;
    return pause_on ? 0 : 34;
}

int main(void) {
    int r;
    if ((r = files()) || (r = numbers()) || (r = strings_and_process()) || (r = signals()))
        return r;
    return 0;
}

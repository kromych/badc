// The POSIX surface a full-screen editor reaches for beyond C99: the
// per-process timers of <time.h> and <signal.h>, strptime, the C99
// per-character multibyte conversions, XSI character-set conversion,
// and Linux's system statistics. Each is called, and every result that
// does not depend on the environment is checked.
//
// A file-scope function-pointer table also names a function that only a
// prototype declares. That is a definition in another unit under C99
// 6.7p7, so it must compile without a diagnostic; the linker resolves
// it, and the table below points at a definition in this unit.

#ifdef _WIN32
int main(void) { return 0; }
#else
#include <iconv.h>
#include <signal.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <unistd.h>
#ifdef __linux__
#include <sys/sysinfo.h>
#endif

int declared_only(int x);

static int doubled(int x) { return x + x; }

int (*table[2])(int) = {doubled, declared_only};

int declared_only(int x) { return x + 1; }

int main(void) {
    if (table[0](21) != 42) return 1;
    if (table[1](41) != 42) return 2;

    // C99 7.20.7: one multibyte character at a time. The C locale is a
    // single-byte encoding, so each conversion covers exactly one byte.
    if (mblen("a", 1) != 1) return 3;
    wchar_t wc = 0;
    if (mbtowc(&wc, "z", 1) != 1) return 4;
    if (wc != (wchar_t)'z') return 5;
    char out[8];
    if (wctomb(out, (wchar_t)'z') != 1) return 6;
    if (out[0] != 'z') return 7;

    // POSIX: the inverse of strftime.
    struct tm parsed;
    memset(&parsed, 0, sizeof parsed);
    char *rest = strptime("2024-05-06", "%Y-%m-%d", &parsed);
    if (rest == 0 || *rest != 0) return 8;
    if (parsed.tm_year != 124 || parsed.tm_mon != 4 || parsed.tm_mday != 6)
        return 9;

    // XSI conversion, over an encoding every implementation carries.
    iconv_t cd = iconv_open("UTF-8", "UTF-8");
    if (cd == (iconv_t)-1) return 10;
    char in_buf[4];
    char out_buf[8];
    in_buf[0] = 'h';
    in_buf[1] = 'i';
    char *inp = in_buf;
    char *outp = out_buf;
    unsigned long inleft = 2;
    unsigned long outleft = sizeof out_buf;
    if (iconv(cd, &inp, &inleft, &outp, &outleft) == (unsigned long)-1) return 11;
    if (inleft != 0 || outleft != sizeof out_buf - 2) return 12;
    if (out_buf[0] != 'h' || out_buf[1] != 'i') return 13;
    if (iconv_close(cd) != 0) return 14;

#ifdef __linux__
    // A per-process timer that notifies nothing: create, arm, read back
    // and delete. The interval is long enough that it cannot expire
    // before the read.
    struct sigevent ev;
    memset(&ev, 0, sizeof ev);
    ev.sigev_notify = SIGEV_NONE;
    timer_t id;
    if (timer_create(CLOCK_MONOTONIC, &ev, &id) != 0) return 15;
    struct itimerspec spec;
    spec.it_interval.tv_sec = 0;
    spec.it_interval.tv_nsec = 0;
    spec.it_value.tv_sec = 3600;
    spec.it_value.tv_nsec = 0;
    if (timer_settime(id, 0, &spec, 0) != 0) return 16;
    struct itimerspec left;
    memset(&left, 0, sizeof left);
    if (timer_gettime(id, &left) != 0) return 17;
    if (left.it_value.tv_sec <= 0 || left.it_value.tv_sec > 3600) return 18;
    if (timer_getoverrun(id) != 0) return 19;
    if (timer_delete(id) != 0) return 20;

    // The record the kernel fills; uptime and the total-memory word are
    // positive on any running system.
    struct sysinfo info;
    if (sysinfo(&info) != 0) return 21;
    if (info.uptime < 0 || info.totalram == 0 || info.mem_unit == 0) return 22;
    if (get_nprocs() < 1 || get_nprocs_conf() < get_nprocs()) return 23;

    // The signal stack size sysconf reports, at least the minimum.
    long sig = sysconf(_SC_SIGSTKSZ);
    if (sig != -1 && sig < sysconf(_SC_MINSIGSTKSZ)) return 24;
#endif
    return 0;
}
#endif

// struct stat exposes each timestamp both as a timespec (st_mtim on
// Linux, st_mtimespec on macOS) and as the historical flat st_mtime /
// st_mtimensec pair, overlaid at one offset by a union. A stat of the
// root directory reads back consistent values through both views.
// Windows has no POSIX stat layout here.

#ifdef _WIN32
int main(void) { return 0; }
#else
#include <sys/stat.h>

int main(void) {
    struct stat st;
    if (stat("/", &st)) return 1;

    long sec;
#ifdef __APPLE__
    sec = st.st_mtimespec.tv_sec;
#else
    sec = st.st_mtim.tv_sec;
#endif
    // The timespec view and the flat field alias the same tv_sec.
    if (sec != st.st_mtime) return 2;
    // The root directory exists and predates the present.
    if (st.st_mtime < 1000000000L) return 3;
    if (!S_ISDIR(st.st_mode)) return 4;
    return 0;
}
#endif

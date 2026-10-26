// C99 7.23.3.1 asctime and POSIX asctime_r format a broken-down time as
// "Www Mmm dd hh:mm:ss yyyy\n"; asctime_r writes the same text into the
// caller's buffer and returns it. A day of month of two digits keeps the
// text the same where a runtime pads one-digit days with a zero. Windows
// declares asctime_r only under _POSIX_C_SOURCE defined before the first
// include of <time.h>; a unit that includes it earlier declares it itself.
#define _POSIX_C_SOURCE 200809L
#include <string.h>
#include <time.h>

#if defined(_WIN32) && !defined(_POSIX_THREAD_SAFE_FUNCTIONS)
char *asctime_r(const struct tm *restrict tm, char *restrict buf);
#endif

int main(void) {
    static const char want[] = "Thu Jan 15 13:04:05 1970\n";
    struct tm tm = {0};
    char buf[26];
    tm.tm_year = 70;
    tm.tm_mday = 15;
    tm.tm_wday = 4;
    tm.tm_yday = 14;
    tm.tm_hour = 13;
    tm.tm_min = 4;
    tm.tm_sec = 5;
    char *(*asctime_p)(const struct tm *) = asctime;
    const char *text = asctime_p(&tm);
    if (!text || strcmp(text, want) != 0)
        return 1;
    memset(buf, 'x', sizeof buf);
    if (asctime_r(&tm, buf) != buf || strcmp(buf, want) != 0)
        return 2;
    tm.tm_mon = 11;
    tm.tm_mday = 31;
    if (strcmp(asctime_r(&tm, buf), "Thu Dec 31 13:04:05 1970\n") != 0)
        return 3;
    return 0;
}

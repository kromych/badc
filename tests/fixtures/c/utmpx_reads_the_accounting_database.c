// <utmpx.h>: the record has the C library's layout -- glibc's 384 bytes on
// x86-64 with the 32-bit session and time words, 400 on aarch64, the SDK's
// 640 with the user name first -- and setutxent, getutxent and endutxent
// read the database through to its end, every record's type one of the
// header's. A getutxline of a line no record has finds nothing.
// snapshot-budget: exempt
#include <stddef.h>
#include <string.h>
#include <utmpx.h>

#if defined(__APPLE__)
#define SIZE 640
#define USER 0
#define TYPE 296
#define TV 304
#define MAX_TYPE 11
#elif defined(__x86_64__)
#define SIZE 384
#define USER 44
#define TYPE 0
#define TV 340
#define MAX_TYPE 9
#else
#define SIZE 400
#define USER 44
#define TYPE 0
#define TV 344
#define MAX_TYPE 9
#endif

int main(void) {
    struct utmpx *u, key;
    int n = 0;

    if (sizeof(struct utmpx) != SIZE || offsetof(struct utmpx, ut_user) != USER) return 1;
    if (offsetof(struct utmpx, ut_type) != TYPE || offsetof(struct utmpx, ut_tv) != TV) return 2;
    if (sizeof(((struct utmpx *)0)->ut_line) != 32 || sizeof(((struct utmpx *)0)->ut_host) != 256)
        return 3;
    if (EMPTY != 0 || BOOT_TIME != 2 || USER_PROCESS != 7 || DEAD_PROCESS != 8) return 4;
    setutxent();
    while ((u = getutxent()) && n < 100000) {
        if (u->ut_type < EMPTY || u->ut_type > MAX_TYPE) return 5;
        n++;
    }
    setutxent();
    memset(&key, 0, sizeof key);
    strcpy(key.ut_line, "badc-no-such-line");
    if (getutxline(&key)) return 6;
    endutxent();
    return 0;
}

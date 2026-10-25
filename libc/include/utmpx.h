// utmpx.h -- the user accounting database, bound to the C library: glibc's
// calls in libc.so.6 and libSystem's. The record layouts differ: glibc's is
// 384 bytes on x86-64, where the session and the time are 32-bit words so
// the file is shared with 32-bit programs, and 400 on aarch64; the SDK's is
// 628, user name first. The two number OLD_TIME and NEW_TIME the other way
// round.

#pragma once

#include <stdint.h>
#include <sys/time.h>
#include <sys/types.h>

#ifdef __linux__
struct __exit_status {
#ifdef _GNU_SOURCE
    short e_termination;
    short e_exit;
#else
    short __e_termination;
    short __e_exit;
#endif
};

struct utmpx {
    short ut_type;
    pid_t ut_pid;
    char ut_line[32];
    char ut_id[4];
    char ut_user[32];
    char ut_host[256];
    struct __exit_status ut_exit;
#ifdef __x86_64__
    int32_t ut_session;
    struct {
        uint32_t tv_sec;
        int32_t tv_usec;
    } ut_tv;
#else
    long ut_session;
    struct timeval ut_tv;
#endif
    int32_t ut_addr_v6[4];
    char __glibc_reserved[20];
};

#define EMPTY 0
#define BOOT_TIME 2
#define NEW_TIME 3
#define OLD_TIME 4
#define INIT_PROCESS 5
#define LOGIN_PROCESS 6
#define USER_PROCESS 7
#define DEAD_PROCESS 8

#ifdef _GNU_SOURCE
#define RUN_LVL 1
#define ACCOUNTING 9
#define _PATH_UTMPX "/var/run/utmp"
#define _PATH_WTMPX "/var/log/wtmp"
#define UTMPX_FILE _PATH_UTMPX
#define UTMPX_FILENAME _PATH_UTMPX
#define WTMPX_FILE _PATH_WTMPX
#define WTMPX_FILENAME _PATH_WTMPX

struct utmp;
int utmpxname(const char *file);
void updwtmpx(const char *wtmpx_file, const struct utmpx *utmpx);
void getutmp(const struct utmpx *utmpx, struct utmp *utmp);
void getutmpx(const struct utmp *utmp, struct utmpx *utmpx);
#endif

#pragma dylib(libc, "libc.so.6")
#pragma binding(libc::setutxent, "setutxent")
#pragma binding(libc::endutxent, "endutxent")
#pragma binding(libc::getutxent, "getutxent")
#pragma binding(libc::getutxid, "getutxid")
#pragma binding(libc::getutxline, "getutxline")
#pragma binding(libc::pututxline, "pututxline")
#pragma binding(libc::utmpxname, "utmpxname")
#pragma binding(libc::updwtmpx, "updwtmpx")
#pragma binding(libc::getutmp, "getutmp")
#pragma binding(libc::getutmpx, "getutmpx")
#elif defined(__APPLE__)
#define _PATH_UTMPX "/var/run/utmpx"
#define _UTX_USERSIZE 256
#define _UTX_LINESIZE 32
#define _UTX_IDSIZE 4
#define _UTX_HOSTSIZE 256

struct utmpx {
    char ut_user[_UTX_USERSIZE];
    char ut_id[_UTX_IDSIZE];
    char ut_line[_UTX_LINESIZE];
    pid_t ut_pid;
    short ut_type;
    struct timeval ut_tv;
    char ut_host[_UTX_HOSTSIZE];
    uint32_t ut_pad[16];
};

#define EMPTY 0
#define RUN_LVL 1
#define BOOT_TIME 2
#define OLD_TIME 3
#define NEW_TIME 4
#define INIT_PROCESS 5
#define LOGIN_PROCESS 6
#define USER_PROCESS 7
#define DEAD_PROCESS 8

#if !defined(_POSIX_C_SOURCE) || defined(_DARWIN_C_SOURCE)
#define UTMPX_FILE _PATH_UTMPX
#define ACCOUNTING 9
#define SIGNATURE 10
#define SHUTDOWN_TIME 11
#define UTMPX_AUTOFILL_MASK 0x8000
#define UTMPX_DEAD_IF_CORRESPONDING_MASK 0x4000
#define UTMPX_CHANGE_NOTIFICATION "com.apple.system.utmpx"

struct lastlogx {
    struct timeval ll_tv;
    char ll_line[_UTX_LINESIZE];
    char ll_host[_UTX_HOSTSIZE];
};

struct utmp;
struct lastlogx *getlastlogx(uid_t uid, struct lastlogx *lx);
struct lastlogx *getlastlogxbyname(const char *user, struct lastlogx *lx);
void getutmp(const struct utmpx *utmpx, struct utmp *utmp);
void getutmpx(const struct utmp *utmp, struct utmpx *utmpx);
void setutxent_wtmp(int dir);
struct utmpx *getutxent_wtmp(void);
void endutxent_wtmp(void);
int utmpxname(const char *file);
int wtmpxname(const char *file);
#endif

#pragma dylib(libc, "/usr/lib/libSystem.B.dylib")
#pragma binding(libc::setutxent, "_setutxent")
#pragma binding(libc::endutxent, "_endutxent")
#pragma binding(libc::getutxent, "_getutxent")
#pragma binding(libc::getutxid, "_getutxid")
#pragma binding(libc::getutxline, "_getutxline")
#pragma binding(libc::pututxline, "_pututxline")
#pragma binding(libc::getlastlogx, "_getlastlogx")
#pragma binding(libc::getlastlogxbyname, "_getlastlogxbyname")
#pragma binding(libc::getutmp, "_getutmp")
#pragma binding(libc::getutmpx, "_getutmpx")
#pragma binding(libc::setutxent_wtmp, "_setutxent_wtmp")
#pragma binding(libc::getutxent_wtmp, "_getutxent_wtmp")
#pragma binding(libc::endutxent_wtmp, "_endutxent_wtmp")
#pragma binding(libc::utmpxname, "_utmpxname")
#pragma binding(libc::wtmpxname, "_wtmpxname")
#endif

void setutxent(void);
void endutxent(void);
struct utmpx *getutxent(void);
struct utmpx *getutxid(const struct utmpx *id);
struct utmpx *getutxline(const struct utmpx *line);
struct utmpx *pututxline(const struct utmpx *utmpx);

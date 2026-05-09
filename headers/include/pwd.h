// pwd.h -- POSIX user / password database lookups.
//
// `struct passwd` shape is per-platform: Darwin/BSD insert
// pw_change/pw_class/pw_expire, Linux/glibc does not. The
// offsets of pw_dir and pw_name differ accordingly, so a single
// "any-platform" layout misses them on at least one OS.

#ifndef _C5_PWD_H
#define _C5_PWD_H

#include <sys/types.h>

#ifdef __APPLE__
struct passwd {
    char *pw_name;     /* offset  0 */
    char *pw_passwd;   /* offset  8 */
    int   pw_uid;      /* offset 16 */
    int   pw_gid;      /* offset 20 */
    long  pw_change;   /* offset 24, time_t */
    char *pw_class;    /* offset 32 */
    char *pw_gecos;    /* offset 40 */
    char *pw_dir;      /* offset 48 */
    char *pw_shell;    /* offset 56 */
    long  pw_expire;   /* offset 64, time_t */
    char  __pad[64];
};
#else
/* Linux / glibc layout: no pw_change, pw_class, pw_expire. */
struct passwd {
    char *pw_name;     /* offset  0 */
    char *pw_passwd;   /* offset  8 */
    int   pw_uid;      /* offset 16 */
    int   pw_gid;      /* offset 20 */
    char *pw_gecos;    /* offset 24 */
    char *pw_dir;      /* offset 32 */
    char *pw_shell;    /* offset 40 */
    char  __pad[64];
};
#endif

#ifdef __APPLE__
#pragma dylib(libc, "/usr/lib/libSystem.B.dylib")
#pragma binding(libc::getpwuid, "_getpwuid")
#pragma binding(libc::getpwnam, "_getpwnam")
#pragma binding(libc::getpwent, "_getpwent")
#pragma binding(libc::endpwent, "_endpwent")
#endif

#ifdef __linux__
#pragma dylib(libc, "libc.so.6")
#pragma binding(libc::getpwuid, "getpwuid")
#pragma binding(libc::getpwnam, "getpwnam")
#pragma binding(libc::getpwent, "getpwent")
#pragma binding(libc::endpwent, "endpwent")
#endif

struct passwd *getpwuid(int uid);
struct passwd *getpwnam(char *name);
struct passwd *getpwent();
int endpwent();

#endif

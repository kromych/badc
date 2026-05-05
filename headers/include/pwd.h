// pwd.h -- POSIX user / password database lookups.
//
// Real `struct passwd` lays out username, hashed password, uid,
// gid, gecos, home dir, shell. SQLite shell only reads pw_dir
// (for `~` expansion) and pw_name. The opaque buffer below is
// large enough that libc's writes don't overflow.

#ifndef _C5_PWD_H
#define _C5_PWD_H

#include <sys/types.h>

struct passwd {
    char *pw_name;
    char *pw_passwd;
    int   pw_uid;
    int   pw_gid;
    int   pw_change;
    char *pw_class;
    char *pw_gecos;
    char *pw_dir;
    char *pw_shell;
    int   pw_expire;
    char  __pad[64];
};

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

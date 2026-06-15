// grp.h -- group database access (POSIX 7.20). `struct group` is 32 bytes on
// every supported target.

#pragma once

struct group {
    char *gr_name;
    char *gr_passwd;
    unsigned int gr_gid;
    char **gr_mem;
};

#ifdef __APPLE__
#pragma dylib(libc, "/usr/lib/libSystem.B.dylib")
#pragma binding(libc::getgrnam, "_getgrnam")
#pragma binding(libc::getgrgid, "_getgrgid")
#pragma binding(libc::getgrnam_r, "_getgrnam_r")
#pragma binding(libc::getgrgid_r, "_getgrgid_r")
#elif defined(__linux__)
#pragma dylib(libc, "libc.so.6")
#pragma binding(libc::getgrnam, "getgrnam")
#pragma binding(libc::getgrgid, "getgrgid")
#pragma binding(libc::getgrnam_r, "getgrnam_r")
#pragma binding(libc::getgrgid_r, "getgrgid_r")
#endif

struct group *getgrnam(const char *name);
struct group *getgrgid(unsigned int gid);
int getgrnam_r(const char *name, struct group *grp, char *buf, unsigned long buflen, struct group **result);
int getgrgid_r(unsigned int gid, struct group *grp, char *buf, unsigned long buflen, struct group **result);

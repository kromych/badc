#pragma once

// sys/xattr.h -- extended file attributes (Linux). The `l*` variants act
// on a symbolic link itself; the `f*` variants take an open descriptor.

#ifdef __linux__
#pragma dylib(libc, "libc.so.6")
#pragma binding(libc::getxattr,     "getxattr")
#pragma binding(libc::lgetxattr,    "lgetxattr")
#pragma binding(libc::fgetxattr,    "fgetxattr")
#pragma binding(libc::setxattr,     "setxattr")
#pragma binding(libc::lsetxattr,    "lsetxattr")
#pragma binding(libc::fsetxattr,    "fsetxattr")
#pragma binding(libc::listxattr,    "listxattr")
#pragma binding(libc::llistxattr,   "llistxattr")
#pragma binding(libc::flistxattr,   "flistxattr")
#pragma binding(libc::removexattr,  "removexattr")
#pragma binding(libc::lremovexattr, "lremovexattr")
#pragma binding(libc::fremovexattr, "fremovexattr")
#endif

#define XATTR_CREATE  1
#define XATTR_REPLACE 2

long getxattr(const char *path, const char *name, void *value, unsigned long size);
long lgetxattr(const char *path, const char *name, void *value, unsigned long size);
long fgetxattr(int fd, const char *name, void *value, unsigned long size);
int setxattr(const char *path, const char *name, const void *value,
             unsigned long size, int flags);
int lsetxattr(const char *path, const char *name, const void *value,
              unsigned long size, int flags);
int fsetxattr(int fd, const char *name, const void *value,
              unsigned long size, int flags);
long listxattr(const char *path, char *list, unsigned long size);
long llistxattr(const char *path, char *list, unsigned long size);
long flistxattr(int fd, char *list, unsigned long size);
int removexattr(const char *path, const char *name);
int lremovexattr(const char *path, const char *name);
int fremovexattr(int fd, const char *name);

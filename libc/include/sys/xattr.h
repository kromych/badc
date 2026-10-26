#pragma once

// sys/xattr.h -- extended file attributes. Linux's calls have `l*` variants
// that act on a symbolic link itself and `f*` variants that take an open
// descriptor; the macOS SDK's take a position and an options word
// (XATTR_NOFOLLOW for a link) instead of the `l*` variants.

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

#define XATTR_CREATE   1
#define XATTR_REPLACE  2
#define XATTR_SIZE_MAX 65536
#define XATTR_LIST_MAX 65536

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
#endif

#ifdef __APPLE__
#pragma dylib(libc, "/usr/lib/libSystem.B.dylib")
#pragma binding(libc::getxattr,     "_getxattr")
#pragma binding(libc::fgetxattr,    "_fgetxattr")
#pragma binding(libc::setxattr,     "_setxattr")
#pragma binding(libc::fsetxattr,    "_fsetxattr")
#pragma binding(libc::listxattr,    "_listxattr")
#pragma binding(libc::flistxattr,   "_flistxattr")
#pragma binding(libc::removexattr,  "_removexattr")
#pragma binding(libc::fremovexattr, "_fremovexattr")

#define XATTR_NOFOLLOW         0x0001
#define XATTR_CREATE           0x0002
#define XATTR_REPLACE          0x0004
#define XATTR_NOSECURITY       0x0008
#define XATTR_NODEFAULT        0x0010
#define XATTR_SHOWCOMPRESSION  0x0020
#define XATTR_NOFOLLOW_ANY     0x0040
#define XATTR_RESOLVE_BENEATH  0x0080
#define XATTR_MAXNAMELEN       127
#define XATTR_FINDERINFO_NAME  "com.apple.FinderInfo"
#define XATTR_RESOURCEFORK_NAME "com.apple.ResourceFork"

long getxattr(const char *path, const char *name, void *value, unsigned long size,
              unsigned int position, int options);
long fgetxattr(int fd, const char *name, void *value, unsigned long size,
               unsigned int position, int options);
int setxattr(const char *path, const char *name, const void *value, unsigned long size,
             unsigned int position, int options);
int fsetxattr(int fd, const char *name, const void *value, unsigned long size,
              unsigned int position, int options);
int removexattr(const char *path, const char *name, int options);
int fremovexattr(int fd, const char *name, int options);
long listxattr(const char *path, char *namebuff, unsigned long size, int options);
long flistxattr(int fd, char *namebuff, unsigned long size, int options);
#endif

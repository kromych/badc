/* MSVC low-level I/O (<io.h>). Underscored POSIX-shaped calls over
** msvcrt. The C99-visible stream API lives in <stdio.h>; this header
** carries the fd-level surface Windows sources reach for directly. */
#pragma once

#ifdef _WIN32

#pragma dylib(msvcrt, "msvcrt.dll")
#pragma binding(msvcrt::_open,    "_open")
#pragma binding(msvcrt::_close,   "_close")
#pragma binding(msvcrt::_read,    "_read")
#pragma binding(msvcrt::_write,   "_write")
#pragma binding(msvcrt::_lseek,   "_lseek")
#pragma binding(msvcrt::_lseeki64, "_lseeki64")
#pragma binding(msvcrt::_unlink,  "_unlink")
#pragma binding(msvcrt::_chmod,   "_chmod")
#pragma binding(msvcrt::_dup,     "_dup")
#pragma binding(msvcrt::_dup2,    "_dup2")
#pragma binding(msvcrt::_fileno,  "_fileno")
#pragma binding(msvcrt::_isatty,  "_isatty")
#pragma binding(msvcrt::_setmode, "_setmode")
#pragma binding(msvcrt::_access,  "_access")
#pragma binding(msvcrt::_commit,  "_commit")

int       _open(char *path, int oflag, int pmode);
int       _close(int fd);
int       _read(int fd, void *buf, unsigned int count);
int       _write(int fd, void *buf, unsigned int count);
long      _lseek(int fd, long offset, int origin);
long long _lseeki64(int fd, long long offset, int origin);
int       _unlink(char *path);
int       _chmod(char *path, int mode);
int       _dup(int fd);
int       _dup2(int fd1, int fd2);
int       _isatty(int fd);
int       _setmode(int fd, int mode);
int       _access(char *path, int mode);
int       _commit(int fd);

#define _S_IREAD  0400
#define _S_IWRITE 0200

#endif

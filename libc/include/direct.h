/* MSVC directory-management (<direct.h>): underscored POSIX-shaped
** calls over msvcrt. */
#pragma once

#ifdef _WIN32

#pragma dylib(msvcrt, "msvcrt.dll")
#pragma binding(msvcrt::_mkdir,  "_mkdir")
#pragma binding(msvcrt::_rmdir,  "_rmdir")
#pragma binding(msvcrt::_chdir,  "_chdir")
#pragma binding(msvcrt::_getcwd, "_getcwd")

int   _mkdir(char *path);
int   _rmdir(char *path);
int   _chdir(char *path);
char *_getcwd(char *buf, int size);

#endif

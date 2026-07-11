/* Demo-local <direct.h>. rcore.c uses _mkdir for MakeDirectory on Windows;
 * msvcrt exports it. _chdir / _getcwd are already declared by the bundled
 * <stdio.h>, so only _mkdir is added here. */
#ifndef RGFW_DEMO_DIRECT_H
#define RGFW_DEMO_DIRECT_H

#pragma dylib(msvcrt, "msvcrt.dll")
#pragma binding(msvcrt::_mkdir, "_mkdir")
int _mkdir(const char *dirname);

#endif /* RGFW_DEMO_DIRECT_H */

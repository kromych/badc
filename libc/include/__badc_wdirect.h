// __badc_wdirect.h -- the functions of the UCRT's corecrt_wdirect.h, which
// its <direct.h> and <wchar.h> both include, with its prototypes; mingw-w64
// declares them in both headers too. msvcrt.dll exports each on both
// targets.

#pragma once

#ifdef _WIN32

#include <stddef.h>

#pragma dylib(msvcrt, "msvcrt.dll")
#pragma binding(msvcrt::_wgetcwd, "_wgetcwd")
wchar_t *_wgetcwd(wchar_t *_DstBuf, int _SizeInWords);
#pragma binding(msvcrt::_wgetdcwd, "_wgetdcwd")
wchar_t *_wgetdcwd(int _Drive, wchar_t *_DstBuf, int _SizeInWords);
#pragma binding(msvcrt::_wchdir, "_wchdir")
int _wchdir(const wchar_t *_Path);
#pragma binding(msvcrt::_wmkdir, "_wmkdir")
int _wmkdir(const wchar_t *_Path);
#pragma binding(msvcrt::_wrmdir, "_wrmdir")
int _wrmdir(const wchar_t *_Path);

#endif

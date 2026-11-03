// __badc_wio.h -- the functions of the UCRT's corecrt_wio.h, which its
// <io.h> and <wchar.h> both include, with its prototypes and its
// _wfinddata64_t; mingw-w64 declares them in both headers too. Each binds to
// msvcrt.dll, which exports it on both targets. _wfindfirst and
// _wfindnext are msvcrt.dll's entries over _wfinddata_t: 64-bit times and a
// 32-bit size. ucrtbase.dll alone exports the 32 / 32i64 / 64i32 find forms
// and _wsopen_dispatch, which are not declared.

#pragma once

#ifdef _WIN32

#include <corecrt.h>

struct _wfinddata_t {
    unsigned int attrib;
    long long time_create;
    long long time_access;
    long long time_write;
    unsigned int size;
    wchar_t name[260];
};

struct _wfinddata64_t {
    unsigned int attrib;
    __time64_t time_create;
    __time64_t time_access;
    __time64_t time_write;
    long long size;
    wchar_t name[260];
};

#pragma dylib(msvcrt, "msvcrt.dll")
#pragma binding(msvcrt::_waccess, "_waccess")
int _waccess(const wchar_t *_FileName, int _AccessMode);
#pragma binding(msvcrt::_waccess_s, "_waccess_s")
errno_t _waccess_s(const wchar_t *_FileName, int _AccessMode);
#pragma binding(msvcrt::_wchmod, "_wchmod")
int _wchmod(const wchar_t *_FileName, int _Mode);
#pragma binding(msvcrt::_wcreat, "_wcreat")
int _wcreat(const wchar_t *_FileName, int _PermissionMode);
#pragma binding(msvcrt::_wunlink, "_wunlink")
int _wunlink(const wchar_t *_FileName);
#pragma binding(msvcrt::_wrename, "_wrename")
int _wrename(const wchar_t *_OldFileName, const wchar_t *_NewFileName);
#pragma binding(msvcrt::_wmktemp, "_wmktemp")
wchar_t *_wmktemp(wchar_t *_TemplateName);
#pragma binding(msvcrt::_wmktemp_s, "_wmktemp_s")
errno_t _wmktemp_s(wchar_t *_TemplateName, size_t _SizeInWords);
// The mode is read only with _O_CREAT.
#pragma binding(msvcrt::_wopen, "_wopen")
int _wopen(const wchar_t *_FileName, int _OpenFlag, ...);
#pragma binding(msvcrt::_wsopen, "_wsopen")
int _wsopen(const wchar_t *_FileName, int _OpenFlag, int _ShareFlag, ...);
#pragma binding(msvcrt::_wsopen_s, "_wsopen_s")
errno_t _wsopen_s(int *_FileHandle, const wchar_t *_FileName, int _OpenFlag, int _ShareFlag,
                  int _PermissionFlag);
#pragma binding(msvcrt::_wfindfirst, "_wfindfirst")
__INTPTR_TYPE__ _wfindfirst(const wchar_t *_FileName, void *_FindData);
#pragma binding(msvcrt::_wfindnext, "_wfindnext")
int _wfindnext(__INTPTR_TYPE__ _FindHandle, void *_FindData);
#pragma binding(msvcrt::_wfindfirst64, "_wfindfirst64")
__INTPTR_TYPE__ _wfindfirst64(const wchar_t *_FileName, struct _wfinddata64_t *_FindData);
#pragma binding(msvcrt::_wfindnext64, "_wfindnext64")
int _wfindnext64(__INTPTR_TYPE__ _FindHandle, struct _wfinddata64_t *_FindData);

#endif

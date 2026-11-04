// __badc_wprocess.h -- the functions of the UCRT's corecrt_wprocess.h, which
// its <process.h> and <wchar.h> both include, with its prototypes; mingw-w64
// declares them in both headers too. msvcrt.dll exports each on both
// targets. An exec or spawn result is a process handle or exit code, as wide
// as a pointer.

#pragma once

#ifdef _WIN32

#include <stddef.h>

#pragma dylib(msvcrt, "msvcrt.dll")
#pragma binding(msvcrt::_wexecl, "_wexecl")
__INTPTR_TYPE__ _wexecl(const wchar_t *_FileName, const wchar_t *_ArgList, ...);
#pragma binding(msvcrt::_wexecle, "_wexecle")
__INTPTR_TYPE__ _wexecle(const wchar_t *_FileName, const wchar_t *_ArgList, ...);
#pragma binding(msvcrt::_wexeclp, "_wexeclp")
__INTPTR_TYPE__ _wexeclp(const wchar_t *_FileName, const wchar_t *_ArgList, ...);
#pragma binding(msvcrt::_wexeclpe, "_wexeclpe")
__INTPTR_TYPE__ _wexeclpe(const wchar_t *_FileName, const wchar_t *_ArgList, ...);
#pragma binding(msvcrt::_wexecv, "_wexecv")
__INTPTR_TYPE__ _wexecv(const wchar_t *_FileName, const wchar_t *const *_ArgList);
#pragma binding(msvcrt::_wexecve, "_wexecve")
__INTPTR_TYPE__ _wexecve(const wchar_t *_FileName, const wchar_t *const *_ArgList,
                         const wchar_t *const *_Env);
#pragma binding(msvcrt::_wexecvp, "_wexecvp")
__INTPTR_TYPE__ _wexecvp(const wchar_t *_FileName, const wchar_t *const *_ArgList);
#pragma binding(msvcrt::_wexecvpe, "_wexecvpe")
__INTPTR_TYPE__ _wexecvpe(const wchar_t *_FileName, const wchar_t *const *_ArgList,
                          const wchar_t *const *_Env);
#pragma binding(msvcrt::_wspawnl, "_wspawnl")
__INTPTR_TYPE__ _wspawnl(int _Mode, const wchar_t *_FileName, const wchar_t *_ArgList, ...);
#pragma binding(msvcrt::_wspawnle, "_wspawnle")
__INTPTR_TYPE__ _wspawnle(int _Mode, const wchar_t *_FileName, const wchar_t *_ArgList, ...);
#pragma binding(msvcrt::_wspawnlp, "_wspawnlp")
__INTPTR_TYPE__ _wspawnlp(int _Mode, const wchar_t *_FileName, const wchar_t *_ArgList, ...);
#pragma binding(msvcrt::_wspawnlpe, "_wspawnlpe")
__INTPTR_TYPE__ _wspawnlpe(int _Mode, const wchar_t *_FileName, const wchar_t *_ArgList, ...);
#pragma binding(msvcrt::_wspawnv, "_wspawnv")
__INTPTR_TYPE__ _wspawnv(int _Mode, const wchar_t *_FileName, const wchar_t *const *_ArgList);
#pragma binding(msvcrt::_wspawnve, "_wspawnve")
__INTPTR_TYPE__ _wspawnve(int _Mode, const wchar_t *_FileName, const wchar_t *const *_ArgList,
                          const wchar_t *const *_Env);
#pragma binding(msvcrt::_wspawnvp, "_wspawnvp")
__INTPTR_TYPE__ _wspawnvp(int _Mode, const wchar_t *_FileName, const wchar_t *const *_ArgList);
#pragma binding(msvcrt::_wspawnvpe, "_wspawnvpe")
__INTPTR_TYPE__ _wspawnvpe(int _Mode, const wchar_t *_FileName, const wchar_t *const *_ArgList,
                           const wchar_t *const *_Env);
#pragma binding(msvcrt::_wsystem, "_wsystem")
int _wsystem(const wchar_t *_Command);

#endif

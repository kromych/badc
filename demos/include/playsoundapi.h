/* Demo-local <playsoundapi.h>: the winmm PlaySound entry points, with the
 * Windows SDK signatures. raylib's fix_win32_compatibility.h includes it with
 * these names renamed, as it does the <windows.h> names raylib's API reuses. */
#ifndef _PLAYSOUNDAPI_H_
#define _PLAYSOUNDAPI_H_

#include <windows.h>

BOOL WINAPI PlaySoundA(LPCSTR pszSound, HMODULE hmod, DWORD fdwSound);
BOOL WINAPI PlaySoundW(LPCWSTR pszSound, HMODULE hmod, DWORD fdwSound);

#endif

// windows.h -- Win32 surface kept under its own name.
//
// dlfcn.h already aliases the loader trio (LoadLibraryA, etc.) to
// the portable POSIX-spelled names; this header is for sources that
// want to call the Win32 functions by their native names. Currently
// just the page-allocation trio plus the imports dlfcn.h doesn't
// expose, since that's what the badc fixtures reach for. Add more
// as you need them; the kernel32 dylib is the same one dlfcn.h
// declares, so include order doesn't matter.
//
// Including this header on a non-Windows target is a no-op -- the
// whole body is gated on `_WIN32` so cross-platform fixtures can
// `#include <windows.h>` unconditionally without having to wrap
// the include in their own `#ifdef`.

#pragma once

#ifdef _WIN32
#pragma dylib(kernel32, "kernel32.dll")
#pragma binding(kernel32::VirtualAlloc,            "VirtualAlloc")
#pragma binding(kernel32::VirtualProtect,          "VirtualProtect")
#pragma binding(kernel32::VirtualFree,             "VirtualFree")
#pragma binding(kernel32::LoadLibraryA,            "LoadLibraryA")
#pragma binding(kernel32::GetProcAddress,          "GetProcAddress")
#pragma binding(kernel32::FreeLibrary,             "FreeLibrary")
#pragma binding(kernel32::GetLastError,            "GetLastError")
#pragma binding(kernel32::ExitProcess,             "ExitProcess")
#pragma binding(kernel32::Sleep,                   "Sleep")
#pragma binding(kernel32::CreateThread,            "CreateThread")
#pragma binding(kernel32::WaitForSingleObject,     "WaitForSingleObject")
#pragma binding(kernel32::CloseHandle,             "CloseHandle")
#pragma binding(kernel32::GetExitCodeThread,       "GetExitCodeThread")
#pragma binding(kernel32::GetCurrentThreadId,      "GetCurrentThreadId")
#pragma binding(kernel32::InitializeCriticalSection, "InitializeCriticalSection")
#pragma binding(kernel32::EnterCriticalSection,    "EnterCriticalSection")
#pragma binding(kernel32::LeaveCriticalSection,    "LeaveCriticalSection")
#pragma binding(kernel32::DeleteCriticalSection,   "DeleteCriticalSection")

#define INFINITE        0xFFFFFFFF
#define WAIT_OBJECT_0   0
// CRITICAL_SECTION is a 40-byte opaque struct on x64; allocate 64
// for safety / future fields.
#define CRITICAL_SECTION_SIZE 64

// Windows API integer typedefs. The widths are pinned by the
// platform ABI -- DWORD is 32 bits, WORD 16, BYTE 8 -- so c5's
// struct layouts match what kernel32 / msvcrt expect when
// reading the same struct on the other side.
//
//   * HANDLE / SIZE_T / LPVOID / pointers: 8 bytes (Win64 LLP64).
//   * DWORD / BOOL / LONG: 4 bytes (= c5's `int`).
//   * WORD / SHORT: 2 bytes.
//   * BYTE: 1 byte.
//   * UINT_PTR / ULONG_PTR / DWORD_PTR / LARGE_INTEGER: 8 bytes.
//
// The header only declares the surface sqlite + the bundled c5
// fixtures actually reach for; extend on demand. Wide-string
// types (LPWSTR / LPCWSTR) point at unsigned short rather than
// `wchar_t` because c5 doesn't have a separate wchar_t typedef
// and msvcrt's wchar is 16-bit anyway.
typedef long long          HANDLE;
typedef long long          SIZE_T;
typedef long long          LARGE_INTEGER;
typedef long long          ULONG_PTR;
typedef long long          UINT_PTR;
typedef long long          DWORD_PTR;
typedef long long          LONG_PTR;
typedef int                BOOL;
typedef int                LONG;
typedef int                HRESULT;
typedef unsigned int       DWORD;
typedef unsigned int       UINT;
typedef unsigned int       ULONG;
typedef short              SHORT;
typedef unsigned short     WORD;
typedef unsigned short     USHORT;
typedef unsigned char      BYTE;
typedef unsigned char      UCHAR;
typedef void              *LPVOID;
typedef void              *PVOID;
typedef char              *LPSTR;
typedef char              *LPCSTR;
typedef unsigned short    *LPWSTR;
typedef unsigned short    *LPCWSTR;

// FILETIME / SYSTEMTIME -- the two structs sqlite's Windows VFS
// uses (file timestamps + broken-down localtime fallback). Layout
// matches the Win64 ABI byte-for-byte so kernel32 calls writing
// these can hand back results c5 can read.
struct _FILETIME {
    DWORD dwLowDateTime;
    DWORD dwHighDateTime;
};
typedef struct _FILETIME FILETIME;

struct _SYSTEMTIME {
    WORD wYear;
    WORD wMonth;
    WORD wDayOfWeek;
    WORD wDay;
    WORD wHour;
    WORD wMinute;
    WORD wSecond;
    WORD wMilliseconds;
};
typedef struct _SYSTEMTIME SYSTEMTIME;

char *VirtualAlloc(char *addr, long long size, int type, int protect);
int VirtualProtect(char *addr, long long size, int new_protect, int *old_protect);
int VirtualFree(char *addr, long long size, int type);
char *LoadLibraryA(char *name);
char *GetProcAddress(char *module, char *name);
int FreeLibrary(char *module);
int GetLastError();
int ExitProcess(int status);
int Sleep(int milliseconds);

// CreateThread returns a thread HANDLE (kernel object). Args
// mirror the Win32 prototype: lpThreadAttributes, dwStackSize,
// lpStartAddress, lpParameter, dwCreationFlags, lpThreadId.
HANDLE CreateThread(char *attrs, long long stack_size, int *start, char *param,
                    int flags, int *thread_id);
int WaitForSingleObject(HANDLE handle, int millis);
int CloseHandle(HANDLE handle);
int GetExitCodeThread(HANDLE handle, int *exit_code);
int GetCurrentThreadId();
int InitializeCriticalSection(char *cs);
int EnterCriticalSection(char *cs);
int LeaveCriticalSection(char *cs);
int DeleteCriticalSection(char *cs);
#endif

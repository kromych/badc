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

// `NULL` and `size_t` (C99 7.17) -- included so consumers
// that only pull in `<windows.h>` get them too.
#include <stddef.h>

// Windows SDK version constants. Real <windows.h> pulls these in so
// version-gated API selection (condition variables, etc.) resolves.
#include <sdkddkver.h>

// Win32 system error codes (GetLastError values) and the Winsock codes.
#include <winerror.h>

// Win32 API decoration macros. The runtime calls go through the
// IAT (kernel32.dll already exports them by name) so the
// __stdcall / __declspec(dllimport) tagging the headers carry on
// MSVC is irrelevant to the codegen -- empty expansions let
// sqlite's prototypes parse without c5 having to model the
// extension keywords. WINBASEAPI / WINAPI / WINAPI_INLINE / VOID
// / FAR / NEAR are the spellings sqlite's `os_win.c` reaches for.
// MSVC decoration spellings used by sqlite + the bundled C runtime
// headers. None of them affect codegen on c5 -- the IAT routes
// the call regardless of inline / dllimport tagging -- so they
// expand to nothing. `__declspec(...)` swallows its argument
// list; `__forceinline` / `__inline` collapse to nothing.
// Win32 TCHAR-aware string macros. Real headers expand these to
// `L"..."` under `UNICODE`; we treat them as no-ops because c5's
// runtime always reaches for the ANSI-flavoured calls. The
// matching `LoadLibrary` / `GetModuleHandle` / etc. macros pick
// the `A` suffix variant.
#define _T(x) x
#define __TEXT(x) x
#define TEXT(x) x
// Generic-text character type. c5 reaches for the ANSI-flavoured calls, so
// TCHAR is `char` unless the program opts into UNICODE.
#ifdef UNICODE
typedef unsigned short TCHAR;
#else
typedef char TCHAR;
#endif
#define LoadLibrary LoadLibraryA
#define GetModuleHandle GetModuleHandleA
#define GetSystemDirectory GetSystemDirectoryA
#define WINBASEAPI
#define WINAPI
#define WINAPI_INLINE
#define APIENTRY
#define CALLBACK
#define FAR
#define NEAR
#define VOID void
#define CONST const
#define IN
#define OUT
#define OPTIONAL
typedef void *FARPROC;
typedef void *HMODULE;
typedef void *HINSTANCE;
typedef void *HRGN;
typedef void *HKEY;
typedef int   *LPDWORD;
typedef int   *PDWORD;
typedef int    LPVOID_TYPE_PLACEHOLDER;
// LPCVOID and LPSECURITY_ATTRIBUTES are opaque pointers to sqlite;
// the Win32 dispatch table casts them to whatever shape it needs
// before any call.
typedef void  *LPCVOID;
typedef void  *LPSECURITY_ATTRIBUTES;
typedef void  *LPOVERLAPPED;
typedef void  *PSYSTEMTIME;
typedef void  *LPSYSTEMTIME;
// GET_FILEEX_INFO_LEVELS is an enum on real Windows; sqlite only
// ever passes the literal 0 (`GetFileExInfoStandard`) and never
// names the enum, so a typedef is enough to keep the prototype
// parseable.
typedef int    GET_FILEEX_INFO_LEVELS;
#define GetFileExInfoStandard 0
#define GetFileExMaxInfoLevel 1

#pragma dylib(kernel32, "kernel32.dll")
#pragma binding(kernel32::VirtualAlloc,            "VirtualAlloc")
#pragma binding(kernel32::VirtualProtect,          "VirtualProtect")
#pragma binding(kernel32::VirtualFree,             "VirtualFree")
#pragma binding(kernel32::LoadLibraryA,            "LoadLibraryA")
#pragma binding(kernel32::LoadLibraryExA,          "LoadLibraryExA")
#pragma binding(kernel32::LoadLibraryExW,          "LoadLibraryExW")
#pragma binding(kernel32::GetProcAddress,          "GetProcAddress")
#pragma binding(kernel32::FreeLibrary,             "FreeLibrary")
#pragma binding(kernel32::GetModuleFileNameA,      "GetModuleFileNameA")
// SearchPathA is the canonical kernel32 entry; the unsuffixed
// `SearchPath` spelling lets source compiled against `<windows.h>`
// pick up the same binding through the `#define SearchPath
// SearchPathA` alias below.
#pragma binding(kernel32::SearchPath,              "SearchPathA")
#pragma binding(kernel32::GetLastError,            "GetLastError")
#pragma binding(kernel32::ExitProcess,             "ExitProcess")
#pragma binding(kernel32::Sleep,                   "Sleep")
#pragma binding(kernel32::CreateThread,            "CreateThread")
// Function-table registration for SEH-style stack unwinding.
// `RtlAddFunctionTable` registers a `RUNTIME_FUNCTION` array as
// the unwind data for a code range; `RtlDeleteFunctionTable`
// removes a previously-registered table.
#pragma binding(kernel32::RtlAddFunctionTable,     "RtlAddFunctionTable")
#pragma binding(kernel32::RtlDeleteFunctionTable,  "RtlDeleteFunctionTable")
#pragma binding(kernel32::WaitForSingleObject,     "WaitForSingleObject")
#pragma binding(kernel32::CloseHandle,             "CloseHandle")
#pragma binding(kernel32::GetExitCodeThread,       "GetExitCodeThread")
#pragma binding(kernel32::SetThreadPriority,       "SetThreadPriority")
#pragma binding(kernel32::GetCurrentThreadId,      "GetCurrentThreadId")
#pragma binding(kernel32::InitializeCriticalSection, "InitializeCriticalSection")
#pragma binding(kernel32::InitializeCriticalSectionEx, "InitializeCriticalSectionEx")
#pragma binding(kernel32::EnterCriticalSection,    "EnterCriticalSection")
#pragma binding(kernel32::LeaveCriticalSection,    "LeaveCriticalSection")
#pragma binding(kernel32::DeleteCriticalSection,   "DeleteCriticalSection")
// Thread-local storage slots indexed off the TEB. A TlsAlloc index
// names a per-thread pointer-sized slot read/written by TlsGetValue /
// TlsSetValue and released by TlsFree.
#pragma binding(kernel32::TlsAlloc,                "TlsAlloc")
#pragma binding(kernel32::TlsGetValue,             "TlsGetValue")
#pragma binding(kernel32::TlsSetValue,             "TlsSetValue")
#pragma binding(kernel32::TlsFree,                 "TlsFree")
// Slim reader/writer locks and condition variables (Vista+).
#pragma binding(kernel32::InitializeSRWLock,           "InitializeSRWLock")
#pragma binding(kernel32::AcquireSRWLockExclusive,     "AcquireSRWLockExclusive")
#pragma binding(kernel32::ReleaseSRWLockExclusive,     "ReleaseSRWLockExclusive")
#pragma binding(kernel32::AcquireSRWLockShared,        "AcquireSRWLockShared")
#pragma binding(kernel32::ReleaseSRWLockShared,        "ReleaseSRWLockShared")
#pragma binding(kernel32::TryAcquireSRWLockExclusive,  "TryAcquireSRWLockExclusive")
#pragma binding(kernel32::TryAcquireSRWLockShared,     "TryAcquireSRWLockShared")
#pragma binding(kernel32::InitializeConditionVariable, "InitializeConditionVariable")
#pragma binding(kernel32::SleepConditionVariableSRW,   "SleepConditionVariableSRW")
#pragma binding(kernel32::SleepConditionVariableCS,    "SleepConditionVariableCS")
#pragma binding(kernel32::WakeConditionVariable,       "WakeConditionVariable")
#pragma binding(kernel32::WakeAllConditionVariable,    "WakeAllConditionVariable")
#pragma binding(kernel32::CreateSemaphoreW,            "CreateSemaphoreW")
#pragma binding(kernel32::ReleaseSemaphore,            "ReleaseSemaphore")
#pragma binding(kernel32::GetCurrentThread,            "GetCurrentThread")
#pragma binding(kernel32::GetProcessTimes,             "GetProcessTimes")
#pragma binding(kernel32::CancelIoEx,                  "CancelIoEx")
#pragma binding(kernel32::GetNumberOfConsoleInputEvents, "GetNumberOfConsoleInputEvents")
#pragma binding(kernel32::SetErrorMode,                "SetErrorMode")
#pragma binding(kernel32::GetErrorMode,                "GetErrorMode")
#pragma binding(kernel32::WaitForMultipleObjects,      "WaitForMultipleObjects")
#pragma binding(kernel32::GetThreadTimes,              "GetThreadTimes")
#pragma binding(kernel32::OpenThread,                  "OpenThread")
#pragma binding(kernel32::CompareStringOrdinal,        "CompareStringOrdinal")
#pragma binding(kernel32::GetOverlappedResult,         "GetOverlappedResult")
#pragma dylib(bcrypt, "bcrypt.dll")
#pragma binding(bcrypt::BCryptGenRandom,               "BCryptGenRandom")
#pragma dylib(advapi32, "advapi32.dll")
#pragma binding(advapi32::GetUserNameW,                "GetUserNameW")
#pragma binding(advapi32::ConvertStringSecurityDescriptorToSecurityDescriptorW, "ConvertStringSecurityDescriptorToSecurityDescriptorW")
// advapi32 registry API (winreg.h). The reflection-key entry points
// (RegEnable/Disable/QueryReflectionKey) are absent: callers resolve
// them at runtime through GetProcAddress, so no binding is needed.
#pragma binding(advapi32::RegCloseKey,                 "RegCloseKey")
#pragma binding(advapi32::RegConnectRegistryW,         "RegConnectRegistryW")
#pragma binding(advapi32::RegCreateKeyW,               "RegCreateKeyW")
#pragma binding(advapi32::RegCreateKeyExW,             "RegCreateKeyExW")
#pragma binding(advapi32::RegDeleteKeyW,               "RegDeleteKeyW")
#pragma binding(advapi32::RegDeleteKeyExW,             "RegDeleteKeyExW")
#pragma binding(advapi32::RegDeleteValueW,             "RegDeleteValueW")
#pragma binding(advapi32::RegEnumKeyExW,               "RegEnumKeyExW")
#pragma binding(advapi32::RegEnumValueW,               "RegEnumValueW")
#pragma binding(advapi32::RegFlushKey,                 "RegFlushKey")
#pragma binding(advapi32::RegLoadKeyW,                 "RegLoadKeyW")
#pragma binding(advapi32::RegOpenKeyExW,               "RegOpenKeyExW")
#pragma binding(advapi32::RegQueryInfoKeyW,            "RegQueryInfoKeyW")
#pragma binding(advapi32::RegQueryValueExW,            "RegQueryValueExW")
#pragma binding(advapi32::RegSaveKeyW,                 "RegSaveKeyW")
#pragma binding(advapi32::RegSetValueExW,              "RegSetValueExW")
#pragma dylib(pathcch, "api-ms-win-core-path-l1-1-0.dll")
#pragma binding(pathcch::PathCchSkipRoot,              "PathCchSkipRoot")
#pragma binding(pathcch::PathCchCombineEx,             "PathCchCombineEx")
#pragma dylib(version, "version.dll")
#pragma binding(version::GetFileVersionInfoSizeW,      "GetFileVersionInfoSizeW")
#pragma binding(version::GetFileVersionInfoW,          "GetFileVersionInfoW")
#pragma binding(version::VerQueryValueW,               "VerQueryValueW")
#pragma binding(kernel32::GetACP,                      "GetACP")
#pragma binding(kernel32::GetLocaleInfoA,              "GetLocaleInfoA")
#pragma binding(kernel32::GetFinalPathNameByHandleW,   "GetFinalPathNameByHandleW")
#pragma binding(kernel32::CreateWaitableTimerExW,      "CreateWaitableTimerExW")
#pragma binding(kernel32::ConnectNamedPipe,            "ConnectNamedPipe")
#pragma binding(kernel32::GetCurrentThreadStackLimits, "GetCurrentThreadStackLimits")
#pragma binding(kernel32::SetThreadStackGuarantee,     "SetThreadStackGuarantee")
#pragma binding(kernel32::GetModuleFileNameW,          "GetModuleFileNameW")
#pragma binding(kernel32::GetFileType,                 "GetFileType")
#pragma binding(kernel32::GetFileInformationByHandle,  "GetFileInformationByHandle")
#pragma binding(kernel32::GetFileInformationByHandleEx, "GetFileInformationByHandleEx")
#pragma binding(kernel32::SetFileInformationByHandle,  "SetFileInformationByHandle")
#pragma binding(kernel32::GetHandleInformation,        "GetHandleInformation")
#pragma binding(kernel32::SetHandleInformation,        "SetHandleInformation")
#pragma binding(kernel32::GetNamedPipeHandleStateW,    "GetNamedPipeHandleStateW")
#pragma binding(kernel32::SetNamedPipeHandleState,     "SetNamedPipeHandleState")
#pragma binding(kernel32::CreatePipe,                  "CreatePipe")
#pragma binding(kernel32::DeviceIoControl,             "DeviceIoControl")
#pragma binding(kernel32::CreateHardLinkW,             "CreateHardLinkW")
#pragma binding(kernel32::CreateSymbolicLinkW,         "CreateSymbolicLinkW")
#pragma binding(kernel32::MoveFileExW,                 "MoveFileExW")
#pragma binding(kernel32::MoveFileExA,                 "MoveFileExA")
#pragma binding(kernel32::SetEnvironmentVariableW,     "SetEnvironmentVariableW")
#pragma binding(kernel32::GetDriveTypeW,               "GetDriveTypeW")
#pragma binding(kernel32::GetDiskFreeSpaceExW,         "GetDiskFreeSpaceExW")
#pragma binding(kernel32::GetLogicalDriveStringsW,     "GetLogicalDriveStringsW")
#pragma binding(kernel32::GetVolumePathNameW,          "GetVolumePathNameW")
#pragma binding(kernel32::GetVolumePathNamesForVolumeNameW, "GetVolumePathNamesForVolumeNameW")
#pragma binding(kernel32::FindFirstVolumeW,            "FindFirstVolumeW")
#pragma binding(kernel32::FindNextVolumeW,             "FindNextVolumeW")
#pragma binding(kernel32::FindVolumeClose,             "FindVolumeClose")
#pragma binding(kernel32::GetActiveProcessorCount,     "GetActiveProcessorCount")
#pragma binding(kernel32::OpenProcess,                 "OpenProcess")
#pragma binding(kernel32::AddDllDirectory,             "AddDllDirectory")
#pragma binding(kernel32::RemoveDllDirectory,          "RemoveDllDirectory")
#pragma binding(kernel32::SetWaitableTimer,            "SetWaitableTimer")
#pragma binding(kernel32::SetWaitableTimerEx,          "SetWaitableTimerEx")
#pragma binding(kernel32::GetStringTypeW,              "GetStringTypeW")
#pragma binding(kernel32::PssCaptureSnapshot,          "PssCaptureSnapshot")
#pragma binding(kernel32::PssFreeSnapshot,             "PssFreeSnapshot")
#pragma binding(kernel32::PssQuerySnapshot,            "PssQuerySnapshot")
// Process / named-pipe / synchronization surface (processthreadsapi.h,
// namedpipeapi.h, memoryapi.h, fileapi.h, winbase.h).
#pragma binding(kernel32::CreateNamedPipeW,            "CreateNamedPipeW")
#pragma binding(kernel32::WaitNamedPipeW,              "WaitNamedPipeW")
#pragma binding(kernel32::PeekNamedPipe,               "PeekNamedPipe")
#pragma binding(kernel32::GetExitCodeProcess,          "GetExitCodeProcess")
#pragma binding(kernel32::ResumeThread,                "ResumeThread")
#pragma binding(kernel32::TerminateThread,             "TerminateThread")
#pragma binding(kernel32::GetVersion,                  "GetVersion")
#pragma binding(kernel32::GetTickCount64,              "GetTickCount64")
#pragma binding(kernel32::GetLongPathNameW,            "GetLongPathNameW")
#pragma binding(kernel32::GetShortPathNameW,           "GetShortPathNameW")
#pragma binding(kernel32::OpenFileMappingW,            "OpenFileMappingW")
#pragma binding(kernel32::VirtualQuery,                "VirtualQuery")
#pragma binding(kernel32::CopyFile2,                   "CopyFile2")
#pragma binding(kernel32::NeedCurrentDirectoryForExePathW, "NeedCurrentDirectoryForExePathW")
#pragma binding(kernel32::LCMapStringEx,               "LCMapStringEx")
#pragma binding(kernel32::InitializeProcThreadAttributeList, "InitializeProcThreadAttributeList")
#pragma binding(kernel32::UpdateProcThreadAttribute,   "UpdateProcThreadAttribute")
#pragma binding(kernel32::DeleteProcThreadAttributeList, "DeleteProcThreadAttributeList")
// Token-privilege surface (processthreadsapi.h / securitybaseapi.h).
#pragma binding(advapi32::OpenProcessToken,            "OpenProcessToken")
#pragma binding(advapi32::LookupPrivilegeValueW,       "LookupPrivilegeValueW")
#pragma binding(advapi32::AdjustTokenPrivileges,       "AdjustTokenPrivileges")

#define INFINITE        0xFFFFFFFF
#define WAIT_OBJECT_0   0
#define TRUE            1
#define FALSE           0
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
typedef void              *HANDLE;
typedef HANDLE            *PHANDLE;
typedef HANDLE            *LPHANDLE;
typedef unsigned long long SIZE_T;
typedef unsigned long long ULONG_PTR;
typedef unsigned long long UINT_PTR;
typedef unsigned long long DWORD_PTR;
typedef long long          LONG_PTR;
typedef long long          LONGLONG;
// basetsd.h pointer/integer conversions. HANDLE is pointer-width; a LONG
// sign-extends through LONG_PTR before becoming a HANDLE.
#define LongToHandle(h) ((HANDLE)(LONG_PTR)(long)(h))
#define HandleToLong(h) ((long)(LONG_PTR)(h))
#define ULongToHandle(h) ((HANDLE)(ULONG_PTR)(unsigned long)(h))
typedef unsigned long long ULONGLONG;
typedef long long          INT64;
typedef long long          LONG64;
typedef unsigned long long UINT64;
typedef unsigned long long ULONG64;
typedef unsigned long long DWORD64;
typedef unsigned long long DWORDLONG;
typedef int                INT32;
typedef int                LONG32;
typedef unsigned int       UINT32;
typedef unsigned int       ULONG32;
typedef unsigned int       DWORD32;
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
typedef unsigned char     *LPBYTE;
// REGSAM is winnt.h's ACCESS_MASK (a DWORD = unsigned long on Win32)
// used as the security-access mask of the registry API. LSTATUS is
// winreg.h's LONG-valued status return of the registry functions.
typedef unsigned long      REGSAM;
typedef LONG               LSTATUS;
typedef void              *LPVOID;
typedef void              *PVOID;
typedef char              *LPSTR;
typedef char              *LPCSTR;
typedef unsigned short    *LPWSTR;
typedef unsigned short    *LPCWSTR;
typedef unsigned short     WCHAR;
typedef unsigned short    *PWSTR;
typedef unsigned short    *PCWSTR;
// Generic-text pointer aliases. c5 builds ANSI, so the T-variants map to the
// narrow forms unless the program opts into UNICODE.
#ifdef UNICODE
typedef LPWSTR             LPTSTR;
typedef LPCWSTR            LPCTSTR;
#else
typedef LPSTR              LPTSTR;
typedef LPCSTR             LPCTSTR;
#endif
typedef LPCSTR             PCSTR;
typedef LPSTR              PSTR;
typedef long long          INT_PTR;
typedef long long          SSIZE_T;
typedef long long          LRESULT;
typedef long long          LPARAM;
typedef unsigned long long WPARAM;
typedef int                NTSTATUS;
typedef int               *LPBOOL;
typedef int               *PBOOL;
typedef unsigned char      BOOLEAN;

// Slim reader/writer lock, condition variable, and one-time init
// (Vista+). Pointer-sized opaque values per the Windows SDK.
typedef struct _RTL_SRWLOCK { PVOID Ptr; } SRWLOCK;
// Static initialiser for an SRWLOCK (minwinbase.h RTL_SRWLOCK_INIT).
#define SRWLOCK_INIT {0}
typedef struct _RTL_CONDITION_VARIABLE { PVOID Ptr; } CONDITION_VARIABLE;
typedef struct _RTL_RUN_ONCE { PVOID Ptr; } INIT_ONCE;
typedef SRWLOCK            *PSRWLOCK;
typedef CONDITION_VARIABLE *PCONDITION_VARIABLE;

// Layout matches RTL_CRITICAL_SECTION so the type embeds at the right
// size inside other structures (x64: 40 bytes).
typedef struct _RTL_CRITICAL_SECTION {
    PVOID     DebugInfo;
    LONG      LockCount;
    LONG      RecursionCount;
    HANDLE    OwningThread;
    HANDLE    LockSemaphore;
    ULONG_PTR SpinCount;
} CRITICAL_SECTION;
typedef CRITICAL_SECTION   *LPCRITICAL_SECTION;
typedef CRITICAL_SECTION   *PCRITICAL_SECTION;

// 128-bit volume-relative file identifier, per the Windows SDK.
typedef struct _FILE_ID_128 { unsigned char Identifier[16]; } FILE_ID_128;

// The anonymous struct is first, matching the Win32 header: a nested
// aggregate initializer (`{{lo, hi}}`) fills it, and `.LowPart` /
// `.HighPart` reach it directly. The named `u` struct overlaps at offset 0.
union _LARGE_INTEGER {
    struct {
        DWORD LowPart;
        LONG  HighPart;
    };
    struct {
        DWORD LowPart;
        LONG  HighPart;
    } u;
    long long QuadPart;
};

union _ULARGE_INTEGER {
    struct {
        DWORD LowPart;
        DWORD HighPart;
    };
    struct {
        DWORD LowPart;
        DWORD HighPart;
    } u;
    unsigned long long QuadPart;
};

typedef union _LARGE_INTEGER  LARGE_INTEGER;
typedef union _ULARGE_INTEGER ULARGE_INTEGER;
typedef union _LARGE_INTEGER  *PLARGE_INTEGER;
typedef union _ULARGE_INTEGER *PULARGE_INTEGER;

typedef void              *HLOCAL;
typedef void              *HGLOBAL;
typedef void              *HRSRC;
typedef void              *HKL;
typedef void              *HMENU;
typedef void              *HWND;
typedef void              *HDC;
typedef void              *HBITMAP;
typedef void              *HBRUSH;
typedef void              *HFONT;
typedef void              *HICON;
typedef void              *HCURSOR;
typedef void              *HMUTEX;
typedef void              *HMUTANT;
typedef void              *HEVENT;
typedef void              *HSEMAPHORE;
typedef void              *HKEY;
typedef HKEY              *PHKEY;
typedef void              *HCRYPTPROV;
typedef void              *HCRYPTKEY;
typedef void              *HMONITOR;

// OVERLAPPED -- the i/o completion descriptor struct passed by
// pointer to ReadFile / LockFileEx / WriteFile when those calls
// run in async mode. sqlite's Windows VFS only needs the layout
// (it never inspects the kernel-internal handle field), so the
// fields are pinned to match the Win64 ABI but the layout is
// frozen to "five 8-byte slots" for portability.
// The real Windows OVERLAPPED nests an anonymous union with an
// anonymous struct -- c5 doesn't model anonymous nesting, so the
// layout is flattened to four named u32/u64 slots that occupy the
// same 16 bytes the union/struct group does on Win64. sqlite
// accesses `ov.Offset` and `ov.OffsetHigh` so those names live at
// the same byte offsets the Windows headers put them at.
struct _OVERLAPPED {
    ULONG_PTR Internal;
    ULONG_PTR InternalHigh;
    DWORD Offset;
    DWORD OffsetHigh;
    HANDLE hEvent;
};
typedef struct _OVERLAPPED OVERLAPPED;
typedef struct _OVERLAPPED *POVERLAPPED;
typedef struct _OVERLAPPED *LPOVERLAPPED2;

// SYSTEM_INFO -- platform info populated by GetSystemInfo. Real
// Windows headers nest the OEM ID alongside the processor arch
// inside an anonymous union; c5 doesn't model anonymous nesting,
// so the layout is flattened to occupy the same bytes as the
// Win64 ABI version. sqlite reads `dwAllocationGranularity` and
// `dwPageSize` so those names live at the same offsets the kernel
// header puts them at.
struct _SYSTEM_INFO {
    DWORD     dwOemId;
    DWORD     dwPageSize;
    LPVOID    lpMinimumApplicationAddress;
    LPVOID    lpMaximumApplicationAddress;
    DWORD_PTR dwActiveProcessorMask;
    DWORD     dwNumberOfProcessors;
    DWORD     dwProcessorType;
    DWORD     dwAllocationGranularity;
    WORD      wProcessorLevel;
    WORD      wProcessorRevision;
};
typedef struct _SYSTEM_INFO SYSTEM_INFO;
typedef struct _SYSTEM_INFO *LPSYSTEM_INFO;

// SEH function-table entry. Layout differs between Win64 x64 and
// AArch64 / IA64; the fields below match the Win64 x64 shape
// since that is the only one any c5 consumer references today.
// AArch64 uses a different `UnwindData` encoding inside the same
// DWORD slot, so the c5-side declaration stays a flat
// three-DWORD struct that both ABIs accept by ignoring the
// platform-specific bit packing.
struct _RUNTIME_FUNCTION {
    DWORD BeginAddress;
    DWORD EndAddress;
    DWORD UnwindData;
};
typedef struct _RUNTIME_FUNCTION RUNTIME_FUNCTION;
typedef struct _RUNTIME_FUNCTION *PRUNTIME_FUNCTION;

// FILETIME / SYSTEMTIME -- the two structs sqlite's Windows VFS
// uses (file timestamps + broken-down localtime fallback). Layout
// matches the Win64 ABI byte-for-byte so kernel32 calls writing
// these can hand back results c5 can read.
struct _FILETIME {
    DWORD dwLowDateTime;
    DWORD dwHighDateTime;
};
typedef struct _FILETIME FILETIME;
typedef struct _FILETIME *LPFILETIME;
typedef struct _FILETIME *PFILETIME;

// File-information structures the path / stat layer reads field by field.
typedef struct _BY_HANDLE_FILE_INFORMATION {
    DWORD    dwFileAttributes;
    FILETIME ftCreationTime;
    FILETIME ftLastAccessTime;
    FILETIME ftLastWriteTime;
    DWORD    dwVolumeSerialNumber;
    DWORD    nFileSizeHigh;
    DWORD    nFileSizeLow;
    DWORD    nNumberOfLinks;
    DWORD    nFileIndexHigh;
    DWORD    nFileIndexLow;
} BY_HANDLE_FILE_INFORMATION;
typedef struct _FILE_BASIC_INFO {
    LARGE_INTEGER CreationTime;
    LARGE_INTEGER LastAccessTime;
    LARGE_INTEGER LastWriteTime;
    LARGE_INTEGER ChangeTime;
    DWORD         FileAttributes;
} FILE_BASIC_INFO;
typedef struct _FILE_ID_INFO {
    ULONGLONG   VolumeSerialNumber;
    FILE_ID_128 FileId;
} FILE_ID_INFO;
typedef struct _FILE_ATTRIBUTE_TAG_INFO {
    DWORD FileAttributes;
    DWORD ReparseTag;
} FILE_ATTRIBUTE_TAG_INFO;
typedef struct _VS_FIXEDFILEINFO {
    DWORD dwSignature;
    DWORD dwStrucVersion;
    DWORD dwFileVersionMS;
    DWORD dwFileVersionLS;
    DWORD dwProductVersionMS;
    DWORD dwProductVersionLS;
    DWORD dwFileFlagsMask;
    DWORD dwFileFlags;
    DWORD dwFileOS;
    DWORD dwFileType;
    DWORD dwFileSubtype;
    DWORD dwFileDateMS;
    DWORD dwFileDateLS;
} VS_FIXEDFILEINFO;
typedef struct _GUID {
    DWORD Data1;
    WORD  Data2;
    WORD  Data3;
    BYTE  Data4[8];
} GUID;
typedef struct _SECURITY_ATTRIBUTES {
    DWORD  nLength;
    LPVOID lpSecurityDescriptor;
    int    bInheritHandle;
} SECURITY_ATTRIBUTES;

// STARTUPINFOW / STARTUPINFOEXW / PROCESS_INFORMATION (processthreadsapi.h).
// Field order and widths match the Win64 ABI: STARTUPINFOW is passed by
// pointer to CreateProcessW, so the kernel reads each field at its native
// offset. cbReserved2 / lpReserved2 sit between wShowWindow and hStdInput as
// the SDK lays them out (a WORD then 4 bytes padding then an 8-byte pointer).
typedef struct _STARTUPINFOW {
    DWORD  cb;
    LPWSTR lpReserved;
    LPWSTR lpDesktop;
    LPWSTR lpTitle;
    DWORD  dwX;
    DWORD  dwY;
    DWORD  dwXSize;
    DWORD  dwYSize;
    DWORD  dwXCountChars;
    DWORD  dwYCountChars;
    DWORD  dwFillAttribute;
    DWORD  dwFlags;
    WORD   wShowWindow;
    WORD   cbReserved2;
    LPBYTE lpReserved2;
    HANDLE hStdInput;
    HANDLE hStdOutput;
    HANDLE hStdError;
} STARTUPINFOW;
typedef struct _STARTUPINFOW *LPSTARTUPINFOW;

// Opaque process-thread attribute list. CreateProcessW reads the bytes;
// callers only ever pass a pointer obtained from
// InitializeProcThreadAttributeList.
typedef struct _PROC_THREAD_ATTRIBUTE_LIST PROC_THREAD_ATTRIBUTE_LIST;
typedef PROC_THREAD_ATTRIBUTE_LIST *LPPROC_THREAD_ATTRIBUTE_LIST;

typedef struct _STARTUPINFOEXW {
    STARTUPINFOW                 StartupInfo;
    LPPROC_THREAD_ATTRIBUTE_LIST lpAttributeList;
} STARTUPINFOEXW;
typedef struct _STARTUPINFOEXW *LPSTARTUPINFOEXW;

typedef struct _PROCESS_INFORMATION {
    HANDLE hProcess;
    HANDLE hThread;
    DWORD  dwProcessId;
    DWORD  dwThreadId;
} PROCESS_INFORMATION;
typedef struct _PROCESS_INFORMATION *LPPROCESS_INFORMATION;
typedef struct _PROCESS_INFORMATION *PPROCESS_INFORMATION;

// Token-privilege structures (winnt.h). LUID is the locally-unique 64-bit
// identifier a privilege is named by; TOKEN_PRIVILEGES carries a
// variable-length Privileges array (declared [1]; callers overallocate).
typedef struct _LUID {
    DWORD LowPart;
    LONG  HighPart;
} LUID;
typedef struct _LUID *PLUID;
typedef struct _LUID_AND_ATTRIBUTES {
    LUID  Luid;
    DWORD Attributes;
} LUID_AND_ATTRIBUTES;
typedef struct _TOKEN_PRIVILEGES {
    DWORD               PrivilegeCount;
    LUID_AND_ATTRIBUTES Privileges[1];
} TOKEN_PRIVILEGES;
typedef struct _TOKEN_PRIVILEGES *PTOKEN_PRIVILEGES;

// MEMORY_BASIC_INFORMATION (winnt.h) populated by VirtualQuery; Win64
// layout is 48 bytes with the trailing PartitionId on recent SDKs.
typedef struct _MEMORY_BASIC_INFORMATION {
    PVOID  BaseAddress;
    PVOID  AllocationBase;
    DWORD  AllocationProtect;
    WORD   PartitionId;
    SIZE_T RegionSize;
    DWORD  State;
    DWORD  Protect;
    DWORD  Type;
} MEMORY_BASIC_INFORMATION;
typedef struct _MEMORY_BASIC_INFORMATION *PMEMORY_BASIC_INFORMATION;

// COPYFILE2_EXTENDED_PARAMETERS (winbase.h) passed by pointer to CopyFile2.
typedef struct _COPYFILE2_EXTENDED_PARAMETERS {
    DWORD  dwSize;
    DWORD  dwCopyFlags;
    int   *pfCancel;
    void  *pProgressRoutine;
    void  *pvCallbackContext;
} COPYFILE2_EXTENDED_PARAMETERS;
typedef void *DLL_DIRECTORY_COOKIE;
typedef struct _FILE_FS_PERSISTENT_VOLUME_INFORMATION {
    ULONG VolumeFlags;
    ULONG FlagMask;
    ULONG Version;
    ULONG Reserved;
} FILE_FS_PERSISTENT_VOLUME_INFORMATION;
typedef struct _OSVERSIONINFOEXW {
    DWORD          dwOSVersionInfoSize;
    DWORD          dwMajorVersion;
    DWORD          dwMinorVersion;
    DWORD          dwBuildNumber;
    DWORD          dwPlatformId;
    unsigned short szCSDVersion[128];
    WORD           wServicePackMajor;
    WORD           wServicePackMinor;
    WORD           wSuiteMask;
    unsigned char  wProductType;
    unsigned char  wReserved;
} OSVERSIONINFOEXW;
typedef struct _OSVERSIONINFOEXW *LPOSVERSIONINFOEXW;
typedef struct _OSVERSIONINFOEXW *POSVERSIONINFOEXW;

// OSVERSIONINFOA / OSVERSIONINFOW -- sqlite reads `dwPlatformId`
// out of the struct after a `GetVersionEx*` call. The other fields
// are present for layout fidelity (so the kernel32 callee writes
// the platform id at the offset c5 reads from). The W variant
// uses an `unsigned short` szCSDVersion[128] to mirror the wchar_t
// shape on real Windows -- c5 doesn't have wchar_t but our
// LPWSTR is `unsigned short *`, so the inline array follows the
// same convention.
struct _OSVERSIONINFOA {
    DWORD dwOSVersionInfoSize;
    DWORD dwMajorVersion;
    DWORD dwMinorVersion;
    DWORD dwBuildNumber;
    DWORD dwPlatformId;
    char  szCSDVersion[128];
};
typedef struct _OSVERSIONINFOA OSVERSIONINFOA;
typedef struct _OSVERSIONINFOA *LPOSVERSIONINFOA;
typedef struct _OSVERSIONINFOA *POSVERSIONINFOA;

struct _OSVERSIONINFOW {
    DWORD dwOSVersionInfoSize;
    DWORD dwMajorVersion;
    DWORD dwMinorVersion;
    DWORD dwBuildNumber;
    DWORD dwPlatformId;
    unsigned short szCSDVersion[128];
};
typedef struct _OSVERSIONINFOW OSVERSIONINFOW;
typedef struct _OSVERSIONINFOW *LPOSVERSIONINFOW;
typedef struct _OSVERSIONINFOW *POSVERSIONINFOW;

// Generic OSVERSIONINFO* names resolve to the W variant (winbase.h
// under UNICODE), matching the rest of this header's A/W convention.
typedef OSVERSIONINFOW OSVERSIONINFO;
typedef OSVERSIONINFOW *LPOSVERSIONINFO;
typedef OSVERSIONINFOW *POSVERSIONINFO;
typedef OSVERSIONINFOEXW OSVERSIONINFOEX;
typedef OSVERSIONINFOEXW *LPOSVERSIONINFOEX;
typedef OSVERSIONINFOEXW *POSVERSIONINFOEX;

#define VER_PLATFORM_WIN32s         0
#define VER_PLATFORM_WIN32_WINDOWS  1
#define VER_PLATFORM_WIN32_NT       2

// VerifyVersionInfo type masks and comparison operators (winnt.h).
// VER_SET_CONDITION folds an operator into the condition mask via
// VerSetConditionMask.
#define VER_MINORVERSION     0x0000001
#define VER_MAJORVERSION     0x0000002
#define VER_BUILDNUMBER      0x0000004
#define VER_PLATFORMID       0x0000008
#define VER_SERVICEPACKMINOR 0x0000010
#define VER_SERVICEPACKMAJOR 0x0000020
#define VER_SUITENAME        0x0000040
#define VER_PRODUCT_TYPE     0x0000080
#define VER_EQUAL            1
#define VER_GREATER          2
#define VER_GREATER_EQUAL    3
#define VER_LESS             4
#define VER_LESS_EQUAL       5
#define VER_AND              6
#define VER_OR               7
#define VER_SET_CONDITION(mask, type, cond) \
    ((mask) = VerSetConditionMask((mask), (type), (cond)))

// GetComputerNameExW name selector (sysinfoapi.h) and the NetBIOS
// name length cap (winbase.h).
#define MAX_COMPUTERNAME_LENGTH 15
typedef enum _COMPUTER_NAME_FORMAT {
    ComputerNameNetBIOS,
    ComputerNameDnsHostname,
    ComputerNameDnsDomain,
    ComputerNameDnsFullyQualified,
    ComputerNamePhysicalNetBIOS,
    ComputerNamePhysicalDnsHostname,
    ComputerNamePhysicalDnsDomain,
    ComputerNamePhysicalDnsFullyQualified,
    ComputerNameMax
} COMPUTER_NAME_FORMAT;

// Codepage / API constants the Win32 VFS reaches for. Values
// pinned by the platform; sqlite consumes them as plain integer
// arguments to `MultiByteToWideChar` / `WideCharToMultiByte` and
// the file/lock APIs.
#define CP_ACP              0
#define CP_OEMCP            1
#define CP_UTF8             65001
#define MB_ERR_INVALID_CHARS 0x00000008
#define WC_ERR_INVALID_CHARS 0x00000080
#define WC_NO_BEST_FIT_CHARS 0x00000400

// File access / share / creation flags.
#define GENERIC_READ        0x80000000
#define GENERIC_WRITE       0x40000000
#define GENERIC_EXECUTE     0x20000000
#define GENERIC_ALL         0x10000000
#define MAXIMUM_ALLOWED     0x02000000
#define FILE_READ_DATA      0x00000001
#define FILE_EXECUTE        0x00000020
#define SYNCHRONIZE         0x00100000
#define FILE_SHARE_READ     0x00000001
#define FILE_SHARE_WRITE    0x00000002
#define FILE_SHARE_DELETE   0x00000004
#define CREATE_NEW          1
#define CREATE_ALWAYS       2
#define OPEN_EXISTING       3
#define OPEN_ALWAYS         4
#define TRUNCATE_EXISTING   5
#define FILE_ATTRIBUTE_READONLY        0x00000001
#define FILE_ATTRIBUTE_HIDDEN          0x00000002
#define FILE_ATTRIBUTE_SYSTEM          0x00000004
#define FILE_ATTRIBUTE_DIRECTORY       0x00000010
#define FILE_ATTRIBUTE_ARCHIVE         0x00000020
#define FILE_ATTRIBUTE_DEVICE          0x00000040
#define FILE_ATTRIBUTE_NORMAL          0x00000080
#define FILE_ATTRIBUTE_TEMPORARY       0x00000100
#define FILE_ATTRIBUTE_SPARSE_FILE     0x00000200
#define FILE_ATTRIBUTE_REPARSE_POINT   0x00000400
#define FILE_ATTRIBUTE_COMPRESSED      0x00000800
#define FILE_ATTRIBUTE_OFFLINE         0x00001000
#define FILE_ATTRIBUTE_NOT_CONTENT_INDEXED 0x00002000
#define FILE_ATTRIBUTE_ENCRYPTED       0x00004000
#define FILE_FLAG_RANDOM_ACCESS        0x10000000
#define FILE_FLAG_OVERLAPPED           0x40000000
#define FILE_FLAG_WRITE_THROUGH        0x80000000
#define FILE_FLAG_DELETE_ON_CLOSE      0x04000000
#define FILE_FLAG_BACKUP_SEMANTICS     0x02000000
#define FILE_FLAG_POSIX_SEMANTICS      0x01000000
#define FILE_FLAG_OPEN_REPARSE_POINT   0x00200000
#define FILE_FLAG_OPEN_NO_RECALL       0x00100000
#define FILE_FLAG_NO_BUFFERING         0x20000000
#define FILE_FLAG_SEQUENTIAL_SCAN      0x08000000
#define FILE_WRITE_ATTRIBUTES          0x100
#define FILE_READ_ATTRIBUTES           0x80
#define INVALID_HANDLE_VALUE           ((HANDLE)-1)
#define INVALID_FILE_ATTRIBUTES        0xFFFFFFFF
#define INVALID_SET_FILE_POINTER       0xFFFFFFFF
#define FILE_BEGIN          0
#define FILE_CURRENT        1
#define FILE_END            2

// Memory protection / map-view flags.
#define PAGE_NOACCESS       0x01
#define PAGE_READONLY       0x02
#define PAGE_READWRITE      0x04
#define PAGE_WRITECOPY      0x08
#define PAGE_EXECUTE        0x10
#define PAGE_EXECUTE_READ   0x20
#define PAGE_EXECUTE_READWRITE 0x40

// VirtualAlloc / VirtualFree allocation-type flags.
#define MEM_COMMIT          0x00001000
#define MEM_RESERVE         0x00002000
#define MEM_DECOMMIT        0x00004000
#define MEM_RELEASE         0x00008000
#define MEM_RESET           0x00080000
#define MEM_TOP_DOWN        0x00100000
#define MEM_LARGE_PAGES     0x20000000

// Section / process / event access masks.
#define SECTION_ALL_ACCESS  0x000F001FUL
#define PROCESS_ALL_ACCESS  0x001FFFFFUL
#define THREAD_ALL_ACCESS   0x001FFFFFUL
#define EVENT_ALL_ACCESS    0x001F0003UL
#define EVENT_MODIFY_STATE  0x00000002UL
#define SEC_IMAGE           0x01000000UL
#define FILE_MAP_READ       0x0004
#define FILE_MAP_WRITE      0x0002
#define FILE_MAP_COPY       0x0001
#define SECTION_MAP_READ    FILE_MAP_READ
#define SECTION_MAP_WRITE   FILE_MAP_WRITE

// LockFile / LockFileEx control bits.
#define LOCKFILE_FAIL_IMMEDIATELY 0x00000001
#define LOCKFILE_EXCLUSIVE_LOCK   0x00000002

// FormatMessage flag bits.
#define FORMAT_MESSAGE_ALLOCATE_BUFFER 0x00000100
#define FORMAT_MESSAGE_FROM_SYSTEM     0x00001000
#define FORMAT_MESSAGE_IGNORE_INSERTS  0x00000200
#define FORMAT_MESSAGE_FROM_HMODULE    0x00000800
#define FORMAT_MESSAGE_ARGUMENT_ARRAY  0x00002000
#define FORMAT_MESSAGE_MAX_WIDTH_MASK  0x000000FF
#define LANG_NEUTRAL                   0
#define SUBLANG_DEFAULT                1

// Heap function flags.
#define HEAP_NO_SERIALIZE              0x00000001
#define HEAP_GENERATE_EXCEPTIONS       0x00000004
#define HEAP_ZERO_MEMORY               0x00000008
#define HEAP_REALLOC_IN_PLACE_ONLY     0x00000010

// Win32 system error codes are in <winerror.h> (included above).
#define WAIT_TIMEOUT                   258
#define SEM_FAILCRITICALERRORS         0x0001
#define THREAD_QUERY_LIMITED_INFORMATION 0x0800
#define FILE_ATTRIBUTE_VIRTUAL         0x00010000
#define STATUS_CONTROL_C_EXIT          0xC000013A
#define CP_UTF7                        65000
#define CP_UTF8                        65001
#define IO_REPARSE_TAG_SYMLINK         0xA000000C
// winnt.h surrogate-bit predicate over the reparse tag; not an export.
#define IsReparseTagNameSurrogate(tag) (((tag) & 0x20000000))
#define BCRYPT_USE_SYSTEM_PREFERRED_RNG 0x00000002
#define EXCEPTION_CONTINUE_SEARCH      0
#define EXCEPTION_EXECUTE_HANDLER      1
#define EXCEPTION_NONCONTINUABLE       0x1
#define EXCEPTION_ACCESS_VIOLATION     0xC0000005
#define EXCEPTION_IN_PAGE_ERROR        0xC0000006
#define EXCEPTION_NONCONTINUABLE_EXCEPTION 0xC0000025
#define EXCEPTION_FLT_DIVIDE_BY_ZERO   0xC000008E
#define EXCEPTION_FLT_OVERFLOW         0xC0000091
#define EXCEPTION_INT_DIVIDE_BY_ZERO   0xC0000094
#define EXCEPTION_INT_OVERFLOW         0xC0000095
#define EXCEPTION_STACK_OVERFLOW       0xC00000FD
#define IO_REPARSE_TAG_MOUNT_POINT     0xA0000003
#define IO_REPARSE_TAG_APPEXECLINK     0x8000001B
#define SDDL_REVISION_1                1
#define MOVEFILE_REPLACE_EXISTING      0x00000001
#define MOVEFILE_COPY_ALLOWED          0x00000002
#define MOVEFILE_WRITE_THROUGH         0x00000008
#define SYMBOLIC_LINK_FLAG_DIRECTORY   0x00000001
#define SYMBOLIC_LINK_FLAG_ALLOW_UNPRIVILEGED_CREATE 0x00000002
#define HANDLE_FLAG_INHERIT            0x00000001
#define HANDLE_FLAG_PROTECT_FROM_CLOSE 0x00000002
#define ALL_PROCESSOR_GROUPS           0xffff
#define SEM_NOGPFAULTERRORBOX          0x0002
#define SEM_NOALIGNMENTFAULTEXCEPT     0x0004
#define SEM_NOOPENFILEERRORBOX         0x8000
#define CSTR_LESS_THAN                 1
#define CSTR_EQUAL                     2
#define CSTR_GREATER_THAN              3
#define LOAD_WITH_ALTERED_SEARCH_PATH      0x00000008
#define LOAD_LIBRARY_SEARCH_DLL_LOAD_DIR   0x00000100
#define LOAD_LIBRARY_SEARCH_APPLICATION_DIR 0x00000200
#define LOAD_LIBRARY_SEARCH_USER_DIRS      0x00000400
#define LOAD_LIBRARY_SEARCH_SYSTEM32       0x00000800
#define LOAD_LIBRARY_SEARCH_DEFAULT_DIRS   0x00001000
#define BCRYPT_SUCCESS(status) (((NTSTATUS)(status)) >= 0)
#define TLS_OUT_OF_INDEXES             0xFFFFFFFF
#define TIMER_ALL_ACCESS               0x1F0003
#define VOLUME_NAME_DOS                0x0
#define VOLUME_NAME_GUID               0x1
#define VOLUME_NAME_NT                 0x2
#define VOLUME_NAME_NONE               0x4
#define FILE_NAME_NORMALIZED           0x0
#define FILE_NAME_OPENED               0x8
#define CreateEvent CreateEventA
#define CREATE_WAITABLE_TIMER_HIGH_RESOLUTION 0x00000002
#define CT_CTYPE1          1
#define CT_CTYPE2          2
#define CT_CTYPE3          4
#define FILE_TYPE_UNKNOWN  0x0000
#define FILE_TYPE_DISK     0x0001
#define FILE_TYPE_CHAR     0x0002
#define FILE_TYPE_PIPE     0x0003
#define FILE_TYPE_REMOTE   0x8000
#define FILE_DEVICE_BEEP                0x00000001
#define FILE_DEVICE_CD_ROM              0x00000002
#define FILE_DEVICE_CD_ROM_FILE_SYSTEM  0x00000003
#define FILE_DEVICE_CONTROLLER          0x00000004
#define FILE_DEVICE_DATALINK            0x00000005
#define FILE_DEVICE_DFS                 0x00000006
#define FILE_DEVICE_DISK                0x00000007
#define FILE_DEVICE_DISK_FILE_SYSTEM    0x00000008
#define FILE_DEVICE_FILE_SYSTEM         0x00000009
#define FILE_DEVICE_INPORT_PORT         0x0000000a
#define FILE_DEVICE_KEYBOARD            0x0000000b
#define FILE_DEVICE_MAILSLOT            0x0000000c
#define FILE_DEVICE_MIDI_IN             0x0000000d
#define FILE_DEVICE_MIDI_OUT            0x0000000e
#define FILE_DEVICE_MOUSE               0x0000000f
#define FILE_DEVICE_MULTI_UNC_PROVIDER  0x00000010
#define FILE_DEVICE_NAMED_PIPE          0x00000011
#define FILE_DEVICE_NETWORK             0x00000012
#define FILE_DEVICE_NETWORK_BROWSER     0x00000013
#define FILE_DEVICE_NETWORK_FILE_SYSTEM 0x00000014
#define FILE_DEVICE_NULL                0x00000015
#define FILE_DEVICE_PARALLEL_PORT       0x00000016
#define FILE_DEVICE_PHYSICAL_NETCARD    0x00000017
#define FILE_DEVICE_PRINTER             0x00000018
#define FILE_DEVICE_SCANNER             0x00000019
#define FILE_DEVICE_SERIAL_MOUSE_PORT   0x0000001a
#define FILE_DEVICE_SERIAL_PORT         0x0000001b
#define FILE_DEVICE_SCREEN              0x0000001c
#define FILE_DEVICE_SOUND               0x0000001d
#define FILE_DEVICE_STREAMS             0x0000001e
#define FILE_DEVICE_TAPE                0x0000001f
#define FILE_DEVICE_TAPE_FILE_SYSTEM    0x00000020
#define FILE_DEVICE_TRANSPORT           0x00000021
#define FILE_DEVICE_UNKNOWN             0x00000022
#define FILE_DEVICE_VIDEO               0x00000023
#define FILE_DEVICE_VIRTUAL_DISK        0x00000024
#define FILE_DEVICE_WAVE_IN             0x00000025
#define FILE_DEVICE_WAVE_OUT            0x00000026
#define FILE_DEVICE_8042_PORT           0x00000027
#define FILE_DEVICE_NETWORK_REDIRECTOR  0x00000028
#define FILE_DEVICE_BATTERY             0x00000029
#define FILE_DEVICE_BUS_EXTENDER        0x0000002a
#define FILE_DEVICE_MODEM               0x0000002b
#define FILE_DEVICE_VDM                 0x0000002c
#define FILE_DEVICE_MASS_STORAGE        0x0000002d
#define FILE_DEVICE_SMB                 0x0000002e
#define FILE_DEVICE_KS                  0x0000002f
#define FILE_DEVICE_CHANGER             0x00000030
#define FILE_DEVICE_SMARTCARD           0x00000031
#define FILE_DEVICE_ACPI                0x00000032
#define FILE_DEVICE_DVD                 0x00000033
#define FILE_DEVICE_FULLSCREEN_VIDEO    0x00000034
#define FILE_DEVICE_DFS_FILE_SYSTEM     0x00000035
#define FILE_DEVICE_DFS_VOLUME          0x00000036
#define FILE_DEVICE_SERENUM             0x00000037
#define FILE_DEVICE_TERMSRV             0x00000038
#define FILE_DEVICE_KSEC                0x00000039
#define FILE_DEVICE_FIPS                0x0000003a
#define FILE_DEVICE_INFINIBAND          0x0000003b
#define FILE_DEVICE_CONSOLE             0x00000050
#define FILE_DEVICE_NFS                 0x00000051
#define FILE_DEVICE_TCP_UDP             0x00000052
// FILE_INFO_BY_HANDLE_CLASS values for GetFileInformationByHandleEx.
#define FileBasicInfo        0
#define FileStandardInfo     1
#define FileNameInfo         2
#define FileStreamInfo       7
#define FileAttributeTagInfo 9
#define FileIdBothDirectoryInfo 10
#define FileIdInfo           18
// Locale identifiers for GetLocaleInfoA.
#define LOCALE_USER_DEFAULT      0x0400
#define LOCALE_SYSTEM_DEFAULT    0x0800
#define LOCALE_SISO639LANGNAME   0x59
#define LOCALE_SISO3166CTRYNAME  0x5a
#define LOCALE_NAME_MAX_LENGTH   85
#define LOCALE_IDEFAULTLANGUAGE     0x09
#define LOCALE_IDEFAULTCOUNTRY      0x0a
#define LOCALE_IDEFAULTCODEPAGE     0x0b
#define LOCALE_IDEFAULTANSICODEPAGE 0x1004
#define DRIVE_UNKNOWN      0
#define DRIVE_NO_ROOT_DIR  1
#define DRIVE_REMOVABLE    2
#define DRIVE_FIXED        3
#define DRIVE_REMOTE       4
#define DRIVE_CDROM        5
#define DRIVE_RAMDISK      6
#define PIPE_WAIT             0x00000000
#define PIPE_NOWAIT           0x00000001
#define PIPE_READMODE_BYTE    0x00000000
#define PIPE_READMODE_MESSAGE 0x00000002
#define PIPE_TYPE_BYTE        0x00000000
#define PIPE_TYPE_MESSAGE     0x00000004
#define PIPE_ACCESS_INBOUND   0x00000001
#define PIPE_ACCESS_OUTBOUND  0x00000002
#define PIPE_ACCESS_DUPLEX    0x00000003
// Device I/O control codes (winioctl.h CTL_CODE construction).
#define METHOD_BUFFERED   0
#define METHOD_IN_DIRECT  1
#define METHOD_OUT_DIRECT 2
#define METHOD_NEITHER    3
#define FILE_ANY_ACCESS     0
#define FILE_SPECIAL_ACCESS 0
#define FILE_READ_ACCESS    1
#define FILE_WRITE_ACCESS   2
#define CTL_CODE(DeviceType, Function, Method, Access) \
    (((DeviceType) << 16) | ((Access) << 14) | ((Function) << 2) | (Method))
#define FSCTL_GET_REPARSE_POINT \
    CTL_CODE(FILE_DEVICE_FILE_SYSTEM, 42, METHOD_BUFFERED, FILE_ANY_ACCESS)
#define FSCTL_SET_REPARSE_POINT \
    CTL_CODE(FILE_DEVICE_FILE_SYSTEM, 41, METHOD_BUFFERED, FILE_SPECIAL_ACCESS)
#define FSCTL_DELETE_REPARSE_POINT \
    CTL_CODE(FILE_DEVICE_FILE_SYSTEM, 43, METHOD_BUFFERED, FILE_SPECIAL_ACCESS)
#define FSCTL_QUERY_PERSISTENT_VOLUME_STATE \
    CTL_CODE(FILE_DEVICE_FILE_SYSTEM, 57, METHOD_BUFFERED, FILE_ANY_ACCESS)
#define PATHCCH_ALLOW_LONG_PATHS 0x00000001
// winnt.h byte-offset of a struct member; equivalent to <stddef.h>
// offsetof, which windows.h pulls in above.
#define FIELD_OFFSET(type, field) ((LONG)offsetof(type, field))
#define RTL_SIZEOF_THROUGH_FIELD(type, field) \
    (FIELD_OFFSET(type, field) + sizeof(((type *)0)->field))
#define LOWORD(l) ((WORD)((DWORD_PTR)(l) & 0xffff))
#define HIWORD(l) ((WORD)(((DWORD_PTR)(l) >> 16) & 0xffff))
#define LOBYTE(w) ((BYTE)((DWORD_PTR)(w) & 0xff))
#define HIBYTE(w) ((BYTE)(((DWORD_PTR)(w) >> 8) & 0xff))
// Character-type bits returned by GetStringTypeW for CT_CTYPE3.
#define C3_NONSPACING    0x0001
#define C3_DIACRITIC     0x0002
#define C3_VOWELMARK     0x0004
#define C3_SYMBOL        0x0008
#define C3_KATAKANA      0x0010
#define C3_HIRAGANA      0x0020
#define C3_HALFWIDTH     0x0040
#define C3_FULLWIDTH     0x0080
#define C3_IDEOGRAPH     0x0100
#define C3_KASHIDA       0x0200
#define C3_LEXICAL       0x0400
#define C3_HIGHSURROGATE 0x0800
#define C3_LOWSURROGATE  0x1000
#define C3_ALPHA         0x8000
#define C3_NOTAPPLICABLE 0x0000
#define MAKELANGID(p, s) ((((WORD)(s)) << 10) | (WORD)(p))
#ifndef min
#define min(a, b) (((a) < (b)) ? (a) : (b))
#endif
#ifndef max
#define max(a, b) (((a) > (b)) ? (a) : (b))
#endif
#define ERROR_INVALID_FUNCTION         1
#define ERROR_TOO_MANY_OPEN_FILES      4
#define ERROR_CANNOT_MAKE              82
#define ERROR_RETRY                    1237
#define ERROR_OPERATION_ABORTED        995
#define ERROR_IO_INCOMPLETE            996
#define ERROR_IO_PENDING               997
#define ERROR_ALREADY_EXISTS           183
#define ERROR_DEV_NOT_EXIST            55
#define ERROR_NETWORK_UNREACHABLE      1231
#define ERROR_SEM_TIMEOUT              121
#define ERROR_USER_MAPPED_FILE         1224
#define NO_ERROR                       0
#define STATUS_PENDING                 0x00000103

// Registry predefined keys, access rights, and value/option types
// (winnt.h). HKEY_* are the fixed pseudo-handles; the cast routes a
// 32-bit constant through the 64-bit HKEY without sign extension.
// The registry status codes ERROR_SUCCESS / ERROR_MORE_DATA come
// from <winerror.h>.
#define HKEY_CLASSES_ROOT     ((HKEY)(unsigned long long)0x80000000)
#define HKEY_CURRENT_USER     ((HKEY)(unsigned long long)0x80000001)
#define HKEY_LOCAL_MACHINE    ((HKEY)(unsigned long long)0x80000002)
#define HKEY_USERS            ((HKEY)(unsigned long long)0x80000003)
#define HKEY_PERFORMANCE_DATA ((HKEY)(unsigned long long)0x80000004)
#define HKEY_CURRENT_CONFIG   ((HKEY)(unsigned long long)0x80000005)
#define HKEY_DYN_DATA         ((HKEY)(unsigned long long)0x80000006)

#define KEY_QUERY_VALUE        0x0001
#define KEY_SET_VALUE          0x0002
#define KEY_CREATE_SUB_KEY     0x0004
#define KEY_ENUMERATE_SUB_KEYS 0x0008
#define KEY_NOTIFY             0x0010
#define KEY_CREATE_LINK        0x0020
#define KEY_WOW64_64KEY        0x0100
#define KEY_WOW64_32KEY        0x0200
#define KEY_READ               0x20019
#define KEY_WRITE              0x20006
#define KEY_EXECUTE            0x20019
#define KEY_ALL_ACCESS         0xF003F

#define REG_NONE                       0
#define REG_SZ                         1
#define REG_EXPAND_SZ                  2
#define REG_BINARY                     3
#define REG_DWORD                      4
#define REG_DWORD_LITTLE_ENDIAN        4
#define REG_DWORD_BIG_ENDIAN           5
#define REG_LINK                       6
#define REG_MULTI_SZ                   7
#define REG_RESOURCE_LIST              8
#define REG_FULL_RESOURCE_DESCRIPTOR   9
#define REG_RESOURCE_REQUIREMENTS_LIST 10
#define REG_QWORD                      11
#define REG_QWORD_LITTLE_ENDIAN        11

#define REG_OPTION_RESERVED       0
#define REG_OPTION_NON_VOLATILE   0
#define REG_OPTION_VOLATILE       1
#define REG_OPTION_CREATE_LINK    2
#define REG_OPTION_BACKUP_RESTORE 4
#define REG_OPTION_OPEN_LINK      8

#define REG_CREATED_NEW_KEY     1
#define REG_OPENED_EXISTING_KEY 2

#define REG_WHOLE_HIVE_VOLATILE 1
#define REG_REFRESH_HIVE        2
#define REG_NO_LAZY_FLUSH       4

#define REG_NOTIFY_CHANGE_NAME       1
#define REG_NOTIFY_CHANGE_ATTRIBUTES 2
#define REG_NOTIFY_CHANGE_LAST_SET   4
#define REG_NOTIFY_CHANGE_SECURITY   8
#define REG_LEGAL_CHANGE_FILTER      0xF
#define REG_LEGAL_OPTION             0x1F
#define WAIT_OBJECT_0_BASE             0
#define INVALID_FILE_SIZE              0xFFFFFFFF

#define WAIT_FAILED                    0xFFFFFFFF
#define WAIT_TIMEOUT                   258
#define WAIT_ABANDONED                 0x00000080
#define WAIT_ABANDONED_0               0x00000080
#define MAXIMUM_WAIT_OBJECTS           64

// Win32 system error codes referenced as integer literals. Values per
// <winerror.h>; the registry/socket subset lives in the bundled
// <winerror.h>, these complete the process/pipe surface.
#define ERROR_PIPE_BUSY                231
#define ERROR_NO_MORE_ITEMS            259
#define ERROR_ABANDONED_WAIT_0         735
#define ERROR_CONTROL_C_EXIT           572
#define ERROR_PIPE_CONNECTED           535
#define ERROR_PRIVILEGE_NOT_HELD       1314
#define ERROR_NOT_FOUND                1168
#define ERROR_NO_SYSTEM_RESOURCES      1450

// CreateProcess dwCreationFlags and process priority classes (winbase.h).
#define DEBUG_PROCESS                  0x00000001
#define DEBUG_ONLY_THIS_PROCESS        0x00000002
#define CREATE_SUSPENDED               0x00000004
#define DETACHED_PROCESS               0x00000008
#define CREATE_NEW_CONSOLE             0x00000010
#define NORMAL_PRIORITY_CLASS          0x00000020
#define IDLE_PRIORITY_CLASS            0x00000040
#define HIGH_PRIORITY_CLASS            0x00000080
#define REALTIME_PRIORITY_CLASS        0x00000100
#define CREATE_NEW_PROCESS_GROUP       0x00000200
#define CREATE_UNICODE_ENVIRONMENT     0x00000400
#define CREATE_DEFAULT_ERROR_MODE      0x04000000
#define CREATE_NO_WINDOW               0x08000000
#define CREATE_BREAKAWAY_FROM_JOB      0x01000000
#define BELOW_NORMAL_PRIORITY_CLASS    0x00004000
#define ABOVE_NORMAL_PRIORITY_CLASS    0x00008000
#define EXTENDED_STARTUPINFO_PRESENT   0x00080000

// STARTUPINFO dwFlags bits (winbase.h).
#define STARTF_USESHOWWINDOW           0x00000001
#define STARTF_USESIZE                 0x00000002
#define STARTF_USEPOSITION             0x00000004
#define STARTF_USECOUNTCHARS           0x00000008
#define STARTF_USEFILLATTRIBUTE        0x00000010
#define STARTF_RUNFULLSCREEN           0x00000020
#define STARTF_FORCEONFEEDBACK         0x00000040
#define STARTF_FORCEOFFFEEDBACK        0x00000080
#define STARTF_USESTDHANDLES           0x00000100
#define STARTF_USEHOTKEY               0x00000200
#define STARTF_TITLEISLINKNAME         0x00000800
#define STARTF_TITLEISAPPID            0x00001000
#define STARTF_PREVENTPINNING          0x00002000
#define STARTF_UNTRUSTEDSOURCE         0x00008000

// GetExitCodeProcess sentinel and ShowWindow command (winbase.h/winuser.h).
#define STILL_ACTIVE                   259
#define SW_HIDE                        0

// Standard device handle ids and DuplicateHandle options (processenv.h /
// handleapi.h).
#define DUPLICATE_CLOSE_SOURCE         0x00000001
#define DUPLICATE_SAME_ACCESS          0x00000002

// Process / token access rights (winnt.h).
#define PROCESS_DUP_HANDLE             0x0040
#define TOKEN_QUERY                    0x0008
#define TOKEN_ADJUST_PRIVILEGES        0x0020
#define SE_PRIVILEGE_ENABLED           0x00000002

// Named-pipe creation flags (winbase.h / namedpipeapi.h).
#define PIPE_UNLIMITED_INSTANCES       255
#define NMPWAIT_WAIT_FOREVER           0xFFFFFFFF
#define NMPWAIT_NOWAIT                 0x00000001
#define NMPWAIT_USE_DEFAULT_WAIT       0x00000000
#define FILE_FLAG_FIRST_PIPE_INSTANCE  0x00080000

// File-mapping view access and section flags (memoryapi.h / winnt.h).
#define FILE_MAP_ALL_ACCESS            0x000F001F
#define FILE_MAP_EXECUTE               0x0020
#define SEC_RESERVE                    0x04000000
#define SEC_COMMIT                     0x08000000
#define SEC_NOCACHE                    0x10000000
#define SEC_WRITECOMBINE               0x40000000
#define SEC_LARGE_PAGES                0x80000000

// Memory protection / region-state bits (winnt.h) beyond the VirtualAlloc
// subset declared earlier.
#define PAGE_WRITECOPY                 0x08
#define PAGE_EXECUTE_WRITECOPY         0x80
#define PAGE_GUARD                     0x100
#define PAGE_NOCACHE                   0x200
#define PAGE_WRITECOMBINE              0x400
#define MEM_FREE                       0x10000
#define MEM_PRIVATE                    0x20000
#define MEM_MAPPED                     0x40000
#define MEM_IMAGE                      0x1000000

// Composite generic file-access masks (winnt.h).
#define FILE_GENERIC_READ              0x00120089
#define FILE_GENERIC_WRITE             0x00120116

// LCMapStringEx mapping flags (winnls.h).
#define LCMAP_LOWERCASE                0x00000100
#define LCMAP_UPPERCASE                0x00000200
#define LCMAP_TITLECASE                0x00000300
#define LCMAP_SORTKEY                  0x00000400
#define LCMAP_BYTEREV                  0x00000800
#define LCMAP_HIRAGANA                 0x00100000
#define LCMAP_KATAKANA                 0x00200000
#define LCMAP_HALFWIDTH                0x00400000
#define LCMAP_FULLWIDTH                0x00800000
#define LCMAP_LINGUISTIC_CASING        0x01000000
#define LCMAP_SIMPLIFIED_CHINESE       0x02000000
#define LCMAP_TRADITIONAL_CHINESE      0x04000000
#define LCMAP_SORTHANDLE               0x20000000
#define LCMAP_HASH                     0x00040000

// Locale-name constants for the *Ex APIs (winnls.h).
#define LOCALE_NAME_USER_DEFAULT       NULL
#define LOCALE_NAME_INVARIANT          L""
#define LOCALE_NAME_SYSTEM_DEFAULT     L"!x-sys-default-locale"

// ProcThreadAttribute identifier for the inherited-handle list
// (processthreadsapi.h). Encoded as ProcThreadAttributeHandleList(2) with
// the THREAD(0x10000) and INPUT(0x20000) flag bits set.
#define PROC_THREAD_ATTRIBUTE_HANDLE_LIST 0x00020002

// CopyFile2 dwCopyFlags (winbase.h).
#define COPY_FILE_FAIL_IF_EXISTS              0x00000001
#define COPY_FILE_RESTARTABLE                 0x00000002
#define COPY_FILE_OPEN_SOURCE_FOR_WRITE       0x00000004
#define COPY_FILE_ALLOW_DECRYPTED_DESTINATION 0x00000008
#define COPY_FILE_COPY_SYMLINK                0x00000800
#define COPY_FILE_NO_BUFFERING                0x00001000
#define COPY_FILE_REQUEST_SECURITY_PRIVILEGES 0x00002000
#define COPY_FILE_RESUME_FROM_PAUSE           0x00004000
#define COPY_FILE_NO_OFFLOAD                  0x00040000
#define COPY_FILE_REQUEST_COMPRESSED_TRAFFIC  0x10000000
#define COPY_FILE_DIRECTORY                   0x00000080
// COPYFILE2 progress-callback reason and result codes (winbase.h).
#define COPYFILE2_CALLBACK_CHUNK_STARTED   1
#define COPYFILE2_CALLBACK_CHUNK_FINISHED  2
#define COPYFILE2_CALLBACK_STREAM_STARTED  3
#define COPYFILE2_CALLBACK_STREAM_FINISHED 4
#define COPYFILE2_CALLBACK_POLL_CONTINUE   5
#define COPYFILE2_CALLBACK_ERROR           6
#define COPYFILE2_PROGRESS_CONTINUE        0
#define COPYFILE2_PROGRESS_CANCEL          1
#define COPYFILE2_PROGRESS_STOP            2
#define COPYFILE2_PROGRESS_QUIET           3
#define COPYFILE2_PROGRESS_PAUSE           4

// UNICODE name mapping for the privilege-lookup call and its name string
// (winbase.h / winnt.h). Source uses the bare spelling under UNICODE.
#define LookupPrivilegeValue LookupPrivilegeValueW
#define SE_RESTORE_NAME L"SeRestorePrivilege"

// SEH exception codes sqlite checks against in its mmap recovery
// hook. Spelled out because c5's preprocessor can't expand the
// MSVC `EXCEPTION_*` enum the SDK headers normally provide.
#define EXCEPTION_IN_PAGE_ERROR        0xC0000006
#define EXCEPTION_ACCESS_VIOLATION     0xC0000005
#define EXCEPTION_EXECUTE_HANDLER      1
#define EXCEPTION_CONTINUE_SEARCH      0
#define EXCEPTION_CONTINUE_EXECUTION   (-1)

// SEH descriptor structs sqlite's mmap-recovery filter walks.
// Layout pinned to the Win64 SDK so kernel-emitted records can
// be read field-by-field. `ExceptionInformation` is the standard
// 15-slot array; sqlite reads index 1 to recover the faulting
// virtual address.
struct _EXCEPTION_RECORD {
    DWORD                     ExceptionCode;
    DWORD                     ExceptionFlags;
    struct _EXCEPTION_RECORD *ExceptionRecord;
    void                     *ExceptionAddress;
    DWORD                     NumberParameters;
    ULONG_PTR                 ExceptionInformation[15];
};
typedef struct _EXCEPTION_RECORD EXCEPTION_RECORD;
typedef struct _EXCEPTION_RECORD *PEXCEPTION_RECORD;

struct _EXCEPTION_POINTERS {
    EXCEPTION_RECORD *ExceptionRecord;
    void             *ContextRecord;
};
typedef struct _EXCEPTION_POINTERS EXCEPTION_POINTERS;
typedef struct _EXCEPTION_POINTERS *PEXCEPTION_POINTERS;
typedef struct _EXCEPTION_POINTERS *LPEXCEPTION_POINTERS;

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

typedef struct _TIME_ZONE_INFORMATION {
    LONG       Bias;
    WCHAR      StandardName[32];
    SYSTEMTIME StandardDate;
    LONG       StandardBias;
    WCHAR      DaylightName[32];
    SYSTEMTIME DaylightDate;
    LONG       DaylightBias;
} TIME_ZONE_INFORMATION;

// WIN32_FILE_ATTRIBUTE_DATA -- output buffer for
// GetFileAttributesEx. sqlite reads the attribute / size pair to
// pre-size buffers; the high/low DWORD halves of the 64-bit size
// match the Win64 layout. Has to come after FILETIME above
// because c5 needs the inner-struct definition before the
// outer-struct field.
struct _WIN32_FILE_ATTRIBUTE_DATA {
    DWORD    dwFileAttributes;
    FILETIME ftCreationTime;
    FILETIME ftLastAccessTime;
    FILETIME ftLastWriteTime;
    DWORD    nFileSizeHigh;
    DWORD    nFileSizeLow;
};
typedef struct _WIN32_FILE_ATTRIBUTE_DATA WIN32_FILE_ATTRIBUTE_DATA;
typedef struct _WIN32_FILE_ATTRIBUTE_DATA *LPWIN32_FILE_ATTRIBUTE_DATA;

// WIN32_FIND_DATAA / WIN32_FIND_DATAW -- output buffer for
// FindFirstFile / FindNextFile. Layouts pinned to the Win64 ABI;
// the ANSI flavour uses MAX_PATH bytes for the file name, the wide
// flavour uses 260 unsigned shorts.
#define MAX_PATH 260
struct _WIN32_FIND_DATAA {
    DWORD    dwFileAttributes;
    FILETIME ftCreationTime;
    FILETIME ftLastAccessTime;
    FILETIME ftLastWriteTime;
    DWORD    nFileSizeHigh;
    DWORD    nFileSizeLow;
    DWORD    dwReserved0;
    DWORD    dwReserved1;
    char     cFileName[260];
    char     cAlternateFileName[14];
};
typedef struct _WIN32_FIND_DATAA WIN32_FIND_DATAA;
typedef struct _WIN32_FIND_DATAA *LPWIN32_FIND_DATAA;
typedef struct _WIN32_FIND_DATAA *PWIN32_FIND_DATAA;

struct _WIN32_FIND_DATAW {
    DWORD          dwFileAttributes;
    FILETIME       ftCreationTime;
    FILETIME       ftLastAccessTime;
    FILETIME       ftLastWriteTime;
    DWORD          nFileSizeHigh;
    DWORD          nFileSizeLow;
    DWORD          dwReserved0;
    DWORD          dwReserved1;
    unsigned short cFileName[260];
    unsigned short cAlternateFileName[14];
};
typedef struct _WIN32_FIND_DATAW WIN32_FIND_DATAW;
typedef struct _WIN32_FIND_DATAW *LPWIN32_FIND_DATAW;
typedef struct _WIN32_FIND_DATAW *PWIN32_FIND_DATAW;

// Console-info structs shell.c reads when sniffing whether stdout
// is a terminal vs a redirected pipe. Layouts pinned to the Win64
// SDK so the kernel-emitted records align with c5's reads.
struct _COORD {
    SHORT X;
    SHORT Y;
};
typedef struct _COORD COORD;
typedef struct _COORD *PCOORD;

struct _SMALL_RECT {
    SHORT Left;
    SHORT Top;
    SHORT Right;
    SHORT Bottom;
};
typedef struct _SMALL_RECT SMALL_RECT;
typedef struct _SMALL_RECT *PSMALL_RECT;

struct _CONSOLE_SCREEN_BUFFER_INFO {
    COORD      dwSize;
    COORD      dwCursorPosition;
    WORD       wAttributes;
    SMALL_RECT srWindow;
    COORD      dwMaximumWindowSize;
};
typedef struct _CONSOLE_SCREEN_BUFFER_INFO CONSOLE_SCREEN_BUFFER_INFO;
typedef struct _CONSOLE_SCREEN_BUFFER_INFO *PCONSOLE_SCREEN_BUFFER_INFO;

#define STD_INPUT_HANDLE  ((DWORD)-10)
#define STD_OUTPUT_HANDLE ((DWORD)-11)
#define STD_ERROR_HANDLE  ((DWORD)-12)
#define ENABLE_PROCESSED_INPUT          0x0001
#define ENABLE_LINE_INPUT               0x0002
#define ENABLE_ECHO_INPUT               0x0004
#define ENABLE_WINDOW_INPUT             0x0008
#define ENABLE_MOUSE_INPUT              0x0010
#define ENABLE_INSERT_MODE              0x0020
#define ENABLE_QUICK_EDIT_MODE          0x0040
#define ENABLE_EXTENDED_FLAGS           0x0080
#define ENABLE_AUTO_POSITION            0x0100
#define ENABLE_VIRTUAL_TERMINAL_INPUT   0x0200
#define ENABLE_PROCESSED_OUTPUT         0x0001
#define ENABLE_WRAP_AT_EOL_OUTPUT       0x0002
#define ENABLE_VIRTUAL_TERMINAL_PROCESSING 0x0004
#define DISABLE_NEWLINE_AUTO_RETURN     0x0008
#define ENABLE_LVB_GRID_WORLDWIDE       0x0010

// Foreground / background console attribute bits (pinned).
#define FOREGROUND_BLUE                 0x0001
#define FOREGROUND_GREEN                0x0002
#define FOREGROUND_RED                  0x0004
#define FOREGROUND_INTENSITY            0x0008
#define BACKGROUND_BLUE                 0x0010
#define BACKGROUND_GREEN                0x0020
#define BACKGROUND_RED                  0x0040
#define BACKGROUND_INTENSITY            0x0080
#define COMMON_LVB_LEADING_BYTE         0x0100
#define COMMON_LVB_TRAILING_BYTE        0x0200
#define COMMON_LVB_GRID_HORIZONTAL      0x0400
#define COMMON_LVB_GRID_LVERTICAL       0x0800
#define COMMON_LVB_GRID_RVERTICAL       0x1000
#define COMMON_LVB_REVERSE_VIDEO        0x4000
#define COMMON_LVB_UNDERSCORE           0x8000

// Console control-event codes the SetConsoleCtrlHandler callback
// distinguishes between -- shell.c uses these for ^C handling.
#define CTRL_C_EVENT        0
#define CTRL_BREAK_EVENT    1
#define CTRL_CLOSE_EVENT    2
#define CTRL_LOGOFF_EVENT   5
#define CTRL_SHUTDOWN_EVENT 6

char *VirtualAlloc(char *addr, long long size, int type, int protect);
int VirtualProtect(char *addr, long long size, int new_protect, int *old_protect);
int VirtualFree(char *addr, long long size, int type);
HANDLE LoadLibraryA(char *name);
// LoadLibraryExA: name, hFile (reserved, must be NULL), dwFlags.
// dwFlags bits (LOAD_*) control search-path and binding semantics.
HANDLE LoadLibraryExA(char *name, HANDLE reserved, int flags);
HANDLE LoadLibraryExW(const unsigned short *name, HANDLE reserved, int flags);
PVOID  GetProcAddress(HANDLE module, char *name);
int    FreeLibrary(HANDLE module);
DWORD  GetLastError(void);
int ExitProcess(int status);
int Sleep(int milliseconds);
// Function-table registration for SEH-style stack unwinding on
// Win64. `EntryCount` is the number of `RUNTIME_FUNCTION`
// entries; `BaseAddress` is the image base the offsets are
// relative to.
int RtlAddFunctionTable(PRUNTIME_FUNCTION FunctionTable, DWORD EntryCount,
                        long long BaseAddress);
int RtlDeleteFunctionTable(PRUNTIME_FUNCTION FunctionTable);

// CreateThread returns a thread HANDLE (kernel object). Args
// mirror the Win32 prototype: lpThreadAttributes, dwStackSize,
// lpStartAddress, lpParameter, dwCreationFlags, lpThreadId.
HANDLE CreateThread(char *attrs, long long stack_size, int *start, char *param,
                    int flags, int *thread_id);
int WaitForSingleObject(HANDLE handle, int millis);
int CloseHandle(HANDLE handle);
int GetExitCodeThread(HANDLE handle, int *exit_code);
int SetThreadPriority(HANDLE thread, int priority);
int GetCurrentThreadId();
int InitializeCriticalSection(char *cs);
// InitializeCriticalSectionEx(cs, spin, flags): the flag word selects debug
// info / no-dynamic-spin; c5 passes 0.
int InitializeCriticalSectionEx(char *cs, DWORD spin, DWORD flags);
int EnterCriticalSection(char *cs);
int LeaveCriticalSection(char *cs);
int DeleteCriticalSection(char *cs);
DWORD TlsAlloc(void);
PVOID TlsGetValue(DWORD index);
int   TlsSetValue(DWORD index, PVOID value);
int   TlsFree(DWORD index);
void InitializeSRWLock(PSRWLOCK lock);
void AcquireSRWLockExclusive(PSRWLOCK lock);
void ReleaseSRWLockExclusive(PSRWLOCK lock);
void AcquireSRWLockShared(PSRWLOCK lock);
void ReleaseSRWLockShared(PSRWLOCK lock);
BOOLEAN TryAcquireSRWLockExclusive(PSRWLOCK lock);
BOOLEAN TryAcquireSRWLockShared(PSRWLOCK lock);
void InitializeConditionVariable(PCONDITION_VARIABLE cv);
int  SleepConditionVariableSRW(PCONDITION_VARIABLE cv, PSRWLOCK lock, DWORD ms, ULONG flags);
int  SleepConditionVariableCS(PCONDITION_VARIABLE cv, PCRITICAL_SECTION cs, DWORD ms);
void WakeConditionVariable(PCONDITION_VARIABLE cv);
void WakeAllConditionVariable(PCONDITION_VARIABLE cv);
HANDLE CreateSemaphoreW(void *attrs, LONG initial, LONG maximum, PCWSTR name);
#define CreateSemaphore CreateSemaphoreW
int ReleaseSemaphore(HANDLE sem, LONG release, LONG *previous);
HANDLE GetCurrentThread(void);
int GetProcessTimes(HANDLE proc, void *creation, void *exit, void *kernel, void *user);
int CancelIoEx(HANDLE h, LPOVERLAPPED overlapped);
int GetNumberOfConsoleInputEvents(HANDLE h, LPDWORD count);

// The SDK inlines SecureZeroMemory so the clear is not elided. badc does
// no dead-store elimination at -O0 (the build default), so a plain clear
// matches. A volatile form is the follow-up if the image is built -O.
#define SecureZeroMemory(ptr, cnt) memset((ptr), 0, (cnt))
// winbase.h block-memory aliases over the C library primitives.
#define ZeroMemory(dst, len)      memset((dst), 0, (len))
#define FillMemory(dst, len, val) memset((dst), (val), (len))
#define CopyMemory(dst, src, len) memcpy((dst), (src), (len))
#define MoveMemory(dst, src, len) memmove((dst), (src), (len))

typedef UINT_PTR SOCKET;
#define FAILED(hr) (((HRESULT)(hr)) < 0)
unsigned int SetErrorMode(unsigned int mode);
unsigned int GetErrorMode(void);
DWORD WaitForMultipleObjects(DWORD count, HANDLE *handles, int wait_all, DWORD millis);
int GetThreadTimes(HANDLE thread, void *creation, void *exit, void *kernel, void *user);
HANDLE OpenThread(DWORD access, int inherit, DWORD thread_id);
int CompareStringOrdinal(PCWSTR s1, int n1, PCWSTR s2, int n2, int ignore_case);
int GetOverlappedResult(HANDLE h, LPOVERLAPPED overlapped, LPDWORD transferred, int wait);
int BCryptGenRandom(void *algorithm, unsigned char *buffer, unsigned long count, unsigned long flags);
unsigned int GetACP(void);
int GetLocaleInfoA(DWORD locale, DWORD info_type, char *data, int cch_data);
DWORD GetFinalPathNameByHandleW(HANDLE file, unsigned short *path, DWORD len, DWORD flags);
HANDLE CreateWaitableTimerExW(void *timer_attrs, const unsigned short *name, DWORD flags, DWORD access);
int ConnectNamedPipe(HANDLE pipe, LPOVERLAPPED overlapped);
void GetCurrentThreadStackLimits(ULONG_PTR *low_limit, ULONG_PTR *high_limit);
int SetThreadStackGuarantee(ULONG *stack_size_in_bytes);
int GetModuleFileNameW(HANDLE module, unsigned short *filename, DWORD size);
DWORD GetFileType(HANDLE file);
int GetFileInformationByHandle(HANDLE file, BY_HANDLE_FILE_INFORMATION *info);
int GetFileInformationByHandleEx(HANDLE file, int info_class, void *info, DWORD size);
int SetFileInformationByHandle(HANDLE file, int info_class, void *info, DWORD size);
int GetHandleInformation(HANDLE object, LPDWORD flags);
int SetHandleInformation(HANDLE object, DWORD mask, DWORD flags);
int GetNamedPipeHandleStateW(HANDLE pipe, LPDWORD state, LPDWORD instances, LPDWORD max_collect, LPDWORD timeout, unsigned short *user, DWORD user_size);
int SetNamedPipeHandleState(HANDLE pipe, LPDWORD mode, LPDWORD max_collect, LPDWORD timeout);
int CreatePipe(PHANDLE read_handle, PHANDLE write_handle, void *attrs, DWORD size);
int DeviceIoControl(HANDLE device, DWORD code, void *in_buf, DWORD in_size, void *out_buf, DWORD out_size, LPDWORD returned, LPOVERLAPPED overlapped);
int CreateHardLinkW(const unsigned short *link, const unsigned short *target, void *attrs);
int CreateSymbolicLinkW(const unsigned short *symlink, const unsigned short *target, DWORD flags);
int MoveFileExW(const unsigned short *from, const unsigned short *to, DWORD flags);
int MoveFileExA(const char *from, const char *to, DWORD flags);
#define MoveFileEx MoveFileExA
int SetEnvironmentVariableW(const unsigned short *name, const unsigned short *value);
unsigned int GetDriveTypeW(const unsigned short *root);
int GetDiskFreeSpaceExW(const unsigned short *dir, void *avail, void *total, void *free_total);
DWORD GetLogicalDriveStringsW(DWORD size, unsigned short *buffer);
int GetVolumePathNameW(const unsigned short *filename, unsigned short *volume, DWORD len);
int GetVolumePathNamesForVolumeNameW(const unsigned short *volume, unsigned short *names, DWORD len, LPDWORD returned);
HANDLE FindFirstVolumeW(unsigned short *volume, DWORD len);
int FindNextVolumeW(HANDLE find, unsigned short *volume, DWORD len);
int FindVolumeClose(HANDLE find);
DWORD GetActiveProcessorCount(WORD group);
HANDLE OpenProcess(DWORD access, int inherit, DWORD pid);
void *AddDllDirectory(const unsigned short *path);
int RemoveDllDirectory(void *cookie);
int SetWaitableTimer(HANDLE timer, void *due, LONG period, void *routine, void *arg, int resume);
int SetWaitableTimerEx(HANDLE timer, void *due, LONG period, void *routine, void *arg, void *wake_ctx, DWORD tolerable_delay);
int GetStringTypeW(DWORD info_type, const unsigned short *src, int count, WORD *char_type);
int PssCaptureSnapshot(HANDLE process, DWORD flags, DWORD ctx_flags, void *snapshot);
int PssFreeSnapshot(HANDLE process, void *snapshot);
int PssQuerySnapshot(void *snapshot, int info_class, void *buffer, DWORD len);
int GetUserNameW(unsigned short *buffer, LPDWORD size);
int ConvertStringSecurityDescriptorToSecurityDescriptorW(const unsigned short *str, DWORD revision, void *sd, LPDWORD size);
long PathCchSkipRoot(const unsigned short *path, const unsigned short **root_end);
long PathCchCombineEx(unsigned short *out, unsigned long len, const unsigned short *base, const unsigned short *more, unsigned long flags);
DWORD GetFileVersionInfoSizeW(const unsigned short *filename, LPDWORD handle);
int GetFileVersionInfoW(const unsigned short *filename, DWORD handle, DWORD len, void *data);
int VerQueryValueW(void *block, const unsigned short *sub_block, void **buffer, UINT *len);

// advapi32 registry API (winreg.h). Each returns a LONG status
// (ERROR_SUCCESS on success); signatures track the Win32 wide forms.
LONG RegCloseKey(HKEY hKey);
LONG RegConnectRegistryW(LPCWSTR lpMachineName, HKEY hKey, PHKEY phkResult);
LONG RegCreateKeyW(HKEY hKey, LPCWSTR lpSubKey, PHKEY phkResult);
LONG RegCreateKeyExW(HKEY hKey, LPCWSTR lpSubKey, DWORD Reserved, LPWSTR lpClass,
                     DWORD dwOptions, REGSAM samDesired, LPSECURITY_ATTRIBUTES lpSecurityAttributes,
                     PHKEY phkResult, LPDWORD lpdwDisposition);
LONG RegDeleteKeyW(HKEY hKey, LPCWSTR lpSubKey);
LONG RegDeleteKeyExW(HKEY hKey, LPCWSTR lpSubKey, REGSAM samDesired, DWORD Reserved);
LONG RegDeleteValueW(HKEY hKey, LPCWSTR lpValueName);
LONG RegEnumKeyExW(HKEY hKey, DWORD dwIndex, LPWSTR lpName, LPDWORD lpcchName,
                   LPDWORD lpReserved, LPWSTR lpClass, LPDWORD lpcchClass, PFILETIME lpftLastWriteTime);
LONG RegEnumValueW(HKEY hKey, DWORD dwIndex, LPWSTR lpValueName, LPDWORD lpcchValueName,
                   LPDWORD lpReserved, LPDWORD lpType, LPBYTE lpData, LPDWORD lpcbData);
LONG RegFlushKey(HKEY hKey);
LONG RegLoadKeyW(HKEY hKey, LPCWSTR lpSubKey, LPCWSTR lpFile);
LONG RegOpenKeyExW(HKEY hKey, LPCWSTR lpSubKey, DWORD ulOptions, REGSAM samDesired, PHKEY phkResult);
LONG RegQueryInfoKeyW(HKEY hKey, LPWSTR lpClass, LPDWORD lpcchClass, LPDWORD lpReserved,
                      LPDWORD lpcSubKeys, LPDWORD lpcbMaxSubKeyLen, LPDWORD lpcbMaxClassLen,
                      LPDWORD lpcValues, LPDWORD lpcbMaxValueNameLen, LPDWORD lpcbMaxValueLen,
                      LPDWORD lpcbSecurityDescriptor, PFILETIME lpftLastWriteTime);
LONG RegQueryValueExW(HKEY hKey, LPCWSTR lpValueName, LPDWORD lpReserved, LPDWORD lpType,
                      LPBYTE lpData, LPDWORD lpcbData);
LONG RegSaveKeyW(HKEY hKey, LPCWSTR lpFile, LPSECURITY_ATTRIBUTES lpSecurityAttributes);
LONG RegSetValueExW(HKEY hKey, LPCWSTR lpValueName, DWORD Reserved, DWORD dwType,
                    const BYTE *lpData, DWORD cbData);

// kernel32 API surface that sqlite's Windows VFS dispatch table
// (`aSyscall[]`) takes the address of with `(SYSCALL)Name`. The
// table only ever calls these via the cast'd function pointer, so
// the c5-side prototypes don't need to be exact -- the cast at
// the call site re-types the pointer to the right signature
// before the call. Declared here as `int Name();` to give each
// name a Token::Sys symbol the static initializer can reference;
// the matching `#pragma binding` puts the IAT slot in scope so the
// codegen has a kernel32 import to point the function-pointer
// initializer at.
#pragma binding(kernel32::AreFileApisANSI,         "AreFileApisANSI")
#pragma binding(kernel32::CancelIo,                "CancelIo")
#pragma binding(kernel32::CreateEventA,            "CreateEventA")
#pragma binding(kernel32::FlushViewOfFile,         "FlushViewOfFile")
#pragma binding(kernel32::GetModuleHandleA,        "GetModuleHandleA")
#pragma binding(kernel32::GetModuleHandleW,        "GetModuleHandleW")
#pragma binding(kernel32::GetNativeSystemInfo,     "GetNativeSystemInfo")
#pragma binding(kernel32::GetProcessHeap,          "GetProcessHeap")
#pragma binding(kernel32::GetProcAddressA,         "GetProcAddress")
// CharLowerW / CharUpperW are user32.dll exports (winuser.h).
#pragma dylib(user32, "user32.dll")
#pragma binding(user32::CharLowerW,                "CharLowerW")
#pragma binding(user32::CharUpperW,                "CharUpperW")
#pragma binding(kernel32::CreateFileA,             "CreateFileA")
#pragma binding(kernel32::CreateFileTransactedA,   "CreateFileTransactedA")
#pragma binding(kernel32::CreateFileTransactedW,   "CreateFileTransactedW")
#pragma binding(kernel32::CreateFileMappingA,      "CreateFileMappingA")
#pragma binding(kernel32::CreateFileMappingW,      "CreateFileMappingW")
#pragma binding(kernel32::CreateFileW,             "CreateFileW")
#pragma binding(kernel32::CreateMutexW,            "CreateMutexW")
#pragma binding(kernel32::DeleteFileA,             "DeleteFileA")
#pragma binding(kernel32::DeleteFileW,             "DeleteFileW")
#pragma binding(kernel32::FileTimeToLocalFileTime, "FileTimeToLocalFileTime")
#pragma binding(kernel32::FileTimeToSystemTime,    "FileTimeToSystemTime")
#pragma binding(kernel32::FlushFileBuffers,        "FlushFileBuffers")
#pragma binding(kernel32::FormatMessageA,          "FormatMessageA")
#pragma binding(kernel32::FormatMessageW,          "FormatMessageW")
#pragma binding(kernel32::GetCurrentProcessId,     "GetCurrentProcessId")
#pragma binding(kernel32::GetProcessId,            "GetProcessId")
#pragma binding(kernel32::lstrcpyA,                "lstrcpyA")
#pragma binding(kernel32::lstrcpyW,                "lstrcpyW")
#pragma binding(kernel32::GetDiskFreeSpaceA,       "GetDiskFreeSpaceA")
#pragma binding(kernel32::GetDiskFreeSpaceW,       "GetDiskFreeSpaceW")
#pragma binding(kernel32::GetFileAttributesA,      "GetFileAttributesA")
#pragma binding(kernel32::GetFileAttributesExW,    "GetFileAttributesExW")
#pragma binding(kernel32::GetFileAttributesW,      "GetFileAttributesW")
#pragma binding(kernel32::GetFileSize,             "GetFileSize")
#pragma binding(kernel32::GetFullPathNameA,        "GetFullPathNameA")
#pragma binding(kernel32::GetFullPathNameW,        "GetFullPathNameW")
#pragma binding(kernel32::GetSystemInfo,           "GetSystemInfo")
#pragma binding(kernel32::GetSystemTime,           "GetSystemTime")
#pragma binding(kernel32::GetSystemTimeAsFileTime, "GetSystemTimeAsFileTime")
#pragma binding(kernel32::GetTempPathA,            "GetTempPathA")
#pragma binding(kernel32::GetTempPathW,            "GetTempPathW")
#pragma binding(kernel32::GetTickCount,            "GetTickCount")
#pragma binding(kernel32::GetVersionExA,           "GetVersionExA")
#pragma binding(kernel32::GetVersionExW,           "GetVersionExW")
#pragma binding(kernel32::VerifyVersionInfoW,      "VerifyVersionInfoW")
#pragma binding(kernel32::VerSetConditionMask,     "VerSetConditionMask")
#pragma binding(kernel32::GetComputerNameExW,      "GetComputerNameExW")
#pragma binding(kernel32::HeapAlloc,               "HeapAlloc")
#pragma binding(kernel32::HeapCompact,             "HeapCompact")
#pragma binding(kernel32::HeapCreate,              "HeapCreate")
#pragma binding(kernel32::HeapDestroy,             "HeapDestroy")
#pragma binding(kernel32::HeapFree,                "HeapFree")
#pragma binding(kernel32::HeapReAlloc,             "HeapReAlloc")
#pragma binding(kernel32::HeapSize,                "HeapSize")
#pragma binding(kernel32::HeapValidate,            "HeapValidate")
#pragma binding(kernel32::LoadLibraryW,            "LoadLibraryW")
#pragma binding(kernel32::LocalFree,               "LocalFree")
#pragma binding(kernel32::LockFile,                "LockFile")
#pragma binding(kernel32::LockFileEx,              "LockFileEx")
#pragma binding(kernel32::MapViewOfFile,           "MapViewOfFile")
#pragma binding(kernel32::MultiByteToWideChar,     "MultiByteToWideChar")
#pragma binding(kernel32::OutputDebugStringA,      "OutputDebugStringA")
#pragma binding(kernel32::OutputDebugStringW,      "OutputDebugStringW")
#pragma binding(kernel32::QueryPerformanceCounter, "QueryPerformanceCounter")
#pragma binding(kernel32::ReadFile,                "ReadFile")
#pragma binding(kernel32::SetEndOfFile,            "SetEndOfFile")
#pragma binding(kernel32::SetFilePointer,          "SetFilePointer")
#pragma binding(kernel32::SystemTimeToFileTime,    "SystemTimeToFileTime")
#pragma binding(kernel32::UnlockFile,              "UnlockFile")
#pragma binding(kernel32::UnlockFileEx,            "UnlockFileEx")
#pragma binding(kernel32::UnmapViewOfFile,         "UnmapViewOfFile")
#pragma binding(kernel32::WaitForSingleObjectEx,   "WaitForSingleObjectEx")
#pragma binding(kernel32::WideCharToMultiByte,     "WideCharToMultiByte")
#pragma binding(kernel32::WriteFile,               "WriteFile")
#pragma binding(kernel32::FindFirstFileA,          "FindFirstFileA")
#pragma binding(kernel32::FindFirstFileW,          "FindFirstFileW")
#pragma binding(kernel32::FindNextFileA,           "FindNextFileA")
#pragma binding(kernel32::FindNextFileW,           "FindNextFileW")
#pragma binding(kernel32::FindClose,               "FindClose")
#pragma binding(kernel32::SetCurrentDirectoryA,    "SetCurrentDirectoryA")
#pragma binding(kernel32::SetCurrentDirectoryW,    "SetCurrentDirectoryW")
#pragma binding(kernel32::GetCurrentDirectoryA,    "GetCurrentDirectoryA")
#pragma binding(kernel32::GetCurrentDirectoryW,    "GetCurrentDirectoryW")
#pragma binding(kernel32::CreateDirectoryA,        "CreateDirectoryA")
#pragma binding(kernel32::CreateDirectoryW,        "CreateDirectoryW")
#pragma binding(kernel32::RemoveDirectoryA,        "RemoveDirectoryA")
#pragma binding(kernel32::RemoveDirectoryW,        "RemoveDirectoryW")
#pragma binding(kernel32::SetFileAttributesA,      "SetFileAttributesA")
#pragma binding(kernel32::SetFileAttributesW,      "SetFileAttributesW")
#pragma binding(kernel32::GetEnvironmentVariableA, "GetEnvironmentVariableA")
#pragma binding(kernel32::GetEnvironmentVariableW, "GetEnvironmentVariableW")
#pragma binding(kernel32::SetFileTime,             "SetFileTime")
#pragma binding(kernel32::GetFileTime,             "GetFileTime")
#pragma binding(kernel32::GetTempFileNameA,        "GetTempFileNameA")
#pragma binding(kernel32::GetTempFileNameW,        "GetTempFileNameW")
#pragma binding(kernel32::GetCurrentProcess,       "GetCurrentProcess")
#pragma binding(kernel32::DuplicateHandle,         "DuplicateHandle")
#pragma binding(kernel32::SetFilePointerEx,        "SetFilePointerEx")
#pragma binding(kernel32::GetFileSizeEx,           "GetFileSizeEx")
#pragma binding(kernel32::CreateMutexA,            "CreateMutexA")
#pragma binding(kernel32::CreateEventW,            "CreateEventW")
#pragma binding(kernel32::ReleaseMutex,            "ReleaseMutex")
#pragma binding(kernel32::SetEvent,                "SetEvent")
#pragma binding(kernel32::ResetEvent,              "ResetEvent")
#pragma binding(kernel32::CreateIoCompletionPort,  "CreateIoCompletionPort")
#pragma binding(kernel32::GetQueuedCompletionStatus, "GetQueuedCompletionStatus")
#pragma binding(kernel32::PostQueuedCompletionStatus, "PostQueuedCompletionStatus")
#pragma binding(kernel32::RegisterWaitForSingleObject, "RegisterWaitForSingleObject")
#pragma binding(kernel32::UnregisterWait,          "UnregisterWait")
#pragma binding(kernel32::UnregisterWaitEx,        "UnregisterWaitEx")
#pragma binding(kernel32::OpenMutexA,              "OpenMutexA")
#pragma binding(kernel32::OpenMutexW,              "OpenMutexW")
#pragma binding(kernel32::OpenEventA,              "OpenEventA")
#pragma binding(kernel32::OpenEventW,              "OpenEventW")
#pragma binding(kernel32::RaiseException,          "RaiseException")
#pragma binding(kernel32::IsDebuggerPresent,       "IsDebuggerPresent")
#pragma binding(kernel32::DebugBreak,              "DebugBreak")
#pragma binding(kernel32::SetUnhandledExceptionFilter, "SetUnhandledExceptionFilter")
#pragma binding(kernel32::AddVectoredExceptionHandler, "AddVectoredExceptionHandler")
#pragma binding(kernel32::RemoveVectoredExceptionHandler, "RemoveVectoredExceptionHandler")
#pragma binding(kernel32::TerminateProcess,        "TerminateProcess")
#pragma binding(kernel32::GetSystemDirectoryA,     "GetSystemDirectoryA")
#pragma binding(kernel32::GetSystemDirectoryW,     "GetSystemDirectoryW")
#pragma binding(kernel32::GetWindowsDirectoryA,    "GetWindowsDirectoryA")
#pragma binding(kernel32::GetWindowsDirectoryW,    "GetWindowsDirectoryW")
#pragma binding(kernel32::ExpandEnvironmentStringsA, "ExpandEnvironmentStringsA")
#pragma binding(kernel32::ExpandEnvironmentStringsW, "ExpandEnvironmentStringsW")
#pragma binding(kernel32::SearchPathA,             "SearchPathA")
#pragma binding(kernel32::SearchPathW,             "SearchPathW")
#pragma binding(kernel32::CreateProcessA,          "CreateProcessA")
#pragma binding(kernel32::CreateProcessW,          "CreateProcessW")
#pragma binding(kernel32::GetStdHandle,            "GetStdHandle")
#pragma binding(kernel32::SetStdHandle,            "SetStdHandle")
#pragma binding(kernel32::GetConsoleMode,          "GetConsoleMode")
#pragma binding(kernel32::SetConsoleMode,          "SetConsoleMode")
#pragma binding(kernel32::GetConsoleOutputCP,      "GetConsoleOutputCP")
#pragma binding(kernel32::SetConsoleOutputCP,      "SetConsoleOutputCP")
#pragma binding(kernel32::GetConsoleCP,            "GetConsoleCP")
#pragma binding(kernel32::SetConsoleCP,            "SetConsoleCP")
#pragma binding(kernel32::WriteConsoleW,           "WriteConsoleW")
#pragma binding(kernel32::WriteConsoleA,           "WriteConsoleA")
#pragma binding(kernel32::ReadConsoleW,            "ReadConsoleW")
#pragma binding(kernel32::ReadConsoleA,            "ReadConsoleA")
#pragma binding(kernel32::FlushConsoleInputBuffer, "FlushConsoleInputBuffer")
#pragma binding(kernel32::GetConsoleScreenBufferInfo, "GetConsoleScreenBufferInfo")
#pragma binding(kernel32::SetConsoleScreenBufferSize, "SetConsoleScreenBufferSize")
#pragma binding(kernel32::SetConsoleCursorPosition, "SetConsoleCursorPosition")
#pragma binding(kernel32::SetConsoleTextAttribute, "SetConsoleTextAttribute")
#pragma binding(kernel32::FillConsoleOutputCharacterA, "FillConsoleOutputCharacterA")
#pragma binding(kernel32::FillConsoleOutputCharacterW, "FillConsoleOutputCharacterW")
#pragma binding(kernel32::FillConsoleOutputAttribute, "FillConsoleOutputAttribute")
#pragma binding(kernel32::ScrollConsoleScreenBufferA, "ScrollConsoleScreenBufferA")
#pragma binding(kernel32::ScrollConsoleScreenBufferW, "ScrollConsoleScreenBufferW")
#pragma binding(kernel32::SetConsoleTitleA,        "SetConsoleTitleA")
#pragma binding(kernel32::SetConsoleTitleW,        "SetConsoleTitleW")
#pragma binding(kernel32::GetConsoleTitleA,        "GetConsoleTitleA")
#pragma binding(kernel32::GetConsoleTitleW,        "GetConsoleTitleW")
#pragma binding(kernel32::PeekConsoleInputA,       "PeekConsoleInputA")
#pragma binding(kernel32::PeekConsoleInputW,       "PeekConsoleInputW")
#pragma binding(kernel32::ReadConsoleInputA,       "ReadConsoleInputA")
#pragma binding(kernel32::ReadConsoleInputW,       "ReadConsoleInputW")
#pragma binding(kernel32::WriteConsoleInputA,      "WriteConsoleInputA")
#pragma binding(kernel32::WriteConsoleInputW,      "WriteConsoleInputW")
#pragma binding(kernel32::SetConsoleCtrlHandler,   "SetConsoleCtrlHandler")
#pragma binding(kernel32::GenerateConsoleCtrlEvent,"GenerateConsoleCtrlEvent")
#pragma binding(kernel32::AllocConsole,            "AllocConsole")
#pragma binding(kernel32::FreeConsole,             "FreeConsole")
#pragma binding(kernel32::AttachConsole,           "AttachConsole")
#pragma binding(kernel32::GetConsoleProcessList,   "GetConsoleProcessList")
#pragma binding(kernel32::GetConsoleWindow,        "GetConsoleWindow")
#pragma binding(kernel32::GetSystemTimePreciseAsFileTime, "GetSystemTimePreciseAsFileTime")
#pragma binding(kernel32::QueryPerformanceFrequency, "QueryPerformanceFrequency")
#pragma binding(kernel32::GetTickCount64,          "GetTickCount64")
#pragma binding(kernel32::SwitchToThread,          "SwitchToThread")
#pragma binding(kernel32::SleepEx,                 "SleepEx")
#pragma binding(kernel32::GetTimeZoneInformation,  "GetTimeZoneInformation")
#pragma binding(kernel32::SystemTimeToTzSpecificLocalTime, "SystemTimeToTzSpecificLocalTime")
#pragma binding(kernel32::TzSpecificLocalTimeToSystemTime, "TzSpecificLocalTimeToSystemTime")
#pragma binding(kernel32::GetLocalTime,            "GetLocalTime")
#pragma binding(kernel32::SetLastError,            "SetLastError")
// UuidCreate / UuidCreateSequential are rpcrt4.dll exports (rpcdce.h);
// binding them to kernel32 fails at load.
#pragma dylib(rpcrt4, "rpcrt4.dll")
#pragma binding(rpcrt4::UuidCreate,                "UuidCreate")
#pragma binding(rpcrt4::UuidCreateSequential,      "UuidCreateSequential")

// Prototypes mirror the Win32 API shapes documented on MSDN. Where
// the real return type is `BOOL` (= int) we keep `int`; where it's
// `HANDLE`, `HWND`, or `unsigned long long`, the user-facing type
// is preserved. Pointer-style parameter types use the typedefs
// declared earlier in this header (DWORD, HANDLE, LPSTR, ...);
// struct-by-pointer parameters whose layout c5 doesn't model
// (`STARTUPINFO`, `PROCESS_INFORMATION`, `TIME_ZONE_INFORMATION`,
// `INPUT_RECORD`) come through as `void *` -- the kernel writes
// the bytes back; sqlite + shell.c never look inside.
int AreFileApisANSI(void);
int CancelIo(HANDLE hFile);
HANDLE CreateEventA(LPSECURITY_ATTRIBUTES lpEventAttributes, int bManualReset,
                    int bInitialState, LPCSTR lpName);
int    FlushViewOfFile(LPCVOID lpBaseAddress, SIZE_T dwNumberOfBytesToFlush);
HANDLE GetModuleHandleA(LPCSTR lpModuleName);
HANDLE GetModuleHandleW(LPCWSTR lpModuleName);
int    GetNativeSystemInfo(LPSYSTEM_INFO lpSystemInfo);
HANDLE GetProcessHeap(void);
PVOID  GetProcAddressA(HANDLE hModule, LPCSTR lpProcName);
int    CharLowerW(LPWSTR lpsz);
int    CharUpperW(LPWSTR lpsz);
HANDLE CreateFileA(LPCSTR lpFileName, DWORD dwDesiredAccess, DWORD dwShareMode,
                   LPSECURITY_ATTRIBUTES lpSecurityAttributes,
                   DWORD dwCreationDisposition, DWORD dwFlagsAndAttributes,
                   HANDLE hTemplateFile);
HANDLE CreateFileMappingA(HANDLE hFile, LPSECURITY_ATTRIBUTES lpFileMappingAttributes,
                          DWORD flProtect, DWORD dwMaximumSizeHigh,
                          DWORD dwMaximumSizeLow, LPCSTR lpName);
HANDLE CreateFileMappingW(HANDLE hFile, LPSECURITY_ATTRIBUTES lpFileMappingAttributes,
                          DWORD flProtect, DWORD dwMaximumSizeHigh,
                          DWORD dwMaximumSizeLow, LPCWSTR lpName);
HANDLE CreateFileW(LPCWSTR lpFileName, DWORD dwDesiredAccess, DWORD dwShareMode,
                   LPSECURITY_ATTRIBUTES lpSecurityAttributes,
                   DWORD dwCreationDisposition, DWORD dwFlagsAndAttributes,
                   HANDLE hTemplateFile);
HANDLE CreateFileTransactedA(LPCSTR lpFileName, DWORD dwDesiredAccess,
                             DWORD dwShareMode,
                             LPSECURITY_ATTRIBUTES lpSecurityAttributes,
                             DWORD dwCreationDisposition,
                             DWORD dwFlagsAndAttributes,
                             HANDLE hTemplateFile, HANDLE hTransaction,
                             PVOID pusMiniVersion, PVOID pExtendedParameter);
HANDLE CreateFileTransactedW(LPCWSTR lpFileName, DWORD dwDesiredAccess,
                             DWORD dwShareMode,
                             LPSECURITY_ATTRIBUTES lpSecurityAttributes,
                             DWORD dwCreationDisposition,
                             DWORD dwFlagsAndAttributes,
                             HANDLE hTemplateFile, HANDLE hTransaction,
                             PVOID pusMiniVersion, PVOID pExtendedParameter);
DWORD  GetProcessId(HANDLE Process);
LPSTR  lstrcpyA(LPSTR lpString1, LPCSTR lpString2);
LPWSTR lstrcpyW(LPWSTR lpString1, LPCWSTR lpString2);
HANDLE CreateMutexW(LPSECURITY_ATTRIBUTES lpMutexAttributes, int bInitialOwner,
                    LPCWSTR lpName);
int DeleteFileA(LPCSTR lpFileName);
int DeleteFileW(LPCWSTR lpFileName);
int FileTimeToLocalFileTime(FILETIME *lpFileTime, LPFILETIME lpLocalFileTime);
int FileTimeToSystemTime(FILETIME *lpFileTime, SYSTEMTIME *lpSystemTime);
int FlushFileBuffers(HANDLE hFile);
int FormatMessageA(DWORD dwFlags, LPCVOID lpSource, DWORD dwMessageId,
                   DWORD dwLanguageId, LPSTR lpBuffer, DWORD nSize, ...);
int FormatMessageW(DWORD dwFlags, LPCVOID lpSource, DWORD dwMessageId,
                   DWORD dwLanguageId, LPWSTR lpBuffer, DWORD nSize, ...);
int GetCurrentProcessId(void);
int GetDiskFreeSpaceA(LPCSTR lpRootPathName, LPDWORD lpSectorsPerCluster,
                      LPDWORD lpBytesPerSector, LPDWORD lpNumberOfFreeClusters,
                      LPDWORD lpTotalNumberOfClusters);
int GetDiskFreeSpaceW(LPCWSTR lpRootPathName, LPDWORD lpSectorsPerCluster,
                      LPDWORD lpBytesPerSector, LPDWORD lpNumberOfFreeClusters,
                      LPDWORD lpTotalNumberOfClusters);
int GetFileAttributesA(LPCSTR lpFileName);
int GetFileAttributesExW(LPCWSTR lpFileName, GET_FILEEX_INFO_LEVELS fInfoLevelId,
                         LPVOID lpFileInformation);
int GetFileAttributesW(LPCWSTR lpFileName);
int GetFileSize(HANDLE hFile, LPDWORD lpFileSizeHigh);
int GetFullPathNameA(LPCSTR lpFileName, DWORD nBufferLength, LPSTR lpBuffer,
                     char **lpFilePart);
int GetFullPathNameW(LPCWSTR lpFileName, DWORD nBufferLength, LPWSTR lpBuffer,
                     unsigned short **lpFilePart);
int GetSystemInfo(LPSYSTEM_INFO lpSystemInfo);
int GetSystemTime(SYSTEMTIME *lpSystemTime);
int GetSystemTimeAsFileTime(LPFILETIME lpSystemTimeAsFileTime);
int GetTempPathA(DWORD nBufferLength, LPSTR lpBuffer);
int GetTempPathW(DWORD nBufferLength, LPWSTR lpBuffer);
int GetTickCount(void);
int GetVersionExA(LPOSVERSIONINFOA lpVersionInformation);
int GetVersionExW(LPOSVERSIONINFOW lpVersionInformation);
#define GetVersionEx GetVersionExW
int VerifyVersionInfoW(LPOSVERSIONINFOEXW lpVersionInformation,
                       DWORD dwTypeMask, DWORDLONG dwlConditionMask);
DWORDLONG VerSetConditionMask(DWORDLONG ConditionMask, DWORD TypeMask,
                              unsigned char Condition);
#define VerifyVersionInfo VerifyVersionInfoW
int GetComputerNameExW(COMPUTER_NAME_FORMAT NameType, LPWSTR lpBuffer,
                       DWORD *nSize);
LPVOID HeapAlloc(HANDLE hHeap, DWORD dwFlags, SIZE_T dwBytes);
int    HeapCompact(HANDLE hHeap, DWORD dwFlags);
HANDLE HeapCreate(DWORD flOptions, SIZE_T dwInitialSize, SIZE_T dwMaximumSize);
int    HeapDestroy(HANDLE hHeap);
int    HeapFree(HANDLE hHeap, DWORD dwFlags, LPVOID lpMem);
LPVOID HeapReAlloc(HANDLE hHeap, DWORD dwFlags, LPVOID lpMem, SIZE_T dwBytes);
SIZE_T HeapSize(HANDLE hHeap, DWORD dwFlags, LPCVOID lpMem);
int    HeapValidate(HANDLE hHeap, DWORD dwFlags, LPCVOID lpMem);
HANDLE LoadLibraryW(LPCWSTR lpLibFileName);
HLOCAL LocalFree(HLOCAL hMem);
int LockFile(HANDLE hFile, DWORD dwFileOffsetLow, DWORD dwFileOffsetHigh,
             DWORD nNumberOfBytesToLockLow, DWORD nNumberOfBytesToLockHigh);
int LockFileEx(HANDLE hFile, DWORD dwFlags, DWORD dwReserved,
               DWORD nNumberOfBytesToLockLow, DWORD nNumberOfBytesToLockHigh,
               LPOVERLAPPED lpOverlapped);
LPVOID MapViewOfFile(HANDLE hFileMappingObject, DWORD dwDesiredAccess,
                     DWORD dwFileOffsetHigh, DWORD dwFileOffsetLow,
                     SIZE_T dwNumberOfBytesToMap);
int MultiByteToWideChar(UINT CodePage, DWORD dwFlags, LPCSTR lpMultiByteStr,
                        int cbMultiByte, LPWSTR lpWideCharStr,
                        int cchWideChar);
int OutputDebugStringA(LPCSTR lpOutputString);
int OutputDebugStringW(LPCWSTR lpOutputString);
int QueryPerformanceCounter(PLARGE_INTEGER lpPerformanceCount);
int ReadFile(HANDLE hFile, LPVOID lpBuffer, DWORD nNumberOfBytesToRead,
             LPDWORD lpNumberOfBytesRead, LPOVERLAPPED lpOverlapped);
int SetEndOfFile(HANDLE hFile);
int SetFilePointer(HANDLE hFile, LONG lDistanceToMove,
                   LONG *lpDistanceToMoveHigh, DWORD dwMoveMethod);
int SystemTimeToFileTime(SYSTEMTIME *lpSystemTime, LPFILETIME lpFileTime);
int UnlockFile(HANDLE hFile, DWORD dwFileOffsetLow, DWORD dwFileOffsetHigh,
               DWORD nNumberOfBytesToUnlockLow,
               DWORD nNumberOfBytesToUnlockHigh);
int UnlockFileEx(HANDLE hFile, DWORD dwReserved,
                 DWORD nNumberOfBytesToUnlockLow,
                 DWORD nNumberOfBytesToUnlockHigh, LPOVERLAPPED lpOverlapped);
int UnmapViewOfFile(LPCVOID lpBaseAddress);
int WaitForSingleObjectEx(HANDLE hHandle, DWORD dwMilliseconds, int bAlertable);
int WideCharToMultiByte(UINT CodePage, DWORD dwFlags, LPCWSTR lpWideCharStr,
                        int cchWideChar, LPSTR lpMultiByteStr, int cbMultiByte,
                        LPCSTR lpDefaultChar, LPBOOL lpUsedDefaultChar);
int WriteFile(HANDLE hFile, LPCVOID lpBuffer, DWORD nNumberOfBytesToWrite,
              LPDWORD lpNumberOfBytesWritten, LPOVERLAPPED lpOverlapped);
HANDLE FindFirstFileA(LPCSTR lpFileName, LPWIN32_FIND_DATAA lpFindFileData);
HANDLE FindFirstFileW(LPCWSTR lpFileName, LPWIN32_FIND_DATAW lpFindFileData);
int FindNextFileA(HANDLE hFindFile, LPWIN32_FIND_DATAA lpFindFileData);
int FindNextFileW(HANDLE hFindFile, LPWIN32_FIND_DATAW lpFindFileData);
int FindClose(HANDLE hFindFile);
int SetCurrentDirectoryA(LPCSTR lpPathName);
int SetCurrentDirectoryW(LPCWSTR lpPathName);
int GetCurrentDirectoryA(DWORD nBufferLength, LPSTR lpBuffer);
int GetCurrentDirectoryW(DWORD nBufferLength, LPWSTR lpBuffer);
int CreateDirectoryA(LPCSTR lpPathName,
                     LPSECURITY_ATTRIBUTES lpSecurityAttributes);
int CreateDirectoryW(LPCWSTR lpPathName,
                     LPSECURITY_ATTRIBUTES lpSecurityAttributes);
int RemoveDirectoryA(LPCSTR lpPathName);
int RemoveDirectoryW(LPCWSTR lpPathName);
int SetFileAttributesA(LPCSTR lpFileName, DWORD dwFileAttributes);
int SetFileAttributesW(LPCWSTR lpFileName, DWORD dwFileAttributes);
int GetEnvironmentVariableA(LPCSTR lpName, LPSTR lpBuffer, DWORD nSize);
int GetEnvironmentVariableW(LPCWSTR lpName, LPWSTR lpBuffer, DWORD nSize);
int SetFileTime(HANDLE hFile, FILETIME *lpCreationTime,
                FILETIME *lpLastAccessTime, FILETIME *lpLastWriteTime);
int GetFileTime(HANDLE hFile, LPFILETIME lpCreationTime,
                LPFILETIME lpLastAccessTime, LPFILETIME lpLastWriteTime);
int GetTempFileNameA(LPCSTR lpPathName, LPCSTR lpPrefixString, UINT uUnique,
                     LPSTR lpTempFileName);
int GetTempFileNameW(LPCWSTR lpPathName, LPCWSTR lpPrefixString, UINT uUnique,
                     LPWSTR lpTempFileName);
HANDLE GetCurrentProcess(void);
int DuplicateHandle(HANDLE hSourceProcessHandle, HANDLE hSourceHandle,
                    HANDLE hTargetProcessHandle, LPHANDLE lpTargetHandle,
                    DWORD dwDesiredAccess, int bInheritHandle, DWORD dwOptions);
int SetFilePointerEx(HANDLE hFile, LARGE_INTEGER liDistanceToMove,
                     PLARGE_INTEGER lpNewFilePointer, DWORD dwMoveMethod);
int GetFileSizeEx(HANDLE hFile, PLARGE_INTEGER lpFileSize);
HANDLE CreateMutexA(LPSECURITY_ATTRIBUTES lpMutexAttributes, int bInitialOwner,
                    LPCSTR lpName);
HANDLE CreateEventW(LPSECURITY_ATTRIBUTES lpEventAttributes, int bManualReset,
                    int bInitialState, LPCWSTR lpName);
int ReleaseMutex(HANDLE hMutex);
int SetEvent(HANDLE hEvent);
int ResetEvent(HANDLE hEvent);

// I/O completion ports and thread-pool waits (synchapi.h / ioapiset.h).
// RegisterWaitForSingleObject queues a callback of this shape when the
// object signals; the BOOLEAN reports whether the wait timed out.
typedef void (CALLBACK *WAITORTIMERCALLBACK)(PVOID lpParameter,
                                             BOOLEAN TimerOrWaitFired);

// dwFlags for RegisterWaitForSingleObject (winnt.h).
#define WT_EXECUTEDEFAULT       0x00000000
#define WT_EXECUTEINIOTHREAD    0x00000001
#define WT_EXECUTEINWAITTHREAD  0x00000004
#define WT_EXECUTEONLYONCE      0x00000008
#define WT_EXECUTELONGFUNCTION  0x00000010
#define WT_EXECUTEINTIMERTHREAD 0x00000020
#define WT_EXECUTEINPERSISTENTTHREAD 0x00000080

// True once the kernel has finished the overlapped request (winbase.h):
// the Internal status word is no longer STATUS_PENDING.
#define HasOverlappedIoCompleted(lpOverlapped) \
    (((DWORD)(lpOverlapped)->Internal) != STATUS_PENDING)

HANDLE CreateIoCompletionPort(HANDLE FileHandle, HANDLE ExistingCompletionPort,
                              ULONG_PTR CompletionKey,
                              DWORD NumberOfConcurrentThreads);
int GetQueuedCompletionStatus(HANDLE CompletionPort, LPDWORD lpNumberOfBytes,
                              ULONG_PTR *lpCompletionKey,
                              OVERLAPPED **lpOverlapped, DWORD dwMilliseconds);
int PostQueuedCompletionStatus(HANDLE CompletionPort,
                               DWORD dwNumberOfBytesTransferred,
                               ULONG_PTR dwCompletionKey,
                               LPOVERLAPPED lpOverlapped);
int RegisterWaitForSingleObject(PHANDLE phNewWaitObject, HANDLE hObject,
                                WAITORTIMERCALLBACK Callback, PVOID Context,
                                ULONG dwMilliseconds, ULONG dwFlags);
int UnregisterWait(HANDLE WaitHandle);
int UnregisterWaitEx(HANDLE WaitHandle, HANDLE CompletionEvent);

HANDLE OpenMutexA(DWORD dwDesiredAccess, int bInheritHandle, LPCSTR lpName);
HANDLE OpenMutexW(DWORD dwDesiredAccess, int bInheritHandle, LPCWSTR lpName);
HANDLE OpenEventA(DWORD dwDesiredAccess, int bInheritHandle, LPCSTR lpName);
HANDLE OpenEventW(DWORD dwDesiredAccess, int bInheritHandle, LPCWSTR lpName);
int RaiseException(DWORD dwExceptionCode, DWORD dwExceptionFlags,
                   DWORD nNumberOfArguments, ULONG_PTR *lpArguments);
int IsDebuggerPresent(void);
int DebugBreak(void);
int SetUnhandledExceptionFilter(void *lpTopLevelExceptionFilter);
int AddVectoredExceptionHandler(ULONG First, void *Handler);
int RemoveVectoredExceptionHandler(void *Handle);
int TerminateProcess(HANDLE hProcess, UINT uExitCode);
int GetSystemDirectoryA(LPSTR lpBuffer, UINT uSize);
int GetSystemDirectoryW(LPWSTR lpBuffer, UINT uSize);
int GetWindowsDirectoryA(LPSTR lpBuffer, UINT uSize);
int GetWindowsDirectoryW(LPWSTR lpBuffer, UINT uSize);
int ExpandEnvironmentStringsA(LPCSTR lpSrc, LPSTR lpDst, DWORD nSize);
int ExpandEnvironmentStringsW(LPCWSTR lpSrc, LPWSTR lpDst, DWORD nSize);
int SearchPathA(LPCSTR lpPath, LPCSTR lpFileName, LPCSTR lpExtension,
                DWORD nBufferLength, LPSTR lpBuffer, char **lpFilePart);
int SearchPath(LPCSTR lpPath, LPCSTR lpFileName, LPCSTR lpExtension,
               DWORD nBufferLength, LPSTR lpBuffer, char **lpFilePart);
int GetModuleFileNameA(void *hModule, LPSTR lpFilename, DWORD nSize);
int SearchPathW(LPCWSTR lpPath, LPCWSTR lpFileName, LPCWSTR lpExtension,
                DWORD nBufferLength, LPWSTR lpBuffer,
                unsigned short **lpFilePart);
int CreateProcessA(LPCSTR lpApplicationName, LPSTR lpCommandLine,
                   LPSECURITY_ATTRIBUTES lpProcessAttributes,
                   LPSECURITY_ATTRIBUTES lpThreadAttributes,
                   int bInheritHandles, DWORD dwCreationFlags,
                   LPVOID lpEnvironment, LPCSTR lpCurrentDirectory,
                   void *lpStartupInfo, void *lpProcessInformation);
int CreateProcessW(LPCWSTR lpApplicationName, LPWSTR lpCommandLine,
                   LPSECURITY_ATTRIBUTES lpProcessAttributes,
                   LPSECURITY_ATTRIBUTES lpThreadAttributes,
                   int bInheritHandles, DWORD dwCreationFlags,
                   LPVOID lpEnvironment, LPCWSTR lpCurrentDirectory,
                   void *lpStartupInfo, void *lpProcessInformation);
HANDLE GetStdHandle(DWORD nStdHandle);
int SetStdHandle(DWORD nStdHandle, HANDLE hHandle);
int GetConsoleMode(HANDLE hConsoleHandle, LPDWORD lpMode);
int SetConsoleMode(HANDLE hConsoleHandle, DWORD dwMode);
int GetConsoleOutputCP(void);
int SetConsoleOutputCP(UINT wCodePageID);
int GetConsoleCP(void);
int SetConsoleCP(UINT wCodePageID);
int WriteConsoleW(HANDLE hConsoleOutput, void *lpBuffer,
                  DWORD nNumberOfCharsToWrite,
                  LPDWORD lpNumberOfCharsWritten, LPVOID lpReserved);
int WriteConsoleA(HANDLE hConsoleOutput, void *lpBuffer,
                  DWORD nNumberOfCharsToWrite,
                  LPDWORD lpNumberOfCharsWritten, LPVOID lpReserved);
int ReadConsoleW(HANDLE hConsoleInput, LPVOID lpBuffer,
                 DWORD nNumberOfCharsToRead,
                 LPDWORD lpNumberOfCharsRead, LPVOID pInputControl);
int ReadConsoleA(HANDLE hConsoleInput, LPVOID lpBuffer,
                 DWORD nNumberOfCharsToRead,
                 LPDWORD lpNumberOfCharsRead, LPVOID pInputControl);
int FlushConsoleInputBuffer(HANDLE hConsoleInput);
int GetConsoleScreenBufferInfo(HANDLE hConsoleOutput,
                               PCONSOLE_SCREEN_BUFFER_INFO lpInfo);
int SetConsoleScreenBufferSize(HANDLE hConsoleOutput, COORD dwSize);
int SetConsoleCursorPosition(HANDLE hConsoleOutput, COORD dwCursorPosition);
int SetConsoleTextAttribute(HANDLE hConsoleOutput, WORD wAttributes);
int FillConsoleOutputCharacterA(HANDLE hConsoleOutput, char cCharacter,
                                DWORD nLength, COORD dwWriteCoord,
                                LPDWORD lpNumberOfCharsWritten);
int FillConsoleOutputCharacterW(HANDLE hConsoleOutput, WCHAR cCharacter,
                                DWORD nLength, COORD dwWriteCoord,
                                LPDWORD lpNumberOfCharsWritten);
int FillConsoleOutputAttribute(HANDLE hConsoleOutput, WORD wAttribute,
                               DWORD nLength, COORD dwWriteCoord,
                               LPDWORD lpNumberOfAttrsWritten);
int ScrollConsoleScreenBufferA(HANDLE hConsoleOutput,
                               SMALL_RECT *lpScrollRectangle,
                               SMALL_RECT *lpClipRectangle,
                               COORD dwDestinationOrigin, void *lpFill);
int ScrollConsoleScreenBufferW(HANDLE hConsoleOutput,
                               SMALL_RECT *lpScrollRectangle,
                               SMALL_RECT *lpClipRectangle,
                               COORD dwDestinationOrigin, void *lpFill);
int SetConsoleTitleA(LPCSTR lpConsoleTitle);
int SetConsoleTitleW(LPCWSTR lpConsoleTitle);
int GetConsoleTitleA(LPSTR lpConsoleTitle, DWORD nSize);
int GetConsoleTitleW(LPWSTR lpConsoleTitle, DWORD nSize);
int PeekConsoleInputA(HANDLE hConsoleInput, void *lpBuffer, DWORD nLength,
                      LPDWORD lpNumberOfEventsRead);
int PeekConsoleInputW(HANDLE hConsoleInput, void *lpBuffer, DWORD nLength,
                      LPDWORD lpNumberOfEventsRead);
int ReadConsoleInputA(HANDLE hConsoleInput, void *lpBuffer, DWORD nLength,
                      LPDWORD lpNumberOfEventsRead);
int ReadConsoleInputW(HANDLE hConsoleInput, void *lpBuffer, DWORD nLength,
                      LPDWORD lpNumberOfEventsRead);
int WriteConsoleInputA(HANDLE hConsoleInput, void *lpBuffer, DWORD nLength,
                       LPDWORD lpNumberOfEventsWritten);
int WriteConsoleInputW(HANDLE hConsoleInput, void *lpBuffer, DWORD nLength,
                       LPDWORD lpNumberOfEventsWritten);
int SetConsoleCtrlHandler(void *HandlerRoutine, int Add);
int GenerateConsoleCtrlEvent(DWORD dwCtrlEvent, DWORD dwProcessGroupId);
int AllocConsole(void);
int FreeConsole(void);
int AttachConsole(DWORD dwProcessId);
int GetConsoleProcessList(LPDWORD lpdwProcessList, DWORD dwProcessCount);
HWND GetConsoleWindow(void);
int GetSystemTimePreciseAsFileTime(LPFILETIME lpSystemTimeAsFileTime);
int QueryPerformanceFrequency(PLARGE_INTEGER lpFrequency);
unsigned long long GetTickCount64(void);
int SwitchToThread(void);
int SleepEx(DWORD dwMilliseconds, int bAlertable);
int GetTimeZoneInformation(void *lpTimeZoneInformation);
int SystemTimeToTzSpecificLocalTime(void *lpTimeZoneInformation,
                                    SYSTEMTIME *lpUniversalTime,
                                    SYSTEMTIME *lpLocalTime);
int TzSpecificLocalTimeToSystemTime(void *lpTimeZoneInformation,
                                    SYSTEMTIME *lpLocalTime,
                                    SYSTEMTIME *lpUniversalTime);
int GetLocalTime(SYSTEMTIME *lpSystemTime);
int SetLastError(DWORD dwErrCode);
int UuidCreate(void *Uuid);
int UuidCreateSequential(void *Uuid);

// Process / named-pipe / synchronization surface (processthreadsapi.h,
// namedpipeapi.h, memoryapi.h, fileapi.h, winbase.h). Struct-by-pointer
// parameters use the typedefs declared earlier; the kernel reads/writes
// the bytes at the native field offsets.
HANDLE CreateNamedPipeW(LPCWSTR lpName, DWORD dwOpenMode, DWORD dwPipeMode,
                        DWORD nMaxInstances, DWORD nOutBufferSize,
                        DWORD nInBufferSize, DWORD nDefaultTimeOut,
                        LPSECURITY_ATTRIBUTES lpSecurityAttributes);
int WaitNamedPipeW(LPCWSTR lpNamedPipeName, DWORD nTimeOut);
int PeekNamedPipe(HANDLE hNamedPipe, LPVOID lpBuffer, DWORD nBufferSize,
                  LPDWORD lpBytesRead, LPDWORD lpTotalBytesAvail,
                  LPDWORD lpBytesLeftThisMessage);
int GetExitCodeProcess(HANDLE hProcess, LPDWORD lpExitCode);
DWORD ResumeThread(HANDLE hThread);
int TerminateThread(HANDLE hThread, DWORD dwExitCode);
DWORD GetVersion(void);
DWORD GetLongPathNameW(LPCWSTR lpszShortPath, LPWSTR lpszLongPath, DWORD cchBuffer);
DWORD GetShortPathNameW(LPCWSTR lpszLongPath, LPWSTR lpszShortPath, DWORD cchBuffer);
HANDLE OpenFileMappingW(DWORD dwDesiredAccess, int bInheritHandle, LPCWSTR lpName);
SIZE_T VirtualQuery(LPCVOID lpAddress, PMEMORY_BASIC_INFORMATION lpBuffer,
                    SIZE_T dwLength);
HRESULT CopyFile2(LPCWSTR pwszExistingFileName, LPCWSTR pwszNewFileName,
                  COPYFILE2_EXTENDED_PARAMETERS *pExtendedParameters);
int NeedCurrentDirectoryForExePathW(LPCWSTR ExeName);
int LCMapStringEx(LPCWSTR lpLocaleName, DWORD dwMapFlags, LPCWSTR lpSrcStr,
                  int cchSrc, LPWSTR lpDestStr, int cchDest, void *lpVersionInformation,
                  void *lpReserved, LONG_PTR sortHandle);
int InitializeProcThreadAttributeList(LPPROC_THREAD_ATTRIBUTE_LIST lpAttributeList,
                                      DWORD dwAttributeCount, DWORD dwFlags,
                                      SIZE_T *lpSize);
int UpdateProcThreadAttribute(LPPROC_THREAD_ATTRIBUTE_LIST lpAttributeList,
                              DWORD dwFlags, DWORD_PTR Attribute, PVOID lpValue,
                              SIZE_T cbSize, PVOID lpPreviousValue,
                              SIZE_T *lpReturnSize);
void DeleteProcThreadAttributeList(LPPROC_THREAD_ATTRIBUTE_LIST lpAttributeList);

// Token-privilege surface (processthreadsapi.h / securitybaseapi.h).
int OpenProcessToken(HANDLE ProcessHandle, DWORD DesiredAccess, PHANDLE TokenHandle);
int LookupPrivilegeValueW(LPCWSTR lpSystemName, LPCWSTR lpName, PLUID lpLuid);
int AdjustTokenPrivileges(HANDLE TokenHandle, int DisableAllPrivileges,
                          PTOKEN_PRIVILEGES NewState, DWORD BufferLength,
                          PTOKEN_PRIVILEGES PreviousState, LPDWORD ReturnLength);

// ---------------------------------------------------------------------------
// Win32 GUI / GDI / WGL surface (user32.dll, gdi32.dll, opengl32.dll,
// shell32.dll). Widths and field order are pinned to the Win64 (LLP64) ABI so
// the structs match what the OS reads/writes on the other side of a call.
// Handles are opaque pointers (8 bytes). Bindings for the entry points below
// live in the consumer's link header; only the declarations are here.
// ---------------------------------------------------------------------------

typedef void *HGLRC;   // OpenGL rendering context (wingdi.h)
typedef void *HGDIOBJ; // generic GDI object
typedef void *HDROP;   // dropped-file handle (shellapi.h)
typedef void *HRAWINPUT;
typedef void *PROC;    // wglGetProcAddress return; cast to the target PFN
typedef float FLOAT;
typedef DWORD COLORREF;
typedef WORD  ATOM;
typedef char  CHAR;
typedef const char *LPCCH;
typedef WORD *LPWORD;
typedef UINT *PUINT;

// Empty error code returned by XInputGetKeystroke / message peeks.
#ifndef ERROR_DEVICE_NOT_CONNECTED
#define ERROR_DEVICE_NOT_CONNECTED 1167
#endif
#ifndef ERROR_EMPTY
#define ERROR_EMPTY 4306
#endif

// Word extraction from message parameters (minwindef.h).
#define LOWORD(l) ((WORD)((DWORD_PTR)(l) & 0xffff))
#define HIWORD(l) ((WORD)(((DWORD_PTR)(l) >> 16) & 0xffff))
#define RGB(r, g, b) \
    ((COLORREF)(((BYTE)(r)) | (((WORD)((BYTE)(g))) << 8) | (((DWORD)(BYTE)(b)) << 16)))
#define MAKEINTRESOURCEA(i) ((LPSTR)((ULONG_PTR)((WORD)(i))))

struct tagPOINT { LONG x; LONG y; };
typedef struct tagPOINT POINT;
typedef struct tagPOINT *LPPOINT;
typedef struct tagPOINT *PPOINT;

struct tagRECT { LONG left; LONG top; LONG right; LONG bottom; };
typedef struct tagRECT RECT;
typedef struct tagRECT *LPRECT;
typedef struct tagRECT *PRECT;

struct tagMSG {
    HWND   hwnd;
    UINT   message;
    WPARAM wParam;
    LPARAM lParam;
    DWORD  time;
    POINT  pt;
};
typedef struct tagMSG MSG;
typedef struct tagMSG *LPMSG;
typedef struct tagMSG *PMSG;

// WndProc and enumeration callback shapes.
typedef LRESULT (*WNDPROC)(HWND, UINT, WPARAM, LPARAM);
typedef int (*MONITORENUMPROC)(HMONITOR, HDC, LPRECT, LPARAM);

struct tagWNDCLASSA {
    UINT    style;
    WNDPROC lpfnWndProc;
    int     cbClsExtra;
    int     cbWndExtra;
    HINSTANCE hInstance;
    HICON   hIcon;
    HCURSOR hCursor;
    HBRUSH  hbrBackground;
    LPCSTR  lpszMenuName;
    LPCSTR  lpszClassName;
};
typedef struct tagWNDCLASSA WNDCLASSA;
typedef struct tagWNDCLASSA *LPWNDCLASSA;

struct tagWNDCLASSW {
    UINT    style;
    WNDPROC lpfnWndProc;
    int     cbClsExtra;
    int     cbWndExtra;
    HINSTANCE hInstance;
    HICON   hIcon;
    HCURSOR hCursor;
    HBRUSH  hbrBackground;
    const WCHAR *lpszMenuName;
    const WCHAR *lpszClassName;
};
typedef struct tagWNDCLASSW WNDCLASSW;
typedef struct tagWNDCLASSW *LPWNDCLASSW;

// Pixel format descriptor (wingdi.h) -- 40 bytes, all fields BYTE/WORD/DWORD.
struct tagPIXELFORMATDESCRIPTOR {
    WORD  nSize;
    WORD  nVersion;
    DWORD dwFlags;
    BYTE  iPixelType;
    BYTE  cColorBits;
    BYTE  cRedBits;
    BYTE  cRedShift;
    BYTE  cGreenBits;
    BYTE  cGreenShift;
    BYTE  cBlueBits;
    BYTE  cBlueShift;
    BYTE  cAlphaBits;
    BYTE  cAlphaShift;
    BYTE  cAccumBits;
    BYTE  cAccumRedBits;
    BYTE  cAccumGreenBits;
    BYTE  cAccumBlueBits;
    BYTE  cAccumAlphaBits;
    BYTE  cDepthBits;
    BYTE  cStencilBits;
    BYTE  cAuxBuffers;
    BYTE  iLayerType;
    BYTE  bReserved;
    DWORD dwLayerMask;
    DWORD dwVisibleMask;
    DWORD dwDamageMask;
};
typedef struct tagPIXELFORMATDESCRIPTOR PIXELFORMATDESCRIPTOR;
typedef struct tagPIXELFORMATDESCRIPTOR *LPPIXELFORMATDESCRIPTOR;

struct tagMINMAXINFO {
    POINT ptReserved;
    POINT ptMaxSize;
    POINT ptMaxPosition;
    POINT ptMinTrackSize;
    POINT ptMaxTrackSize;
};
typedef struct tagMINMAXINFO MINMAXINFO;
typedef struct tagMINMAXINFO *PMINMAXINFO;

struct tagWINDOWPLACEMENT {
    UINT  length;
    UINT  flags;
    UINT  showCmd;
    POINT ptMinPosition;
    POINT ptMaxPosition;
    RECT  rcNormalPosition;
};
typedef struct tagWINDOWPLACEMENT WINDOWPLACEMENT;
typedef struct tagWINDOWPLACEMENT *LPWINDOWPLACEMENT;

struct tagMONITORINFO {
    DWORD cbSize;
    RECT  rcMonitor;
    RECT  rcWork;
    DWORD dwFlags;
};
typedef struct tagMONITORINFO MONITORINFO;
typedef struct tagMONITORINFO *LPMONITORINFO;

#define CCHDEVICENAME 32
typedef struct tagMONITORINFOEXW {
    DWORD cbSize;
    RECT  rcMonitor;
    RECT  rcWork;
    DWORD dwFlags;
    WCHAR szDevice[CCHDEVICENAME];
} MONITORINFOEXW, *LPMONITORINFOEXW;
typedef struct tagMONITORINFOEXA {
    DWORD cbSize;
    RECT  rcMonitor;
    RECT  rcWork;
    DWORD dwFlags;
    char  szDevice[CCHDEVICENAME];
} MONITORINFOEXA, *LPMONITORINFOEXA;
#define MONITORINFOEX MONITORINFOEXW

struct _DISPLAY_DEVICEA {
    DWORD cb;
    CHAR  DeviceName[32];
    CHAR  DeviceString[128];
    DWORD StateFlags;
    CHAR  DeviceID[128];
    CHAR  DeviceKey[128];
};
typedef struct _DISPLAY_DEVICEA DISPLAY_DEVICEA;
typedef struct _DISPLAY_DEVICEA *PDISPLAY_DEVICEA;

// Raw input (winuser.h). Anonymous union/struct members are flattened to
// named fields occupying the same byte offsets the SDK lays out.
struct tagRAWINPUTHEADER {
    DWORD  dwType;
    DWORD  dwSize;
    HANDLE hDevice;
    WPARAM wParam;
};
typedef struct tagRAWINPUTHEADER RAWINPUTHEADER;

struct tagRAWMOUSE {
    USHORT usFlags;
    USHORT usReserved;
    ULONG  ulButtons;
    ULONG  ulRawButtons;
    LONG   lLastX;
    LONG   lLastY;
    ULONG  ulExtraInformation;
};
typedef struct tagRAWMOUSE RAWMOUSE;

struct tagRAWKEYBOARD {
    USHORT MakeCode;
    USHORT Flags;
    USHORT Reserved;
    USHORT VKey;
    UINT   Message;
    ULONG  ExtraInformation;
};
typedef struct tagRAWKEYBOARD RAWKEYBOARD;

struct tagRAWHID {
    DWORD dwSizeHid;
    DWORD dwCount;
    BYTE  bRawData[1];
};
typedef struct tagRAWHID RAWHID;

struct tagRAWINPUT {
    RAWINPUTHEADER header;
    union {
        RAWMOUSE    mouse;
        RAWKEYBOARD keyboard;
        RAWHID      hid;
    } data;
};
typedef struct tagRAWINPUT RAWINPUT;

struct tagRAWINPUTDEVICE {
    USHORT usUsagePage;
    USHORT usUsage;
    DWORD  dwFlags;
    HWND   hwndTarget;
};
typedef struct tagRAWINPUTDEVICE RAWINPUTDEVICE;
typedef struct tagRAWINPUTDEVICE *PRAWINPUTDEVICE;

// Raw-input device enumeration surface (GetRawInputDeviceList /
// GetRawInputDeviceInfo). Used to identify XInput HID devices.
typedef struct tagRAWINPUTDEVICELIST {
    HANDLE hDevice;
    DWORD  dwType;
} RAWINPUTDEVICELIST, *PRAWINPUTDEVICELIST;

typedef struct tagRID_DEVICE_INFO_MOUSE {
    DWORD dwId;
    DWORD dwNumberOfButtons;
    DWORD dwSampleRate;
    BOOL  fHasHorizontalWheel;
} RID_DEVICE_INFO_MOUSE;

typedef struct tagRID_DEVICE_INFO_KEYBOARD {
    DWORD dwType;
    DWORD dwSubType;
    DWORD dwKeyboardMode;
    DWORD dwNumberOfFunctionKeys;
    DWORD dwNumberOfIndicators;
    DWORD dwNumberOfKeysTotal;
} RID_DEVICE_INFO_KEYBOARD;

typedef struct tagRID_DEVICE_INFO_HID {
    DWORD  dwVendorId;
    DWORD  dwProductId;
    DWORD  dwVersionNumber;
    USHORT usUsagePage;
    USHORT usUsage;
} RID_DEVICE_INFO_HID;

typedef struct tagRID_DEVICE_INFO {
    DWORD cbSize;
    DWORD dwType;
    union {
        RID_DEVICE_INFO_MOUSE    mouse;
        RID_DEVICE_INFO_KEYBOARD keyboard;
        RID_DEVICE_INFO_HID      hid;
    };
} RID_DEVICE_INFO, *PRID_DEVICE_INFO;

#define RIM_TYPEMOUSE    0
#define RIM_TYPEKEYBOARD 1
#define RIM_TYPEHID      2
#define RIDI_DEVICENAME  0x20000007
#define RIDI_DEVICEINFO  0x2000000b

UINT GetRawInputDeviceList(PRAWINPUTDEVICELIST pRawInputDeviceList,
                           PUINT puiNumDevices, UINT cbSize);
UINT GetRawInputDeviceInfoA(HANDLE hDevice, UINT uiCommand, LPVOID pData,
                            PUINT pcbSize);
UINT GetRawInputDeviceInfoW(HANDLE hDevice, UINT uiCommand, LPVOID pData,
                            PUINT pcbSize);

struct _ICONINFO {
    BOOL    fIcon;
    DWORD   xHotspot;
    DWORD   yHotspot;
    HBITMAP hbmMask;
    HBITMAP hbmColor;
};
typedef struct _ICONINFO ICONINFO;
typedef struct _ICONINFO *PICONINFO;

// DIB / icon bitmap structures (wingdi.h).
typedef struct tagRGBQUAD {
    BYTE rgbBlue;
    BYTE rgbGreen;
    BYTE rgbRed;
    BYTE rgbReserved;
} RGBQUAD;
typedef struct tagBITMAPINFOHEADER {
    DWORD biSize;
    LONG  biWidth;
    LONG  biHeight;
    WORD  biPlanes;
    WORD  biBitCount;
    DWORD biCompression;
    DWORD biSizeImage;
    LONG  biXPelsPerMeter;
    LONG  biYPelsPerMeter;
    DWORD biClrUsed;
    DWORD biClrImportant;
} BITMAPINFOHEADER;
typedef struct tagBITMAPINFO {
    BITMAPINFOHEADER bmiHeader;
    RGBQUAD          bmiColors[1];
} BITMAPINFO;
// 14-byte on-disk BMP file header; bfSize/bfOffBits are unaligned, so it is
// packed to match the file format the OS clipboard produces.
#pragma pack(push, 1)
typedef struct tagBITMAPFILEHEADER {
    WORD  bfType;
    DWORD bfSize;
    WORD  bfReserved1;
    WORD  bfReserved2;
    DWORD bfOffBits;
} BITMAPFILEHEADER;
#pragma pack(pop)
typedef struct tagCIEXYZ { LONG ciexyzX; LONG ciexyzY; LONG ciexyzZ; } CIEXYZ;
typedef struct tagCIEXYZTRIPLE { CIEXYZ ciexyzRed; CIEXYZ ciexyzGreen; CIEXYZ ciexyzBlue; } CIEXYZTRIPLE;
typedef struct {
    DWORD        bV5Size;
    LONG         bV5Width;
    LONG         bV5Height;
    WORD         bV5Planes;
    WORD         bV5BitCount;
    DWORD        bV5Compression;
    DWORD        bV5SizeImage;
    LONG         bV5XPelsPerMeter;
    LONG         bV5YPelsPerMeter;
    DWORD        bV5ClrUsed;
    DWORD        bV5ClrImportant;
    DWORD        bV5RedMask;
    DWORD        bV5GreenMask;
    DWORD        bV5BlueMask;
    DWORD        bV5AlphaMask;
    DWORD        bV5CSType;
    CIEXYZTRIPLE bV5Endpoints;
    DWORD        bV5GammaRed;
    DWORD        bV5GammaGreen;
    DWORD        bV5GammaBlue;
    DWORD        bV5Intent;
    DWORD        bV5ProfileData;
    DWORD        bV5ProfileSize;
    DWORD        bV5Reserved;
} BITMAPV5HEADER;

// Window messages (winuser.h).
#define WM_NULL         0x0000
#define WM_MOVE         0x0003
#define WM_SIZE         0x0005
#define WM_ACTIVATE     0x0006
#define WM_PAINT        0x000F
#define WM_CLOSE        0x0010
#define WM_QUIT         0x0012
#define WM_GETMINMAXINFO 0x0024
#define WM_DEVICECHANGE 0x0219
#define WM_INPUT        0x00FF

// Window messages, styles, virtual keys and metrics RGFW's win32 backend
// reads. Canonical Win32 values; guarded so this augments the surface above.
#ifndef WM_MOUSEACTIVATE
#define WM_MOUSEACTIVATE 0x0021
#endif
#ifndef WM_SETICON
#define WM_SETICON 0x0080
#endif
#ifndef WM_NCHITTEST
#define WM_NCHITTEST 0x0084
#endif
#ifndef WM_NCLBUTTONDOWN
#define WM_NCLBUTTONDOWN 0x00A1
#endif
#ifndef WM_CHAR
#define WM_CHAR 0x0102
#endif
#ifndef WM_SYSKEYDOWN
#define WM_SYSKEYDOWN 0x0104
#endif
#ifndef WM_SYSKEYUP
#define WM_SYSKEYUP 0x0105
#endif
#ifndef WM_SYSCHAR
#define WM_SYSCHAR 0x0106
#endif
#ifndef WM_UNICHAR
#define WM_UNICHAR 0x0109
#endif
#ifndef WM_TIMER
#define WM_TIMER 0x0113
#endif
#ifndef WM_SIZING
#define WM_SIZING 0x0214
#endif
#ifndef WM_CAPTURECHANGED
#define WM_CAPTURECHANGED 0x0215
#endif
#ifndef WM_MOUSEHWHEEL
#define WM_MOUSEHWHEEL 0x020E
#endif
#ifndef WM_XBUTTONDOWN
#define WM_XBUTTONDOWN 0x020B
#endif
#ifndef WM_XBUTTONUP
#define WM_XBUTTONUP 0x020C
#endif
#ifndef WM_DISPLAYCHANGE
#define WM_DISPLAYCHANGE 0x007E
#endif
#ifndef WM_ENTERSIZEMOVE
#define WM_ENTERSIZEMOVE 0x0231
#endif
#ifndef WM_EXITSIZEMOVE
#define WM_EXITSIZEMOVE 0x0232
#endif
#ifndef WM_DPICHANGED
#define WM_DPICHANGED 0x02E0
#endif
#ifndef WM_DWMCOMPOSITIONCHANGED
#define WM_DWMCOMPOSITIONCHANGED 0x031E
#endif
#ifndef WM_DWMCOLORIZATIONCOLORCHANGED
#define WM_DWMCOLORIZATIONCOLORCHANGED 0x0320
#endif

#ifndef WS_EX_TOPMOST
#define WS_EX_TOPMOST 0x00000008
#endif
#ifndef WS_EX_APPWINDOW
#define WS_EX_APPWINDOW 0x00040000
#endif
#ifndef SW_MAXIMIZE
#define SW_MAXIMIZE 3
#endif
#ifndef SWP_NOACTIVATE
#define SWP_NOACTIVATE 0x0010
#endif
#ifndef SWP_NOOWNERZORDER
#define SWP_NOOWNERZORDER 0x0200
#endif
#ifndef HWND_TOPMOST
#define HWND_TOPMOST ((HWND)-1)
#endif
#ifndef HWND_NOTOPMOST
#define HWND_NOTOPMOST ((HWND)-2)
#endif
#ifndef SM_XVIRTUALSCREEN
#define SM_XVIRTUALSCREEN 76
#endif
#ifndef SM_YVIRTUALSCREEN
#define SM_YVIRTUALSCREEN 77
#endif
#ifndef SM_CXVIRTUALSCREEN
#define SM_CXVIRTUALSCREEN 78
#endif
#ifndef SM_CYVIRTUALSCREEN
#define SM_CYVIRTUALSCREEN 79
#endif
#ifndef MAPVK_VK_TO_VSC
#define MAPVK_VK_TO_VSC 0
#endif
#ifndef MAPVK_VSC_TO_VK
#define MAPVK_VSC_TO_VK 1
#endif
#ifndef KF_EXTENDED
#define KF_EXTENDED 0x0100
#endif
#ifndef PFD_STEREO
#define PFD_STEREO 0x00000002
#endif
#ifndef HTCLIENT
#define HTCLIENT 1
#endif
#ifndef HTCAPTION
#define HTCAPTION 2
#endif
#ifndef UNICODE_NOCHAR
#define UNICODE_NOCHAR 0xFFFF
#endif
#ifndef MOUSE_MOVE_ABSOLUTE
#define MOUSE_MOVE_RELATIVE 0
#define MOUSE_MOVE_ABSOLUTE 0x01
#define MOUSE_VIRTUAL_DESKTOP 0x02
#endif
#ifndef XBUTTON1
#define XBUTTON1 0x0001
#define XBUTTON2 0x0002
#endif
#ifndef GET_X_LPARAM
#define GET_X_LPARAM(lp) ((int)(short)LOWORD(lp))
#define GET_Y_LPARAM(lp) ((int)(short)HIWORD(lp))
#define GET_XBUTTON_WPARAM(wp) (HIWORD(wp))
#endif
#ifndef BI_RGB
#define BI_RGB 0
#endif
#ifndef HORZSIZE
#define HORZSIZE 4
#define VERTSIZE 6
#endif
#ifndef ICON_SMALL
#define ICON_SMALL 0
#define ICON_BIG 1
#endif
#ifndef SRCCOPY
#define SRCCOPY 0x00CC0020
#endif
#ifndef WMSZ_LEFT
#define WMSZ_LEFT 1
#define WMSZ_RIGHT 2
#define WMSZ_TOP 3
#define WMSZ_TOPLEFT 4
#define WMSZ_TOPRIGHT 5
#define WMSZ_BOTTOM 6
#define WMSZ_BOTTOMLEFT 7
#define WMSZ_BOTTOMRIGHT 8
#endif
#ifndef IMAGE_ICON
#define IMAGE_ICON 1
#endif
#ifndef LR_DEFAULTSIZE
#define LR_DEFAULTSIZE 0x00000040
#endif
#ifndef LR_SHARED
#define LR_SHARED 0x00008000
#endif
#ifndef IDI_APPLICATION
#define IDI_APPLICATION ((LPCSTR)(ULONG_PTR)32512)
#endif
#ifndef MONITORINFOF_PRIMARY
#define MONITORINFOF_PRIMARY 0x00000001
#endif
#ifndef ENUM_CURRENT_SETTINGS
#define ENUM_CURRENT_SETTINGS ((DWORD)-1)
#endif
#ifndef DISPLAY_DEVICE_ACTIVE
#define DISPLAY_DEVICE_ACTIVE 0x00000001
#endif
#ifndef DISP_CHANGE_SUCCESSFUL
#define DISP_CHANGE_SUCCESSFUL 0
#endif
#ifndef CDS_UPDATEREGISTRY
#define CDS_UPDATEREGISTRY 0x00000001
#endif
#ifndef CDS_TEST
#define CDS_TEST 0x00000002
#endif
#ifndef DM_BITSPERPEL
#define DM_BITSPERPEL 0x00040000
#endif
#ifndef DM_PELSWIDTH
#define DM_PELSWIDTH 0x00080000
#endif
#ifndef DM_PELSHEIGHT
#define DM_PELSHEIGHT 0x00100000
#endif
#ifndef DM_DISPLAYFREQUENCY
#define DM_DISPLAYFREQUENCY 0x00400000
#endif
#ifndef DWMWA_USE_IMMERSIVE_DARK_MODE
#define DWMWA_USE_IMMERSIVE_DARK_MODE 20
#endif
#ifndef FLASHW_STOP
#define FLASHW_STOP 0
#endif
#ifndef FLASHW_TRAY
#define FLASHW_TRAY 0x00000002
#endif
#ifndef FLASHW_TIMERNOFG
#define FLASHW_TIMERNOFG 0x0000000C
#endif

// Virtual-key codes (winuser.h).
#ifndef VK_RETURN
#define VK_RETURN 0x0D
#endif
#ifndef VK_CONTROL
#define VK_CONTROL 0x11
#endif
#ifndef VK_PAUSE
#define VK_PAUSE 0x13
#endif
#ifndef VK_PRIOR
#define VK_PRIOR 0x21
#endif
#ifndef VK_NEXT
#define VK_NEXT 0x22
#endif
#ifndef VK_END
#define VK_END 0x23
#endif
#ifndef VK_HOME
#define VK_HOME 0x24
#endif
#ifndef VK_LEFT
#define VK_LEFT 0x25
#endif
#ifndef VK_UP
#define VK_UP 0x26
#endif
#ifndef VK_RIGHT
#define VK_RIGHT 0x27
#endif
#ifndef VK_DOWN
#define VK_DOWN 0x28
#endif
#ifndef VK_SNAPSHOT
#define VK_SNAPSHOT 0x2C
#endif
#ifndef VK_INSERT
#define VK_INSERT 0x2D
#endif
#ifndef VK_LWIN
#define VK_LWIN 0x5B
#endif
#ifndef VK_RWIN
#define VK_RWIN 0x5C
#endif
#ifndef VK_APPS
#define VK_APPS 0x5D
#endif
#ifndef VK_NUMPAD0
#define VK_NUMPAD0 0x60
#define VK_NUMPAD1 0x61
#define VK_NUMPAD2 0x62
#define VK_NUMPAD3 0x63
#define VK_NUMPAD4 0x64
#define VK_NUMPAD5 0x65
#define VK_NUMPAD6 0x66
#define VK_NUMPAD7 0x67
#define VK_NUMPAD8 0x68
#define VK_NUMPAD9 0x69
#endif
#ifndef VK_MULTIPLY
#define VK_MULTIPLY 0x6A
#define VK_ADD 0x6B
#define VK_SUBTRACT 0x6D
#define VK_DECIMAL 0x6E
#define VK_DIVIDE 0x6F
#endif
#ifndef VK_F1
#define VK_F1 0x70
#define VK_F2 0x71
#define VK_F3 0x72
#define VK_F4 0x73
#define VK_F5 0x74
#define VK_F6 0x75
#define VK_F7 0x76
#define VK_F8 0x77
#define VK_F9 0x78
#define VK_F10 0x79
#define VK_F11 0x7A
#define VK_F12 0x7B
#define VK_F13 0x7C
#define VK_F14 0x7D
#define VK_F15 0x7E
#define VK_F16 0x7F
#define VK_F17 0x80
#define VK_F18 0x81
#define VK_F19 0x82
#define VK_F20 0x83
#define VK_F21 0x84
#define VK_F22 0x85
#define VK_F23 0x86
#define VK_F24 0x87
#endif
#ifndef VK_SCROLL
#define VK_SCROLL 0x91
#endif
#ifndef VK_LSHIFT
#define VK_LSHIFT 0xA0
#define VK_RSHIFT 0xA1
#define VK_LCONTROL 0xA2
#define VK_RCONTROL 0xA3
#define VK_LMENU 0xA4
#define VK_RMENU 0xA5
#endif
#ifndef MAKELONG
#define MAKELONG(a, b) ((LONG)(((WORD)((a) & 0xffff)) | ((DWORD)((WORD)((b) & 0xffff))) << 16))
#endif
#define WM_KEYDOWN      0x0100
#define WM_KEYUP        0x0101
#define WM_MOUSEMOVE    0x0200
#define WM_LBUTTONDOWN  0x0201
#define WM_LBUTTONUP    0x0202
#define WM_RBUTTONDOWN  0x0204
#define WM_RBUTTONUP    0x0205
#define WM_MBUTTONDOWN  0x0207
#define WM_MBUTTONUP    0x0208
#define WM_MOUSEWHEEL   0x020A
#define WM_DROPFILES    0x0233
#define WM_MOUSELEAVE   0x02A3
#define WA_INACTIVE     0

// Window styles.
#define WS_OVERLAPPEDWINDOW 0x00CF0000
#define WS_POPUP            0x80000000
#define WS_VISIBLE         0x10000000
#define WS_CLIPSIBLINGS    0x04000000
#define WS_CLIPCHILDREN    0x02000000
#define WS_CAPTION         0x00C00000
#define WS_BORDER          0x00800000
#define WS_SYSMENU         0x00080000
#define WS_THICKFRAME      0x00040000
#define WS_SIZEBOX         0x00040000
#define WS_MINIMIZEBOX     0x00020000
#define WS_MAXIMIZEBOX     0x00010000
#define WS_EX_TRANSPARENT  0x00000020
#define WS_EX_LAYERED      0x00080000

// Pixel format flags / types (wingdi.h).
#define PFD_DOUBLEBUFFER        0x00000001
#define PFD_DRAW_TO_WINDOW      0x00000004
#define PFD_SUPPORT_OPENGL      0x00000020
#define PFD_GENERIC_FORMAT      0x00000040
#define PFD_GENERIC_ACCELERATED 0x00001000
#define PFD_TYPE_RGBA           0
#define PFD_MAIN_PLANE          0

#define PM_REMOVE       0x0001
#define SW_HIDE         0
#define SW_SHOWNORMAL   1
#define SW_SHOWMINIMIZED 2
#define SW_SHOWMAXIMIZED 3
#define SW_MINIMIZE     6
#define SW_RESTORE      9
#define GWL_STYLE       (-16)
#define GWL_EXSTYLE     (-20)
#define GCLP_HICON      (-14)
#define GCLP_HCURSOR    (-12)
#define VK_SHIFT        0x10
#define VK_CAPITAL      0x14
#define VK_NUMLOCK      0x90
#define MAPVK_VK_TO_CHAR 2
#define SM_CXSCREEN     0
#define SM_CYSCREEN     1
#define RID_INPUT       0x10000003
#define RIDEV_REMOVE    0x00000001
#define RIM_TYPEMOUSE   0
#define MONITOR_DEFAULTTOPRIMARY 0x00000001
#define WHEEL_DELTA     120
#define IDC_ARROW       MAKEINTRESOURCEA(32512)
#define OCR_NORMAL      32512
#define OCR_IBEAM       32513
#define OCR_CROSS       32515
#define OCR_SIZENWSE    32642
#define OCR_SIZENESW    32643
#define OCR_SIZEWE      32644
#define OCR_SIZENS      32645
#define OCR_SIZEALL     32646
#define OCR_NO          32648
#define OCR_HAND        32649
#define OCR_WAIT        32514
#define OCR_UP          32516
#define OCR_APPSTARTING 32650
#define QS_ALLINPUT     0x04FF
#define CF_UNICODETEXT  13
#define CF_DIB          8
#define GMEM_MOVEABLE   0x0002
#define LWA_ALPHA       0x00000002
#define BI_BITFIELDS    3
#define DIB_RGB_COLORS  0
#define LOGPIXELSX      88
#define LOGPIXELSY      90
#define SWP_NOSIZE      0x0001
#define SWP_NOMOVE      0x0002
#define SWP_NOZORDER    0x0004
#define SWP_FRAMECHANGED 0x0020
#define SWP_SHOWWINDOW  0x0040
#define HORZRES         8
#define VERTRES         10
#define HWND_TOP        ((HWND)0)

// kernel32 movable-memory allocation (used for clipboard transfers).
#pragma binding(kernel32::GlobalAlloc,  "GlobalAlloc")
#pragma binding(kernel32::GlobalFree,   "GlobalFree")
#pragma binding(kernel32::GlobalLock,   "GlobalLock")
#pragma binding(kernel32::GlobalUnlock, "GlobalUnlock")
#pragma binding(kernel32::GlobalSize,   "GlobalSize")
HGLOBAL GlobalAlloc(UINT uFlags, SIZE_T dwBytes);
HGLOBAL GlobalFree(HGLOBAL hMem);
LPVOID  GlobalLock(HGLOBAL hMem);
BOOL    GlobalUnlock(HGLOBAL hMem);
SIZE_T  GlobalSize(HGLOBAL hMem);

// user32.dll window, message, input, monitor, and clipboard entry points.
#define CreateWindowA(cls, name, style, x, y, w, h, parent, menu, inst, param) \
    CreateWindowExA(0, cls, name, style, x, y, w, h, parent, menu, inst, param)
#define LoadCursor    LoadCursorA
#define MapVirtualKey MapVirtualKeyA
#define GetWindowLong GetWindowLongA
#define SetWindowLong SetWindowLongA
HWND CreateWindowExA(DWORD dwExStyle, LPCSTR lpClassName, LPCSTR lpWindowName,
                     DWORD dwStyle, int X, int Y, int nWidth, int nHeight,
                     HWND hWndParent, HMENU hMenu, HINSTANCE hInstance, LPVOID lpParam);
ATOM    RegisterClassA(const WNDCLASSA *lpWndClass);
LRESULT DefWindowProcA(HWND hWnd, UINT Msg, WPARAM wParam, LPARAM lParam);

#define CreateWindowW(cls, name, style, x, y, w, h, parent, menu, inst, param) \
    CreateWindowExW(0, cls, name, style, x, y, w, h, parent, menu, inst, param)
HWND CreateWindowExW(DWORD dwExStyle, const WCHAR *lpClassName,
                     const WCHAR *lpWindowName, DWORD dwStyle, int X, int Y,
                     int nWidth, int nHeight, HWND hWndParent, HMENU hMenu,
                     HINSTANCE hInstance, LPVOID lpParam);
ATOM    RegisterClassW(const WNDCLASSW *lpWndClass);
LRESULT DefWindowProcW(HWND hWnd, UINT Msg, WPARAM wParam, LPARAM lParam);
#ifndef SendMessage
#define SendMessage SendMessageW
#endif
#ifndef PostMessage
#define PostMessage PostMessageW
#endif
#ifndef GetWindowLongPtr
#define GetWindowLongPtr GetWindowLongPtrW
#endif
#ifndef LoadIcon
#define LoadIcon LoadIconA
#endif
HANDLE  GetPropW(HWND hWnd, const WCHAR *lpString);
BOOL    SetPropW(HWND hWnd, const WCHAR *lpString, HANDLE hData);
HANDLE  RemovePropW(HWND hWnd, const WCHAR *lpString);

// Registry read used for the Windows dark-mode query.
#define HKEY_CURRENT_USER ((HKEY)(ULONG_PTR)0x80000001)
#define RRF_RT_REG_DWORD 0x00000010
LONG RegGetValueW(HKEY hkey, const WCHAR *lpSubKey, const WCHAR *lpValue,
                  DWORD dwFlags, LPDWORD pdwType, void *pvData, LPDWORD pcbData);

// Display / paint / timer surface RGFW's win32 backend reads.
typedef BYTE *PBYTE;
typedef void (CALLBACK *TIMERPROC)(HWND, UINT, UINT_PTR, DWORD);
typedef enum MONITOR_DPI_TYPE {
    MDT_EFFECTIVE_DPI = 0,
    MDT_ANGULAR_DPI = 1,
    MDT_RAW_DPI = 2,
    MDT_DEFAULT = 0
} MONITOR_DPI_TYPE;

typedef struct tagPOINTL { LONG x; LONG y; } POINTL;

typedef struct _devicemodeW {
    WCHAR dmDeviceName[32];
    WORD  dmSpecVersion;
    WORD  dmDriverVersion;
    WORD  dmSize;
    WORD  dmDriverExtra;
    DWORD dmFields;
    union {
        struct {
            short dmOrientation;
            short dmPaperSize;
            short dmPaperLength;
            short dmPaperWidth;
            short dmScale;
            short dmCopies;
            short dmDefaultSource;
            short dmPrintQuality;
        };
        struct {
            POINTL dmPosition;
            DWORD  dmDisplayOrientation;
            DWORD  dmDisplayFixedOutput;
        };
    };
    short dmColor;
    short dmDuplex;
    short dmYResolution;
    short dmTTOption;
    short dmCollate;
    WCHAR dmFormName[32];
    WORD  dmLogPixels;
    DWORD dmBitsPerPel;
    DWORD dmPelsWidth;
    DWORD dmPelsHeight;
    union {
        DWORD dmDisplayFlags;
        DWORD dmNup;
    };
    DWORD dmDisplayFrequency;
    DWORD dmICMMethod;
    DWORD dmICMIntent;
    DWORD dmMediaType;
    DWORD dmDitherType;
    DWORD dmReserved1;
    DWORD dmReserved2;
    DWORD dmPanningWidth;
    DWORD dmPanningHeight;
} DEVMODEW, *PDEVMODEW, *LPDEVMODEW;

typedef struct _DISPLAY_DEVICEW {
    DWORD cb;
    WCHAR DeviceName[32];
    WCHAR DeviceString[128];
    DWORD StateFlags;
    WCHAR DeviceID[128];
    WCHAR DeviceKey[128];
} DISPLAY_DEVICEW, *PDISPLAY_DEVICEW;

typedef struct tagPAINTSTRUCT {
    HDC  hdc;
    BOOL fErase;
    RECT rcPaint;
    BOOL fRestore;
    BOOL fIncUpdate;
    BYTE rgbReserved[32];
} PAINTSTRUCT, *LPPAINTSTRUCT;

typedef struct tagFLASHWINFO {
    UINT  cbSize;
    HWND  hwnd;
    DWORD dwFlags;
    UINT  uCount;
    DWORD dwTimeout;
} FLASHWINFO, *PFLASHWINFO;

BOOL     GetKeyboardState(PBYTE lpKeyState);
HKL      GetKeyboardLayout(DWORD idThread);
UINT     MapVirtualKeyW(UINT uCode, UINT uMapType);
int      ToUnicodeEx(UINT wVirtKey, UINT wScanCode, const BYTE *lpKeyState,
                     LPWSTR pwszBuff, int cchBuff, UINT wFlags, HKL dwhkl);
LONG     ChangeDisplaySettingsExW(const WCHAR *lpszDeviceName, DEVMODEW *lpDevMode,
                                  HWND hwnd, DWORD dwflags, LPVOID lParam);
BOOL     EnumDisplayDevicesW(const WCHAR *lpDevice, DWORD iDevNum,
                             PDISPLAY_DEVICEW lpDisplayDevice, DWORD dwFlags);
BOOL     EnumDisplaySettingsW(const WCHAR *lpszDeviceName, DWORD iModeNum,
                              DEVMODEW *lpDevMode);
BOOL     FlashWindowEx(PFLASHWINFO pfwi);
BOOL     GetMonitorInfoW(HMONITOR hMonitor, MONITORINFO *lpmi);
BOOL     IsZoomed(HWND hWnd);
HICON    LoadIconA(HINSTANCE hInstance, LPCSTR lpIconName);
HANDLE   LoadImageA(HINSTANCE hInst, LPCSTR name, UINT type, int cx, int cy,
                    UINT fuLoad);
LONG_PTR GetWindowLongPtrW(HWND hWnd, int nIndex);
LONG_PTR SetWindowLongPtrW(HWND hWnd, int nIndex, LONG_PTR dwNewLong);
BOOL     SetWindowTextW(HWND hWnd, const WCHAR *lpString);
LRESULT  SendMessageW(HWND hWnd, UINT Msg, WPARAM wParam, LPARAM lParam);
HWND     SetFocus(HWND hWnd);
BOOL     SetForegroundWindow(HWND hWnd);
UINT_PTR SetTimer(HWND hWnd, UINT_PTR nIDEvent, UINT uElapse, TIMERPROC lpTimerFunc);
BOOL     KillTimer(HWND hWnd, UINT_PTR uIDEvent);
HDC      BeginPaint(HWND hWnd, LPPAINTSTRUCT lpPaint);
BOOL     EndPaint(HWND hWnd, const PAINTSTRUCT *lpPaint);
BOOL     BringWindowToTop(HWND hWnd);
BOOL     AdjustWindowRectEx(LPRECT lpRect, DWORD dwStyle, BOOL bMenu, DWORD dwExStyle);
BOOL     MoveWindow(HWND hWnd, int X, int Y, int nWidth, int nHeight, BOOL bRepaint);
BOOL     BitBlt(HDC hdc, int x, int y, int cx, int cy, HDC hdcSrc, int x1, int y1,
                DWORD rop);
HDC      CreateDCW(const WCHAR *pwszDriver, const WCHAR *pwszDevice,
                   const WCHAR *pszPort, const DEVMODEW *pdm);
BOOL     GetDeviceGammaRamp(HDC hdc, LPVOID lpRamp);
BOOL     SetDeviceGammaRamp(HDC hdc, LPVOID lpRamp);
BOOL    ShowWindow(HWND hWnd, int nCmdShow);
HDC     GetDC(HWND hWnd);
int     ReleaseDC(HWND hWnd, HDC hDC);
BOOL    GetWindowRect(HWND hWnd, LPRECT lpRect);
BOOL    GetClientRect(HWND hWnd, LPRECT lpRect);
BOOL    DestroyWindow(HWND hWnd);
BOOL    PeekMessageA(LPMSG lpMsg, HWND hWnd, UINT wMsgFilterMin, UINT wMsgFilterMax, UINT wRemoveMsg);
BOOL    TranslateMessage(const MSG *lpMsg);
LRESULT DispatchMessageA(const MSG *lpMsg);
BOOL    PostMessageW(HWND hWnd, UINT Msg, WPARAM wParam, LPARAM lParam);
DWORD   MsgWaitForMultipleObjects(DWORD nCount, void *pHandles, BOOL fWaitAll, DWORD dwMilliseconds, DWORD dwWakeMask);
HCURSOR LoadCursorA(HINSTANCE hInstance, LPCSTR lpCursorName);
SHORT   GetKeyState(int nVirtKey);
int     GetKeyNameTextA(LONG lParam, LPSTR lpString, int cchSize);
UINT    MapVirtualKeyA(UINT uCode, UINT uMapType);
int     ToAscii(UINT uVirtKey, UINT uScanCode, const BYTE *lpKeyState, LPWORD lpChar, UINT uFlags);
UINT    GetRawInputData(HRAWINPUT hRawInput, UINT uiCommand, LPVOID pData, PUINT pcbSize, UINT cbSizeHeader);
BOOL    RegisterRawInputDevices(const RAWINPUTDEVICE *pRawInputDevices, UINT uiNumDevices, UINT cbSize);
BOOL    ClipCursor(const RECT *lpRect);
BOOL    GetCursorPos(LPPOINT lpPoint);
BOOL    SetCursorPos(int X, int Y);
BOOL    ClientToScreen(HWND hWnd, LPPOINT lpPoint);
BOOL    ScreenToClient(HWND hWnd, LPPOINT lpPoint);
BOOL    IsWindow(HWND hWnd);
BOOL    IsWindowVisible(HWND hWnd);
BOOL    GetWindowPlacement(HWND hWnd, WINDOWPLACEMENT *lpwndpl);
ULONG_PTR SetClassLongPtrA(HWND hWnd, int nIndex, LONG_PTR dwNewLong);
HCURSOR SetCursor(HCURSOR hCursor);
BOOL    DestroyCursor(HCURSOR hCursor);
BOOL    DestroyIcon(HICON hIcon);
BOOL    SetWindowPos(HWND hWnd, HWND hWndInsertAfter, int X, int Y, int cx, int cy, UINT uFlags);
BOOL    SetWindowTextA(HWND hWnd, LPCSTR lpString);
LONG    GetWindowLongW(HWND hWnd, int nIndex);
LONG    SetWindowLongW(HWND hWnd, int nIndex, LONG dwNewLong);
LONG    GetWindowLongA(HWND hWnd, int nIndex);
LONG    SetWindowLongA(HWND hWnd, int nIndex, LONG dwNewLong);
BOOL    GetLayeredWindowAttributes(HWND hWnd, COLORREF *pcrKey, BYTE *pbAlpha, DWORD *pdwFlags);
BOOL    SetLayeredWindowAttributes(HWND hWnd, COLORREF crKey, BYTE bAlpha, DWORD dwFlags);
int     GetSystemMetrics(int nIndex);
HMONITOR MonitorFromPoint(POINT pt, DWORD dwFlags);
HMONITOR MonitorFromWindow(HWND hwnd, DWORD dwFlags);
BOOL    EnumDisplayMonitors(HDC hdc, LPRECT lprcClip, MONITORENUMPROC lpfnEnum, LPARAM dwData);
BOOL    EnumDisplayDevicesA(LPCSTR lpDevice, DWORD iDevNum, PDISPLAY_DEVICEA lpDisplayDevice, DWORD dwFlags);
BOOL    GetMonitorInfoA(HMONITOR hMonitor, LPMONITORINFO lpmi);
BOOL    SetProcessDPIAware(void);
HWND    GetForegroundWindow(void);
BOOL    OpenClipboard(HWND hWndNewOwner);
BOOL    CloseClipboard(void);
HANDLE  GetClipboardData(UINT uFormat);
BOOL    EmptyClipboard(void);
HANDLE  SetClipboardData(UINT uFormat, HANDLE hMem);
DWORD   CharLowerBuffA(LPSTR lpsz, DWORD cchLength);

// gdi32.dll pixel format, DIB, and bitblt entry points.
int     ChoosePixelFormat(HDC hdc, const PIXELFORMATDESCRIPTOR *ppfd);
BOOL    SetPixelFormat(HDC hdc, int format, const PIXELFORMATDESCRIPTOR *ppfd);
int     DescribePixelFormat(HDC hdc, int iPixelFormat, UINT nBytes, LPPIXELFORMATDESCRIPTOR ppfd);
BOOL    SwapBuffers(HDC hdc);
int     GetDeviceCaps(HDC hdc, int index);
HBITMAP CreateBitmap(int nWidth, int nHeight, UINT nPlanes, UINT nBitCount, const void *lpBits);
HBITMAP CreateDIBSection(HDC hdc, const BITMAPINFO *pbmi, UINT usage, void **ppvBits, HANDLE hSection, DWORD offset);
HDC     CreateCompatibleDC(HDC hdc);
BOOL    DeleteDC(HDC hdc);
BOOL    DeleteObject(HGDIOBJ ho);
HGDIOBJ SelectObject(HDC hdc, HGDIOBJ h);
HICON   CreateIconIndirect(PICONINFO piconinfo);

// opengl32.dll WGL context entry points.
HGLRC   wglCreateContext(HDC hdc);
BOOL    wglDeleteContext(HGLRC hglrc);
BOOL    wglMakeCurrent(HDC hdc, HGLRC hglrc);
PROC    wglGetProcAddress(LPCSTR lpszProc);
HDC     wglGetCurrentDC(void);
HGLRC   wglGetCurrentContext(void);
BOOL    wglShareLists(HGLRC hglrc1, HGLRC hglrc2);

#endif

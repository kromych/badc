// windows.h -- the Win32 surface, with the types the Windows SDK gives it,
// so a program that declares one of these functions itself redeclares
// the same type. dlfcn.h binds the loader trio under the POSIX names.
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
#include <stdarg.h>

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
// Base types (minwindef.h, basetsd.h, winnt.h) at the LLP64 widths:
// `long` is 4 bytes on the Windows targets and `wchar_t` 2.
typedef unsigned long      DWORD;
typedef int                BOOL;
typedef unsigned char      BYTE;
typedef unsigned short     WORD;
typedef float              FLOAT;
typedef FLOAT             *PFLOAT;
typedef BOOL              *PBOOL;
typedef BOOL              *LPBOOL;
typedef BYTE              *PBYTE;
typedef BYTE              *LPBYTE;
typedef int               *PINT;
typedef int               *LPINT;
typedef WORD              *PWORD;
typedef WORD              *LPWORD;
typedef long              *LPLONG;
typedef DWORD             *PDWORD;
typedef DWORD             *LPDWORD;
typedef void              *LPVOID;
typedef const void        *LPCVOID;
typedef int                INT;
typedef unsigned int       UINT;
typedef unsigned int      *PUINT;
typedef void              *PVOID;
typedef char               CHAR;
typedef short              SHORT;
typedef long               LONG;
typedef unsigned long      ULONG;
typedef ULONG             *PULONG;
typedef unsigned short     USHORT;
typedef USHORT            *PUSHORT;
typedef unsigned char      UCHAR;
typedef UCHAR             *PUCHAR;
typedef LONG              *PLONG;
typedef wchar_t            WCHAR;
typedef WCHAR             *PWCHAR, *LPWCH, *PWCH;
typedef const WCHAR       *LPCWCH, *PCWCH;
typedef WCHAR             *NWPSTR, *LPWSTR, *PWSTR;
typedef const WCHAR       *LPCWSTR, *PCWSTR;
typedef CHAR              *PCHAR, *LPCH, *PCH;
typedef const CHAR        *LPCCH, *PCCH;
typedef CHAR              *NPSTR, *LPSTR, *PSTR;
typedef const CHAR        *LPCSTR, *PCSTR;
#ifdef UNICODE
typedef WCHAR              TCHAR, *PTCHAR;
typedef LPWSTR             PTSTR, LPTSTR;
typedef LPCWSTR            PCTSTR, LPCTSTR;
#else
typedef char               TCHAR, *PTCHAR;
typedef LPSTR              PTSTR, LPTSTR;
typedef LPCSTR             PCTSTR, LPCTSTR;
#endif
typedef long long          LONGLONG;
typedef unsigned long long ULONGLONG;
typedef ULONGLONG          DWORDLONG;
typedef long long          INT_PTR, *PINT_PTR;
typedef unsigned long long UINT_PTR, *PUINT_PTR;
typedef long long          LONG_PTR, *PLONG_PTR;
typedef unsigned long long ULONG_PTR, *PULONG_PTR;
typedef ULONG_PTR          SIZE_T, *PSIZE_T;
typedef LONG_PTR           SSIZE_T, *PSSIZE_T;
typedef ULONG_PTR          DWORD_PTR, *PDWORD_PTR;
typedef long long          LONG64, *PLONG64;
typedef unsigned long long ULONG64, *PULONG64;
typedef unsigned long long DWORD64, *PDWORD64;
typedef signed char        INT8, *PINT8;
typedef signed short       INT16, *PINT16;
typedef signed int         INT32, *PINT32;
typedef long long          INT64, *PINT64;
typedef unsigned char      UINT8, *PUINT8;
typedef unsigned short     UINT16, *PUINT16;
typedef unsigned int       UINT32, *PUINT32;
typedef unsigned long long UINT64, *PUINT64;
typedef signed int         LONG32, *PLONG32;
typedef unsigned int       ULONG32, *PULONG32;
typedef unsigned int       DWORD32, *PDWORD32;
typedef UINT_PTR           WPARAM;
typedef LONG_PTR           LPARAM;
typedef LONG_PTR           LRESULT;
typedef LONG               HRESULT;
typedef LONG               NTSTATUS;
typedef UCHAR              BOOLEAN;
typedef WORD               ATOM;
typedef ULONG              LCID;
typedef USHORT             LANGID;
typedef DWORD              LCTYPE;
typedef DWORD              ACCESS_MASK;
typedef ACCESS_MASK       *PACCESS_MASK;
typedef ACCESS_MASK        REGSAM;
typedef LONG               LSTATUS;
typedef DWORD              COLORREF;
typedef DWORD             *LPCOLORREF;
typedef long               RPC_STATUS;
typedef DWORD              EXECUTION_STATE;
// basetsd.h pointer/integer conversions. HANDLE is pointer-width; a LONG
// sign-extends through LONG_PTR before becoming a HANDLE.
#define LongToHandle(h) ((HANDLE)(LONG_PTR)(long)(h))
#define HandleToLong(h) ((long)(LONG_PTR)(h))
#define ULongToHandle(h) ((HANDLE)(ULONG_PTR)(unsigned long)(h))

// Handles (winnt.h, minwindef.h, windef.h). STRICT is the SDK default:
// each handle type points to a struct of its own, so two do not mix.
#ifndef NO_STRICT
#ifndef STRICT
#define STRICT 1
#endif
#endif
typedef void              *HANDLE;
#define DECLARE_HANDLE(name) struct name##__ { int unused; }; typedef struct name##__ *name
typedef HANDLE            *PHANDLE;
typedef HANDLE            *SPHANDLE;
typedef HANDLE            *LPHANDLE;
typedef HANDLE             HGLOBAL;
typedef HANDLE             HLOCAL;
typedef HANDLE             GLOBALHANDLE;
typedef HANDLE             LOCALHANDLE;
typedef INT_PTR (WINAPI *FARPROC)();
typedef INT_PTR (WINAPI *NEARPROC)();
typedef INT_PTR (WINAPI *PROC)();
DECLARE_HANDLE(HKEY);
typedef HKEY              *PHKEY;
DECLARE_HANDLE(HMETAFILE);
DECLARE_HANDLE(HINSTANCE);
typedef HINSTANCE          HMODULE;
DECLARE_HANDLE(HRGN);
DECLARE_HANDLE(HRSRC);
DECLARE_HANDLE(HSPRITE);
DECLARE_HANDLE(HLSURF);
DECLARE_HANDLE(HSTR);
DECLARE_HANDLE(HTASK);
DECLARE_HANDLE(HWINSTA);
DECLARE_HANDLE(HKL);
typedef int                HFILE;
DECLARE_HANDLE(HWND);
DECLARE_HANDLE(HHOOK);
typedef void              *HGDIOBJ;
DECLARE_HANDLE(HACCEL);
DECLARE_HANDLE(HBITMAP);
DECLARE_HANDLE(HBRUSH);
DECLARE_HANDLE(HCOLORSPACE);
DECLARE_HANDLE(HDC);
DECLARE_HANDLE(HGLRC);
DECLARE_HANDLE(HDESK);
DECLARE_HANDLE(HENHMETAFILE);
DECLARE_HANDLE(HFONT);
DECLARE_HANDLE(HICON);
DECLARE_HANDLE(HMENU);
DECLARE_HANDLE(HPALETTE);
DECLARE_HANDLE(HPEN);
DECLARE_HANDLE(HWINEVENTHOOK);
DECLARE_HANDLE(HMONITOR);
DECLARE_HANDLE(HUMPD);
typedef HICON              HCURSOR;
DECLARE_HANDLE(HDROP);
DECLARE_HANDLE(HRAWINPUT);
DECLARE_HANDLE(HPSS);
typedef HANDLE             HMUTEX;
typedef HANDLE             HMUTANT;
typedef HANDLE             HEVENT;
typedef HANDLE             HSEMAPHORE;
typedef ULONG_PTR          HCRYPTPROV;
typedef ULONG_PTR          HCRYPTKEY;
typedef ULONG_PTR          HCRYPTHASH;
typedef PVOID              DLL_DIRECTORY_COOKIE, *PDLL_DIRECTORY_COOKIE;
typedef PVOID              BCRYPT_HANDLE;
typedef PVOID              BCRYPT_ALG_HANDLE;
typedef PVOID              PSECURITY_DESCRIPTOR;
typedef PVOID              PSID;

// The records the prototypes take by pointer before their definition, and
// the callback shapes.
typedef struct _SECURITY_ATTRIBUTES SECURITY_ATTRIBUTES, *PSECURITY_ATTRIBUTES,
    *LPSECURITY_ATTRIBUTES;
typedef struct _OVERLAPPED OVERLAPPED, *POVERLAPPED, *LPOVERLAPPED;
typedef struct _SYSTEMTIME SYSTEMTIME, *PSYSTEMTIME, *LPSYSTEMTIME;
struct _EXCEPTION_POINTERS;
typedef DWORD (WINAPI *PTHREAD_START_ROUTINE)(LPVOID lpThreadParameter);
typedef PTHREAD_START_ROUTINE LPTHREAD_START_ROUTINE;
typedef VOID (WINAPI *PTIMERAPCROUTINE)(LPVOID lpArgToCompletionRoutine,
                                        DWORD dwTimerLowValue, DWORD dwTimerHighValue);
typedef BOOL (WINAPI *PHANDLER_ROUTINE)(DWORD CtrlType);
typedef LONG (WINAPI *PTOP_LEVEL_EXCEPTION_FILTER)(struct _EXCEPTION_POINTERS *ExceptionInfo);
typedef PTOP_LEVEL_EXCEPTION_FILTER LPTOP_LEVEL_EXCEPTION_FILTER;
typedef LONG (WINAPI *PVECTORED_EXCEPTION_HANDLER)(struct _EXCEPTION_POINTERS *ExceptionInfo);
typedef enum _GET_FILEEX_INFO_LEVELS {
    GetFileExInfoStandard,
    GetFileExMaxInfoLevel
} GET_FILEEX_INFO_LEVELS;
typedef struct _REASON_CONTEXT {
    ULONG Version;
    DWORD Flags;
    union {
        struct {
            HMODULE LocalizedReasonModule;
            ULONG   LocalizedReasonId;
            ULONG   ReasonStringCount;
            LPWSTR *ReasonStrings;
        } Detailed;
        LPWSTR SimpleReasonString;
    } Reason;
} REASON_CONTEXT, *PREASON_CONTEXT;
typedef enum {
    PSS_CAPTURE_NONE                              = 0x00000000,
    PSS_CAPTURE_VA_CLONE                          = 0x00000001,
    PSS_CAPTURE_RESERVED_00000002                 = 0x00000002,
    PSS_CAPTURE_HANDLES                           = 0x00000004,
    PSS_CAPTURE_HANDLE_NAME_INFORMATION           = 0x00000008,
    PSS_CAPTURE_HANDLE_BASIC_INFORMATION          = 0x00000010,
    PSS_CAPTURE_HANDLE_TYPE_SPECIFIC_INFORMATION  = 0x00000020,
    PSS_CAPTURE_HANDLE_TRACE                      = 0x00000040,
    PSS_CAPTURE_THREADS                           = 0x00000080,
    PSS_CAPTURE_THREAD_CONTEXT                    = 0x00000100,
    PSS_CAPTURE_THREAD_CONTEXT_EXTENDED           = 0x00000200,
    PSS_CAPTURE_RESERVED_00000400                 = 0x00000400,
    PSS_CAPTURE_VA_SPACE                          = 0x00000800,
    PSS_CAPTURE_VA_SPACE_SECTION_INFORMATION      = 0x00001000,
    PSS_CAPTURE_IPT_TRACE                         = 0x00002000,
    PSS_CAPTURE_RESERVED_00004000                 = 0x00004000,
    PSS_CREATE_BREAKAWAY_OPTIONAL                 = 0x04000000,
    PSS_CREATE_BREAKAWAY                          = 0x08000000,
    PSS_CREATE_FORCE_BREAKAWAY                    = 0x10000000,
    PSS_CREATE_USE_VM_ALLOCATIONS                 = 0x20000000,
    PSS_CREATE_MEASURE_PERFORMANCE                = 0x40000000,
    PSS_CREATE_RELEASE_SECTION                    = 0x80000000
} PSS_CAPTURE_FLAGS;
typedef enum {
    PSS_QUERY_PROCESS_INFORMATION         = 0,
    PSS_QUERY_VA_CLONE_INFORMATION        = 1,
    PSS_QUERY_AUXILIARY_PAGES_INFORMATION = 2,
    PSS_QUERY_VA_SPACE_INFORMATION        = 3,
    PSS_QUERY_HANDLE_INFORMATION          = 4,
    PSS_QUERY_THREAD_INFORMATION          = 5,
    PSS_QUERY_HANDLE_TRACE_INFORMATION    = 6,
    PSS_QUERY_PERFORMANCE_COUNTERS        = 7
} PSS_QUERY_INFORMATION_CLASS;

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

// Slim reader/writer lock, condition variable and one-time initialization
// (Vista+): pointer-sized opaque values.
typedef struct _RTL_SRWLOCK { PVOID Ptr; } RTL_SRWLOCK, *PRTL_SRWLOCK;
typedef RTL_SRWLOCK SRWLOCK, *PSRWLOCK;
#define RTL_SRWLOCK_INIT {0}
#define SRWLOCK_INIT RTL_SRWLOCK_INIT
typedef struct _RTL_CONDITION_VARIABLE { PVOID Ptr; } RTL_CONDITION_VARIABLE,
    *PRTL_CONDITION_VARIABLE;
typedef RTL_CONDITION_VARIABLE CONDITION_VARIABLE, *PCONDITION_VARIABLE;
#define CONDITION_VARIABLE_INIT {0}
typedef struct _RTL_RUN_ONCE { PVOID Ptr; } RTL_RUN_ONCE, *PRTL_RUN_ONCE;
typedef RTL_RUN_ONCE INIT_ONCE;
typedef PRTL_RUN_ONCE PINIT_ONCE, LPINIT_ONCE;
#define INIT_ONCE_STATIC_INIT {0}

// Layout matches RTL_CRITICAL_SECTION so the type embeds at the right
// size inside other structures (x64: 40 bytes).
typedef struct _RTL_CRITICAL_SECTION {
    PVOID     DebugInfo;
    LONG      LockCount;
    LONG      RecursionCount;
    HANDLE    OwningThread;
    HANDLE    LockSemaphore;
    ULONG_PTR SpinCount;
} RTL_CRITICAL_SECTION, *PRTL_CRITICAL_SECTION;
typedef RTL_CRITICAL_SECTION CRITICAL_SECTION;
typedef PRTL_CRITICAL_SECTION PCRITICAL_SECTION, LPCRITICAL_SECTION;

// 128-bit volume-relative file identifier, per the Windows SDK.
typedef struct _FILE_ID_128 { BYTE Identifier[16]; } FILE_ID_128, *PFILE_ID_128;

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
    LONGLONG QuadPart;
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
    ULONGLONG QuadPart;
};

typedef union _LARGE_INTEGER  LARGE_INTEGER;
typedef union _ULARGE_INTEGER ULARGE_INTEGER;
typedef union _LARGE_INTEGER  *PLARGE_INTEGER;
typedef union _ULARGE_INTEGER *PULARGE_INTEGER;

// OVERLAPPED (minwinbase.h): the offset pair overlays `Pointer`.
struct _OVERLAPPED {
    ULONG_PTR Internal;
    ULONG_PTR InternalHigh;
    union {
        struct {
            DWORD Offset;
            DWORD OffsetHigh;
        };
        PVOID Pointer;
    };
    HANDLE hEvent;
};

// SYSTEM_INFO (sysinfoapi.h): the OEM id overlays the processor pair.
struct _SYSTEM_INFO {
    union {
        DWORD dwOemId;
        struct {
            WORD wProcessorArchitecture;
            WORD wReserved;
        };
    };
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

// Function-table entries (winnt.h): the x64 entry names its unwind info,
// the AArch64 entry packs the unwind codes into the second word.
typedef struct _IMAGE_RUNTIME_FUNCTION_ENTRY {
    DWORD BeginAddress;
    DWORD EndAddress;
    union {
        DWORD UnwindInfoAddress;
        DWORD UnwindData;
    };
} IMAGE_RUNTIME_FUNCTION_ENTRY, *PIMAGE_RUNTIME_FUNCTION_ENTRY;
typedef struct _IMAGE_ARM64_RUNTIME_FUNCTION_ENTRY {
    DWORD BeginAddress;
    union {
        DWORD UnwindData;
        struct {
            DWORD Flag : 2;
            DWORD FunctionLength : 11;
            DWORD RegF : 3;
            DWORD RegI : 4;
            DWORD H : 1;
            DWORD CR : 2;
            DWORD FrameSize : 9;
        };
    };
} IMAGE_ARM64_RUNTIME_FUNCTION_ENTRY, *PIMAGE_ARM64_RUNTIME_FUNCTION_ENTRY;
#ifdef __aarch64__
typedef IMAGE_ARM64_RUNTIME_FUNCTION_ENTRY RUNTIME_FUNCTION, *PRUNTIME_FUNCTION;
#else
typedef IMAGE_RUNTIME_FUNCTION_ENTRY RUNTIME_FUNCTION, *PRUNTIME_FUNCTION;
#endif

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
} BY_HANDLE_FILE_INFORMATION, *PBY_HANDLE_FILE_INFORMATION, *LPBY_HANDLE_FILE_INFORMATION;
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
typedef GUID UUID;
typedef GUID *LPGUID;
typedef struct _nlsversioninfo {
    DWORD dwNLSVersionInfoSize;
    DWORD dwNLSVersion;
    DWORD dwDefinedVersion;
    DWORD dwEffectiveId;
    GUID  guidCustomVersion;
} NLSVERSIONINFO, *LPNLSVERSIONINFO;
struct _SECURITY_ATTRIBUTES {
    DWORD  nLength;
    LPVOID lpSecurityDescriptor;
    BOOL   bInheritHandle;
};

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
typedef struct _STARTUPINFOA {
    DWORD  cb;
    LPSTR  lpReserved;
    LPSTR  lpDesktop;
    LPSTR  lpTitle;
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
} STARTUPINFOA, *LPSTARTUPINFOA;

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
typedef enum _FILE_INFO_BY_HANDLE_CLASS {
    FileBasicInfo,
    FileStandardInfo,
    FileNameInfo,
    FileRenameInfo,
    FileDispositionInfo,
    FileAllocationInfo,
    FileEndOfFileInfo,
    FileStreamInfo,
    FileCompressionInfo,
    FileAttributeTagInfo,
    FileIdBothDirectoryInfo,
    FileIdBothDirectoryRestartInfo,
    FileIoPriorityHintInfo,
    FileRemoteProtocolInfo,
    FileFullDirectoryInfo,
    FileFullDirectoryRestartInfo,
    FileStorageInfo,
    FileAlignmentInfo,
    FileIdInfo,
    FileIdExtdDirectoryInfo,
    FileIdExtdDirectoryRestartInfo,
    FileDispositionInfoEx,
    FileRenameInfoEx,
    FileCaseSensitiveInfo,
    FileNormalizedNameInfo,
    MaximumFileInfoByHandleClass
} FILE_INFO_BY_HANDLE_CLASS, *PFILE_INFO_BY_HANDLE_CLASS;
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

typedef struct _TIME_ZONE_INFORMATION {
    LONG       Bias;
    WCHAR      StandardName[32];
    SYSTEMTIME StandardDate;
    LONG       StandardBias;
    WCHAR      DaylightName[32];
    SYSTEMTIME DaylightDate;
    LONG       DaylightBias;
} TIME_ZONE_INFORMATION, *PTIME_ZONE_INFORMATION, *LPTIME_ZONE_INFORMATION;

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

typedef struct _KEY_EVENT_RECORD {
    BOOL bKeyDown;
    WORD wRepeatCount;
    WORD wVirtualKeyCode;
    WORD wVirtualScanCode;
    union {
        WCHAR UnicodeChar;
        CHAR  AsciiChar;
    } uChar;
    DWORD dwControlKeyState;
} KEY_EVENT_RECORD, *PKEY_EVENT_RECORD;
typedef struct _MOUSE_EVENT_RECORD {
    COORD dwMousePosition;
    DWORD dwButtonState;
    DWORD dwControlKeyState;
    DWORD dwEventFlags;
} MOUSE_EVENT_RECORD, *PMOUSE_EVENT_RECORD;
typedef struct _WINDOW_BUFFER_SIZE_RECORD {
    COORD dwSize;
} WINDOW_BUFFER_SIZE_RECORD, *PWINDOW_BUFFER_SIZE_RECORD;
typedef struct _MENU_EVENT_RECORD {
    UINT dwCommandId;
} MENU_EVENT_RECORD, *PMENU_EVENT_RECORD;
typedef struct _FOCUS_EVENT_RECORD {
    BOOL bSetFocus;
} FOCUS_EVENT_RECORD, *PFOCUS_EVENT_RECORD;
typedef struct _INPUT_RECORD {
    WORD EventType;
    union {
        KEY_EVENT_RECORD          KeyEvent;
        MOUSE_EVENT_RECORD        MouseEvent;
        WINDOW_BUFFER_SIZE_RECORD WindowBufferSizeEvent;
        MENU_EVENT_RECORD         MenuEvent;
        FOCUS_EVENT_RECORD        FocusEvent;
    } Event;
} INPUT_RECORD, *PINPUT_RECORD;
typedef struct _CHAR_INFO {
    union {
        WCHAR UnicodeChar;
        CHAR  AsciiChar;
    } Char;
    WORD Attributes;
} CHAR_INFO, *PCHAR_INFO;
typedef struct _CONSOLE_READCONSOLE_CONTROL {
    ULONG nLength;
    ULONG nInitialChars;
    ULONG dwCtrlWakeupMask;
    ULONG dwControlKeyState;
} CONSOLE_READCONSOLE_CONTROL, *PCONSOLE_READCONSOLE_CONTROL;
#define KEY_EVENT                0x0001
#define MOUSE_EVENT              0x0002
#define WINDOW_BUFFER_SIZE_EVENT 0x0004
#define MENU_EVENT               0x0008
#define FOCUS_EVENT              0x0010

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

LPVOID VirtualAlloc(LPVOID lpAddress, SIZE_T dwSize, DWORD flAllocationType,
                    DWORD flProtect);
BOOL VirtualProtect(LPVOID lpAddress, SIZE_T dwSize, DWORD flNewProtect,
                    PDWORD lpflOldProtect);
BOOL VirtualFree(LPVOID lpAddress, SIZE_T dwSize, DWORD dwFreeType);
HMODULE LoadLibraryA(LPCSTR lpLibFileName);
// LoadLibraryExA: name, hFile (reserved, must be NULL), dwFlags.
// dwFlags bits (LOAD_*) control search-path and binding semantics.
HMODULE LoadLibraryExA(LPCSTR lpLibFileName, HANDLE hFile, DWORD dwFlags);
HMODULE LoadLibraryExW(LPCWSTR lpLibFileName, HANDLE hFile, DWORD dwFlags);
FARPROC GetProcAddress(HMODULE hModule, LPCSTR lpProcName);
BOOL FreeLibrary(HMODULE hLibModule);
DWORD GetLastError(VOID);
__attribute__((noreturn)) VOID ExitProcess(UINT uExitCode);
VOID Sleep(DWORD dwMilliseconds);
// Function-table registration for SEH-style stack unwinding on
// Win64. `EntryCount` is the number of `RUNTIME_FUNCTION`
// entries; `BaseAddress` is the image base the offsets are
// relative to.
BOOLEAN RtlAddFunctionTable(PRUNTIME_FUNCTION FunctionTable, DWORD EntryCount,
                            DWORD64 BaseAddress);
BOOLEAN RtlDeleteFunctionTable(PRUNTIME_FUNCTION FunctionTable);

// CreateThread returns a thread HANDLE (kernel object). Args
// mirror the Win32 prototype: lpThreadAttributes, dwStackSize,
// lpStartAddress, lpParameter, dwCreationFlags, lpThreadId.
HANDLE CreateThread(LPSECURITY_ATTRIBUTES lpThreadAttributes, SIZE_T dwStackSize,
                    LPTHREAD_START_ROUTINE lpStartAddress, LPVOID lpParameter,
                    DWORD dwCreationFlags, LPDWORD lpThreadId);
DWORD WaitForSingleObject(HANDLE hHandle, DWORD dwMilliseconds);
BOOL CloseHandle(HANDLE hObject);
BOOL GetExitCodeThread(HANDLE hThread, LPDWORD lpExitCode);
BOOL SetThreadPriority(HANDLE hThread, int nPriority);
DWORD GetCurrentThreadId(VOID);
VOID InitializeCriticalSection(LPCRITICAL_SECTION lpCriticalSection);
// InitializeCriticalSectionEx(cs, spin, flags): the flag word selects debug
// info / no-dynamic-spin; c5 passes 0.
BOOL InitializeCriticalSectionEx(LPCRITICAL_SECTION lpCriticalSection,
                                 DWORD dwSpinCount, DWORD Flags);
VOID EnterCriticalSection(LPCRITICAL_SECTION lpCriticalSection);
VOID LeaveCriticalSection(LPCRITICAL_SECTION lpCriticalSection);
VOID DeleteCriticalSection(LPCRITICAL_SECTION lpCriticalSection);
DWORD TlsAlloc(VOID);
LPVOID TlsGetValue(DWORD dwTlsIndex);
BOOL TlsSetValue(DWORD dwTlsIndex, LPVOID lpTlsValue);
BOOL TlsFree(DWORD dwTlsIndex);
VOID InitializeSRWLock(PSRWLOCK SRWLock);
VOID AcquireSRWLockExclusive(PSRWLOCK SRWLock);
VOID ReleaseSRWLockExclusive(PSRWLOCK SRWLock);
VOID AcquireSRWLockShared(PSRWLOCK SRWLock);
VOID ReleaseSRWLockShared(PSRWLOCK SRWLock);
BOOLEAN TryAcquireSRWLockExclusive(PSRWLOCK SRWLock);
BOOLEAN TryAcquireSRWLockShared(PSRWLOCK SRWLock);
VOID InitializeConditionVariable(PCONDITION_VARIABLE ConditionVariable);
BOOL SleepConditionVariableSRW(PCONDITION_VARIABLE ConditionVariable, PSRWLOCK SRWLock,
                               DWORD dwMilliseconds, ULONG Flags);
BOOL SleepConditionVariableCS(PCONDITION_VARIABLE ConditionVariable,
                              PCRITICAL_SECTION CriticalSection, DWORD dwMilliseconds);
VOID WakeConditionVariable(PCONDITION_VARIABLE ConditionVariable);
VOID WakeAllConditionVariable(PCONDITION_VARIABLE ConditionVariable);
HANDLE CreateSemaphoreW(LPSECURITY_ATTRIBUTES lpSemaphoreAttributes, LONG lInitialCount,
                        LONG lMaximumCount, LPCWSTR lpName);
#define CreateSemaphore CreateSemaphoreW
BOOL ReleaseSemaphore(HANDLE hSemaphore, LONG lReleaseCount, LPLONG lpPreviousCount);
HANDLE GetCurrentThread(VOID);
BOOL GetProcessTimes(HANDLE hProcess, LPFILETIME lpCreationTime, LPFILETIME lpExitTime,
                     LPFILETIME lpKernelTime, LPFILETIME lpUserTime);
BOOL CancelIoEx(HANDLE hFile, LPOVERLAPPED lpOverlapped);
BOOL GetNumberOfConsoleInputEvents(HANDLE hConsoleInput, LPDWORD lpNumberOfEvents);

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
UINT SetErrorMode(UINT uMode);
UINT GetErrorMode(VOID);
DWORD WaitForMultipleObjects(DWORD nCount, const HANDLE *lpHandles, BOOL bWaitAll,
                             DWORD dwMilliseconds);
BOOL GetThreadTimes(HANDLE hThread, LPFILETIME lpCreationTime, LPFILETIME lpExitTime,
                    LPFILETIME lpKernelTime, LPFILETIME lpUserTime);
HANDLE OpenThread(DWORD dwDesiredAccess, BOOL bInheritHandle, DWORD dwThreadId);
int CompareStringOrdinal(LPCWCH lpString1, int cchCount1, LPCWCH lpString2,
                         int cchCount2, BOOL bIgnoreCase);
BOOL GetOverlappedResult(HANDLE hFile, LPOVERLAPPED lpOverlapped,
                         LPDWORD lpNumberOfBytesTransferred, BOOL bWait);
NTSTATUS BCryptGenRandom(BCRYPT_ALG_HANDLE hAlgorithm, PUCHAR pbBuffer, ULONG cbBuffer,
                         ULONG dwFlags);
UINT GetACP(VOID);
int GetLocaleInfoA(LCID Locale, LCTYPE LCType, LPSTR lpLCData, int cchData);
DWORD GetFinalPathNameByHandleW(HANDLE hFile, LPWSTR lpszFilePath, DWORD cchFilePath,
                                DWORD dwFlags);
HANDLE CreateWaitableTimerExW(LPSECURITY_ATTRIBUTES lpTimerAttributes,
                              LPCWSTR lpTimerName, DWORD dwFlags, DWORD dwDesiredAccess);
BOOL ConnectNamedPipe(HANDLE hNamedPipe, LPOVERLAPPED lpOverlapped);
VOID GetCurrentThreadStackLimits(PULONG_PTR LowLimit, PULONG_PTR HighLimit);
BOOL SetThreadStackGuarantee(PULONG StackSizeInBytes);
DWORD GetModuleFileNameW(HMODULE hModule, LPWSTR lpFilename, DWORD nSize);
DWORD GetFileType(HANDLE hFile);
BOOL GetFileInformationByHandle(HANDLE hFile,
                                LPBY_HANDLE_FILE_INFORMATION lpFileInformation);
BOOL GetFileInformationByHandleEx(HANDLE hFile,
                                  FILE_INFO_BY_HANDLE_CLASS FileInformationClass,
                                  LPVOID lpFileInformation, DWORD dwBufferSize);
BOOL SetFileInformationByHandle(HANDLE hFile,
                                FILE_INFO_BY_HANDLE_CLASS FileInformationClass,
                                LPVOID lpFileInformation, DWORD dwBufferSize);
BOOL GetHandleInformation(HANDLE hObject, LPDWORD lpdwFlags);
BOOL SetHandleInformation(HANDLE hObject, DWORD dwMask, DWORD dwFlags);
BOOL GetNamedPipeHandleStateW(HANDLE hNamedPipe, LPDWORD lpState,
                              LPDWORD lpCurInstances, LPDWORD lpMaxCollectionCount,
                              LPDWORD lpCollectDataTimeout, LPWSTR lpUserName,
                              DWORD nMaxUserNameSize);
BOOL SetNamedPipeHandleState(HANDLE hNamedPipe, LPDWORD lpMode,
                             LPDWORD lpMaxCollectionCount, LPDWORD lpCollectDataTimeout);
BOOL CreatePipe(PHANDLE hReadPipe, PHANDLE hWritePipe,
                LPSECURITY_ATTRIBUTES lpPipeAttributes, DWORD nSize);
BOOL DeviceIoControl(HANDLE hDevice, DWORD dwIoControlCode, LPVOID lpInBuffer,
                     DWORD nInBufferSize, LPVOID lpOutBuffer, DWORD nOutBufferSize,
                     LPDWORD lpBytesReturned, LPOVERLAPPED lpOverlapped);
BOOL CreateHardLinkW(LPCWSTR lpFileName, LPCWSTR lpExistingFileName,
                     LPSECURITY_ATTRIBUTES lpSecurityAttributes);
BOOLEAN CreateSymbolicLinkW(LPCWSTR lpSymlinkFileName, LPCWSTR lpTargetFileName,
                            DWORD dwFlags);
BOOL MoveFileExW(LPCWSTR lpExistingFileName, LPCWSTR lpNewFileName, DWORD dwFlags);
BOOL MoveFileExA(LPCSTR lpExistingFileName, LPCSTR lpNewFileName, DWORD dwFlags);
#define MoveFileEx MoveFileExA
BOOL SetEnvironmentVariableW(LPCWSTR lpName, LPCWSTR lpValue);
UINT GetDriveTypeW(LPCWSTR lpRootPathName);
BOOL GetDiskFreeSpaceExW(LPCWSTR lpDirectoryName,
                         PULARGE_INTEGER lpFreeBytesAvailableToCaller,
                         PULARGE_INTEGER lpTotalNumberOfBytes,
                         PULARGE_INTEGER lpTotalNumberOfFreeBytes);
DWORD GetLogicalDriveStringsW(DWORD nBufferLength, LPWSTR lpBuffer);
BOOL GetVolumePathNameW(LPCWSTR lpszFileName, LPWSTR lpszVolumePathName,
                        DWORD cchBufferLength);
BOOL GetVolumePathNamesForVolumeNameW(LPCWSTR lpszVolumeName, LPWCH lpszVolumePathNames,
                                      DWORD cchBufferLength, PDWORD lpcchReturnLength);
HANDLE FindFirstVolumeW(LPWSTR lpszVolumeName, DWORD cchBufferLength);
BOOL FindNextVolumeW(HANDLE hFindVolume, LPWSTR lpszVolumeName, DWORD cchBufferLength);
BOOL FindVolumeClose(HANDLE hFindVolume);
DWORD GetActiveProcessorCount(WORD GroupNumber);
HANDLE OpenProcess(DWORD dwDesiredAccess, BOOL bInheritHandle, DWORD dwProcessId);
DLL_DIRECTORY_COOKIE AddDllDirectory(PCWSTR NewDirectory);
BOOL RemoveDllDirectory(DLL_DIRECTORY_COOKIE Cookie);
BOOL SetWaitableTimer(HANDLE hTimer, const LARGE_INTEGER *lpDueTime, LONG lPeriod,
                      PTIMERAPCROUTINE pfnCompletionRoutine,
                      LPVOID lpArgToCompletionRoutine, BOOL fResume);
BOOL SetWaitableTimerEx(HANDLE hTimer, const LARGE_INTEGER *lpDueTime, LONG lPeriod,
                        PTIMERAPCROUTINE pfnCompletionRoutine,
                        LPVOID lpArgToCompletionRoutine, PREASON_CONTEXT WakeContext,
                        ULONG TolerableDelay);
BOOL GetStringTypeW(DWORD dwInfoType, LPCWCH lpSrcStr, int cchSrc, LPWORD lpCharType);
DWORD PssCaptureSnapshot(HANDLE ProcessHandle, PSS_CAPTURE_FLAGS CaptureFlags,
                         DWORD ThreadContextFlags, HPSS *SnapshotHandle);
DWORD PssFreeSnapshot(HANDLE ProcessHandle, HPSS SnapshotHandle);
DWORD PssQuerySnapshot(HPSS SnapshotHandle,
                       PSS_QUERY_INFORMATION_CLASS InformationClass, void *Buffer,
                       DWORD BufferLength);
BOOL GetUserNameW(LPWSTR lpBuffer, LPDWORD pcbBuffer);
BOOL ConvertStringSecurityDescriptorToSecurityDescriptorW(LPCWSTR StringSecurityDescriptor,
                                                          DWORD StringSDRevision,
                                                          PSECURITY_DESCRIPTOR *SecurityDescriptor,
                                                          PULONG SecurityDescriptorSize);
HRESULT PathCchSkipRoot(PCWSTR pszPath, PCWSTR *ppszRootEnd);
HRESULT PathCchCombineEx(PWSTR pszPathOut, size_t cchPathOut, PCWSTR pszPathIn,
                         PCWSTR pszMore, ULONG dwFlags);
DWORD GetFileVersionInfoSizeW(LPCWSTR lptstrFilename, LPDWORD lpdwHandle);
BOOL GetFileVersionInfoW(LPCWSTR lptstrFilename, DWORD dwHandle, DWORD dwLen,
                         LPVOID lpData);
BOOL VerQueryValueW(LPCVOID pBlock, LPCWSTR lpSubBlock, LPVOID *lplpBuffer, PUINT puLen);

// advapi32 registry API (winreg.h). Each returns a LONG status
// (ERROR_SUCCESS on success); signatures track the Win32 wide forms.
LSTATUS RegCloseKey(HKEY hKey);
LSTATUS RegConnectRegistryW(LPCWSTR lpMachineName, HKEY hKey, PHKEY phkResult);
LSTATUS RegCreateKeyW(HKEY hKey, LPCWSTR lpSubKey, PHKEY phkResult);
LSTATUS RegCreateKeyExW(HKEY hKey, LPCWSTR lpSubKey, DWORD Reserved, LPWSTR lpClass,
                        DWORD dwOptions, REGSAM samDesired,
                        const LPSECURITY_ATTRIBUTES lpSecurityAttributes,
                        PHKEY phkResult, LPDWORD lpdwDisposition);
LSTATUS RegDeleteKeyW(HKEY hKey, LPCWSTR lpSubKey);
LSTATUS RegDeleteKeyExW(HKEY hKey, LPCWSTR lpSubKey, REGSAM samDesired, DWORD Reserved);
LSTATUS RegDeleteValueW(HKEY hKey, LPCWSTR lpValueName);
LSTATUS RegEnumKeyExW(HKEY hKey, DWORD dwIndex, LPWSTR lpName, LPDWORD lpcchName,
                      LPDWORD lpReserved, LPWSTR lpClass, LPDWORD lpcchClass,
                      PFILETIME lpftLastWriteTime);
LSTATUS RegEnumValueW(HKEY hKey, DWORD dwIndex, LPWSTR lpValueName,
                      LPDWORD lpcchValueName, LPDWORD lpReserved, LPDWORD lpType,
                      LPBYTE lpData, LPDWORD lpcbData);
LSTATUS RegFlushKey(HKEY hKey);
LSTATUS RegLoadKeyW(HKEY hKey, LPCWSTR lpSubKey, LPCWSTR lpFile);
LSTATUS RegOpenKeyExW(HKEY hKey, LPCWSTR lpSubKey, DWORD ulOptions, REGSAM samDesired,
                      PHKEY phkResult);
LSTATUS RegQueryInfoKeyW(HKEY hKey, LPWSTR lpClass, LPDWORD lpcchClass,
                         LPDWORD lpReserved, LPDWORD lpcSubKeys,
                         LPDWORD lpcbMaxSubKeyLen, LPDWORD lpcbMaxClassLen,
                         LPDWORD lpcValues, LPDWORD lpcbMaxValueNameLen,
                         LPDWORD lpcbMaxValueLen, LPDWORD lpcbSecurityDescriptor,
                         PFILETIME lpftLastWriteTime);
LSTATUS RegQueryValueExW(HKEY hKey, LPCWSTR lpValueName, LPDWORD lpReserved,
                         LPDWORD lpType, LPBYTE lpData, LPDWORD lpcbData);
LSTATUS RegSaveKeyW(HKEY hKey, LPCWSTR lpFile,
                    const LPSECURITY_ATTRIBUTES lpSecurityAttributes);
LSTATUS RegSetValueExW(HKEY hKey, LPCWSTR lpValueName, DWORD Reserved, DWORD dwType,
                       const BYTE *lpData, DWORD cbData);

// kernel32 surface sqlite's Windows VFS dispatch table takes the address
// of; each binding puts the import in scope for the static initializer.
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

// Prototypes carry the SDK's types: a program that declares one of these
// functions itself, as the SDK spells it, redeclares the same type.
BOOL AreFileApisANSI(VOID);
BOOL CancelIo(HANDLE hFile);
HANDLE CreateEventA(LPSECURITY_ATTRIBUTES lpEventAttributes, BOOL bManualReset,
                    BOOL bInitialState, LPCSTR lpName);
BOOL FlushViewOfFile(LPCVOID lpBaseAddress, SIZE_T dwNumberOfBytesToFlush);
HMODULE GetModuleHandleA(LPCSTR lpModuleName);
HMODULE GetModuleHandleW(LPCWSTR lpModuleName);
VOID GetNativeSystemInfo(LPSYSTEM_INFO lpSystemInfo);
HANDLE GetProcessHeap(VOID);
FARPROC GetProcAddressA(HMODULE hModule, LPCSTR lpProcName);
LPWSTR CharLowerW(LPWSTR lpsz);
LPWSTR CharUpperW(LPWSTR lpsz);
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
                             DWORD dwCreationDisposition, DWORD dwFlagsAndAttributes,
                             HANDLE hTemplateFile, HANDLE hTransaction,
                             PUSHORT pusMiniVersion, PVOID lpExtendedParameter);
HANDLE CreateFileTransactedW(LPCWSTR lpFileName, DWORD dwDesiredAccess,
                             DWORD dwShareMode,
                             LPSECURITY_ATTRIBUTES lpSecurityAttributes,
                             DWORD dwCreationDisposition, DWORD dwFlagsAndAttributes,
                             HANDLE hTemplateFile, HANDLE hTransaction,
                             PUSHORT pusMiniVersion, PVOID lpExtendedParameter);
DWORD GetProcessId(HANDLE Process);
LPSTR lstrcpyA(LPSTR lpString1, LPCSTR lpString2);
LPWSTR lstrcpyW(LPWSTR lpString1, LPCWSTR lpString2);
HANDLE CreateMutexW(LPSECURITY_ATTRIBUTES lpMutexAttributes, BOOL bInitialOwner,
                    LPCWSTR lpName);
BOOL DeleteFileA(LPCSTR lpFileName);
BOOL DeleteFileW(LPCWSTR lpFileName);
BOOL FileTimeToLocalFileTime(const FILETIME *lpFileTime, LPFILETIME lpLocalFileTime);
BOOL FileTimeToSystemTime(const FILETIME *lpFileTime, LPSYSTEMTIME lpSystemTime);
BOOL FlushFileBuffers(HANDLE hFile);
DWORD FormatMessageA(DWORD dwFlags, LPCVOID lpSource, DWORD dwMessageId,
                     DWORD dwLanguageId, LPSTR lpBuffer, DWORD nSize, va_list *Arguments);
DWORD FormatMessageW(DWORD dwFlags, LPCVOID lpSource, DWORD dwMessageId,
                     DWORD dwLanguageId, LPWSTR lpBuffer, DWORD nSize,
                     va_list *Arguments);
DWORD GetCurrentProcessId(VOID);
BOOL GetDiskFreeSpaceA(LPCSTR lpRootPathName, LPDWORD lpSectorsPerCluster,
                       LPDWORD lpBytesPerSector, LPDWORD lpNumberOfFreeClusters,
                       LPDWORD lpTotalNumberOfClusters);
BOOL GetDiskFreeSpaceW(LPCWSTR lpRootPathName, LPDWORD lpSectorsPerCluster,
                       LPDWORD lpBytesPerSector, LPDWORD lpNumberOfFreeClusters,
                       LPDWORD lpTotalNumberOfClusters);
DWORD GetFileAttributesA(LPCSTR lpFileName);
BOOL GetFileAttributesExW(LPCWSTR lpFileName, GET_FILEEX_INFO_LEVELS fInfoLevelId,
                          LPVOID lpFileInformation);
DWORD GetFileAttributesW(LPCWSTR lpFileName);
DWORD GetFileSize(HANDLE hFile, LPDWORD lpFileSizeHigh);
DWORD GetFullPathNameA(LPCSTR lpFileName, DWORD nBufferLength, LPSTR lpBuffer,
                       LPSTR *lpFilePart);
DWORD GetFullPathNameW(LPCWSTR lpFileName, DWORD nBufferLength, LPWSTR lpBuffer,
                       LPWSTR *lpFilePart);
VOID GetSystemInfo(LPSYSTEM_INFO lpSystemInfo);
VOID GetSystemTime(LPSYSTEMTIME lpSystemTime);
VOID GetSystemTimeAsFileTime(LPFILETIME lpSystemTimeAsFileTime);
DWORD GetTempPathA(DWORD nBufferLength, LPSTR lpBuffer);
DWORD GetTempPathW(DWORD nBufferLength, LPWSTR lpBuffer);
DWORD GetTickCount(VOID);
BOOL GetVersionExA(LPOSVERSIONINFOA lpVersionInformation);
BOOL GetVersionExW(LPOSVERSIONINFOW lpVersionInformation);
#define GetVersionEx GetVersionExW
BOOL VerifyVersionInfoW(LPOSVERSIONINFOEXW lpVersionInformation, DWORD dwTypeMask,
                        DWORDLONG dwlConditionMask);
ULONGLONG VerSetConditionMask(ULONGLONG ConditionMask, ULONG TypeMask, UCHAR Condition);
#define VerifyVersionInfo VerifyVersionInfoW
BOOL GetComputerNameExW(COMPUTER_NAME_FORMAT NameType, LPWSTR lpBuffer, LPDWORD nSize);
LPVOID HeapAlloc(HANDLE hHeap, DWORD dwFlags, SIZE_T dwBytes);
SIZE_T HeapCompact(HANDLE hHeap, DWORD dwFlags);
HANDLE HeapCreate(DWORD flOptions, SIZE_T dwInitialSize, SIZE_T dwMaximumSize);
BOOL HeapDestroy(HANDLE hHeap);
BOOL HeapFree(HANDLE hHeap, DWORD dwFlags, LPVOID lpMem);
LPVOID HeapReAlloc(HANDLE hHeap, DWORD dwFlags, LPVOID lpMem, SIZE_T dwBytes);
SIZE_T HeapSize(HANDLE hHeap, DWORD dwFlags, LPCVOID lpMem);
BOOL HeapValidate(HANDLE hHeap, DWORD dwFlags, LPCVOID lpMem);
HMODULE LoadLibraryW(LPCWSTR lpLibFileName);
HLOCAL LocalFree(HLOCAL hMem);
BOOL LockFile(HANDLE hFile, DWORD dwFileOffsetLow, DWORD dwFileOffsetHigh,
              DWORD nNumberOfBytesToLockLow, DWORD nNumberOfBytesToLockHigh);
BOOL LockFileEx(HANDLE hFile, DWORD dwFlags, DWORD dwReserved,
                DWORD nNumberOfBytesToLockLow, DWORD nNumberOfBytesToLockHigh,
                LPOVERLAPPED lpOverlapped);
LPVOID MapViewOfFile(HANDLE hFileMappingObject, DWORD dwDesiredAccess,
                     DWORD dwFileOffsetHigh, DWORD dwFileOffsetLow,
                     SIZE_T dwNumberOfBytesToMap);
int MultiByteToWideChar(UINT CodePage, DWORD dwFlags, LPCCH lpMultiByteStr,
                        int cbMultiByte, LPWSTR lpWideCharStr, int cchWideChar);
VOID OutputDebugStringA(LPCSTR lpOutputString);
VOID OutputDebugStringW(LPCWSTR lpOutputString);
BOOL QueryPerformanceCounter(LARGE_INTEGER *lpPerformanceCount);
BOOL ReadFile(HANDLE hFile, LPVOID lpBuffer, DWORD nNumberOfBytesToRead,
              LPDWORD lpNumberOfBytesRead, LPOVERLAPPED lpOverlapped);
BOOL SetEndOfFile(HANDLE hFile);
DWORD SetFilePointer(HANDLE hFile, LONG lDistanceToMove, PLONG lpDistanceToMoveHigh,
                     DWORD dwMoveMethod);
BOOL SystemTimeToFileTime(const SYSTEMTIME *lpSystemTime, LPFILETIME lpFileTime);
BOOL UnlockFile(HANDLE hFile, DWORD dwFileOffsetLow, DWORD dwFileOffsetHigh,
                DWORD nNumberOfBytesToUnlockLow, DWORD nNumberOfBytesToUnlockHigh);
BOOL UnlockFileEx(HANDLE hFile, DWORD dwReserved, DWORD nNumberOfBytesToUnlockLow,
                  DWORD nNumberOfBytesToUnlockHigh, LPOVERLAPPED lpOverlapped);
BOOL UnmapViewOfFile(LPCVOID lpBaseAddress);
DWORD WaitForSingleObjectEx(HANDLE hHandle, DWORD dwMilliseconds, BOOL bAlertable);
int WideCharToMultiByte(UINT CodePage, DWORD dwFlags, LPCWCH lpWideCharStr,
                        int cchWideChar, LPSTR lpMultiByteStr, int cbMultiByte,
                        LPCCH lpDefaultChar, LPBOOL lpUsedDefaultChar);
BOOL WriteFile(HANDLE hFile, LPCVOID lpBuffer, DWORD nNumberOfBytesToWrite,
               LPDWORD lpNumberOfBytesWritten, LPOVERLAPPED lpOverlapped);
HANDLE FindFirstFileA(LPCSTR lpFileName, LPWIN32_FIND_DATAA lpFindFileData);
HANDLE FindFirstFileW(LPCWSTR lpFileName, LPWIN32_FIND_DATAW lpFindFileData);
BOOL FindNextFileA(HANDLE hFindFile, LPWIN32_FIND_DATAA lpFindFileData);
BOOL FindNextFileW(HANDLE hFindFile, LPWIN32_FIND_DATAW lpFindFileData);
BOOL FindClose(HANDLE hFindFile);
BOOL SetCurrentDirectoryA(LPCSTR lpPathName);
BOOL SetCurrentDirectoryW(LPCWSTR lpPathName);
DWORD GetCurrentDirectoryA(DWORD nBufferLength, LPSTR lpBuffer);
DWORD GetCurrentDirectoryW(DWORD nBufferLength, LPWSTR lpBuffer);
BOOL CreateDirectoryA(LPCSTR lpPathName, LPSECURITY_ATTRIBUTES lpSecurityAttributes);
BOOL CreateDirectoryW(LPCWSTR lpPathName, LPSECURITY_ATTRIBUTES lpSecurityAttributes);
BOOL RemoveDirectoryA(LPCSTR lpPathName);
BOOL RemoveDirectoryW(LPCWSTR lpPathName);
BOOL SetFileAttributesA(LPCSTR lpFileName, DWORD dwFileAttributes);
BOOL SetFileAttributesW(LPCWSTR lpFileName, DWORD dwFileAttributes);
DWORD GetEnvironmentVariableA(LPCSTR lpName, LPSTR lpBuffer, DWORD nSize);
DWORD GetEnvironmentVariableW(LPCWSTR lpName, LPWSTR lpBuffer, DWORD nSize);
BOOL SetFileTime(HANDLE hFile, const FILETIME *lpCreationTime,
                 const FILETIME *lpLastAccessTime, const FILETIME *lpLastWriteTime);
BOOL GetFileTime(HANDLE hFile, LPFILETIME lpCreationTime, LPFILETIME lpLastAccessTime,
                 LPFILETIME lpLastWriteTime);
UINT GetTempFileNameA(LPCSTR lpPathName, LPCSTR lpPrefixString, UINT uUnique,
                      LPSTR lpTempFileName);
UINT GetTempFileNameW(LPCWSTR lpPathName, LPCWSTR lpPrefixString, UINT uUnique,
                      LPWSTR lpTempFileName);
HANDLE GetCurrentProcess(VOID);
BOOL DuplicateHandle(HANDLE hSourceProcessHandle, HANDLE hSourceHandle,
                     HANDLE hTargetProcessHandle, LPHANDLE lpTargetHandle,
                     DWORD dwDesiredAccess, BOOL bInheritHandle, DWORD dwOptions);
BOOL SetFilePointerEx(HANDLE hFile, LARGE_INTEGER liDistanceToMove,
                      PLARGE_INTEGER lpNewFilePointer, DWORD dwMoveMethod);
BOOL GetFileSizeEx(HANDLE hFile, PLARGE_INTEGER lpFileSize);
HANDLE CreateMutexA(LPSECURITY_ATTRIBUTES lpMutexAttributes, BOOL bInitialOwner,
                    LPCSTR lpName);
HANDLE CreateEventW(LPSECURITY_ATTRIBUTES lpEventAttributes, BOOL bManualReset,
                    BOOL bInitialState, LPCWSTR lpName);
BOOL ReleaseMutex(HANDLE hMutex);
BOOL SetEvent(HANDLE hEvent);
BOOL ResetEvent(HANDLE hEvent);

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
                              ULONG_PTR CompletionKey, DWORD NumberOfConcurrentThreads);
BOOL GetQueuedCompletionStatus(HANDLE CompletionPort,
                               LPDWORD lpNumberOfBytesTransferred,
                               PULONG_PTR lpCompletionKey, LPOVERLAPPED *lpOverlapped,
                               DWORD dwMilliseconds);
BOOL PostQueuedCompletionStatus(HANDLE CompletionPort, DWORD dwNumberOfBytesTransferred,
                                ULONG_PTR dwCompletionKey, LPOVERLAPPED lpOverlapped);
BOOL RegisterWaitForSingleObject(PHANDLE phNewWaitObject, HANDLE hObject,
                                 WAITORTIMERCALLBACK Callback, PVOID Context,
                                 ULONG dwMilliseconds, ULONG dwFlags);
BOOL UnregisterWait(HANDLE WaitHandle);
BOOL UnregisterWaitEx(HANDLE WaitHandle, HANDLE CompletionEvent);

HANDLE OpenMutexA(DWORD dwDesiredAccess, BOOL bInheritHandle, LPCSTR lpName);
HANDLE OpenMutexW(DWORD dwDesiredAccess, BOOL bInheritHandle, LPCWSTR lpName);
HANDLE OpenEventA(DWORD dwDesiredAccess, BOOL bInheritHandle, LPCSTR lpName);
HANDLE OpenEventW(DWORD dwDesiredAccess, BOOL bInheritHandle, LPCWSTR lpName);
VOID RaiseException(DWORD dwExceptionCode, DWORD dwExceptionFlags,
                    DWORD nNumberOfArguments, const ULONG_PTR *lpArguments);
BOOL IsDebuggerPresent(VOID);
VOID DebugBreak(VOID);
LPTOP_LEVEL_EXCEPTION_FILTER SetUnhandledExceptionFilter(LPTOP_LEVEL_EXCEPTION_FILTER lpTopLevelExceptionFilter);
PVOID AddVectoredExceptionHandler(ULONG First, PVECTORED_EXCEPTION_HANDLER Handler);
ULONG RemoveVectoredExceptionHandler(PVOID Handle);
BOOL TerminateProcess(HANDLE hProcess, UINT uExitCode);
UINT GetSystemDirectoryA(LPSTR lpBuffer, UINT uSize);
UINT GetSystemDirectoryW(LPWSTR lpBuffer, UINT uSize);
UINT GetWindowsDirectoryA(LPSTR lpBuffer, UINT uSize);
UINT GetWindowsDirectoryW(LPWSTR lpBuffer, UINT uSize);
DWORD ExpandEnvironmentStringsA(LPCSTR lpSrc, LPSTR lpDst, DWORD nSize);
DWORD ExpandEnvironmentStringsW(LPCWSTR lpSrc, LPWSTR lpDst, DWORD nSize);
DWORD SearchPathA(LPCSTR lpPath, LPCSTR lpFileName, LPCSTR lpExtension,
                  DWORD nBufferLength, LPSTR lpBuffer, LPSTR *lpFilePart);
DWORD SearchPath(LPCSTR lpPath, LPCSTR lpFileName, LPCSTR lpExtension,
                 DWORD nBufferLength, LPSTR lpBuffer, LPSTR *lpFilePart);
DWORD GetModuleFileNameA(HMODULE hModule, LPSTR lpFilename, DWORD nSize);
DWORD SearchPathW(LPCWSTR lpPath, LPCWSTR lpFileName, LPCWSTR lpExtension,
                  DWORD nBufferLength, LPWSTR lpBuffer, LPWSTR *lpFilePart);
BOOL CreateProcessA(LPCSTR lpApplicationName, LPSTR lpCommandLine,
                    LPSECURITY_ATTRIBUTES lpProcessAttributes,
                    LPSECURITY_ATTRIBUTES lpThreadAttributes, BOOL bInheritHandles,
                    DWORD dwCreationFlags, LPVOID lpEnvironment,
                    LPCSTR lpCurrentDirectory, LPSTARTUPINFOA lpStartupInfo,
                    LPPROCESS_INFORMATION lpProcessInformation);
BOOL CreateProcessW(LPCWSTR lpApplicationName, LPWSTR lpCommandLine,
                    LPSECURITY_ATTRIBUTES lpProcessAttributes,
                    LPSECURITY_ATTRIBUTES lpThreadAttributes, BOOL bInheritHandles,
                    DWORD dwCreationFlags, LPVOID lpEnvironment,
                    LPCWSTR lpCurrentDirectory, LPSTARTUPINFOW lpStartupInfo,
                    LPPROCESS_INFORMATION lpProcessInformation);
HANDLE GetStdHandle(DWORD nStdHandle);
BOOL SetStdHandle(DWORD nStdHandle, HANDLE hHandle);
BOOL GetConsoleMode(HANDLE hConsoleHandle, LPDWORD lpMode);
BOOL SetConsoleMode(HANDLE hConsoleHandle, DWORD dwMode);
UINT GetConsoleOutputCP(VOID);
BOOL SetConsoleOutputCP(UINT wCodePageID);
UINT GetConsoleCP(VOID);
BOOL SetConsoleCP(UINT wCodePageID);
BOOL WriteConsoleW(HANDLE hConsoleOutput, const VOID *lpBuffer,
                   DWORD nNumberOfCharsToWrite, LPDWORD lpNumberOfCharsWritten,
                   LPVOID lpReserved);
BOOL WriteConsoleA(HANDLE hConsoleOutput, const VOID *lpBuffer,
                   DWORD nNumberOfCharsToWrite, LPDWORD lpNumberOfCharsWritten,
                   LPVOID lpReserved);
BOOL ReadConsoleW(HANDLE hConsoleInput, LPVOID lpBuffer, DWORD nNumberOfCharsToRead,
                  LPDWORD lpNumberOfCharsRead,
                  PCONSOLE_READCONSOLE_CONTROL pInputControl);
BOOL ReadConsoleA(HANDLE hConsoleInput, LPVOID lpBuffer, DWORD nNumberOfCharsToRead,
                  LPDWORD lpNumberOfCharsRead,
                  PCONSOLE_READCONSOLE_CONTROL pInputControl);
BOOL FlushConsoleInputBuffer(HANDLE hConsoleInput);
BOOL GetConsoleScreenBufferInfo(HANDLE hConsoleOutput,
                                PCONSOLE_SCREEN_BUFFER_INFO lpConsoleScreenBufferInfo);
BOOL SetConsoleScreenBufferSize(HANDLE hConsoleOutput, COORD dwSize);
BOOL SetConsoleCursorPosition(HANDLE hConsoleOutput, COORD dwCursorPosition);
BOOL SetConsoleTextAttribute(HANDLE hConsoleOutput, WORD wAttributes);
BOOL FillConsoleOutputCharacterA(HANDLE hConsoleOutput, CHAR cCharacter, DWORD nLength,
                                 COORD dwWriteCoord, LPDWORD lpNumberOfCharsWritten);
BOOL FillConsoleOutputCharacterW(HANDLE hConsoleOutput, WCHAR cCharacter, DWORD nLength,
                                 COORD dwWriteCoord, LPDWORD lpNumberOfCharsWritten);
BOOL FillConsoleOutputAttribute(HANDLE hConsoleOutput, WORD wAttribute, DWORD nLength,
                                COORD dwWriteCoord, LPDWORD lpNumberOfAttrsWritten);
BOOL ScrollConsoleScreenBufferA(HANDLE hConsoleOutput,
                                const SMALL_RECT *lpScrollRectangle,
                                const SMALL_RECT *lpClipRectangle,
                                COORD dwDestinationOrigin, const CHAR_INFO *lpFill);
BOOL ScrollConsoleScreenBufferW(HANDLE hConsoleOutput,
                                const SMALL_RECT *lpScrollRectangle,
                                const SMALL_RECT *lpClipRectangle,
                                COORD dwDestinationOrigin, const CHAR_INFO *lpFill);
BOOL SetConsoleTitleA(LPCSTR lpConsoleTitle);
BOOL SetConsoleTitleW(LPCWSTR lpConsoleTitle);
DWORD GetConsoleTitleA(LPSTR lpConsoleTitle, DWORD nSize);
DWORD GetConsoleTitleW(LPWSTR lpConsoleTitle, DWORD nSize);
BOOL PeekConsoleInputA(HANDLE hConsoleInput, PINPUT_RECORD lpBuffer, DWORD nLength,
                       LPDWORD lpNumberOfEventsRead);
BOOL PeekConsoleInputW(HANDLE hConsoleInput, PINPUT_RECORD lpBuffer, DWORD nLength,
                       LPDWORD lpNumberOfEventsRead);
BOOL ReadConsoleInputA(HANDLE hConsoleInput, PINPUT_RECORD lpBuffer, DWORD nLength,
                       LPDWORD lpNumberOfEventsRead);
BOOL ReadConsoleInputW(HANDLE hConsoleInput, PINPUT_RECORD lpBuffer, DWORD nLength,
                       LPDWORD lpNumberOfEventsRead);
BOOL WriteConsoleInputA(HANDLE hConsoleInput, const INPUT_RECORD *lpBuffer,
                        DWORD nLength, LPDWORD lpNumberOfEventsWritten);
BOOL WriteConsoleInputW(HANDLE hConsoleInput, const INPUT_RECORD *lpBuffer,
                        DWORD nLength, LPDWORD lpNumberOfEventsWritten);
BOOL SetConsoleCtrlHandler(PHANDLER_ROUTINE HandlerRoutine, BOOL Add);
BOOL GenerateConsoleCtrlEvent(DWORD dwCtrlEvent, DWORD dwProcessGroupId);
BOOL AllocConsole(VOID);
BOOL FreeConsole(VOID);
BOOL AttachConsole(DWORD dwProcessId);
DWORD GetConsoleProcessList(LPDWORD lpdwProcessList, DWORD dwProcessCount);
HWND GetConsoleWindow(VOID);
VOID GetSystemTimePreciseAsFileTime(LPFILETIME lpSystemTimeAsFileTime);
BOOL QueryPerformanceFrequency(LARGE_INTEGER *lpFrequency);
ULONGLONG GetTickCount64(VOID);
BOOL SwitchToThread(VOID);
DWORD SleepEx(DWORD dwMilliseconds, BOOL bAlertable);
DWORD GetTimeZoneInformation(LPTIME_ZONE_INFORMATION lpTimeZoneInformation);
BOOL SystemTimeToTzSpecificLocalTime(const TIME_ZONE_INFORMATION *lpTimeZoneInformation,
                                     const SYSTEMTIME *lpUniversalTime,
                                     LPSYSTEMTIME lpLocalTime);
BOOL TzSpecificLocalTimeToSystemTime(const TIME_ZONE_INFORMATION *lpTimeZoneInformation,
                                     const SYSTEMTIME *lpLocalTime,
                                     LPSYSTEMTIME lpUniversalTime);
VOID GetLocalTime(LPSYSTEMTIME lpSystemTime);
VOID SetLastError(DWORD dwErrCode);
RPC_STATUS UuidCreate(UUID *Uuid);
RPC_STATUS UuidCreateSequential(UUID *Uuid);

// Process / named-pipe / synchronization surface (processthreadsapi.h,
// namedpipeapi.h, memoryapi.h, fileapi.h, winbase.h). Struct-by-pointer
// parameters use the typedefs declared earlier; the kernel reads/writes
// the bytes at the native field offsets.
HANDLE CreateNamedPipeW(LPCWSTR lpName, DWORD dwOpenMode, DWORD dwPipeMode,
                        DWORD nMaxInstances, DWORD nOutBufferSize, DWORD nInBufferSize,
                        DWORD nDefaultTimeOut,
                        LPSECURITY_ATTRIBUTES lpSecurityAttributes);
BOOL WaitNamedPipeW(LPCWSTR lpNamedPipeName, DWORD nTimeOut);
BOOL PeekNamedPipe(HANDLE hNamedPipe, LPVOID lpBuffer, DWORD nBufferSize,
                   LPDWORD lpBytesRead, LPDWORD lpTotalBytesAvail,
                   LPDWORD lpBytesLeftThisMessage);
BOOL GetExitCodeProcess(HANDLE hProcess, LPDWORD lpExitCode);
DWORD ResumeThread(HANDLE hThread);
BOOL TerminateThread(HANDLE hThread, DWORD dwExitCode);
DWORD GetVersion(VOID);
DWORD GetLongPathNameW(LPCWSTR lpszShortPath, LPWSTR lpszLongPath, DWORD cchBuffer);
DWORD GetShortPathNameW(LPCWSTR lpszLongPath, LPWSTR lpszShortPath, DWORD cchBuffer);
HANDLE OpenFileMappingW(DWORD dwDesiredAccess, BOOL bInheritHandle, LPCWSTR lpName);
SIZE_T VirtualQuery(LPCVOID lpAddress, PMEMORY_BASIC_INFORMATION lpBuffer,
                    SIZE_T dwLength);
HRESULT CopyFile2(PCWSTR pwszExistingFileName, PCWSTR pwszNewFileName,
                  COPYFILE2_EXTENDED_PARAMETERS *pExtendedParameters);
BOOL NeedCurrentDirectoryForExePathW(LPCWSTR ExeName);
int LCMapStringEx(LPCWSTR lpLocaleName, DWORD dwMapFlags, LPCWSTR lpSrcStr, int cchSrc,
                  LPWSTR lpDestStr, int cchDest, LPNLSVERSIONINFO lpVersionInformation,
                  LPVOID lpReserved, LPARAM sortHandle);
BOOL InitializeProcThreadAttributeList(LPPROC_THREAD_ATTRIBUTE_LIST lpAttributeList,
                                       DWORD dwAttributeCount, DWORD dwFlags,
                                       PSIZE_T lpSize);
BOOL UpdateProcThreadAttribute(LPPROC_THREAD_ATTRIBUTE_LIST lpAttributeList,
                               DWORD dwFlags, DWORD_PTR Attribute, PVOID lpValue,
                               SIZE_T cbSize, PVOID lpPreviousValue,
                               PSIZE_T lpReturnSize);
VOID DeleteProcThreadAttributeList(LPPROC_THREAD_ATTRIBUTE_LIST lpAttributeList);

// Token-privilege surface (processthreadsapi.h / securitybaseapi.h).
BOOL OpenProcessToken(HANDLE ProcessHandle, DWORD DesiredAccess, PHANDLE TokenHandle);
BOOL LookupPrivilegeValueW(LPCWSTR lpSystemName, LPCWSTR lpName, PLUID lpLuid);
BOOL AdjustTokenPrivileges(HANDLE TokenHandle, BOOL DisableAllPrivileges,
                           PTOKEN_PRIVILEGES NewState, DWORD BufferLength,
                           PTOKEN_PRIVILEGES PreviousState, PDWORD ReturnLength);

// ---------------------------------------------------------------------------
// PE image format (winnt.h). The DOS header is 2-byte packed and the rest
// 4-byte packed, the 64-bit thunk 8, as the SDK packs them.
// ---------------------------------------------------------------------------

#define IMAGE_DOS_SIGNATURE                 0x5A4D
#define IMAGE_OS2_SIGNATURE                 0x454E
#define IMAGE_OS2_SIGNATURE_LE              0x454C
#define IMAGE_VXD_SIGNATURE                 0x454C
#define IMAGE_NT_SIGNATURE                  0x00004550

#pragma pack(push, 2)
typedef struct _IMAGE_DOS_HEADER {
    WORD  e_magic;
    WORD  e_cblp;
    WORD  e_cp;
    WORD  e_crlc;
    WORD  e_cparhdr;
    WORD  e_minalloc;
    WORD  e_maxalloc;
    WORD  e_ss;
    WORD  e_sp;
    WORD  e_csum;
    WORD  e_ip;
    WORD  e_cs;
    WORD  e_lfarlc;
    WORD  e_ovno;
    WORD  e_res[4];
    WORD  e_oemid;
    WORD  e_oeminfo;
    WORD  e_res2[10];
    LONG  e_lfanew;
} IMAGE_DOS_HEADER, *PIMAGE_DOS_HEADER;
#pragma pack(pop)

#pragma pack(push, 4)
typedef struct _IMAGE_FILE_HEADER {
    WORD  Machine;
    WORD  NumberOfSections;
    DWORD TimeDateStamp;
    DWORD PointerToSymbolTable;
    DWORD NumberOfSymbols;
    WORD  SizeOfOptionalHeader;
    WORD  Characteristics;
} IMAGE_FILE_HEADER, *PIMAGE_FILE_HEADER;

#define IMAGE_SIZEOF_FILE_HEADER             20

#define IMAGE_FILE_RELOCS_STRIPPED           0x0001
#define IMAGE_FILE_EXECUTABLE_IMAGE          0x0002
#define IMAGE_FILE_LINE_NUMS_STRIPPED        0x0004
#define IMAGE_FILE_LOCAL_SYMS_STRIPPED       0x0008
#define IMAGE_FILE_AGGRESIVE_WS_TRIM         0x0010
#define IMAGE_FILE_LARGE_ADDRESS_AWARE       0x0020
#define IMAGE_FILE_BYTES_REVERSED_LO         0x0080
#define IMAGE_FILE_32BIT_MACHINE             0x0100
#define IMAGE_FILE_DEBUG_STRIPPED            0x0200
#define IMAGE_FILE_REMOVABLE_RUN_FROM_SWAP   0x0400
#define IMAGE_FILE_NET_RUN_FROM_SWAP         0x0800
#define IMAGE_FILE_SYSTEM                    0x1000
#define IMAGE_FILE_DLL                       0x2000
#define IMAGE_FILE_UP_SYSTEM_ONLY            0x4000
#define IMAGE_FILE_BYTES_REVERSED_HI         0x8000

#define IMAGE_FILE_MACHINE_UNKNOWN           0
#define IMAGE_FILE_MACHINE_TARGET_HOST       0x0001
#define IMAGE_FILE_MACHINE_I386              0x014c
#define IMAGE_FILE_MACHINE_R3000             0x0162
#define IMAGE_FILE_MACHINE_R4000             0x0166
#define IMAGE_FILE_MACHINE_R10000            0x0168
#define IMAGE_FILE_MACHINE_WCEMIPSV2         0x0169
#define IMAGE_FILE_MACHINE_ALPHA             0x0184
#define IMAGE_FILE_MACHINE_SH3               0x01a2
#define IMAGE_FILE_MACHINE_SH3DSP            0x01a3
#define IMAGE_FILE_MACHINE_SH3E              0x01a4
#define IMAGE_FILE_MACHINE_SH4               0x01a6
#define IMAGE_FILE_MACHINE_SH5               0x01a8
#define IMAGE_FILE_MACHINE_ARM               0x01c0
#define IMAGE_FILE_MACHINE_THUMB             0x01c2
#define IMAGE_FILE_MACHINE_ARMNT             0x01c4
#define IMAGE_FILE_MACHINE_AM33              0x01d3
#define IMAGE_FILE_MACHINE_POWERPC           0x01F0
#define IMAGE_FILE_MACHINE_POWERPCFP         0x01f1
#define IMAGE_FILE_MACHINE_IA64              0x0200
#define IMAGE_FILE_MACHINE_MIPS16            0x0266
#define IMAGE_FILE_MACHINE_ALPHA64           0x0284
#define IMAGE_FILE_MACHINE_MIPSFPU           0x0366
#define IMAGE_FILE_MACHINE_MIPSFPU16         0x0466
#define IMAGE_FILE_MACHINE_AXP64             IMAGE_FILE_MACHINE_ALPHA64
#define IMAGE_FILE_MACHINE_TRICORE           0x0520
#define IMAGE_FILE_MACHINE_CEF               0x0CEF
#define IMAGE_FILE_MACHINE_EBC               0x0EBC
#define IMAGE_FILE_MACHINE_AMD64             0x8664
#define IMAGE_FILE_MACHINE_M32R              0x9041
#define IMAGE_FILE_MACHINE_ARM64             0xAA64
#define IMAGE_FILE_MACHINE_CEE               0xC0EE

typedef struct _IMAGE_DATA_DIRECTORY {
    DWORD VirtualAddress;
    DWORD Size;
} IMAGE_DATA_DIRECTORY, *PIMAGE_DATA_DIRECTORY;

#define IMAGE_NUMBEROF_DIRECTORY_ENTRIES    16

typedef struct _IMAGE_OPTIONAL_HEADER {
    WORD  Magic;
    BYTE  MajorLinkerVersion;
    BYTE  MinorLinkerVersion;
    DWORD SizeOfCode;
    DWORD SizeOfInitializedData;
    DWORD SizeOfUninitializedData;
    DWORD AddressOfEntryPoint;
    DWORD BaseOfCode;
    DWORD BaseOfData;
    DWORD ImageBase;
    DWORD SectionAlignment;
    DWORD FileAlignment;
    WORD  MajorOperatingSystemVersion;
    WORD  MinorOperatingSystemVersion;
    WORD  MajorImageVersion;
    WORD  MinorImageVersion;
    WORD  MajorSubsystemVersion;
    WORD  MinorSubsystemVersion;
    DWORD Win32VersionValue;
    DWORD SizeOfImage;
    DWORD SizeOfHeaders;
    DWORD CheckSum;
    WORD  Subsystem;
    WORD  DllCharacteristics;
    DWORD SizeOfStackReserve;
    DWORD SizeOfStackCommit;
    DWORD SizeOfHeapReserve;
    DWORD SizeOfHeapCommit;
    DWORD LoaderFlags;
    DWORD NumberOfRvaAndSizes;
    IMAGE_DATA_DIRECTORY DataDirectory[IMAGE_NUMBEROF_DIRECTORY_ENTRIES];
} IMAGE_OPTIONAL_HEADER32, *PIMAGE_OPTIONAL_HEADER32;

typedef struct _IMAGE_OPTIONAL_HEADER64 {
    WORD      Magic;
    BYTE      MajorLinkerVersion;
    BYTE      MinorLinkerVersion;
    DWORD     SizeOfCode;
    DWORD     SizeOfInitializedData;
    DWORD     SizeOfUninitializedData;
    DWORD     AddressOfEntryPoint;
    DWORD     BaseOfCode;
    ULONGLONG ImageBase;
    DWORD     SectionAlignment;
    DWORD     FileAlignment;
    WORD      MajorOperatingSystemVersion;
    WORD      MinorOperatingSystemVersion;
    WORD      MajorImageVersion;
    WORD      MinorImageVersion;
    WORD      MajorSubsystemVersion;
    WORD      MinorSubsystemVersion;
    DWORD     Win32VersionValue;
    DWORD     SizeOfImage;
    DWORD     SizeOfHeaders;
    DWORD     CheckSum;
    WORD      Subsystem;
    WORD      DllCharacteristics;
    ULONGLONG SizeOfStackReserve;
    ULONGLONG SizeOfStackCommit;
    ULONGLONG SizeOfHeapReserve;
    ULONGLONG SizeOfHeapCommit;
    DWORD     LoaderFlags;
    DWORD     NumberOfRvaAndSizes;
    IMAGE_DATA_DIRECTORY DataDirectory[IMAGE_NUMBEROF_DIRECTORY_ENTRIES];
} IMAGE_OPTIONAL_HEADER64, *PIMAGE_OPTIONAL_HEADER64;

#define IMAGE_NT_OPTIONAL_HDR32_MAGIC      0x10b
#define IMAGE_NT_OPTIONAL_HDR64_MAGIC      0x20b
#define IMAGE_ROM_OPTIONAL_HDR_MAGIC       0x107

typedef IMAGE_OPTIONAL_HEADER64  IMAGE_OPTIONAL_HEADER;
typedef PIMAGE_OPTIONAL_HEADER64 PIMAGE_OPTIONAL_HEADER;
#define IMAGE_NT_OPTIONAL_HDR_MAGIC        IMAGE_NT_OPTIONAL_HDR64_MAGIC

typedef struct _IMAGE_NT_HEADERS64 {
    DWORD Signature;
    IMAGE_FILE_HEADER FileHeader;
    IMAGE_OPTIONAL_HEADER64 OptionalHeader;
} IMAGE_NT_HEADERS64, *PIMAGE_NT_HEADERS64;

typedef struct _IMAGE_NT_HEADERS {
    DWORD Signature;
    IMAGE_FILE_HEADER FileHeader;
    IMAGE_OPTIONAL_HEADER32 OptionalHeader;
} IMAGE_NT_HEADERS32, *PIMAGE_NT_HEADERS32;

typedef IMAGE_NT_HEADERS64  IMAGE_NT_HEADERS;
typedef PIMAGE_NT_HEADERS64 PIMAGE_NT_HEADERS;

#define IMAGE_FIRST_SECTION(ntheader) ((PIMAGE_SECTION_HEADER)        \
    ((ULONG_PTR)(ntheader) +                                          \
     FIELD_OFFSET(IMAGE_NT_HEADERS, OptionalHeader) +                 \
     ((ntheader))->FileHeader.SizeOfOptionalHeader))

#define IMAGE_SUBSYSTEM_UNKNOWN              0
#define IMAGE_SUBSYSTEM_NATIVE               1
#define IMAGE_SUBSYSTEM_WINDOWS_GUI          2
#define IMAGE_SUBSYSTEM_WINDOWS_CUI          3
#define IMAGE_SUBSYSTEM_OS2_CUI              5
#define IMAGE_SUBSYSTEM_POSIX_CUI            7
#define IMAGE_SUBSYSTEM_NATIVE_WINDOWS       8
#define IMAGE_SUBSYSTEM_WINDOWS_CE_GUI       9
#define IMAGE_SUBSYSTEM_EFI_APPLICATION      10
#define IMAGE_SUBSYSTEM_EFI_BOOT_SERVICE_DRIVER 11
#define IMAGE_SUBSYSTEM_EFI_RUNTIME_DRIVER   12
#define IMAGE_SUBSYSTEM_EFI_ROM              13
#define IMAGE_SUBSYSTEM_XBOX                 14
#define IMAGE_SUBSYSTEM_WINDOWS_BOOT_APPLICATION 16
#define IMAGE_SUBSYSTEM_XBOX_CODE_CATALOG    17

#define IMAGE_DLLCHARACTERISTICS_HIGH_ENTROPY_VA    0x0020
#define IMAGE_DLLCHARACTERISTICS_DYNAMIC_BASE       0x0040
#define IMAGE_DLLCHARACTERISTICS_FORCE_INTEGRITY    0x0080
#define IMAGE_DLLCHARACTERISTICS_NX_COMPAT          0x0100
#define IMAGE_DLLCHARACTERISTICS_NO_ISOLATION       0x0200
#define IMAGE_DLLCHARACTERISTICS_NO_SEH             0x0400
#define IMAGE_DLLCHARACTERISTICS_NO_BIND            0x0800
#define IMAGE_DLLCHARACTERISTICS_APPCONTAINER       0x1000
#define IMAGE_DLLCHARACTERISTICS_WDM_DRIVER         0x2000
#define IMAGE_DLLCHARACTERISTICS_GUARD_CF           0x4000
#define IMAGE_DLLCHARACTERISTICS_TERMINAL_SERVER_AWARE 0x8000

#define IMAGE_DIRECTORY_ENTRY_EXPORT          0
#define IMAGE_DIRECTORY_ENTRY_IMPORT          1
#define IMAGE_DIRECTORY_ENTRY_RESOURCE        2
#define IMAGE_DIRECTORY_ENTRY_EXCEPTION       3
#define IMAGE_DIRECTORY_ENTRY_SECURITY        4
#define IMAGE_DIRECTORY_ENTRY_BASERELOC       5
#define IMAGE_DIRECTORY_ENTRY_DEBUG           6
#define IMAGE_DIRECTORY_ENTRY_ARCHITECTURE    7
#define IMAGE_DIRECTORY_ENTRY_GLOBALPTR       8
#define IMAGE_DIRECTORY_ENTRY_TLS             9
#define IMAGE_DIRECTORY_ENTRY_LOAD_CONFIG    10
#define IMAGE_DIRECTORY_ENTRY_BOUND_IMPORT   11
#define IMAGE_DIRECTORY_ENTRY_IAT            12
#define IMAGE_DIRECTORY_ENTRY_DELAY_IMPORT   13
#define IMAGE_DIRECTORY_ENTRY_COM_DESCRIPTOR 14

#define IMAGE_SIZEOF_SHORT_NAME              8

typedef struct _IMAGE_SECTION_HEADER {
    BYTE  Name[IMAGE_SIZEOF_SHORT_NAME];
    union {
        DWORD PhysicalAddress;
        DWORD VirtualSize;
    } Misc;
    DWORD VirtualAddress;
    DWORD SizeOfRawData;
    DWORD PointerToRawData;
    DWORD PointerToRelocations;
    DWORD PointerToLinenumbers;
    WORD  NumberOfRelocations;
    WORD  NumberOfLinenumbers;
    DWORD Characteristics;
} IMAGE_SECTION_HEADER, *PIMAGE_SECTION_HEADER;

#define IMAGE_SIZEOF_SECTION_HEADER          40

#define IMAGE_SCN_TYPE_NO_PAD                0x00000008
#define IMAGE_SCN_CNT_CODE                   0x00000020
#define IMAGE_SCN_CNT_INITIALIZED_DATA       0x00000040
#define IMAGE_SCN_CNT_UNINITIALIZED_DATA     0x00000080
#define IMAGE_SCN_LNK_OTHER                  0x00000100
#define IMAGE_SCN_LNK_INFO                   0x00000200
#define IMAGE_SCN_LNK_REMOVE                 0x00000800
#define IMAGE_SCN_LNK_COMDAT                 0x00001000
#define IMAGE_SCN_NO_DEFER_SPEC_EXC          0x00004000
#define IMAGE_SCN_GPREL                      0x00008000
#define IMAGE_SCN_MEM_FARDATA                0x00008000
#define IMAGE_SCN_MEM_PURGEABLE              0x00020000
#define IMAGE_SCN_MEM_16BIT                  0x00020000
#define IMAGE_SCN_MEM_LOCKED                 0x00040000
#define IMAGE_SCN_MEM_PRELOAD                0x00080000
#define IMAGE_SCN_ALIGN_1BYTES               0x00100000
#define IMAGE_SCN_ALIGN_2BYTES               0x00200000
#define IMAGE_SCN_ALIGN_4BYTES               0x00300000
#define IMAGE_SCN_ALIGN_8BYTES               0x00400000
#define IMAGE_SCN_ALIGN_16BYTES              0x00500000
#define IMAGE_SCN_ALIGN_32BYTES              0x00600000
#define IMAGE_SCN_ALIGN_64BYTES              0x00700000
#define IMAGE_SCN_ALIGN_128BYTES             0x00800000
#define IMAGE_SCN_ALIGN_256BYTES             0x00900000
#define IMAGE_SCN_ALIGN_512BYTES             0x00A00000
#define IMAGE_SCN_ALIGN_1024BYTES            0x00B00000
#define IMAGE_SCN_ALIGN_2048BYTES            0x00C00000
#define IMAGE_SCN_ALIGN_4096BYTES            0x00D00000
#define IMAGE_SCN_ALIGN_8192BYTES            0x00E00000
#define IMAGE_SCN_ALIGN_MASK                 0x00F00000
#define IMAGE_SCN_LNK_NRELOC_OVFL            0x01000000
#define IMAGE_SCN_MEM_DISCARDABLE            0x02000000
#define IMAGE_SCN_MEM_NOT_CACHED             0x04000000
#define IMAGE_SCN_MEM_NOT_PAGED              0x08000000
#define IMAGE_SCN_MEM_SHARED                 0x10000000
#define IMAGE_SCN_MEM_EXECUTE                0x20000000
#define IMAGE_SCN_MEM_READ                   0x40000000
#define IMAGE_SCN_MEM_WRITE                  0x80000000
#define IMAGE_SCN_SCALE_INDEX                0x00000001

typedef struct _IMAGE_BASE_RELOCATION {
    DWORD VirtualAddress;
    DWORD SizeOfBlock;
} IMAGE_BASE_RELOCATION, *PIMAGE_BASE_RELOCATION;

#define IMAGE_SIZEOF_BASE_RELOCATION         8

#define IMAGE_REL_BASED_ABSOLUTE             0
#define IMAGE_REL_BASED_HIGH                 1
#define IMAGE_REL_BASED_LOW                  2
#define IMAGE_REL_BASED_HIGHLOW              3
#define IMAGE_REL_BASED_HIGHADJ              4
#define IMAGE_REL_BASED_MACHINE_SPECIFIC_5   5
#define IMAGE_REL_BASED_RESERVED             6
#define IMAGE_REL_BASED_MACHINE_SPECIFIC_7   7
#define IMAGE_REL_BASED_MACHINE_SPECIFIC_8   8
#define IMAGE_REL_BASED_MACHINE_SPECIFIC_9   9
#define IMAGE_REL_BASED_DIR64                10
#define IMAGE_REL_BASED_IA64_IMM64           9
#define IMAGE_REL_BASED_MIPS_JMPADDR         5
#define IMAGE_REL_BASED_MIPS_JMPADDR16       9
#define IMAGE_REL_BASED_ARM_MOV32            5
#define IMAGE_REL_BASED_THUMB_MOV32          7

typedef struct _IMAGE_EXPORT_DIRECTORY {
    DWORD Characteristics;
    DWORD TimeDateStamp;
    WORD  MajorVersion;
    WORD  MinorVersion;
    DWORD Name;
    DWORD Base;
    DWORD NumberOfFunctions;
    DWORD NumberOfNames;
    DWORD AddressOfFunctions;
    DWORD AddressOfNames;
    DWORD AddressOfNameOrdinals;
} IMAGE_EXPORT_DIRECTORY, *PIMAGE_EXPORT_DIRECTORY;

typedef struct _IMAGE_IMPORT_BY_NAME {
    WORD Hint;
    CHAR Name[1];
} IMAGE_IMPORT_BY_NAME, *PIMAGE_IMPORT_BY_NAME;

#pragma pack(push, 8)
typedef struct _IMAGE_THUNK_DATA64 {
    union {
        ULONGLONG ForwarderString;
        ULONGLONG Function;
        ULONGLONG Ordinal;
        ULONGLONG AddressOfData;
    } u1;
} IMAGE_THUNK_DATA64, *PIMAGE_THUNK_DATA64;
#pragma pack(pop)

typedef struct _IMAGE_THUNK_DATA32 {
    union {
        DWORD ForwarderString;
        DWORD Function;
        DWORD Ordinal;
        DWORD AddressOfData;
    } u1;
} IMAGE_THUNK_DATA32, *PIMAGE_THUNK_DATA32;

#define IMAGE_ORDINAL_FLAG64 0x8000000000000000
#define IMAGE_ORDINAL_FLAG32 0x80000000
#define IMAGE_ORDINAL64(Ordinal) ((Ordinal) & 0xffff)
#define IMAGE_ORDINAL32(Ordinal) ((Ordinal) & 0xffff)
#define IMAGE_SNAP_BY_ORDINAL64(Ordinal) (((Ordinal) & IMAGE_ORDINAL_FLAG64) != 0)
#define IMAGE_SNAP_BY_ORDINAL32(Ordinal) (((Ordinal) & IMAGE_ORDINAL_FLAG32) != 0)

typedef VOID (WINAPI *PIMAGE_TLS_CALLBACK)(PVOID DllHandle, DWORD Reason, PVOID Reserved);

typedef struct _IMAGE_TLS_DIRECTORY64 {
    ULONGLONG StartAddressOfRawData;
    ULONGLONG EndAddressOfRawData;
    ULONGLONG AddressOfIndex;
    ULONGLONG AddressOfCallBacks;
    DWORD     SizeOfZeroFill;
    union {
        DWORD Characteristics;
        struct {
            DWORD Reserved0 : 20;
            DWORD Alignment : 4;
            DWORD Reserved1 : 8;
        };
    };
} IMAGE_TLS_DIRECTORY64, *PIMAGE_TLS_DIRECTORY64;

typedef struct _IMAGE_TLS_DIRECTORY32 {
    DWORD StartAddressOfRawData;
    DWORD EndAddressOfRawData;
    DWORD AddressOfIndex;
    DWORD AddressOfCallBacks;
    DWORD SizeOfZeroFill;
    union {
        DWORD Characteristics;
        struct {
            DWORD Reserved0 : 20;
            DWORD Alignment : 4;
            DWORD Reserved1 : 8;
        };
    };
} IMAGE_TLS_DIRECTORY32, *PIMAGE_TLS_DIRECTORY32;

#define IMAGE_ORDINAL_FLAG IMAGE_ORDINAL_FLAG64
#define IMAGE_ORDINAL(Ordinal) IMAGE_ORDINAL64(Ordinal)
typedef IMAGE_THUNK_DATA64  IMAGE_THUNK_DATA;
typedef PIMAGE_THUNK_DATA64 PIMAGE_THUNK_DATA;
#define IMAGE_SNAP_BY_ORDINAL(Ordinal) IMAGE_SNAP_BY_ORDINAL64(Ordinal)
typedef IMAGE_TLS_DIRECTORY64  IMAGE_TLS_DIRECTORY;
typedef PIMAGE_TLS_DIRECTORY64 PIMAGE_TLS_DIRECTORY;

typedef struct _IMAGE_IMPORT_DESCRIPTOR {
    union {
        DWORD Characteristics;
        DWORD OriginalFirstThunk;
    };
    DWORD TimeDateStamp;
    DWORD ForwarderChain;
    DWORD Name;
    DWORD FirstThunk;
} IMAGE_IMPORT_DESCRIPTOR, *PIMAGE_IMPORT_DESCRIPTOR;

typedef struct _IMAGE_RESOURCE_DIRECTORY {
    DWORD Characteristics;
    DWORD TimeDateStamp;
    WORD  MajorVersion;
    WORD  MinorVersion;
    WORD  NumberOfNamedEntries;
    WORD  NumberOfIdEntries;
} IMAGE_RESOURCE_DIRECTORY, *PIMAGE_RESOURCE_DIRECTORY;

#define IMAGE_RESOURCE_NAME_IS_STRING        0x80000000
#define IMAGE_RESOURCE_DATA_IS_DIRECTORY     0x80000000

typedef struct _IMAGE_RESOURCE_DIRECTORY_ENTRY {
    union {
        struct {
            DWORD NameOffset : 31;
            DWORD NameIsString : 1;
        };
        DWORD Name;
        WORD  Id;
    };
    union {
        DWORD OffsetToData;
        struct {
            DWORD OffsetToDirectory : 31;
            DWORD DataIsDirectory : 1;
        };
    };
} IMAGE_RESOURCE_DIRECTORY_ENTRY, *PIMAGE_RESOURCE_DIRECTORY_ENTRY;

typedef struct _IMAGE_RESOURCE_DIRECTORY_STRING {
    WORD Length;
    CHAR NameString[1];
} IMAGE_RESOURCE_DIRECTORY_STRING, *PIMAGE_RESOURCE_DIRECTORY_STRING;

typedef struct _IMAGE_RESOURCE_DIR_STRING_U {
    WORD  Length;
    WCHAR NameString[1];
} IMAGE_RESOURCE_DIR_STRING_U, *PIMAGE_RESOURCE_DIR_STRING_U;

typedef struct _IMAGE_RESOURCE_DATA_ENTRY {
    DWORD OffsetToData;
    DWORD Size;
    DWORD CodePage;
    DWORD Reserved;
} IMAGE_RESOURCE_DATA_ENTRY, *PIMAGE_RESOURCE_DATA_ENTRY;
#pragma pack(pop)

// ---------------------------------------------------------------------------
// Win32 GUI / GDI / WGL surface (user32.dll, gdi32.dll, opengl32.dll,
// shell32.dll). Widths and field order are pinned to the Win64 (LLP64) ABI so
// the structs match what the OS reads/writes on the other side of a call.
// Handles are opaque pointers (8 bytes). Bindings for the entry points below
// live in the consumer's link header; only the declarations are here.
// ---------------------------------------------------------------------------


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
typedef const RECT *LPCRECT;

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
typedef BOOL (CALLBACK *MONITORENUMPROC)(HMONITOR, HDC, LPRECT, LPARAM);

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
typedef struct tagWINDOWPLACEMENT *PWINDOWPLACEMENT;
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

// Raw input (winuser.h).
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
typedef const RAWINPUTDEVICE *PCRAWINPUTDEVICE;

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

UINT GetRawInputDeviceList(PRAWINPUTDEVICELIST pRawInputDeviceList, PUINT puiNumDevices,
                           UINT cbSize);
UINT GetRawInputDeviceInfoA(HANDLE hDevice, UINT uiCommand, LPVOID pData, PUINT pcbSize);
UINT GetRawInputDeviceInfoW(HANDLE hDevice, UINT uiCommand, LPVOID pData, PUINT pcbSize);

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
LPVOID GlobalLock(HGLOBAL hMem);
BOOL GlobalUnlock(HGLOBAL hMem);
SIZE_T GlobalSize(HGLOBAL hMem);

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
ATOM RegisterClassA(const WNDCLASSA *lpWndClass);
LRESULT DefWindowProcA(HWND hWnd, UINT Msg, WPARAM wParam, LPARAM lParam);

#define CreateWindowW(cls, name, style, x, y, w, h, parent, menu, inst, param) \
    CreateWindowExW(0, cls, name, style, x, y, w, h, parent, menu, inst, param)
HWND CreateWindowExW(DWORD dwExStyle, LPCWSTR lpClassName, LPCWSTR lpWindowName,
                     DWORD dwStyle, int X, int Y, int nWidth, int nHeight,
                     HWND hWndParent, HMENU hMenu, HINSTANCE hInstance, LPVOID lpParam);
ATOM RegisterClassW(const WNDCLASSW *lpWndClass);
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
HANDLE GetPropW(HWND hWnd, LPCWSTR lpString);
BOOL SetPropW(HWND hWnd, LPCWSTR lpString, HANDLE hData);
HANDLE RemovePropW(HWND hWnd, LPCWSTR lpString);

// Registry read used for the Windows dark-mode query.
#define HKEY_CURRENT_USER ((HKEY)(ULONG_PTR)0x80000001)
#define RRF_RT_REG_DWORD 0x00000010
LSTATUS RegGetValueW(HKEY hkey, LPCWSTR lpSubKey, LPCWSTR lpValue, DWORD dwFlags,
                     LPDWORD pdwType, PVOID pvData, LPDWORD pcbData);

// Display / paint / timer surface RGFW's win32 backend reads.
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

BOOL GetKeyboardState(PBYTE lpKeyState);
HKL GetKeyboardLayout(DWORD idThread);
UINT MapVirtualKeyW(UINT uCode, UINT uMapType);
int ToUnicodeEx(UINT wVirtKey, UINT wScanCode, const BYTE *lpKeyState, LPWSTR pwszBuff,
                int cchBuff, UINT wFlags, HKL dwhkl);
LONG ChangeDisplaySettingsExW(LPCWSTR lpszDeviceName, DEVMODEW *lpDevMode, HWND hwnd,
                              DWORD dwflags, LPVOID lParam);
BOOL EnumDisplayDevicesW(LPCWSTR lpDevice, DWORD iDevNum,
                         PDISPLAY_DEVICEW lpDisplayDevice, DWORD dwFlags);
BOOL EnumDisplaySettingsW(LPCWSTR lpszDeviceName, DWORD iModeNum, DEVMODEW *lpDevMode);
BOOL FlashWindowEx(PFLASHWINFO pfwi);
BOOL GetMonitorInfoW(HMONITOR hMonitor, LPMONITORINFO lpmi);
BOOL IsZoomed(HWND hWnd);
HICON LoadIconA(HINSTANCE hInstance, LPCSTR lpIconName);
HANDLE LoadImageA(HINSTANCE hInst, LPCSTR name, UINT type, int cx, int cy, UINT fuLoad);
LONG_PTR GetWindowLongPtrW(HWND hWnd, int nIndex);
LONG_PTR SetWindowLongPtrW(HWND hWnd, int nIndex, LONG_PTR dwNewLong);
BOOL SetWindowTextW(HWND hWnd, LPCWSTR lpString);
LRESULT SendMessageW(HWND hWnd, UINT Msg, WPARAM wParam, LPARAM lParam);
HWND SetFocus(HWND hWnd);
BOOL SetForegroundWindow(HWND hWnd);
UINT_PTR SetTimer(HWND hWnd, UINT_PTR nIDEvent, UINT uElapse, TIMERPROC lpTimerFunc);
BOOL KillTimer(HWND hWnd, UINT_PTR uIDEvent);
HDC BeginPaint(HWND hWnd, LPPAINTSTRUCT lpPaint);
BOOL EndPaint(HWND hWnd, const PAINTSTRUCT *lpPaint);
BOOL BringWindowToTop(HWND hWnd);
BOOL AdjustWindowRectEx(LPRECT lpRect, DWORD dwStyle, BOOL bMenu, DWORD dwExStyle);
BOOL MoveWindow(HWND hWnd, int X, int Y, int nWidth, int nHeight, BOOL bRepaint);
BOOL BitBlt(HDC hdc, int x, int y, int cx, int cy, HDC hdcSrc, int x1, int y1, DWORD rop);
HDC CreateDCW(LPCWSTR pwszDriver, LPCWSTR pwszDevice, LPCWSTR pszPort,
              const DEVMODEW *pdm);
BOOL GetDeviceGammaRamp(HDC hdc, LPVOID lpRamp);
BOOL SetDeviceGammaRamp(HDC hdc, LPVOID lpRamp);
BOOL ShowWindow(HWND hWnd, int nCmdShow);
HDC GetDC(HWND hWnd);
int ReleaseDC(HWND hWnd, HDC hDC);
BOOL GetWindowRect(HWND hWnd, LPRECT lpRect);
BOOL GetClientRect(HWND hWnd, LPRECT lpRect);
BOOL DestroyWindow(HWND hWnd);
BOOL PeekMessageA(LPMSG lpMsg, HWND hWnd, UINT wMsgFilterMin, UINT wMsgFilterMax,
                  UINT wRemoveMsg);
BOOL TranslateMessage(const MSG *lpMsg);
LRESULT DispatchMessageA(const MSG *lpMsg);
BOOL PostMessageW(HWND hWnd, UINT Msg, WPARAM wParam, LPARAM lParam);
DWORD MsgWaitForMultipleObjects(DWORD nCount, const HANDLE *pHandles, BOOL fWaitAll,
                                DWORD dwMilliseconds, DWORD dwWakeMask);
HCURSOR LoadCursorA(HINSTANCE hInstance, LPCSTR lpCursorName);
SHORT GetKeyState(int nVirtKey);
int GetKeyNameTextA(LONG lParam, LPSTR lpString, int cchSize);
UINT MapVirtualKeyA(UINT uCode, UINT uMapType);
int ToAscii(UINT uVirtKey, UINT uScanCode, const BYTE *lpKeyState, LPWORD lpChar,
            UINT uFlags);
UINT GetRawInputData(HRAWINPUT hRawInput, UINT uiCommand, LPVOID pData, PUINT pcbSize,
                     UINT cbSizeHeader);
BOOL RegisterRawInputDevices(PCRAWINPUTDEVICE pRawInputDevices, UINT uiNumDevices,
                             UINT cbSize);
BOOL ClipCursor(const RECT *lpRect);
BOOL GetCursorPos(LPPOINT lpPoint);
BOOL SetCursorPos(int X, int Y);
BOOL ClientToScreen(HWND hWnd, LPPOINT lpPoint);
BOOL ScreenToClient(HWND hWnd, LPPOINT lpPoint);
BOOL IsWindow(HWND hWnd);
BOOL IsWindowVisible(HWND hWnd);
BOOL GetWindowPlacement(HWND hWnd, WINDOWPLACEMENT *lpwndpl);
ULONG_PTR SetClassLongPtrA(HWND hWnd, int nIndex, LONG_PTR dwNewLong);
HCURSOR SetCursor(HCURSOR hCursor);
BOOL DestroyCursor(HCURSOR hCursor);
BOOL DestroyIcon(HICON hIcon);
BOOL SetWindowPos(HWND hWnd, HWND hWndInsertAfter, int X, int Y, int cx, int cy,
                  UINT uFlags);
BOOL SetWindowTextA(HWND hWnd, LPCSTR lpString);
LONG GetWindowLongW(HWND hWnd, int nIndex);
LONG SetWindowLongW(HWND hWnd, int nIndex, LONG dwNewLong);
LONG GetWindowLongA(HWND hWnd, int nIndex);
LONG SetWindowLongA(HWND hWnd, int nIndex, LONG dwNewLong);
BOOL GetLayeredWindowAttributes(HWND hwnd, COLORREF *pcrKey, BYTE *pbAlpha,
                                DWORD *pdwFlags);
BOOL SetLayeredWindowAttributes(HWND hwnd, COLORREF crKey, BYTE bAlpha, DWORD dwFlags);
int GetSystemMetrics(int nIndex);
HMONITOR MonitorFromPoint(POINT pt, DWORD dwFlags);
HMONITOR MonitorFromWindow(HWND hwnd, DWORD dwFlags);
BOOL EnumDisplayMonitors(HDC hdc, LPCRECT lprcClip, MONITORENUMPROC lpfnEnum,
                         LPARAM dwData);
BOOL EnumDisplayDevicesA(LPCSTR lpDevice, DWORD iDevNum,
                         PDISPLAY_DEVICEA lpDisplayDevice, DWORD dwFlags);
BOOL GetMonitorInfoA(HMONITOR hMonitor, LPMONITORINFO lpmi);
BOOL SetProcessDPIAware(VOID);
HWND GetForegroundWindow(VOID);
BOOL OpenClipboard(HWND hWndNewOwner);
BOOL CloseClipboard(VOID);
HANDLE GetClipboardData(UINT uFormat);
BOOL EmptyClipboard(VOID);
HANDLE SetClipboardData(UINT uFormat, HANDLE hMem);
DWORD CharLowerBuffA(LPSTR lpsz, DWORD cchLength);

// gdi32.dll pixel format, DIB, and bitblt entry points.
int ChoosePixelFormat(HDC hdc, const PIXELFORMATDESCRIPTOR *ppfd);
BOOL SetPixelFormat(HDC hdc, int format, const PIXELFORMATDESCRIPTOR *ppfd);
int DescribePixelFormat(HDC hdc, int iPixelFormat, UINT nBytes,
                        LPPIXELFORMATDESCRIPTOR ppfd);
BOOL SwapBuffers(HDC hdc);
int GetDeviceCaps(HDC hdc, int index);
HBITMAP CreateBitmap(int nWidth, int nHeight, UINT nPlanes, UINT nBitCount,
                     const VOID *lpBits);
HBITMAP CreateDIBSection(HDC hdc, const BITMAPINFO *pbmi, UINT usage, VOID **ppvBits,
                         HANDLE hSection, DWORD offset);
HDC CreateCompatibleDC(HDC hdc);
BOOL DeleteDC(HDC hdc);
BOOL DeleteObject(HGDIOBJ ho);
HGDIOBJ SelectObject(HDC hdc, HGDIOBJ h);
HICON CreateIconIndirect(PICONINFO piconinfo);

// opengl32.dll WGL context entry points.
HGLRC wglCreateContext(HDC hdc);
BOOL wglDeleteContext(HGLRC hglrc);
BOOL wglMakeCurrent(HDC hdc, HGLRC hglrc);
PROC wglGetProcAddress(LPCSTR lpszProc);
HDC wglGetCurrentDC(VOID);
HGLRC wglGetCurrentContext(VOID);
BOOL wglShareLists(HGLRC hglrc1, HGLRC hglrc2);

#endif

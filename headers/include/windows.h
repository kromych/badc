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
#define LoadLibrary LoadLibraryA
#define GetModuleHandle GetModuleHandleA
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
typedef HANDLE *PHANDLE;
typedef HANDLE *LPHANDLE;
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
typedef long long          HANDLE;
typedef long long          SIZE_T;
typedef long long          ULONG_PTR;
typedef long long          UINT_PTR;
typedef long long          DWORD_PTR;
typedef long long          LONG_PTR;
typedef long long          LONGLONG;
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
typedef void              *LPVOID;
typedef void              *PVOID;
typedef char              *LPSTR;
typedef char              *LPCSTR;
typedef unsigned short    *LPWSTR;
typedef unsigned short    *LPCWSTR;
typedef unsigned short     WCHAR;
typedef unsigned short    *PWSTR;
typedef unsigned short    *PCWSTR;
typedef long long          INT_PTR;
typedef long long          SSIZE_T;
typedef int                NTSTATUS;
typedef int               *LPBOOL;
typedef int               *PBOOL;

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

#define VER_PLATFORM_WIN32s         0
#define VER_PLATFORM_WIN32_WINDOWS  1
#define VER_PLATFORM_WIN32_NT       2

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

// Windows error codes sqlite checks against the GetLastError
// return.
#define ERROR_SUCCESS                  0
#define ERROR_INVALID_HANDLE           6
#define ERROR_NOT_LOCKED               158
#define ERROR_LOCK_VIOLATION           33
#define ERROR_HANDLE_DISK_FULL         39
#define ERROR_FILE_NOT_FOUND           2
#define ERROR_PATH_NOT_FOUND           3
#define ERROR_DISK_FULL                112
#define ERROR_SHARING_VIOLATION        32
#define ERROR_NOT_SUPPORTED            50
#define ERROR_ACCESS_DENIED            5
#define ERROR_GEN_FAILURE              31
#define ERROR_NETNAME_DELETED          64
#define ERROR_INVALID_PARAMETER        87
#define ERROR_INSUFFICIENT_BUFFER      122
#define ERROR_OUTOFMEMORY              14
#define ERROR_NO_MORE_FILES            18
#define ERROR_BROKEN_PIPE              109
#define ERROR_HANDLE_EOF               38
#define ERROR_NOT_READY                21
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
#define WAIT_OBJECT_0_BASE             0
#define INVALID_FILE_SIZE              0xFFFFFFFF

#define WAIT_FAILED                    0xFFFFFFFF
#define WAIT_TIMEOUT                   258
#define WAIT_ABANDONED                 0x00000080

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
#pragma binding(kernel32::GetModuleHandleW,        "GetModuleHandleW")
#pragma binding(kernel32::GetNativeSystemInfo,     "GetNativeSystemInfo")
#pragma binding(kernel32::GetProcessHeap,          "GetProcessHeap")
#pragma binding(kernel32::GetProcAddressA,         "GetProcAddress")
#pragma binding(kernel32::CharLowerW,              "CharLowerW")
#pragma binding(kernel32::CharUpperW,              "CharUpperW")
#pragma binding(kernel32::CreateFileA,             "CreateFileA")
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
// rpcrt4-resident UUID helpers; sqlite gates these on
// `SQLITE_WIN32_USE_UUID`. The kernel32 dylib hosts the binding
// nominally -- runtime resolution still goes through the
// dispatch table -- but production-quality runs would bind these
// to rpcrt4.dll.
#pragma binding(kernel32::UuidCreate,              "UuidCreate")
#pragma binding(kernel32::UuidCreateSequential,    "UuidCreateSequential")

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
int CreateEventA(LPSECURITY_ATTRIBUTES lpEventAttributes, int bManualReset,
                 int bInitialState, LPCSTR lpName);
int FlushViewOfFile(LPCVOID lpBaseAddress, SIZE_T dwNumberOfBytesToFlush);
int GetModuleHandleW(LPCWSTR lpModuleName);
int GetNativeSystemInfo(LPSYSTEM_INFO lpSystemInfo);
int GetProcessHeap(void);
int GetProcAddressA(void *hModule, LPCSTR lpProcName);
int CharLowerW(LPWSTR lpsz);
int CharUpperW(LPWSTR lpsz);
int CreateFileA(LPCSTR lpFileName, DWORD dwDesiredAccess, DWORD dwShareMode,
                LPSECURITY_ATTRIBUTES lpSecurityAttributes,
                DWORD dwCreationDisposition, DWORD dwFlagsAndAttributes,
                HANDLE hTemplateFile);
int CreateFileMappingA(HANDLE hFile, LPSECURITY_ATTRIBUTES lpFileMappingAttributes,
                       DWORD flProtect, DWORD dwMaximumSizeHigh,
                       DWORD dwMaximumSizeLow, LPCSTR lpName);
int CreateFileMappingW(HANDLE hFile, LPSECURITY_ATTRIBUTES lpFileMappingAttributes,
                       DWORD flProtect, DWORD dwMaximumSizeHigh,
                       DWORD dwMaximumSizeLow, LPCWSTR lpName);
int CreateFileW(LPCWSTR lpFileName, DWORD dwDesiredAccess, DWORD dwShareMode,
                LPSECURITY_ATTRIBUTES lpSecurityAttributes,
                DWORD dwCreationDisposition, DWORD dwFlagsAndAttributes,
                HANDLE hTemplateFile);
int CreateMutexW(LPSECURITY_ATTRIBUTES lpMutexAttributes, int bInitialOwner,
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
int HeapAlloc(HANDLE hHeap, DWORD dwFlags, SIZE_T dwBytes);
int HeapCompact(HANDLE hHeap, DWORD dwFlags);
int HeapCreate(DWORD flOptions, SIZE_T dwInitialSize, SIZE_T dwMaximumSize);
int HeapDestroy(HANDLE hHeap);
int HeapFree(HANDLE hHeap, DWORD dwFlags, LPVOID lpMem);
int HeapReAlloc(HANDLE hHeap, DWORD dwFlags, LPVOID lpMem, SIZE_T dwBytes);
int HeapSize(HANDLE hHeap, DWORD dwFlags, LPCVOID lpMem);
int HeapValidate(HANDLE hHeap, DWORD dwFlags, LPCVOID lpMem);
int LoadLibraryW(LPCWSTR lpLibFileName);
int LocalFree(HLOCAL hMem);
int LockFile(HANDLE hFile, DWORD dwFileOffsetLow, DWORD dwFileOffsetHigh,
             DWORD nNumberOfBytesToLockLow, DWORD nNumberOfBytesToLockHigh);
int LockFileEx(HANDLE hFile, DWORD dwFlags, DWORD dwReserved,
               DWORD nNumberOfBytesToLockLow, DWORD nNumberOfBytesToLockHigh,
               LPOVERLAPPED lpOverlapped);
int MapViewOfFile(HANDLE hFileMappingObject, DWORD dwDesiredAccess,
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
#endif

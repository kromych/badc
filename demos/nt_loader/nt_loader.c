// ─── Build configuration ──────────────────────────────────────────────────────
// Define USE_UNICODE to build with wide-character (Unicode) strings.
// Comment out or undefine for narrow-character (ANSI) strings.
#define USE_UNICODE

// ─── MSVC compatibility shim ──────────────────────────────────────────────────
// `<msvc_compat.h>` provides no-op definitions for the MSVC keywords
// this source uses (`__int64`, `__stdcall`, `__cdecl`, `__declspec`)
// plus the `#pragma binding(...)` entries that wire the
// kernel32 / msvcrt declarations below to the IAT.
#include "msvc_compat.h"

// ─── Linker directives ───────────────────────────────────────────────────────
// `#pragma comment(lib, ...)` is an MSVC linker directive; badc has
// no link step and resolves imports through the bindings emitted by
// `<msvc_compat.h>`. The compiler accepts the directive silently.
#pragma comment(lib, "kernel32.lib")
#pragma comment(lib, "msvcrt.lib")

// ─── Primitive types (replaces <windows.h>) ───────────────────────────────────
typedef void                    VOID;
typedef void* PVOID;
typedef unsigned char           UCHAR;
typedef unsigned char           BOOLEAN;
typedef unsigned short          USHORT;
typedef unsigned long           ULONG;
typedef long                    LONG;
typedef int                     BOOL;
typedef unsigned long           DWORD;
typedef PVOID                   HANDLE;
typedef HANDLE* PHANDLE;
typedef ULONG                   ACCESS_MASK;
typedef LONG                    NTSTATUS;
typedef USHORT                  WCHAR;
typedef WCHAR* PWSTR;
typedef char                    CHAR;
typedef CHAR* PSTR;
typedef UCHAR* PUCHAR;

#ifdef _WIN64
typedef __int64                 LONG_PTR;
typedef unsigned __int64        ULONG_PTR;
typedef unsigned __int64        SIZE_T;
#else
typedef long                    LONG_PTR;
typedef unsigned long           ULONG_PTR;
typedef unsigned long           SIZE_T;
#endif

typedef union _LARGE_INTEGER {
    struct { ULONG LowPart; LONG HighPart; };
    __int64 QuadPart;
} LARGE_INTEGER, * PLARGE_INTEGER;

typedef struct _GUID {
    unsigned long  Data1;
    unsigned short Data2;
    unsigned short Data3;
    unsigned char  Data4[8];
} GUID, * LPGUID;

// ─── TCHAR macros (replaces <tchar.h>) ───────────────────────────────────────
#ifdef USE_UNICODE
typedef WCHAR   TCHAR;
#  define _T(x)      L##x
#  define _tprintf   wprintf
#  define _tmain     wmain
#else
typedef CHAR    TCHAR;
#  define _T(x)      x
#  define _tprintf   printf
#  define _tmain     main
#endif

// ─── Constants ────────────────────────────────────────────────────────────────
#define NULL                    ((PVOID)0)
#define FALSE                   ((BOOLEAN)0)
#define TRUE                    ((BOOLEAN)1)
#define INVALID_HANDLE_VALUE    ((HANDLE)(LONG_PTR)-1)
#define MAX_PATH                260

#define GENERIC_READ            0x80000000UL
#define GENERIC_WRITE           0x40000000UL
#define OPEN_EXISTING           3
#define FILE_ATTRIBUTE_NORMAL   0x00000080UL

#define PAGE_READONLY           0x02UL
#define SEC_IMAGE               0x01000000UL
#define SECTION_ALL_ACCESS      0x000F001FUL    // STANDARD_RIGHTS_REQUIRED | section-specific bits
#define PROCESS_ALL_ACCESS      0x001FFFFFUL    // STANDARD_RIGHTS_REQUIRED | SYNCHRONIZE | 0xFFFF
#define TRANSACTION_ALL_ACCESS  0x000F003FUL    // STANDARD_RIGHTS_REQUIRED | 0x3F

#define CP_ACP                  0
#define OBJ_CASE_INSENSITIVE    0x00000040UL
#define PS_INHERIT_HANDLES      4

// ─── NT helpers ───────────────────────────────────────────────────────────────
#define NT_SUCCESS(Status)      ((NTSTATUS)(Status) >= 0)
#define NtCurrentProcess()      ((HANDLE)(LONG_PTR)-1)

// ─── Calling conventions ──────────────────────────────────────────────────────
#define NTAPI   __stdcall
#define WINAPI  __stdcall

// ─── NT struct definitions ────────────────────────────────────────────────────
typedef struct _UNICODE_STRING {
    USHORT Length;          // bytes, not including null terminator
    USHORT MaximumLength;
    PWSTR  Buffer;
} UNICODE_STRING, * PUNICODE_STRING;

typedef struct _OBJECT_ATTRIBUTES {
    ULONG           Length;
    HANDLE          RootDirectory;
    PUNICODE_STRING ObjectName;
    ULONG           Attributes;
    PVOID           SecurityDescriptor;
    PVOID           SecurityQualityOfService;
} OBJECT_ATTRIBUTES, * POBJECT_ATTRIBUTES;

// ─── NT function pointer typedefs ─────────────────────────────────────────────
typedef NTSTATUS(NTAPI* fpNtCreateProcessEx)(
    PHANDLE            ProcessHandle,
    ACCESS_MASK        DesiredAccess,
    POBJECT_ATTRIBUTES ObjectAttributes,
    HANDLE             ParentProcess,
    ULONG              Flags,
    HANDLE             SectionHandle,
    HANDLE             DebugPort,
    HANDLE             ExceptionPort,
    BOOLEAN            InJob
    );

typedef NTSTATUS(NTAPI* fpNtCreateTransaction)(
    PHANDLE            TransactionHandle,
    ACCESS_MASK        DesiredAccess,
    POBJECT_ATTRIBUTES ObjectAttributes,
    LPGUID             Uow,
    HANDLE             TmHandle,
    ULONG              CreateOptions,
    ULONG              IsolationLevel,
    ULONG              IsolationFlags,
    PLARGE_INTEGER     Timeout,
    PUNICODE_STRING    Description
    );

typedef NTSTATUS(NTAPI* fpNtCreateSection)(
    PHANDLE            SectionHandle,
    ACCESS_MASK        DesiredAccess,
    POBJECT_ATTRIBUTES ObjectAttributes,
    PLARGE_INTEGER     MaximumSize,
    ULONG              SectionPageProtection,
    ULONG              AllocationAttributes,
    HANDLE             FileHandle
    );

typedef NTSTATUS(NTAPI* fpNtClose)(
    HANDLE Handle
    );

// ─── Win32 API declarations ───────────────────────────────────────────────────
typedef int (WINAPI* FARPROC)();

__declspec(dllimport) HANDLE WINAPI GetModuleHandleW(const WCHAR* lpModuleName);
__declspec(dllimport) FARPROC WINAPI GetProcAddress(HANDLE hModule, const CHAR* lpProcName);
__declspec(dllimport) BOOL   WINAPI CloseHandle(HANDLE hObject);
__declspec(dllimport) DWORD  WINAPI GetLastError(VOID);
__declspec(dllimport) DWORD  WINAPI GetProcessId(HANDLE Process);
__declspec(dllimport) WCHAR* WINAPI lstrcpyW(WCHAR* lpString1, const WCHAR* lpString2);
__declspec(dllimport) CHAR* WINAPI lstrcpyA(CHAR* lpString1, const CHAR* lpString2);
__declspec(dllimport) int    WINAPI MultiByteToWideChar(DWORD CodePage, DWORD dwFlags, const CHAR* lpMultiByteStr, int cbMultiByte, WCHAR* lpWideCharStr, int cchWideChar);

__declspec(dllimport) HANDLE WINAPI CreateFileTransactedW(
    const WCHAR* lpFileName, DWORD dwDesiredAccess, DWORD dwShareMode,
    PVOID lpSecurityAttributes, DWORD dwCreationDisposition,
    DWORD dwFlagsAndAttributes, HANDLE hTemplateFile,
    HANDLE hTransaction, PVOID pusMiniVersion, PVOID pExtendedParameter);

__declspec(dllimport) HANDLE WINAPI CreateFileTransactedA(
    const CHAR* lpFileName, DWORD dwDesiredAccess, DWORD dwShareMode,
    PVOID lpSecurityAttributes, DWORD dwCreationDisposition,
    DWORD dwFlagsAndAttributes, HANDLE hTemplateFile,
    HANDLE hTransaction, PVOID pusMiniVersion, PVOID pExtendedParameter);

// ─── CRT declarations (msvcrt.dll) ───────────────────────────────────────────
__declspec(dllimport) int    __cdecl wprintf(const WCHAR * _Format, ...);
__declspec(dllimport) int    __cdecl printf(const CHAR * _Format, ...);
__declspec(dllimport) SIZE_T __cdecl wcslen(const WCHAR * str);

// ─── Logging helpers ──────────────────────────────────────────────────────────
#define LOG(fmt, ...)     _tprintf(_T("[*] ") fmt _T("\n"), ##__VA_ARGS__)
#define LOG_OK(fmt, ...)  _tprintf(_T("[+] ") fmt _T("\n"), ##__VA_ARGS__)
#define LOG_ERR(fmt, ...) _tprintf(_T("[-] ") fmt _T("\n"), ##__VA_ARGS__)

// ─── Entry point ─────────────────────────────────────────────────────────────
int _tmain(int argc, TCHAR** argv)
{
    if (argc != 2)
    {
        LOG_ERR(_T("Usage: %s <image path>"), argv[0]);
        return 1;
    }

    NTSTATUS  status;
    HANDLE    hProcess = NULL;
    HANDLE    hTransaction = NULL;
    HANDLE    hTransactedFile = INVALID_HANDLE_VALUE;
    HANDLE    hSection = NULL;
    int       exitCode = 1;

    OBJECT_ATTRIBUTES objattr;
    objattr.Length = sizeof(OBJECT_ATTRIBUTES);
    objattr.Attributes = OBJ_CASE_INSENSITIVE;
    objattr.ObjectName = NULL;
    objattr.RootDirectory = NULL;
    objattr.SecurityDescriptor = NULL;
    objattr.SecurityQualityOfService = NULL;

    // ── Resolve ntdll exports ─────────────────────────────────────────────────
    // ntdll is always mapped into every process; GetModuleHandle avoids a
    // ref-count bump and the need for a matching FreeLibrary.
    LOG(_T("Resolving ntdll exports"));
    HANDLE hNtdll = GetModuleHandleW(L"ntdll.dll");
    if (!hNtdll)
    {
        LOG_ERR(_T("GetModuleHandle(ntdll) failed: 0x%08lX"), GetLastError());
        return 1;
    }

    fpNtCreateProcessEx   _NtCreateProcessEx = (fpNtCreateProcessEx)GetProcAddress(hNtdll, "NtCreateProcessEx");
    fpNtCreateTransaction _NtCreateTransaction = (fpNtCreateTransaction)GetProcAddress(hNtdll, "NtCreateTransaction");
    fpNtCreateSection     _NtCreateSection = (fpNtCreateSection)GetProcAddress(hNtdll, "NtCreateSection");
    fpNtClose             _NtClose = (fpNtClose)GetProcAddress(hNtdll, "NtClose");

    if (!_NtCreateProcessEx || !_NtCreateTransaction || !_NtCreateSection || !_NtClose)
    {
        LOG_ERR(_T("Failed to resolve one or more ntdll exports"));
        return 1;
    }
    LOG_OK(_T("ntdll exports resolved"));

    // ── Build wide path (UNICODE_STRING.Buffer is always PWSTR) ──────────────
    WCHAR wPath[MAX_PATH];

#ifdef USE_UNICODE
    if (wcslen(argv[1]) >= MAX_PATH)
    {
        LOG_ERR(_T("Path too long (>= MAX_PATH)"));
        return 1;
    }
    lstrcpyW(wPath, argv[1]);
#else
    int wPathLen = MultiByteToWideChar(CP_ACP, 0, argv[1], -1, wPath, MAX_PATH);
    if (wPathLen == 0)
    {
        LOG_ERR(_T("MultiByteToWideChar failed: 0x%08lX"), GetLastError());
        return 1;
    }
#endif

    // ── Create KTM transaction ────────────────────────────────────────────────
    LOG(_T("Creating KTM transaction"));
    status = _NtCreateTransaction(
        &hTransaction,
        TRANSACTION_ALL_ACCESS,
        &objattr,
        NULL, NULL, 0, 0, 0, NULL, NULL);

    if (!NT_SUCCESS(status))
    {
        LOG_ERR(_T("NtCreateTransaction failed: 0x%08lX"), (ULONG)status);
        goto cleanup;
    }
    LOG_OK(_T("Transaction created (handle: %p)"), hTransaction);

    // ── Open target file within the transaction ───────────────────────────────
    LOG(_T("Opening transacted file: %s"), argv[1]);

#ifdef USE_UNICODE
    hTransactedFile = CreateFileTransactedW(
        wPath,
        GENERIC_READ | GENERIC_WRITE,
        0, NULL,
        OPEN_EXISTING,
        FILE_ATTRIBUTE_NORMAL,
        NULL, hTransaction, NULL, NULL);
#else
    hTransactedFile = CreateFileTransactedA(
        argv[1],
        GENERIC_READ | GENERIC_WRITE,
        0, NULL,
        OPEN_EXISTING,
        FILE_ATTRIBUTE_NORMAL,
        NULL, hTransaction, NULL, NULL);
#endif

    if (hTransactedFile == INVALID_HANDLE_VALUE)
    {
        LOG_ERR(_T("CreateFileTransacted failed: 0x%08lX"), GetLastError());
        goto cleanup;
    }
    LOG_OK(_T("Transacted file opened (handle: %p)"), hTransactedFile);

    // ── Create image section backed by the transacted file ────────────────────
    LOG(_T("Creating image section"));
    status = _NtCreateSection(
        &hSection,
        SECTION_ALL_ACCESS,
        NULL,
        NULL,               // MaximumSize = NULL: use full file size
        PAGE_READONLY,
        SEC_IMAGE,
        hTransactedFile);

    if (!NT_SUCCESS(status))
    {
        LOG_ERR(_T("NtCreateSection failed: 0x%08lX"), (ULONG)status);
        goto cleanup;
    }
    LOG_OK(_T("Image section created (handle: %p)"), hSection);

    // ── Create process from the section ──────────────────────────────────────
    LOG(_T("Creating process from image section"));
    status = _NtCreateProcessEx(
        &hProcess,
        PROCESS_ALL_ACCESS,
        NULL,
        NtCurrentProcess(),
        PS_INHERIT_HANDLES,
        hSection,
        NULL, NULL,
        FALSE);

    if (!NT_SUCCESS(status))
    {
        LOG_ERR(_T("NtCreateProcessEx failed: 0x%08lX"), (ULONG)status);
        goto cleanup;
    }

    DWORD pid = GetProcessId(hProcess);
    if (pid == 0)
    {
        LOG_ERR(_T("GetProcessId failed: 0x%08lX"), GetLastError());
        goto cleanup;
    }
    LOG_OK(_T("Process created. PID = %lu"), (ULONG)pid);
    exitCode = 0;

cleanup:
    LOG(_T("Cleaning up handles"));
    if (hTransactedFile != INVALID_HANDLE_VALUE) CloseHandle(hTransactedFile);
    if (hTransaction)                            _NtClose(hTransaction);
    if (hSection)                                _NtClose(hSection);
    if (hProcess)                                _NtClose(hProcess);

    LOG(_T("Done (exit code: %d)"), exitCode);
    return exitCode;
}

// nt_loader -- launches a user-mode native NT program.
//
// Builds an `SEC_IMAGE` section over a transacted file, spawns a
// process from the section via `NtCreateProcessEx`, then waits up
// to two seconds on a named event for the child to signal it.
// `#define USE_UNICODE` selects the wide-char (`wmain`) build;
// commenting it out selects the narrow-char (`main`) build.

#define USE_UNICODE

// ─── DLL bindings ────────────────────────────────────────────────────────────
// c5 resolves imports through `#pragma binding(...)`; declarations
// below are plain C and the per-binding pragma wires each to its
// IAT slot.

#pragma dylib(kernel32, "kernel32.dll")
#pragma dylib(msvcrt,   "msvcrt.dll")

#pragma binding(kernel32::GetModuleHandleW,      "GetModuleHandleW")
#pragma binding(kernel32::GetProcAddress,        "GetProcAddress")
#pragma binding(kernel32::CloseHandle,           "CloseHandle")
#pragma binding(kernel32::GetLastError,          "GetLastError")
#pragma binding(kernel32::GetProcessId,          "GetProcessId")
#pragma binding(kernel32::lstrcpyW,              "lstrcpyW")
#pragma binding(kernel32::lstrcpyA,              "lstrcpyA")
#pragma binding(kernel32::MultiByteToWideChar,   "MultiByteToWideChar")
#pragma binding(kernel32::CreateFileTransactedW, "CreateFileTransactedW")
#pragma binding(kernel32::CreateFileTransactedA, "CreateFileTransactedA")

#pragma binding(msvcrt::wprintf, "wprintf")
#pragma binding(msvcrt::printf,  "printf")
#pragma binding(msvcrt::wcslen,  "wcslen")

// ─── Primitive types ─────────────────────────────────────────────────────────
typedef void                     VOID;
typedef void                    *PVOID;
typedef unsigned char            UCHAR;
typedef unsigned char            BOOLEAN;
typedef unsigned short           USHORT;
typedef unsigned long            ULONG;
typedef long                     LONG;
typedef int                      BOOL;
typedef unsigned long            DWORD;
typedef PVOID                    HANDLE;
typedef HANDLE                  *PHANDLE;
typedef ULONG                    ACCESS_MASK;
typedef LONG                     NTSTATUS;
typedef unsigned short           WCHAR;
typedef WCHAR                   *PWSTR;
typedef char                     CHAR;
typedef CHAR                    *PSTR;
typedef long long                LONG_PTR;
typedef unsigned long long       ULONG_PTR;
typedef unsigned long long       SIZE_T;

typedef union _LARGE_INTEGER {
    struct { ULONG LowPart; LONG HighPart; };
    long long QuadPart;
} LARGE_INTEGER, *PLARGE_INTEGER;

typedef struct _GUID {
    unsigned long  Data1;
    unsigned short Data2;
    unsigned short Data3;
    unsigned char  Data4[8];
} GUID, *LPGUID;

// ─── TCHAR macros ────────────────────────────────────────────────────────────
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

// ─── Constants ───────────────────────────────────────────────────────────────
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
#define SECTION_ALL_ACCESS      0x000F001FUL
#define PROCESS_ALL_ACCESS      0x001FFFFFUL
#define TRANSACTION_ALL_ACCESS  0x000F003FUL
#define EVENT_ALL_ACCESS        0x001F0003UL

#define CP_ACP                  0
#define OBJ_CASE_INSENSITIVE    0x00000040UL
#define PS_INHERIT_HANDLES      4

// `EVENT_TYPE` values for `NtCreateEvent` -- 0 = NotificationEvent
// (manual-reset), 1 = SynchronizationEvent (auto-reset).
#define NOTIFICATION_EVENT      0
#define SYNCHRONIZATION_EVENT   1

// `NtWaitForSingleObject` timeout values are 100-ns ticks; negative
// values are relative (counted from now), positive are absolute.
// -10_000 (= -1e4) = 1 ms; -2 * 1e7 = 2 seconds.
#define EVENT_WAIT_TIMEOUT_TICKS  ((long long)-20000000)

#define STATUS_TIMEOUT          ((NTSTATUS)0x00000102L)

#define NT_SUCCESS(Status)      ((NTSTATUS)(Status) >= 0)
#define NtCurrentProcess()      ((HANDLE)(LONG_PTR)-1)

// ─── NT struct definitions ───────────────────────────────────────────────────
typedef struct _UNICODE_STRING {
    USHORT Length;
    USHORT MaximumLength;
    PWSTR  Buffer;
} UNICODE_STRING, *PUNICODE_STRING;

typedef struct _OBJECT_ATTRIBUTES {
    ULONG           Length;
    HANDLE          RootDirectory;
    PUNICODE_STRING ObjectName;
    ULONG           Attributes;
    PVOID           SecurityDescriptor;
    PVOID           SecurityQualityOfService;
} OBJECT_ATTRIBUTES, *POBJECT_ATTRIBUTES;

// ─── ntdll function-pointer typedefs ─────────────────────────────────────────
typedef NTSTATUS (*fpNtCreateProcessEx)(
    PHANDLE ProcessHandle, ACCESS_MASK DesiredAccess,
    POBJECT_ATTRIBUTES ObjectAttributes, HANDLE ParentProcess,
    ULONG Flags, HANDLE SectionHandle, HANDLE DebugPort,
    HANDLE ExceptionPort, BOOLEAN InJob);

typedef NTSTATUS (*fpNtCreateTransaction)(
    PHANDLE TransactionHandle, ACCESS_MASK DesiredAccess,
    POBJECT_ATTRIBUTES ObjectAttributes, LPGUID Uow,
    HANDLE TmHandle, ULONG CreateOptions,
    ULONG IsolationLevel, ULONG IsolationFlags,
    PLARGE_INTEGER Timeout, PUNICODE_STRING Description);

typedef NTSTATUS (*fpNtCreateSection)(
    PHANDLE SectionHandle, ACCESS_MASK DesiredAccess,
    POBJECT_ATTRIBUTES ObjectAttributes,
    PLARGE_INTEGER MaximumSize, ULONG SectionPageProtection,
    ULONG AllocationAttributes, HANDLE FileHandle);

typedef NTSTATUS (*fpNtCreateEvent)(
    PHANDLE EventHandle, ACCESS_MASK DesiredAccess,
    POBJECT_ATTRIBUTES ObjectAttributes, ULONG EventType,
    BOOLEAN InitialState);

typedef NTSTATUS (*fpNtWaitForSingleObject)(
    HANDLE Handle, BOOLEAN Alertable, PLARGE_INTEGER Timeout);

typedef NTSTATUS (*fpNtClose)(HANDLE Handle);

typedef void (*fpRtlInitUnicodeString)(
    PUNICODE_STRING DestinationString, PWSTR SourceString);

// ─── Win32 declarations ──────────────────────────────────────────────────────
HANDLE GetModuleHandleW(const WCHAR *lpModuleName);
PVOID  GetProcAddress(HANDLE hModule, const CHAR *lpProcName);
BOOL   CloseHandle(HANDLE hObject);
DWORD  GetLastError(VOID);
DWORD  GetProcessId(HANDLE Process);
WCHAR *lstrcpyW(WCHAR *dst, const WCHAR *src);
CHAR  *lstrcpyA(CHAR *dst, const CHAR *src);
int    MultiByteToWideChar(DWORD CodePage, DWORD dwFlags,
                           const CHAR *lpMultiByteStr, int cbMultiByte,
                           WCHAR *lpWideCharStr, int cchWideChar);

HANDLE CreateFileTransactedW(
    const WCHAR *lpFileName, DWORD dwDesiredAccess, DWORD dwShareMode,
    PVOID lpSecurityAttributes, DWORD dwCreationDisposition,
    DWORD dwFlagsAndAttributes, HANDLE hTemplateFile,
    HANDLE hTransaction, PVOID pusMiniVersion, PVOID pExtendedParameter);

HANDLE CreateFileTransactedA(
    const CHAR *lpFileName, DWORD dwDesiredAccess, DWORD dwShareMode,
    PVOID lpSecurityAttributes, DWORD dwCreationDisposition,
    DWORD dwFlagsAndAttributes, HANDLE hTemplateFile,
    HANDLE hTransaction, PVOID pusMiniVersion, PVOID pExtendedParameter);

// ─── CRT declarations (msvcrt.dll) ───────────────────────────────────────────
int    wprintf(const WCHAR *fmt, ...);
int    printf(const CHAR *fmt, ...);
SIZE_T wcslen(const WCHAR *str);

// ─── Shared-object name for the cross-process event ──────────────────────────
// `\BaseNamedObjects\BadcLoaderSync` -- canonical NT-namespace name.
// The loader creates it; the spawned process (demos/nt_hello) opens
// and signals it.
static WCHAR g_event_name[] = {
    '\\', 'B', 'a', 's', 'e', 'N', 'a', 'm', 'e', 'd', 'O', 'b', 'j',
    'e', 'c', 't', 's', '\\',
    'B', 'a', 'd', 'c', 'L', 'o', 'a', 'd', 'e', 'r', 'S', 'y', 'n', 'c',
    0
};

// ─── Logging helpers ─────────────────────────────────────────────────────────
#define LOG(fmt, ...)     _tprintf(_T("[*] ") fmt _T("\n"), ##__VA_ARGS__)
#define LOG_OK(fmt, ...)  _tprintf(_T("[+] ") fmt _T("\n"), ##__VA_ARGS__)
#define LOG_ERR(fmt, ...) _tprintf(_T("[-] ") fmt _T("\n"), ##__VA_ARGS__)

// ─── Entry point ─────────────────────────────────────────────────────────────
int _tmain(int argc, TCHAR **argv)
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
    HANDLE    hEvent = NULL;
    int       exitCode = 1;

    OBJECT_ATTRIBUTES objattr;
    objattr.Length = sizeof(OBJECT_ATTRIBUTES);
    objattr.Attributes = OBJ_CASE_INSENSITIVE;
    objattr.ObjectName = NULL;
    objattr.RootDirectory = NULL;
    objattr.SecurityDescriptor = NULL;
    objattr.SecurityQualityOfService = NULL;

    // ── Resolve ntdll exports ────────────────────────────────────────────────
    // ntdll is mapped into every process; GetModuleHandle avoids
    // a ref-count bump and an explicit FreeLibrary.
    LOG(_T("Resolving ntdll exports"));
    HANDLE hNtdll = GetModuleHandleW(L"ntdll.dll");
    if (!hNtdll)
    {
        LOG_ERR(_T("GetModuleHandle(ntdll) failed: 0x%08lX"), GetLastError());
        return 1;
    }

    fpNtCreateProcessEx     _NtCreateProcessEx     = (fpNtCreateProcessEx)    GetProcAddress(hNtdll, "NtCreateProcessEx");
    fpNtCreateTransaction   _NtCreateTransaction   = (fpNtCreateTransaction)  GetProcAddress(hNtdll, "NtCreateTransaction");
    fpNtCreateSection       _NtCreateSection       = (fpNtCreateSection)      GetProcAddress(hNtdll, "NtCreateSection");
    fpNtCreateEvent         _NtCreateEvent         = (fpNtCreateEvent)        GetProcAddress(hNtdll, "NtCreateEvent");
    fpNtWaitForSingleObject _NtWaitForSingleObject = (fpNtWaitForSingleObject)GetProcAddress(hNtdll, "NtWaitForSingleObject");
    fpNtClose               _NtClose               = (fpNtClose)              GetProcAddress(hNtdll, "NtClose");
    fpRtlInitUnicodeString  _RtlInitUnicodeString  = (fpRtlInitUnicodeString) GetProcAddress(hNtdll, "RtlInitUnicodeString");

    if (!_NtCreateProcessEx || !_NtCreateTransaction || !_NtCreateSection
        || !_NtCreateEvent || !_NtWaitForSingleObject || !_NtClose
        || !_RtlInitUnicodeString)
    {
        LOG_ERR(_T("Failed to resolve one or more ntdll exports"));
        return 1;
    }
    LOG_OK(_T("ntdll exports resolved"));

    // ── Create the sync event ─────────────────────────────────────────────────
    UNICODE_STRING event_name_us;
    _RtlInitUnicodeString(&event_name_us, g_event_name);
    OBJECT_ATTRIBUTES event_objattr;
    event_objattr.Length = sizeof(OBJECT_ATTRIBUTES);
    event_objattr.Attributes = OBJ_CASE_INSENSITIVE;
    event_objattr.ObjectName = &event_name_us;
    event_objattr.RootDirectory = NULL;
    event_objattr.SecurityDescriptor = NULL;
    event_objattr.SecurityQualityOfService = NULL;
    status = _NtCreateEvent(
        &hEvent, EVENT_ALL_ACCESS, &event_objattr,
        NOTIFICATION_EVENT, FALSE);
    if (!NT_SUCCESS(status))
    {
        LOG_ERR(_T("NtCreateEvent failed: 0x%08lX"), (ULONG)status);
        return 1;
    }
    LOG_OK(_T("Sync event created"));

    // ── Build wide path (UNICODE_STRING.Buffer is always PWSTR) ──────────────
    WCHAR wPath[MAX_PATH];

#ifdef USE_UNICODE
    if (wcslen(argv[1]) >= MAX_PATH)
    {
        LOG_ERR(_T("Path too long (>= MAX_PATH)"));
        goto cleanup;
    }
    lstrcpyW(wPath, argv[1]);
#else
    int wPathLen = MultiByteToWideChar(CP_ACP, 0, argv[1], -1, wPath, MAX_PATH);
    if (wPathLen == 0)
    {
        LOG_ERR(_T("MultiByteToWideChar failed: 0x%08lX"), GetLastError());
        goto cleanup;
    }
#endif

    // ── Create KTM transaction ───────────────────────────────────────────────
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

    // ── Open target file within the transaction ──────────────────────────────
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

    // ── Create image section backed by the transacted file ───────────────────
    LOG(_T("Creating image section"));
    status = _NtCreateSection(
        &hSection,
        SECTION_ALL_ACCESS,
        NULL,
        NULL,
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

    // ── Wait for the child to signal the event (2 s) ─────────────────────────
    LOG(_T("Waiting up to 2s for child to signal the sync event"));
    LARGE_INTEGER timeout;
    timeout.QuadPart = EVENT_WAIT_TIMEOUT_TICKS;
    status = _NtWaitForSingleObject(hEvent, FALSE, &timeout);
    if (status == 0)
    {
        LOG_OK(_T("Sync event received"));
    }
    else if (status == STATUS_TIMEOUT)
    {
        LOG_ERR(_T("Timed out waiting for sync event"));
    }
    else
    {
        LOG_ERR(_T("NtWaitForSingleObject failed: 0x%08lX"), (ULONG)status);
    }
    exitCode = 0;

cleanup:
    LOG(_T("Cleaning up handles"));
    if (hTransactedFile != INVALID_HANDLE_VALUE) CloseHandle(hTransactedFile);
    if (hTransaction)                            _NtClose(hTransaction);
    if (hSection)                                _NtClose(hSection);
    if (hProcess)                                _NtClose(hProcess);
    if (hEvent)                                  _NtClose(hEvent);

    LOG(_T("Done (exit code: %d)"), exitCode);
    return exitCode;
}

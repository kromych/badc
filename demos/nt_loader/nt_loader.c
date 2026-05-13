// nt_loader -- demonstrates the NT primitives for image loading.
//
// Opens an image via TxF (transacted) where the KTM resource
// manager is active, falls back to a plain CreateFile open
// otherwise; builds an SEC_IMAGE section over the file; creates
// a process object from the section via NtCreateProcessEx.
// Stops there. The process object has no initial thread and
// never executes -- starting it requires either ntdll's
// NtCreateUserProcess path (which validates IMAGE_SUBSYSTEM_NATIVE
// against the caller's SeTcbPrivilege and refuses unprivileged
// callers) or constructing the missing PEB.Ldr and
// PEB.ProcessParameters by hand and starting the thread through
// LdrInitializeThunk. Both are educationally interesting but
// out of scope for this demo; see `nt_hello.c` for the
// standalone NATIVE companion.
//
// `#define USE_UNICODE` selects the wide-char (`wmain`) build;
// commenting it out selects the narrow-char (`main`) build.

#define USE_UNICODE

#include <windows.h>
#include <winternl.h>
#include <stdio.h>
#include <wchar.h>

// TCHAR macros.
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

// ntdll function-pointer typedefs (resolved at run time).
// Entries are fetched via `GetProcAddress`; the produced PE
// carries no ntdll import.

typedef NTSTATUS (*fpNtCreateProcessEx)(
    PHANDLE ProcessHandle, ACCESS_MASK DesiredAccess,
    POBJECT_ATTRIBUTES ObjectAttributes, HANDLE ParentProcess,
    ULONG Flags, HANDLE SectionHandle, HANDLE DebugPort,
    HANDLE ExceptionPort, int InJob);

typedef NTSTATUS (*fpNtCreateTransaction)(
    PHANDLE TransactionHandle, ACCESS_MASK DesiredAccess,
    POBJECT_ATTRIBUTES ObjectAttributes, void *Uow,
    HANDLE TmHandle, ULONG CreateOptions,
    ULONG IsolationLevel, ULONG IsolationFlags,
    PLARGE_INTEGER Timeout, PUNICODE_STRING Description);

typedef NTSTATUS (*fpNtCreateSection)(
    PHANDLE SectionHandle, ACCESS_MASK DesiredAccess,
    POBJECT_ATTRIBUTES ObjectAttributes,
    PLARGE_INTEGER MaximumSize, ULONG SectionPageProtection,
    ULONG AllocationAttributes, HANDLE FileHandle);

typedef NTSTATUS (*fpNtClose)(HANDLE Handle);

// Logging helpers.
#define LOG(fmt, ...)     _tprintf(_T("[*] ") fmt _T("\n"), ##__VA_ARGS__)
#define LOG_OK(fmt, ...)  _tprintf(_T("[+] ") fmt _T("\n"), ##__VA_ARGS__)
#define LOG_ERR(fmt, ...) _tprintf(_T("[-] ") fmt _T("\n"), ##__VA_ARGS__)

// Entry point.
int _tmain(int argc, TCHAR **argv)
{
    setvbuf(stdout, NULL, _IONBF, 0);

    if (argc != 2)
    {
        LOG_ERR(_T("Usage: %s <image path>"), argv[0]);
        return 1;
    }

    NTSTATUS  status;
    HANDLE    hProcess = NULL;
    HANDLE    hTransaction = NULL;
    HANDLE    hFile = INVALID_HANDLE_VALUE;
    HANDLE    hSection = NULL;
    int       exitCode = 1;

    OBJECT_ATTRIBUTES objattr;
    objattr.Length = sizeof(OBJECT_ATTRIBUTES);
    objattr.Attributes = OBJ_CASE_INSENSITIVE;
    objattr.ObjectName = NULL;
    objattr.RootDirectory = NULL;
    objattr.SecurityDescriptor = NULL;
    objattr.SecurityQualityOfService = NULL;

    // Resolve ntdll exports.
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
    fpNtClose               _NtClose               = (fpNtClose)              GetProcAddress(hNtdll, "NtClose");

    if (!_NtCreateProcessEx || !_NtCreateTransaction || !_NtCreateSection || !_NtClose)
    {
        LOG_ERR(_T("Failed to resolve one or more ntdll exports"));
        return 1;
    }
    LOG_OK(_T("ntdll exports resolved"));

    // Build wide path (UNICODE_STRING.Buffer is always PWSTR).
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

    // Open the image file. TxF (transacted) is the preferred path
    // -- that's what the demo is about -- but the KTM resource
    // manager is absent on hosted Windows CI volumes (and any host
    // where TxF was never enabled). Try transacted first, fall
    // back to a plain CreateFile so the rest of the section /
    // process flow still runs.
    //
    // Access uses MAXIMUM_ALLOWED rather than GENERIC_READ |
    // GENERIC_EXECUTE: hosted runners' SAFER / AppLocker / WDAC
    // policy can reject the GENERIC_EXECUTE wrapper on freshly
    // built executables with ERROR_PRIVILEGE_NOT_HELD.
    // MAXIMUM_ALLOWED asks the kernel for whatever the token
    // permits, which for a runner's own files normally includes
    // FILE_EXECUTE (needed downstream for SEC_IMAGE).
    LOG(_T("Creating KTM transaction"));
    status = _NtCreateTransaction(
        &hTransaction,
        TRANSACTION_ALL_ACCESS,
        &objattr,
        NULL, NULL, 0, 0, 0, NULL, NULL);

    if (NT_SUCCESS(status))
    {
        LOG_OK(_T("Transaction created (handle: %p)"), hTransaction);
        LOG(_T("Opening transacted file: %s"), argv[1]);
#ifdef USE_UNICODE
        hFile = CreateFileTransactedW(
            wPath,
            MAXIMUM_ALLOWED,
            FILE_SHARE_READ, NULL,
            OPEN_EXISTING,
            FILE_ATTRIBUTE_NORMAL,
            NULL, hTransaction, NULL, NULL);
#else
        hFile = CreateFileTransactedA(
            argv[1],
            MAXIMUM_ALLOWED,
            FILE_SHARE_READ, NULL,
            OPEN_EXISTING,
            FILE_ATTRIBUTE_NORMAL,
            NULL, hTransaction, NULL, NULL);
#endif
        if (hFile == INVALID_HANDLE_VALUE)
        {
            LOG_ERR(_T("CreateFileTransacted failed: 0x%08lX; falling back to non-transacted open"),
                    GetLastError());
            _NtClose(hTransaction);
            hTransaction = NULL;
        }
        else
        {
            LOG_OK(_T("Transacted file opened (handle: %p)"), hFile);
        }
    }
    else
    {
        LOG_ERR(_T("NtCreateTransaction failed: 0x%08lX; falling back to non-transacted open"),
                (ULONG)status);
    }

    if (hFile == INVALID_HANDLE_VALUE)
    {
        LOG(_T("Opening file (non-transacted): %s"), argv[1]);
#ifdef USE_UNICODE
        hFile = CreateFileW(
            wPath,
            MAXIMUM_ALLOWED,
            FILE_SHARE_READ, NULL,
            OPEN_EXISTING,
            FILE_ATTRIBUTE_NORMAL,
            NULL);
#else
        hFile = CreateFileA(
            argv[1],
            MAXIMUM_ALLOWED,
            FILE_SHARE_READ, NULL,
            OPEN_EXISTING,
            FILE_ATTRIBUTE_NORMAL,
            NULL);
#endif
        if (hFile == INVALID_HANDLE_VALUE)
        {
            LOG_ERR(_T("CreateFile failed: 0x%08lX"), GetLastError());
            goto cleanup;
        }
        LOG_OK(_T("File opened (handle: %p)"), hFile);
    }

    // Create image section backed by the file.
    LOG(_T("Creating image section"));
    status = _NtCreateSection(
        &hSection,
        SECTION_ALL_ACCESS,
        NULL,
        NULL,
        PAGE_READONLY,
        SEC_IMAGE,
        hFile);

    if (!NT_SUCCESS(status))
    {
        LOG_ERR(_T("NtCreateSection failed: 0x%08lX"), (ULONG)status);
        goto cleanup;
    }
    LOG_OK(_T("Image section created (handle: %p)"), hSection);

    // Create process from the section. The resulting process
    // object has no initial thread -- this is the educational
    // halt point. See the file header for the two routes to
    // actually starting it.
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
    LOG_OK(_T("Process object created. PID = %lu (no initial thread)"), (ULONG)pid);
    exitCode = 0;

cleanup:
    LOG(_T("Cleaning up handles"));
    if (hFile != INVALID_HANDLE_VALUE) CloseHandle(hFile);
    if (hTransaction)                  _NtClose(hTransaction);
    if (hSection)                      _NtClose(hSection);
    if (hProcess)                      _NtClose(hProcess);

    LOG(_T("Done (exit code: %d)"), exitCode);
    return exitCode;
}

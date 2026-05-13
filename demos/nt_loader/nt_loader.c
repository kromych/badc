// nt_loader -- launches a user-mode native NT program end-to-end.
//
// Builds an `SEC_IMAGE` section over a transacted file (preferred)
// or a plain CreateFile open (fallback when the host has no active
// KTM resource manager). Spawns a process from the section via
// `NtCreateProcessEx`, manually resolves the child's PE imports
// against the parent's already-loaded DLLs and patches the child's
// IAT in place, then starts the initial thread at the PE's entry
// point via `NtCreateThreadEx`. The child runs, opens a named event
// in `\BaseNamedObjects`, signals it, and self-terminates; the
// loader observes the signal on its own wait.
//
// `#define USE_UNICODE` selects the wide-char (`wmain`) build;
// commenting it out selects the narrow-char (`main`) build.
//
// Manual IAT patching is what makes the demo work without running
// `ntdll!LdrInitializeThunk` in the child. We control both halves
// of the handshake, and `nt_hello` imports only from `ntdll`, which
// is mapped at the same address in every process within a boot
// session -- so resolved addresses in the parent are valid in the
// child verbatim.

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

typedef NTSTATUS (*fpNtCreateEvent)(
    PHANDLE EventHandle, ACCESS_MASK DesiredAccess,
    POBJECT_ATTRIBUTES ObjectAttributes, ULONG EventType,
    int InitialState);

typedef NTSTATUS (*fpNtWaitForSingleObject)(
    HANDLE Handle, int Alertable, PLARGE_INTEGER Timeout);

typedef NTSTATUS (*fpNtClose)(HANDLE Handle);

typedef void (*fpRtlInitUnicodeString)(
    PUNICODE_STRING DestinationString, PWSTR SourceString);

typedef NTSTATUS (*fpNtQueryInformationProcess)(
    HANDLE ProcessHandle, ULONG InformationClass,
    PVOID Buffer, ULONG BufferLength, ULONG *ReturnLength);

typedef NTSTATUS (*fpNtReadVirtualMemory)(
    HANDLE ProcessHandle, PVOID BaseAddress, PVOID Buffer,
    long long NumberOfBytesToRead, long long *NumberOfBytesRead);

typedef NTSTATUS (*fpNtWriteVirtualMemory)(
    HANDLE ProcessHandle, PVOID BaseAddress, PVOID Buffer,
    long long NumberOfBytesToWrite, long long *NumberOfBytesWritten);

typedef NTSTATUS (*fpNtCreateThreadEx)(
    PHANDLE ThreadHandle, ACCESS_MASK DesiredAccess,
    POBJECT_ATTRIBUTES ObjectAttributes, HANDLE ProcessHandle,
    PVOID StartRoutine, PVOID Argument, ULONG CreateFlags,
    long long ZeroBits, long long StackSize,
    long long MaximumStackSize, PVOID AttributeList);

// PROCESS_BASIC_INFORMATION (x64 / arm64 layout, 48 bytes).
typedef struct {
    NTSTATUS  ExitStatus;
    PVOID     PebBaseAddress;
    long long AffinityMask;
    LONG      BasePriority;
    HANDLE    UniqueProcessId;
    HANDLE    InheritedFromUniqueProcessId;
} PROCESS_BASIC_INFORMATION;

// `nt_hello` opens this NT path via `NtOpenEvent`. Both the loader
// and the child resolve through the same `\BaseNamedObjects`
// namespace, so they meet without going through Win32's per-session
// mapping.
static WCHAR *g_event_name = L"\\BaseNamedObjects\\BadcLoaderSync";

// `NtWaitForSingleObject` timeout, in 100-ns ticks. Negative
// values are relative; -2*10^7 = 2 s.
#define EVENT_WAIT_TIMEOUT_TICKS  ((long long)-20000000)

// Logging helpers.
#define LOG(fmt, ...)     _tprintf(_T("[*] ") fmt _T("\n"), ##__VA_ARGS__)
#define LOG_OK(fmt, ...)  _tprintf(_T("[+] ") fmt _T("\n"), ##__VA_ARGS__)
#define LOG_ERR(fmt, ...) _tprintf(_T("[-] ") fmt _T("\n"), ##__VA_ARGS__)

// Entry point.
int _tmain(int argc, TCHAR **argv)
{
    // CI smoke pipes stdout, which trips msvcrt's full-buffering for
    // wprintf. Without this, a SIGKILL from the smoke harness drops
    // every diagnostic line on the floor and the log shows nothing.
    setvbuf(stdout, NULL, _IONBF, 0);

    if (argc != 2)
    {
        LOG_ERR(_T("Usage: %s <image path>"), argv[0]);
        return 1;
    }

    NTSTATUS  status;
    HANDLE    hProcess = NULL;
    HANDLE    hThread = NULL;
    HANDLE    hTransaction = NULL;
    HANDLE    hFile = INVALID_HANDLE_VALUE;
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

    // Resolve ntdll exports.
    LOG(_T("Resolving ntdll exports"));
    HANDLE hNtdll = GetModuleHandleW(L"ntdll.dll");
    if (!hNtdll)
    {
        LOG_ERR(_T("GetModuleHandle(ntdll) failed: 0x%08lX"), GetLastError());
        return 1;
    }

    fpNtCreateProcessEx        _NtCreateProcessEx        = (fpNtCreateProcessEx)       GetProcAddress(hNtdll, "NtCreateProcessEx");
    fpNtCreateTransaction      _NtCreateTransaction      = (fpNtCreateTransaction)     GetProcAddress(hNtdll, "NtCreateTransaction");
    fpNtCreateSection          _NtCreateSection          = (fpNtCreateSection)         GetProcAddress(hNtdll, "NtCreateSection");
    fpNtCreateEvent            _NtCreateEvent            = (fpNtCreateEvent)           GetProcAddress(hNtdll, "NtCreateEvent");
    fpNtWaitForSingleObject    _NtWaitForSingleObject    = (fpNtWaitForSingleObject)   GetProcAddress(hNtdll, "NtWaitForSingleObject");
    fpNtClose                  _NtClose                  = (fpNtClose)                 GetProcAddress(hNtdll, "NtClose");
    fpRtlInitUnicodeString     _RtlInitUnicodeString     = (fpRtlInitUnicodeString)    GetProcAddress(hNtdll, "RtlInitUnicodeString");
    fpNtQueryInformationProcess _NtQueryInformationProcess = (fpNtQueryInformationProcess) GetProcAddress(hNtdll, "NtQueryInformationProcess");
    fpNtReadVirtualMemory      _NtReadVirtualMemory      = (fpNtReadVirtualMemory)     GetProcAddress(hNtdll, "NtReadVirtualMemory");
    fpNtWriteVirtualMemory     _NtWriteVirtualMemory     = (fpNtWriteVirtualMemory)    GetProcAddress(hNtdll, "NtWriteVirtualMemory");
    fpNtCreateThreadEx         _NtCreateThreadEx         = (fpNtCreateThreadEx)        GetProcAddress(hNtdll, "NtCreateThreadEx");

    if (!_NtCreateProcessEx || !_NtCreateTransaction || !_NtCreateSection
        || !_NtCreateEvent || !_NtWaitForSingleObject || !_NtClose
        || !_RtlInitUnicodeString || !_NtQueryInformationProcess
        || !_NtReadVirtualMemory || !_NtWriteVirtualMemory
        || !_NtCreateThreadEx)
    {
        LOG_ERR(_T("Failed to resolve one or more ntdll exports"));
        return 1;
    }
    LOG_OK(_T("ntdll exports resolved"));

    // Create the sync event under `\BaseNamedObjects`. The child
    // opens the same NT path so both sides see the same kernel
    // object regardless of the calling session.
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
    // process / event-sync flow still runs.
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

    // Create process from the section.
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
    LOG_OK(_T("Process created. PID = %lu"), (ULONG)pid);

    // Query the child's PEB to find ImageBase. NtCreateProcessEx
    // sets `PEB.ImageBaseAddress` at section attach (offset 0x10
    // on x64/arm64). The user-mode loader normally fills in the
    // rest later; we'll patch imports ourselves.
    LOG(_T("Querying child PEB"));
    PROCESS_BASIC_INFORMATION pbi;
    ULONG pbi_ret = 0;
    status = _NtQueryInformationProcess(hProcess, 0, &pbi, sizeof(pbi), &pbi_ret);
    if (!NT_SUCCESS(status))
    {
        LOG_ERR(_T("NtQueryInformationProcess failed: 0x%08lX"), (ULONG)status);
        goto cleanup;
    }

    char *child_base = NULL;
    status = _NtReadVirtualMemory(hProcess, (char*)pbi.PebBaseAddress + 0x10, &child_base, 8, NULL);
    if (!NT_SUCCESS(status) || !child_base)
    {
        LOG_ERR(_T("Reading child ImageBase failed: 0x%08lX"), (ULONG)status);
        goto cleanup;
    }
    LOG_OK(_T("Child ImageBase = %p"), child_base);

    // Read PE header offsets from the child's mapped image.
    ULONG e_lfanew = 0;
    _NtReadVirtualMemory(hProcess, child_base + 0x3C, &e_lfanew, 4, NULL);

    // PE32+ optional header begins at `nt_off + 4 (NT sig) + 20
    // (COFF header) = nt_off + 24`. `AddressOfEntryPoint` is at
    // optional-header offset 16; `DataDirectory[1]` (Import) is at
    // optional-header offset 112.
    char *opt_hdr = child_base + e_lfanew + 24;
    ULONG entry_rva = 0;
    ULONG import_rva = 0;
    _NtReadVirtualMemory(hProcess, opt_hdr + 16,  &entry_rva,  4, NULL);
    _NtReadVirtualMemory(hProcess, opt_hdr + 112, &import_rva, 4, NULL);

    if (import_rva == 0)
    {
        LOG_ERR(_T("Child has no import directory"));
        goto cleanup;
    }

    // Walk import descriptors (20 bytes each) and patch the IAT.
    LOG(_T("Patching child imports"));
    char *desc = child_base + import_rva;
    int total_imports = 0;
    int total_dlls = 0;
    while (1)
    {
        ULONG ilt_rva = 0, name_rva = 0, iat_rva = 0;
        _NtReadVirtualMemory(hProcess, desc + 0,  &ilt_rva,  4, NULL);
        _NtReadVirtualMemory(hProcess, desc + 12, &name_rva, 4, NULL);
        _NtReadVirtualMemory(hProcess, desc + 16, &iat_rva,  4, NULL);
        if (name_rva == 0) break;

        char dll_name[64];
        _NtReadVirtualMemory(hProcess, child_base + name_rva, dll_name, sizeof(dll_name), NULL);
        dll_name[63] = 0;

        HANDLE hDll = GetModuleHandleA(dll_name);
        if (!hDll)
        {
            hDll = LoadLibraryA(dll_name);
        }
        if (!hDll)
        {
            LOG_ERR(_T("Could not load `%s` for child"), dll_name);
            goto cleanup;
        }

        // Walk the lookup table (ILT preferred; falls back to IAT
        // if the linker collapsed them). Each 8-byte entry is
        // either a name-table RVA (low 31 bits) or, with the high
        // bit set, an ordinal in the low 16 bits.
        char *thunk_addr = child_base + (ilt_rva ? ilt_rva : iat_rva);
        char *iat_addr   = child_base + iat_rva;
        int n = 0;
        while (1)
        {
            long long entry = 0;
            _NtReadVirtualMemory(hProcess, thunk_addr, &entry, 8, NULL);
            if (entry == 0) break;

            void *fn_addr = NULL;
            if (entry < 0)
            {
                // Bit 63 set: import by ordinal.
                fn_addr = (void*)GetProcAddress(hDll, (char*)(entry & 0xFFFF));
            }
            else
            {
                // By name: 2-byte hint then null-terminated string.
                char fn_name[128];
                _NtReadVirtualMemory(hProcess,
                    child_base + (entry & 0xFFFFFFFF) + 2,
                    fn_name, sizeof(fn_name), NULL);
                fn_name[127] = 0;
                fn_addr = (void*)GetProcAddress(hDll, fn_name);
            }
            if (!fn_addr)
            {
                LOG_ERR(_T("Failed to resolve an import from `%s`"), dll_name);
                goto cleanup;
            }

            _NtWriteVirtualMemory(hProcess, iat_addr, &fn_addr, 8, NULL);

            thunk_addr += 8;
            iat_addr += 8;
            n++;
        }
        LOG_OK(_T("  %s: %d imports patched"), dll_name, n);
        desc += 20;
        total_dlls++;
        total_imports += n;
    }
    LOG_OK(_T("Patched %d imports across %d DLLs"), total_imports, total_dlls);

    // Compute entry point in the child's address space and start
    // the initial thread there. The kernel's RtlUserThreadStart
    // trampoline invokes StartRoutine(Argument); nt_hello's
    // entry is `void NtProcessStartup(void *Peb)` and ignores
    // its argument, so passing NULL is fine.
    void *entry_point = child_base + entry_rva;
    LOG(_T("Starting child thread at %p"), entry_point);
    status = _NtCreateThreadEx(
        &hThread, THREAD_ALL_ACCESS, NULL, hProcess,
        entry_point, NULL, 0, 0, 0, 0, NULL);
    if (!NT_SUCCESS(status))
    {
        LOG_ERR(_T("NtCreateThreadEx failed: 0x%08lX"), (ULONG)status);
        goto cleanup;
    }
    LOG_OK(_T("Child thread started (handle: %p)"), hThread);

    // Wait for the child to signal the event. A timeout is a hard
    // failure -- the demo's contract is the handshake.
    LOG(_T("Waiting up to 2s for sync event"));
    LARGE_INTEGER timeout;
    timeout.QuadPart = EVENT_WAIT_TIMEOUT_TICKS;
    status = _NtWaitForSingleObject(hEvent, FALSE, &timeout);
    if (status == STATUS_SUCCESS)
    {
        LOG_OK(_T("Sync event received"));
        exitCode = 0;
    }
    else if (status == STATUS_TIMEOUT)
    {
        LOG_ERR(_T("Timed out waiting for sync event"));
    }
    else
    {
        LOG_ERR(_T("NtWaitForSingleObject failed: 0x%08lX"), (ULONG)status);
    }

cleanup:
    LOG(_T("Cleaning up handles"));
    if (hFile != INVALID_HANDLE_VALUE) CloseHandle(hFile);
    if (hTransaction)                  _NtClose(hTransaction);
    if (hSection)                      _NtClose(hSection);
    if (hThread)                       _NtClose(hThread);
    if (hProcess)                      _NtClose(hProcess);
    if (hEvent)                        _NtClose(hEvent);

    LOG(_T("Done (exit code: %d)"), exitCode);
    return exitCode;
}

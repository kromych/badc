// <winternl.h> -- NT-internal types and constants.
//
// UNICODE_STRING, OBJECT_ATTRIBUTES, OBJ_*, NT_SUCCESS,
// NtCurrentProcess, and the EVENT / SECTION / PROCESS /
// TRANSACTION access masks plus selected NTSTATUS values.
// No ntdll bindings: translation units choose between
// static binding (`#pragma binding(ntdll::...)`) and
// `GetProcAddress`.

#pragma once

#include <windows.h>

typedef ULONG ACCESS_MASK;

struct _UNICODE_STRING {
    USHORT Length;          // bytes, excluding the trailing nul
    USHORT MaximumLength;
    PWSTR  Buffer;
};
typedef struct _UNICODE_STRING  UNICODE_STRING;
typedef struct _UNICODE_STRING *PUNICODE_STRING;

struct _OBJECT_ATTRIBUTES {
    ULONG           Length;
    HANDLE          RootDirectory;
    PUNICODE_STRING ObjectName;
    ULONG           Attributes;
    PVOID           SecurityDescriptor;
    PVOID           SecurityQualityOfService;
};
typedef struct _OBJECT_ATTRIBUTES  OBJECT_ATTRIBUTES;
typedef struct _OBJECT_ATTRIBUTES *POBJECT_ATTRIBUTES;

// OBJECT_ATTRIBUTES::Attributes bits.
#define OBJ_INHERIT             0x00000002UL
#define OBJ_PERMANENT           0x00000010UL
#define OBJ_EXCLUSIVE           0x00000020UL
#define OBJ_CASE_INSENSITIVE    0x00000040UL
#define OBJ_OPENIF              0x00000080UL
#define OBJ_OPENLINK            0x00000100UL
#define OBJ_KERNEL_HANDLE       0x00000200UL

// `EVENT_TYPE` enum for `NtCreateEvent`.
#define NOTIFICATION_EVENT      0
#define SYNCHRONIZATION_EVENT   1

// Transaction-manager / process-flag values.
#define TRANSACTION_ALL_ACCESS  0x000F003FUL
#define PS_INHERIT_HANDLES      4

// NTSTATUS values. The full set lives in `<ntstatus.h>`; the
// subset here covers the codes checked at call sites in the
// bundled demos.
#define STATUS_SUCCESS                  ((NTSTATUS)0x00000000L)
#define STATUS_TIMEOUT                  ((NTSTATUS)0x00000102L)
#define STATUS_OBJECT_NAME_NOT_FOUND    ((NTSTATUS)0xC0000034L)

// Severity is encoded in the top two bits; >= 0 covers
// success and informational results.
#define NT_SUCCESS(Status)      ((NTSTATUS)(Status) >= 0)

// Pseudo-handle for the calling process; the kernel maps it
// to the real handle on syscall entry.
#define NtCurrentProcess()      ((HANDLE)(LONG_PTR)-1)

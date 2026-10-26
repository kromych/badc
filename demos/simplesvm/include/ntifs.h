/* <ntifs.h> subset for the SimpleSvm driver: the WDK types, constants,
 * structures and ntoskrnl.exe routines the sources use, declared and
 * bound by name so badc can build the driver without the WDK. Resolved
 * ahead of any bundled header via -I.
 *
 * This is the SimpleSvm analogue of demos/simplevisor's shvos_badc.c:
 * SimpleSvm calls the WDK directly throughout its single source file
 * rather than behind an OS-abstraction contract, so the demo supplies a
 * header rather than an OS layer. It declares the ntoskrnl.exe routines
 * the driver imports and binds them the way demos/wdm_driver does. The
 * produced image is a native-subsystem .sys whose imports resolve
 * against ntoskrnl.exe; the demo builds and inspects it but never loads
 * it (loading a hypervisor on a shared host is out of scope).
 *
 * Structure layouts (CONTEXT, KTRAP_FRAME) follow the documented
 * windows-x64 ABI and carry size/offset asserts so a divergence fails
 * at compile time. */
#pragma once
#include <basetsd.h>
#include <limits.h>
#include <stdarg.h>

/* ---- base type spellings ------------------------------------------- */
#define VOID void
typedef int            LONG;
typedef unsigned char  BOOLEAN;
typedef int            BOOL;
typedef char           CHAR;
typedef void          *PVOID;
typedef char          *PCHAR;
typedef const char    *PCSTR;
typedef const char    *PCCH;
typedef ULONG         *PULONG;
typedef unsigned short *PWSTR;
typedef LONG           NTSTATUS;
typedef UCHAR          KIRQL;

/* ---- decorators and scalar constants ------------------------------- */
#define DECLSPEC_ALIGN(x)  __attribute__((aligned(x)))
#define DECLSPEC_NORETURN  __attribute__((noreturn))
#define NTAPI
#define NOTHING

#define TRUE   1
#define FALSE  0

#define MAXUINT32  0xffffffffU
#define MAXUINT64  0xffffffffffffffffULL
#define ANSI_NULL  ((CHAR)0)

#define PAGE_SIZE   0x1000
#define PAGE_SHIFT  12
#define PAGE_ALIGN(p) ((PVOID)((ULONG_PTR)(p) & ~((ULONG_PTR)PAGE_SIZE - 1)))

/* AMD64 kernel-mode stack size (six pages). */
#define KERNEL_STACK_SIZE  0x6000

#define OBJ_CASE_INSENSITIVE  0x00000040
#define ALL_PROCESSOR_GROUPS  0xffff
#define PASSIVE_LEVEL   0
#define APC_LEVEL       1
#define DISPATCH_LEVEL  2
#define PAGE_READWRITE  0x04
#define MM_ANY_NODE_OK  0x80000000
#define POOL_FLAG_NON_PAGED  0x0000000000000040ULL
#define DrvRtPoolNxOptIn  1
#define DPFLTR_IHVDRIVER_ID  51
#define DPFLTR_ERROR_LEVEL   0
#define PO_CB_SYSTEM_STATE_LOCK  1
#define MANUALLY_INITIATED_CRASH  0xE2

#define STATUS_SUCCESS                 ((NTSTATUS)0x00000000L)
#define STATUS_UNSUCCESSFUL            ((NTSTATUS)0xC0000001L)
#define STATUS_INSUFFICIENT_RESOURCES  ((NTSTATUS)0xC000009AL)
#define STATUS_HV_FEATURE_UNAVAILABLE  ((NTSTATUS)0xC035001EL)

/* ---- integer unions ------------------------------------------------ */
typedef union _LARGE_INTEGER {
    struct { ULONG LowPart; LONG HighPart; };
    INT64 QuadPart;
} LARGE_INTEGER, PHYSICAL_ADDRESS;

typedef union _ULARGE_INTEGER {
    struct { ULONG LowPart; ULONG HighPart; };
    UINT64 QuadPart;
} ULARGE_INTEGER;

/* ---- processor topology -------------------------------------------- */
typedef struct _PROCESSOR_NUMBER {
    USHORT Group;
    UCHAR Number;
    UCHAR Reserved;
} PROCESSOR_NUMBER, *PPROCESSOR_NUMBER;

typedef struct _GROUP_AFFINITY {
    ULONG_PTR Mask;
    USHORT Group;
    USHORT Reserved[3];
} GROUP_AFFINITY, *PGROUP_AFFINITY;

/* ---- CONTEXT (windows-x64 ABI) ------------------------------------- */
typedef struct DECLSPEC_ALIGN(16) _M128A {
    UINT64 Low;
    INT64 High;
} M128A;

typedef struct DECLSPEC_ALIGN(16) _CONTEXT {
    UINT64 P1Home, P2Home, P3Home, P4Home, P5Home, P6Home;  /* 0x000 */
    UINT32 ContextFlags;                                    /* 0x030 */
    UINT32 MxCsr;                                           /* 0x034 */
    UINT16 SegCs, SegDs, SegEs, SegFs, SegGs, SegSs;        /* 0x038 */
    UINT32 EFlags;                                          /* 0x044 */
    UINT64 Dr0, Dr1, Dr2, Dr3, Dr6, Dr7;                    /* 0x048 */
    UINT64 Rax;                                             /* 0x078 */
    UINT64 Rcx, Rdx, Rbx;                                   /* 0x080 */
    UINT64 Rsp;                                             /* 0x098 */
    UINT64 Rbp, Rsi, Rdi;                                   /* 0x0a0 */
    UINT64 R8, R9, R10, R11, R12, R13, R14, R15;            /* 0x0b8 */
    UINT64 Rip;                                             /* 0x0f8 */
    UINT8 FltSave[512];                                     /* 0x100 */
    M128A VectorRegister[26];                               /* 0x300 */
    UINT64 VectorControl;                                   /* 0x4a0 */
    UINT64 DebugControl, LastBranchToRip, LastBranchFromRip;
    UINT64 LastExceptionToRip, LastExceptionFromRip;        /* 0x4d0 */
} CONTEXT, *PCONTEXT;
static_assert(__builtin_offsetof(CONTEXT, SegCs) == 0x38, "CONTEXT.SegCs");
static_assert(__builtin_offsetof(CONTEXT, EFlags) == 0x44, "CONTEXT.EFlags");
static_assert(__builtin_offsetof(CONTEXT, Rsp) == 0x98, "CONTEXT.Rsp");
static_assert(__builtin_offsetof(CONTEXT, Rip) == 0xf8, "CONTEXT.Rip");
static_assert(sizeof(CONTEXT) == 0x4d0, "CONTEXT size");

/* ---- KTRAP_FRAME: only size and Rsp/Rip offsets matter here -------- */
typedef struct _KTRAP_FRAME {
    UINT8 Reserved0[0x168];
    UINT64 Rip;                      /* 0x168 */
    UINT8 Reserved1[0x180 - 0x170];
    UINT64 Rsp;                      /* 0x180 */
    UINT8 Reserved2[0x190 - 0x188];
} KTRAP_FRAME;
static_assert(sizeof(KTRAP_FRAME) == 0x190, "KTRAP_FRAME size");

/* ---- strings, object attributes, bitmap ---------------------------- */
typedef struct _UNICODE_STRING {
    USHORT Length;
    USHORT MaximumLength;
    PWSTR Buffer;
} UNICODE_STRING, *PUNICODE_STRING;

typedef struct _OBJECT_ATTRIBUTES {
    ULONG Length;
    PVOID RootDirectory;
    PUNICODE_STRING ObjectName;
    ULONG Attributes;
    PVOID SecurityDescriptor;
    PVOID SecurityQualityOfService;
} OBJECT_ATTRIBUTES, *POBJECT_ATTRIBUTES;

typedef struct _RTL_BITMAP {
    ULONG SizeOfBitMap;
    PULONG Buffer;
} RTL_BITMAP, *PRTL_BITMAP;

#define RTL_CONSTANT_STRING(s) \
    ((UNICODE_STRING){ (USHORT)(sizeof(s) - sizeof((s)[0])), (USHORT)sizeof(s), (PWSTR)(s) })
#define RTL_CONSTANT_OBJECT_ATTRIBUTES(n, a) \
    ((OBJECT_ATTRIBUTES){ sizeof(OBJECT_ATTRIBUTES), NULL, (n), (a), NULL, NULL })

/* ---- driver object and callback typedefs --------------------------- */
struct _DRIVER_OBJECT;
typedef NTSTATUS DRIVER_INITIALIZE(struct _DRIVER_OBJECT *DriverObject, PUNICODE_STRING RegistryPath);
typedef VOID DRIVER_UNLOAD(struct _DRIVER_OBJECT *DriverObject);
typedef VOID CALLBACK_FUNCTION(PVOID CallbackContext, PVOID Argument1, PVOID Argument2);
typedef CALLBACK_FUNCTION *PCALLBACK_FUNCTION;

/* DRIVER_OBJECT prefix up to DriverUnload; the kernel zero-fills the
 * rest. The offset matches demos/wdm_driver. */
typedef struct _DRIVER_OBJECT {
    char _header_pad[0x68];
    DRIVER_UNLOAD *DriverUnload;
} DRIVER_OBJECT, *PDRIVER_OBJECT;

typedef struct _CALLBACK_OBJECT *PCALLBACK_OBJECT;

/* ---- assertion / annotation macros --------------------------------- */
#define NT_SUCCESS(s)              ((NTSTATUS)(s) >= 0)
#define NT_ASSERT(exp)             ((void)sizeof((exp) ? 1 : 0))
#define NT_VERIFY(exp)             ((void)(exp))
#define UNREFERENCED_PARAMETER(P)  ((void)(P))
#define ARGUMENT_PRESENT(p)        ((p) != NULL)

/* The driver never loads here, so debugger presence is a constant; the
 * SV_DEBUG_BREAK macro then compiles without importing the kernel's
 * KdDebuggerNotPresent data symbol. */
#define KD_DEBUGGER_NOT_PRESENT  (1)

/* ---- memory and segment-limit spellings ---------------------------- */
#define RtlZeroMemory(d, l)     memset((d), 0, (l))
#define RtlCopyMemory(d, s, l)  memcpy((d), (s), (l))
#define GetSegmentLimit(Selector) __segmentlimit((unsigned)(Selector))
#define ObDereferenceObject(o)  ObfDereferenceObject(o)

/* ---- ntoskrnl.exe imports ------------------------------------------ */
#pragma subsystem(driver)
#pragma entrypoint(DriverEntry)

#pragma dylib(ntoskrnl, "ntoskrnl.exe")
#pragma binding(ntoskrnl::ExAllocatePool2, "ExAllocatePool2")
#pragma binding(ntoskrnl::ExFreePoolWithTag, "ExFreePoolWithTag")
#pragma binding(ntoskrnl::MmAllocateContiguousNodeMemory, "MmAllocateContiguousNodeMemory")
#pragma binding(ntoskrnl::MmFreeContiguousMemory, "MmFreeContiguousMemory")
#pragma binding(ntoskrnl::MmGetPhysicalAddress, "MmGetPhysicalAddress")
#pragma binding(ntoskrnl::KeGetCurrentIrql, "KeGetCurrentIrql")
#pragma binding(ntoskrnl::KeRaiseIrqlToDpcLevel, "KeRaiseIrqlToDpcLevel")
#pragma binding(ntoskrnl::KeLowerIrql, "KeLowerIrql")
#pragma binding(ntoskrnl::KeBugCheck, "KeBugCheck")
#pragma binding(ntoskrnl::KeQueryActiveProcessorCountEx, "KeQueryActiveProcessorCountEx")
#pragma binding(ntoskrnl::KeGetProcessorNumberFromIndex, "KeGetProcessorNumberFromIndex")
#pragma binding(ntoskrnl::KeSetSystemGroupAffinityThread, "KeSetSystemGroupAffinityThread")
#pragma binding(ntoskrnl::KeRevertToUserGroupAffinityThread, "KeRevertToUserGroupAffinityThread")
#pragma binding(ntoskrnl::RtlCaptureContext, "RtlCaptureContext")
#pragma binding(ntoskrnl::RtlInitializeBitMap, "RtlInitializeBitMap")
#pragma binding(ntoskrnl::RtlClearAllBits, "RtlClearAllBits")
#pragma binding(ntoskrnl::RtlSetBits, "RtlSetBits")
#pragma binding(ntoskrnl::ExInitializeDriverRuntime, "ExInitializeDriverRuntime")
#pragma binding(ntoskrnl::ExCreateCallback, "ExCreateCallback")
#pragma binding(ntoskrnl::ExRegisterCallback, "ExRegisterCallback")
#pragma binding(ntoskrnl::ExUnregisterCallback, "ExUnregisterCallback")
#pragma binding(ntoskrnl::ObfDereferenceObject, "ObfDereferenceObject")
#pragma binding(ntoskrnl::vDbgPrintExWithPrefix, "vDbgPrintExWithPrefix")
#pragma binding(ntoskrnl::strcmp, "strcmp")
#pragma binding(ntoskrnl::memset, "memset")
#pragma binding(ntoskrnl::memcpy, "memcpy")

PVOID ExAllocatePool2(UINT64 Flags, SIZE_T NumberOfBytes, ULONG Tag);
VOID ExFreePoolWithTag(PVOID P, ULONG Tag);
PVOID MmAllocateContiguousNodeMemory(SIZE_T NumberOfBytes,
                                     PHYSICAL_ADDRESS LowestAcceptable,
                                     PHYSICAL_ADDRESS HighestAcceptable,
                                     PHYSICAL_ADDRESS BoundaryAddressMultiple,
                                     ULONG Protect, ULONG PreferredNode);
VOID MmFreeContiguousMemory(PVOID BaseAddress);
PHYSICAL_ADDRESS MmGetPhysicalAddress(PVOID BaseAddress);
KIRQL KeGetCurrentIrql(VOID);
KIRQL KeRaiseIrqlToDpcLevel(VOID);
VOID KeLowerIrql(KIRQL NewIrql);
DECLSPEC_NORETURN VOID KeBugCheck(ULONG BugCheckCode);
ULONG KeQueryActiveProcessorCountEx(USHORT GroupNumber);
NTSTATUS KeGetProcessorNumberFromIndex(ULONG ProcIndex, PPROCESSOR_NUMBER ProcNumber);
VOID KeSetSystemGroupAffinityThread(PGROUP_AFFINITY Affinity, PGROUP_AFFINITY PreviousAffinity);
VOID KeRevertToUserGroupAffinityThread(PGROUP_AFFINITY PreviousAffinity);
VOID RtlCaptureContext(PCONTEXT ContextRecord);
VOID RtlInitializeBitMap(PRTL_BITMAP BitMapHeader, PULONG BitMapBuffer, ULONG SizeOfBitMap);
VOID RtlClearAllBits(PRTL_BITMAP BitMapHeader);
VOID RtlSetBits(PRTL_BITMAP BitMapHeader, ULONG StartingIndex, ULONG NumberToSet);
VOID ExInitializeDriverRuntime(ULONG RuntimeFlags);
NTSTATUS ExCreateCallback(PCALLBACK_OBJECT *CallbackObject, POBJECT_ATTRIBUTES ObjectAttributes,
                          BOOLEAN Create, BOOLEAN AllowMultipleCallbacks);
PVOID ExRegisterCallback(PCALLBACK_OBJECT CallbackObject, PCALLBACK_FUNCTION CallbackFunction,
                         PVOID CallbackContext);
VOID ExUnregisterCallback(PVOID CallbackRegistration);
VOID ObfDereferenceObject(PVOID Object);
NTSTATUS vDbgPrintExWithPrefix(PCCH Prefix, ULONG ComponentId, ULONG Level, PCCH Format, va_list arglist);
int strcmp(const char *a, const char *b);
void *memset(void *Dst, int Val, SIZE_T Count);
void *memcpy(void *Dst, const void *Src, SIZE_T Count);

/* Windows OS layer for the SimpleVisor demo.
 *
 * SimpleVisor abstracts every platform service behind the ShvOs*
 * contract declared in shv.h / shv_x.h; upstream ships an NT layer
 * (nt/shvos.c) built against the WDK and a UEFI layer (uefi/shvos.c).
 * badc bundles no WDK headers, so this file is a demo-local NT layer:
 * it declares the handful of ntoskrnl.exe kernel routines it calls and
 * binds them by name, the way demos/wdm_driver declares what it uses.
 * The produced image is a native-subsystem .sys whose imports resolve
 * against ntoskrnl.exe; the demo builds and inspects it but never loads
 * it (loading a hypervisor on a shared host is out of scope).
 *
 * It differs from the upstream NT layer in one respect: the power-state
 * callback that reloads the hypervisor across sleep transitions is
 * omitted, since nothing here loads the driver. The memory, DPC and
 * processor-topology services the core VMX code calls are faithful. */
#include "shv.h"
#include <stdarg.h>

#pragma subsystem(driver)
#pragma entrypoint(DriverEntry)

typedef long NTSTATUS;
typedef int LOGICAL;
typedef void *PVOID;
typedef const char *PCCH;

#define STATUS_SUCCESS                ((NTSTATUS)0x00000000L)
#define STATUS_UNSUCCESSFUL           ((NTSTATUS)0xC0000001L)
#define STATUS_HV_NOT_PRESENT         ((NTSTATUS)0xC0351000L)
#define STATUS_HV_FEATURE_UNAVAILABLE ((NTSTATUS)0xC035001EL)
#define STATUS_HV_NO_RESOURCES        ((NTSTATUS)0xC0350005L)
#define NT_SUCCESS(s)                 ((NTSTATUS)(s) >= 0)

/* PAGE_READWRITE and the all-groups / debug-filter selectors the calls
 * below take as plain scalars. */
#define PAGE_READWRITE          0x04
#define ALL_PROCESSOR_GROUPS    0xFFFF
#define DPFLTR_IHVDRIVER_ID     51
#define DPFLTR_ERROR_LEVEL      0

/* 64-bit physical address, returned and taken by value (8 bytes, passed
 * in a register under the MS x64 ABI). */
typedef union _PHYSICAL_ADDRESS {
    UINT64 QuadPart;
} PHYSICAL_ADDRESS;

/* A deferred procedure call object is reached only by pointer here. */
struct _KDPC;
typedef void (*PKDEFERRED_ROUTINE)(struct _KDPC *Dpc, void *DeferredContext,
                                   void *SystemArgument1, void *SystemArgument2);

/* DRIVER_OBJECT prefix up to DriverUnload; the kernel zero-fills the
 * rest. The offset matches demos/wdm_driver. */
struct _DRIVER_OBJECT {
    char _header_pad[0x68];
    void (*DriverUnload)(struct _DRIVER_OBJECT *DriverObject);
};
typedef struct _DRIVER_OBJECT *PDRIVER_OBJECT;

struct _UNICODE_STRING;
typedef struct _UNICODE_STRING *PUNICODE_STRING;

#pragma dylib(ntoskrnl, "ntoskrnl.exe")
#pragma binding(ntoskrnl::KeGenericCallDpc, "KeGenericCallDpc")
#pragma binding(ntoskrnl::KeSignalCallDpcDone, "KeSignalCallDpcDone")
#pragma binding(ntoskrnl::KeSignalCallDpcSynchronize, "KeSignalCallDpcSynchronize")
#pragma binding(ntoskrnl::KeGetCurrentProcessorNumberEx, "KeGetCurrentProcessorNumberEx")
#pragma binding(ntoskrnl::KeQueryActiveProcessorCountEx, "KeQueryActiveProcessorCountEx")
#pragma binding(ntoskrnl::KeGetCurrentNodeNumber, "KeGetCurrentNodeNumber")
#pragma binding(ntoskrnl::MmAllocateContiguousNodeMemory, "MmAllocateContiguousNodeMemory")
#pragma binding(ntoskrnl::MmFreeContiguousMemory, "MmFreeContiguousMemory")
#pragma binding(ntoskrnl::MmGetPhysicalAddress, "MmGetPhysicalAddress")
#pragma binding(ntoskrnl::RtlCaptureContext, "RtlCaptureContext")
#pragma binding(ntoskrnl::vDbgPrintEx, "vDbgPrintEx")

VOID KeGenericCallDpc(PKDEFERRED_ROUTINE Routine, PVOID Context);
VOID KeSignalCallDpcDone(PVOID SystemArgument1);
LOGICAL KeSignalCallDpcSynchronize(PVOID SystemArgument2);
ULONG KeGetCurrentProcessorNumberEx(PVOID ProcNumber);
ULONG KeQueryActiveProcessorCountEx(USHORT GroupNumber);
USHORT KeGetCurrentNodeNumber(VOID);
PVOID MmAllocateContiguousNodeMemory(SIZE_T NumberOfBytes,
                                     PHYSICAL_ADDRESS LowestAcceptable,
                                     PHYSICAL_ADDRESS HighestAcceptable,
                                     PHYSICAL_ADDRESS BoundaryAddressMultiple,
                                     ULONG Protect, ULONG PreferredNode);
VOID MmFreeContiguousMemory(PVOID BaseAddress);
PHYSICAL_ADDRESS MmGetPhysicalAddress(PVOID BaseAddress);
VOID RtlCaptureContext(PCONTEXT ContextRecord);
int vDbgPrintEx(ULONG ComponentId, ULONG Level, PCCH Format, va_list Args);

/* The ShvVmxEntry stub (shvasm_x64.c) tail-calls this handler. */
VOID ShvVmxEntryHandler(VOID);
VOID ShvVmxCleanup(UINT16 Data, UINT16 Teb);
struct _EXCEPTION_RECORD;
VOID ShvOsRestoreContext2(PCONTEXT ContextRecord,
                          struct _EXCEPTION_RECORD *ExceptionRecord);

PSHV_VP_DATA *ShvGlobalData;

#define KGDT64_R3_DATA  0x28
#define KGDT64_R3_CMTEB 0x50

typedef struct _SHV_DPC_CONTEXT {
    PSHV_CPU_CALLBACK Routine;
    struct _SHV_CALLBACK_CONTEXT *Context;
} SHV_DPC_CONTEXT, *PSHV_DPC_CONTEXT;

static NTSTATUS ShvOsErrorToError(INT32 Error) {
    if (Error == SHV_STATUS_NOT_AVAILABLE) return STATUS_HV_FEATURE_UNAVAILABLE;
    if (Error == SHV_STATUS_NO_RESOURCES) return STATUS_HV_NO_RESOURCES;
    if (Error == SHV_STATUS_NOT_PRESENT) return STATUS_HV_NOT_PRESENT;
    if (Error == SHV_STATUS_SUCCESS) return STATUS_SUCCESS;
    return STATUS_UNSUCCESSFUL;
}

static VOID ShvOsDpcRoutine(struct _KDPC *Dpc, PVOID DeferredContext,
                            PVOID SystemArgument1, PVOID SystemArgument2) {
    PSHV_DPC_CONTEXT dpcContext = DeferredContext;
    (void)Dpc;
    dpcContext->Routine(dpcContext->Context);
    /* RtlRestoreContext's iretq strips the RPL bits off DS/ES/FS;
     * restore them so a WoW64 thread does not fault after the switch. */
    ShvVmxCleanup(KGDT64_R3_DATA | RPL_MASK, KGDT64_R3_CMTEB | RPL_MASK);
    KeSignalCallDpcSynchronize(SystemArgument2);
    KeSignalCallDpcDone(SystemArgument1);
}

INT32 ShvOsPrepareProcessor(PSHV_VP_DATA VpData) {
    (void)VpData;
    return SHV_STATUS_SUCCESS;
}

VOID ShvOsUnprepareProcessor(PSHV_VP_DATA VpData) {
    /* VMX root mode leaves the GDTR/IDTR limits at 0xFFFF; restore the
     * captured descriptors so integrity checks do not trip. */
    __lgdt(&VpData->SpecialRegisters.Gdtr.Limit);
    __lidt(&VpData->SpecialRegisters.Idtr.Limit);
}

VOID ShvOsFreeContiguousAlignedMemory(VOID *BaseAddress, size_t Size) {
    (void)Size;
    MmFreeContiguousMemory(BaseAddress);
}

VOID *ShvOsAllocateContigousAlignedMemory(size_t Size) {
    PHYSICAL_ADDRESS lowest, highest;
    lowest.QuadPart = 0;
    highest.QuadPart = (UINT64)-1;
    return MmAllocateContiguousNodeMemory(Size, lowest, highest, lowest,
                                          PAGE_READWRITE, KeGetCurrentNodeNumber());
}

UINT64 ShvOsGetPhysicalAddress(VOID *BaseAddress) {
    return MmGetPhysicalAddress(BaseAddress).QuadPart;
}

VOID ShvOsRunCallbackOnProcessors(PSHV_CPU_CALLBACK Routine, VOID *Context) {
    SHV_DPC_CONTEXT dpcContext;
    dpcContext.Routine = Routine;
    dpcContext.Context = Context;
    KeGenericCallDpc(ShvOsDpcRoutine, &dpcContext);
}

VOID ShvOsRestoreContext(PCONTEXT ContextRecord) {
    ShvOsRestoreContext2(ContextRecord, NULL);
}

VOID ShvOsCaptureContext(PCONTEXT ContextRecord) {
    RtlCaptureContext(ContextRecord);
}

INT32 ShvOsGetCurrentProcessorNumber(VOID) {
    return (INT32)KeGetCurrentProcessorNumberEx(NULL);
}

INT32 ShvOsGetActiveProcessorCount(VOID) {
    return (INT32)KeQueryActiveProcessorCountEx(ALL_PROCESSOR_GROUPS);
}

VOID ShvOsDebugPrint(const char *Format, ...) {
    va_list arglist;
    va_start(arglist, Format);
    vDbgPrintEx(DPFLTR_IHVDRIVER_ID, DPFLTR_ERROR_LEVEL, Format, arglist);
    va_end(arglist);
}

static void DriverUnload(struct _DRIVER_OBJECT *DriverObject) {
    (void)DriverObject;
    ShvUnload();
}

NTSTATUS DriverEntry(struct _DRIVER_OBJECT *DriverObject, PUNICODE_STRING RegistryPath) {
    (void)RegistryPath;
    DriverObject->DriverUnload = DriverUnload;
    return ShvOsErrorToError(ShvLoad());
}

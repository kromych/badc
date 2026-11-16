/* The WDM driver skeleton written against the Windows Driver Kit: <wdm.h>
 * declares the kernel API and the WDK's ntoskrnl.lib names the image the
 * imports bind to. Built with `--subsystem=driver --entry=DriverEntry`, as
 * link.exe builds a driver with /DRIVER and /ENTRY. smoke.py builds it with
 * `--wdk`; loading it needs test signing. */
#include <wdm.h>

DRIVER_INITIALIZE DriverEntry;
static DRIVER_UNLOAD DriverUnload;

static VOID DriverUnload(PDRIVER_OBJECT DriverObject) {
    UNREFERENCED_PARAMETER(DriverObject);
    DbgPrintEx(DPFLTR_IHVDRIVER_ID, DPFLTR_INFO_LEVEL, "badc WDK driver: unloaded\n");
}

NTSTATUS DriverEntry(PDRIVER_OBJECT DriverObject, PUNICODE_STRING RegistryPath) {
    UNREFERENCED_PARAMETER(RegistryPath);
    DriverObject->DriverUnload = DriverUnload;
    DbgPrintEx(DPFLTR_IHVDRIVER_ID, DPFLTR_INFO_LEVEL, "badc WDK driver: loaded\n");
    return STATUS_SUCCESS;
}

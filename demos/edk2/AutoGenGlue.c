/* Hand-written stand-in for per-module AutoGen.c. */
#include <Uefi.h>
#pragma subsystem(efi_application)
#pragma entrypoint(_ModuleEntryPoint)

const UINT32 _gUefiDriverRevision = 0;

EFI_STATUS EFIAPI UefiMain(EFI_HANDLE, EFI_SYSTEM_TABLE *);
EFI_STATUS EFIAPI UefiBootServicesTableLibConstructor(EFI_HANDLE, EFI_SYSTEM_TABLE *);
EFI_STATUS EFIAPI UefiRuntimeServicesTableLibConstructor(EFI_HANDLE, EFI_SYSTEM_TABLE *);

VOID EFIAPI ProcessLibraryConstructorList(EFI_HANDLE ImageHandle, EFI_SYSTEM_TABLE *SystemTable) {
    UefiBootServicesTableLibConstructor(ImageHandle, SystemTable);
    UefiRuntimeServicesTableLibConstructor(ImageHandle, SystemTable);
}
EFI_STATUS EFIAPI ProcessModuleEntryPointList(EFI_HANDLE ImageHandle, EFI_SYSTEM_TABLE *SystemTable) {
    return UefiMain(ImageHandle, SystemTable);
}
VOID EFIAPI ProcessLibraryDestructorList(EFI_HANDLE ImageHandle, EFI_SYSTEM_TABLE *SystemTable) {
    (void)ImageHandle; (void)SystemTable;
}

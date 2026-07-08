#include <Uefi.h>
#include <Library/PrintLib.h>
#include <Library/BaseLib.h>
EFI_STATUS EFIAPI UefiMain(EFI_HANDLE ImageHandle, EFI_SYSTEM_TABLE *SystemTable) {
    (void)ImageHandle;
    CHAR16 buf[192];
    MemoryFence(); /* real BaseLib AArch64 .S (dmb sy), assembled by clang */
    UnicodeSPrint(buf, sizeof(buf),
        L"badc+EDK2 arm64: MemoryFence() [clang .S] ok, 0x%08x + %d = %d\r\n", 0x1000, 34, 0x1000 + 34);
    SystemTable->ConOut->OutputString(SystemTable->ConOut, buf);
    SystemTable->ConOut->OutputString(SystemTable->ConOut,
        L"AArch64 .S assembled by clang, linked into PE by badc\r\n");
    return EFI_SUCCESS;
}

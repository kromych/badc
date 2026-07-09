#include <Uefi.h>
#include <Library/PrintLib.h>
EFI_STATUS EFIAPI UefiMain(EFI_HANDLE ImageHandle, EFI_SYSTEM_TABLE *SystemTable) {
    (void)ImageHandle;
    CHAR16 buf[160];
    /* Exercise real PrintLib formatting: hex, signed decimal, width. */
    UnicodeSPrint(buf, sizeof(buf),
        L"badc+EDK2: PrintLib says 0x%08x + %d = %d\r\n", 0x1000, 34, 0x1000 + 34);
    SystemTable->ConOut->OutputString(SystemTable->ConOut, buf);
    UnicodeSPrint(buf, sizeof(buf), L"%s build via badc own-linker OK\r\n", L"MdePkg");
    SystemTable->ConOut->OutputString(SystemTable->ConOut, buf);
    return EFI_SUCCESS;
}

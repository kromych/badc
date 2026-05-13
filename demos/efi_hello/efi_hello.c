/* Minimal UEFI application.
 *
 * Pragmas:
 *   #pragma subsystem(efi_application) -- PE optional-header
 *     Subsystem = IMAGE_SUBSYSTEM_EFI_APPLICATION (10).
 *   #pragma entrypoint(efi_main) -- the PE writer treats EFI
 *     and NT subsystems as passthrough: AddressOfEntryPoint
 *     targets `efi_main` directly with no CRT shim and no
 *     msvcrt import.
 *
 * Build:
 *
 *     badc --target=windows-x64 demos/efi_hello/efi_hello.c -o efi_hello.efi
 *
 * Run on any UEFI shell (TianoCore's UEFI Shell, OVMF under
 * qemu, the firmware shell on a real machine):
 *
 *     fs0:\> efi_hello.efi
 *     Hello, EFI!
 *
 * UEFI has no DLLs and no syscalls -- every service is reached
 * by following function pointers in `EFI_SYSTEM_TABLE`. The
 * declarations below carry the minimum to call
 * `ConOut->OutputString`. A bundled `<efi.h>` is tracked in
 * gh #78. */

#pragma subsystem(efi_application)
#pragma entrypoint(efi_main)

/* --- EFI core typedefs --- */
typedef unsigned long long UINTN;
typedef unsigned long long EFI_STATUS;
typedef void *EFI_HANDLE;
typedef unsigned short CHAR16;

#define EFI_SUCCESS 0

/* `EFI_SIMPLE_TEXT_OUTPUT_PROTOCOL`: ten function-pointer slots
 * per the UEFI spec. Only `OutputString` (slot 1) is used; the
 * other slots stay `void *` so the offsets stay correct without
 * pulling in additional signatures. */
struct EFI_SIMPLE_TEXT_OUTPUT_PROTOCOL {
    void      *Reset;
    EFI_STATUS (*OutputString)(struct EFI_SIMPLE_TEXT_OUTPUT_PROTOCOL *This,
                               CHAR16 *String);
    void      *TestString;
    void      *QueryMode;
    void      *SetMode;
    void      *SetAttribute;
    void      *ClearScreen;
    void      *SetCursorPosition;
    void      *EnableCursor;
    void      *Mode;
};

/* `EFI_SYSTEM_TABLE` prefix up to `ConOut`. Fields past ConOut
 * (StdErr, RuntimeServices, BootServices, ...) are unused. */
struct EFI_TABLE_HEADER {
    unsigned long long Signature;
    unsigned int       Revision;
    unsigned int       HeaderSize;
    unsigned int       CRC32;
    unsigned int       Reserved;
};

struct EFI_SYSTEM_TABLE {
    struct EFI_TABLE_HEADER Hdr;
    CHAR16                 *FirmwareVendor;
    unsigned int            FirmwareRevision;
    EFI_HANDLE              ConsoleInHandle;
    void                   *ConIn;
    EFI_HANDLE              ConsoleOutHandle;
    struct EFI_SIMPLE_TEXT_OUTPUT_PROTOCOL *ConOut;
};

/* "Hello, EFI!\r\n" as a CHAR16 array; c5 does not yet parse the
 * `L"..."` wide-string literal syntax. CRLF matches what most
 * UEFI shells expect. */
static CHAR16 kHello[] = {
    'H', 'e', 'l', 'l', 'o', ',', ' ',
    'E', 'F', 'I', '!', '\r', '\n', 0
};

EFI_STATUS efi_main(EFI_HANDLE ImageHandle,
                    struct EFI_SYSTEM_TABLE *SystemTable) {
    (void)ImageHandle;
    SystemTable->ConOut->OutputString(SystemTable->ConOut, kHello);
    return EFI_SUCCESS;
}

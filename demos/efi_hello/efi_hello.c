/* Minimal UEFI "Hello, world!" application.
 *
 * Demonstrates the freestanding PE flavour that landed alongside
 * the WinMain stub work:
 *
 *   * `#pragma subsystem(efi_application)` -- PE optional-header
 *     Subsystem becomes IMAGE_SUBSYSTEM_EFI_APPLICATION (10).
 *     The firmware loader recognises the image as a UEFI app
 *     (vs. a Windows binary it would refuse to launch).
 *   * `#pragma entrypoint(efi_main)` -- the entry symbol is
 *     `efi_main` instead of `main`. The badc PE writer treats
 *     EFI / NT subsystems as passthrough: AddressOfEntryPoint
 *     points straight at `efi_main`, no CRT shim is wedged in
 *     front, and no `msvcrt` import is added (which would
 *     prevent the firmware loader from launching the binary --
 *     UEFI knows nothing about msvcrt).
 *
 * Build:
 *
 *     badc --target=windows-x64 demos/efi_hello/efi_hello.c -o efi_hello.efi
 *
 * Run (any UEFI shell -- TianoCore's UEFI Shell, an OVMF guest
 * under qemu, or a real machine booted to the firmware shell):
 *
 *     fs0:\> efi_hello.efi
 *     Hello, EFI!
 *
 * Why so much boilerplate -- UEFI is pure-pointer-soup: there
 * are no DLLs to bind, no syscalls; every service is reached
 * by chasing function pointers through `EFI_SYSTEM_TABLE`. The
 * declarations below carry the minimum subset to call
 * `ConOut->OutputString`. Real applications would `#include
 * <efi.h>` once the bundled freestanding headers land
 * (gh #78). */

#pragma subsystem(efi_application)
#pragma entrypoint(efi_main)

/* --- EFI core typedefs --- */
typedef unsigned long long UINTN;
typedef unsigned long long EFI_STATUS;
typedef void *EFI_HANDLE;
typedef unsigned short CHAR16;

#define EFI_SUCCESS 0

/* `EFI_SIMPLE_TEXT_OUTPUT_PROTOCOL` -- 10 function-pointer
 * slots. We only call `OutputString` (slot 1); the others are
 * placeholders so the offsets line up with the UEFI spec.
 * `void *` slots are deliberately untyped so we don't have to
 * pull in their signatures just to skip past them. */
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

/* `EFI_TABLE_HEADER` and the first few SystemTable fields up to
 * `ConOut`. Beyond ConOut sits ConsoleErrorHandle / StdErr /
 * RuntimeServices / BootServices / NumTableEntries /
 * ConfigurationTable -- none of which this demo touches. */
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
    /* ... more fields follow; we stop here because the demo
     * doesn't reference any. */
};

/* `L"Hello, EFI!\r\n"` -- spelled out as a CHAR16 array because
 * c5 doesn't (yet) recognise the `L"..."` wide-string literal
 * syntax. CRLF matches the firmware's expectations on most
 * UEFI shells; a bare LF prints but doesn't return to column 0. */
static CHAR16 kHello[] = {
    'H', 'e', 'l', 'l', 'o', ',', ' ',
    'E', 'F', 'I', '!', '\r', '\n', 0
};

EFI_STATUS efi_main(EFI_HANDLE ImageHandle,
                    struct EFI_SYSTEM_TABLE *SystemTable) {
    (void)ImageHandle;
    /* Standard UEFI ABI -- the firmware loader calls
     * `efi_main(EFI_HANDLE, EFI_SYSTEM_TABLE *)` with
     * Microsoft-x64 / AAPCS64 calling conventions, the same
     * ABI c5 generates for Windows PEs. The `Subsystem` byte
     * in the PE optional header is the only thing
     * distinguishing this image from a regular Win32 exe. */
    SystemTable->ConOut->OutputString(SystemTable->ConOut, kHello);
    return EFI_SUCCESS;
}

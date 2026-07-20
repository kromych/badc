/* A small freestanding "kernel": a UEFI application that badc compiles for
 * x86_64 and AArch64 and that boots under QEMU through UEFI firmware. It runs
 * before any OS, talks only to the firmware console (mirrored to the serial
 * line), and exercises inline assembly on each architecture so the boot is a
 * live end-to-end test of badc's inline-asm support:
 *
 *   x86_64  -- `cpuid` reads the processor vendor string; a `bswap` through the
 *              table-driven encoder byte-reverses a known value; a raw-byte NOP.
 *   AArch64 -- `mrs` reads a system register (CTR_EL0); a raw-byte NOP spelled
 *              both as a `.byte` directive and as a bare hex-byte run.
 *
 * The printed results are deterministic where the value is (the byte-reversed
 * constant, the static markers), so demos/kernel/smoke.py can assert on them.
 *
 * Build:  badc --target=windows-x64   demos/kernel/kernel.c -o kernel-x64.efi
 *         badc --target=windows-arm64 demos/kernel/kernel.c -o kernel-arm64.efi
 * Run:    python3 demos/kernel/smoke.py
 */

#pragma subsystem(efi_application)
#pragma entrypoint(efi_main)

typedef unsigned long long UINTN;
typedef unsigned long long EFI_STATUS;
typedef void *EFI_HANDLE;
typedef unsigned short CHAR16;

#define EFI_SUCCESS 0

/* Ten function-pointer slots per the UEFI spec; only OutputString (slot 1) is
 * used, the rest stay `void *` so the offsets are correct. */
struct EFI_SIMPLE_TEXT_OUTPUT_PROTOCOL {
    void *Reset;
    EFI_STATUS (*OutputString)(struct EFI_SIMPLE_TEXT_OUTPUT_PROTOCOL *This,
                               CHAR16 *String);
    void *TestString;
    void *QueryMode;
    void *SetMode;
    void *SetAttribute;
    void *ClearScreen;
    void *SetCursorPosition;
    void *EnableCursor;
    void *Mode;
};

struct EFI_TABLE_HEADER {
    unsigned long long Signature;
    unsigned int Revision;
    unsigned int HeaderSize;
    unsigned int CRC32;
    unsigned int Reserved;
};

struct EFI_SYSTEM_TABLE {
    struct EFI_TABLE_HEADER Hdr;
    CHAR16 *FirmwareVendor;
    unsigned int FirmwareRevision;
    EFI_HANDLE ConsoleInHandle;
    void *ConIn;
    EFI_HANDLE ConsoleOutHandle;
    struct EFI_SIMPLE_TEXT_OUTPUT_PROTOCOL *ConOut;
};

static struct EFI_SIMPLE_TEXT_OUTPUT_PROTOCOL *g_out;

/* Print an ASCII string widened to CHAR16 (c5 does not parse `L"..."`). */
static void print(const char *s) {
    CHAR16 buf[160];
    int i = 0;
    while (s[i] && i < 159) {
        buf[i] = (CHAR16)(unsigned char)s[i];
        i++;
    }
    buf[i] = 0;
    g_out->OutputString(g_out, buf);
}

static void print_hex(unsigned long long v) {
    static const char digits[] = "0123456789abcdef";
    CHAR16 buf[19];
    buf[0] = '0';
    buf[1] = 'x';
    for (int i = 0; i < 16; i++) {
        buf[2 + i] = (CHAR16)(unsigned char)digits[(v >> ((15 - i) * 4)) & 0xf];
    }
    buf[18] = 0;
    g_out->OutputString(g_out, buf);
}

static void newline(void) {
    print("\r\n");
}

EFI_STATUS efi_main(EFI_HANDLE ImageHandle, struct EFI_SYSTEM_TABLE *SystemTable) {
    (void)ImageHandle;
    g_out = SystemTable->ConOut;

    print("badc kernel: hello");
    newline();

#if defined(__x86_64__)
    /* CPUID leaf 0: the vendor string arrives in EBX, EDX, ECX (12 chars). */
    unsigned int a, b, c, d;
    __asm__("cpuid" : "=a"(a), "=b"(b), "=c"(c), "=d"(d) : "a"(0u), "c"(0u));
    char vendor[13];
    unsigned int words[3] = {b, d, c};
    for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 4; j++) {
            vendor[i * 4 + j] = (char)((words[i] >> (j * 8)) & 0xff);
        }
    }
    vendor[12] = 0;
    print("cpuid vendor: ");
    print(vendor);
    newline();

    /* bswap through the table-driven encoder: a deterministic byte reversal. */
    unsigned long long x = 0x0102030405060708ull;
    __asm__("bswapq %0" : "+r"(x));
    print("bswap: ");
    print_hex(x);
    newline();

    /* Raw machine bytes: a NOP spelled as a `.byte` directive. */
    __asm__ volatile(".byte 0x90" ::: "memory");
    print("rawbyte: ok");
    newline();
#elif defined(__aarch64__)
    /* MRS reads a system register; CTR_EL0 (cache type) is readable at EL1. */
    unsigned long long ctr;
    __asm__("mrs %0, ctr_el0" : "=r"(ctr));
    print("ctr_el0: ");
    print_hex(ctr);
    newline();

    /* Raw machine bytes: an AArch64 NOP (0xD503201F) as a `.byte` directive and
     * as a bare hex-byte run. */
    __asm__ volatile(".byte 0x1f, 0x20, 0x03, 0xd5" ::: "memory");
    __asm__ volatile("1f 20 03 d5");
    print("rawbyte: ok");
    newline();
#endif

    print("BADC-KERNEL-OK");
    newline();
    return EFI_SUCCESS;
}

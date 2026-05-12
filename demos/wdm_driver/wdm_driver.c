/* Minimal Windows kernel-mode driver skeleton (WDM-flavoured).
 *
 * Demonstrates building a `.sys`-shaped PE that:
 *
 *   * Carries the `IMAGE_SUBSYSTEM_NATIVE` (1) Subsystem byte
 *     via `#pragma subsystem(driver)` -- an alias for
 *     `native`. The kernel's PE loader treats a driver as a
 *     loadable module rather than a Win32 process and refuses
 *     to load anything with `WINDOWS_CUI` / `WINDOWS_GUI`.
 *   * Uses `#pragma entrypoint(DriverEntry)` -- the kernel
 *     calls the entry with the WDM `(PDRIVER_OBJECT,
 *     PUNICODE_STRING)` signature. The badc PE writer's
 *     passthrough path leaves `AddressOfEntryPoint` pointing
 *     directly at `DriverEntry`; no CRT shim is wedged in
 *     between (the kernel has no msvcrt to begin with).
 *   * Imports the minimum from `ntoskrnl.exe`. A real driver
 *     would pull in `IoCreateDevice`, `IoCreateSymbolicLink`,
 *     etc.; this skeleton only registers `DRIVER_UNLOAD` so
 *     the driver is dynamically unloadable via `sc stop`.
 *
 * Build:
 *
 *     badc --target=windows-x64 demos/wdm_driver/wdm_driver.c -o wdm_hello.sys
 *
 * Load (Windows host, elevated, test-signing on so an
 * unsigned driver can load):
 *
 *     bcdedit /set testsigning on   (then reboot)
 *     sc create wdm_hello type= kernel binPath= C:\path\wdm_hello.sys
 *     sc start wdm_hello            (DriverEntry runs)
 *     sc stop  wdm_hello            (DRIVER_UNLOAD runs)
 *     sc delete wdm_hello
 *
 * The demo is build-only in CI -- loading a kernel driver
 * requires admin rights, a signed image (or test-signing
 * mode), and a host willing to reboot. The point of the
 * skeleton is to verify the PE shape the kernel loader
 * expects; once a kernel-test harness is available the
 * skeleton can grow into something that pings WPP / ETW. */

#pragma subsystem(driver)
#pragma entrypoint(DriverEntry)

#pragma dylib(ntoskrnl, "ntoskrnl.exe")
/* No imports needed for this skeleton -- DriverEntry +
 * DRIVER_UNLOAD by themselves don't touch any kernel API.
 * Real drivers would `#pragma binding(ntoskrnl::IoCreateDevice,
 * "IoCreateDevice")` and friends here. */

typedef long  NTSTATUS;
typedef void *PVOID;

/* `STATUS_SUCCESS` -- canonical 0 return. NTSTATUS encodes a
 * severity / facility / code triple; 0 means "no error,
 * informational severity, facility = null". */
#define STATUS_SUCCESS ((NTSTATUS)0)

/* `UNICODE_STRING` -- a length + maximum-length + buffer
 * triple; the kernel uses this everywhere a Win32 API would
 * take a `LPWSTR`. `Length` is in bytes, NOT in CHAR16 units,
 * and excludes a null terminator (which UNICODE_STRINGs do
 * not require). */
struct UNICODE_STRING {
    unsigned short  Length;
    unsigned short  MaximumLength;
    unsigned short *Buffer;
};

/* `DRIVER_OBJECT` -- the kernel hands DriverEntry a pointer
 * to one of these. We only touch `DriverUnload`; the major
 * function dispatch table, fast I/O dispatch, and friends
 * stay zero-initialised by the kernel, which is exactly the
 * right behaviour for a driver that has no devices yet. */
struct DRIVER_OBJECT {
    /* The header preceding the field we care about is ~0x68
     * bytes; spelling out every byte would just be padding
     * we don't use. The field offsets in the kernel's
     * `_DRIVER_OBJECT` are stable across Windows versions
     * because so much third-party code depends on them. */
    char _header_pad[0x68];
    void (*DriverUnload)(struct DRIVER_OBJECT *DriverObject);
    /* ... DriverInit / DriverStartIo / DriverName / etc. follow */
};

/* `DRIVER_UNLOAD` callback. The kernel invokes this when the
 * Service Control Manager (or another component holding a
 * reference) asks the driver to unload. By the time we
 * return, every reference to anything this driver allocated
 * must be released -- we have nothing to release in this
 * skeleton, so the body is empty. */
static void DriverUnload(struct DRIVER_OBJECT *DriverObject) {
    (void)DriverObject;
    /* Real drivers tear down device objects, free pool
     * allocations, deregister callbacks, and stop worker
     * threads here. */
}

NTSTATUS DriverEntry(struct DRIVER_OBJECT *DriverObject,
                     struct UNICODE_STRING *RegistryPath) {
    (void)RegistryPath;
    /* Register the unload callback so the driver can be
     * stopped via `sc stop wdm_hello`. Without this, the
     * kernel marks the driver as non-unloadable for the
     * lifetime of the boot. */
    DriverObject->DriverUnload = &DriverUnload;
    return STATUS_SUCCESS;
}

/* Minimal Windows kernel-mode driver skeleton (WDM).
 *
 * Builds a `.sys`-shaped PE that:
 *
 *   * Carries `IMAGE_SUBSYSTEM_NATIVE (1)` via
 *     `#pragma subsystem(driver)` -- an alias for `native`.
 *     The kernel's PE loader refuses anything with
 *     `WINDOWS_CUI` / `WINDOWS_GUI`.
 *   * Uses `#pragma entrypoint(DriverEntry)`. The kernel calls
 *     the entry with the WDM `(PDRIVER_OBJECT, PUNICODE_STRING)`
 *     signature; the writer's passthrough path leaves
 *     `AddressOfEntryPoint` at `DriverEntry` with no CRT shim
 *     in between.
 *   * Imports the minimum from `ntoskrnl.exe`. A real driver
 *     would pull in `IoCreateDevice`, `IoCreateSymbolicLink`,
 *     etc.; this skeleton only registers `DRIVER_UNLOAD` so the
 *     driver is unloadable via `sc stop`.
 *
 * Build:
 *
 *     badc -O demos/wdm_driver/wdm_driver.c -o wdm_hello.sys
 *
 * Load on a Windows x64 host (admin / elevated). Test-signing mode
 * permits a TEST-SIGNED driver, not an unsigned one: `sc start` on an
 * unsigned image returns 577 (ERROR_INVALID_IMAGE_HASH). The steps,
 * verified end to end:
 *
 *   1. Enable test-signing, then reboot:
 *        bcdedit /set testsigning on
 *        shutdown /r /t 0
 *   2. Create a self-signed code-signing certificate and trust it in
 *      both the Root and TrustedPublisher machine stores:
 *        $c = New-SelfSignedCertificate -Type CodeSigningCert `
 *               -Subject "CN=badc-test-driver" `
 *               -CertStoreLocation Cert:\LocalMachine\My
 *        Export-Certificate -Cert $c -FilePath badc-test.cer
 *        Import-Certificate -FilePath badc-test.cer `
 *               -CertStoreLocation Cert:\LocalMachine\Root
 *        Import-Certificate -FilePath badc-test.cer `
 *               -CertStoreLocation Cert:\LocalMachine\TrustedPublisher
 *   3. Sign the image. `/sm` selects the machine store, where the
 *      certificate lives:
 *        signtool sign /sm /fd sha256 /sha1 <thumbprint> wdm_hello.sys
 *   4. Register, start, query, stop, remove (spaces after `=` are
 *      required):
 *        sc create wdm_hello type= kernel binPath= C:\path\wdm_hello.sys
 *        sc start  wdm_hello   (DriverEntry runs; state RUNNING)
 *        sc query  wdm_hello
 *        sc stop   wdm_hello   (DRIVER_UNLOAD runs; state STOPPED)
 *        sc delete wdm_hello
 *   5. Restore the host: remove the certificate from the three stores,
 *      then `bcdedit /set testsigning off` and reboot.
 *
 * The `.sys` carries no base-relocation table; it does not need one,
 * because the code is position-independent (`&DriverUnload` is a
 * RIP-relative `lea`), so the kernel loads it at any base.
 *
 * Build-only in CI: loading a kernel driver requires admin,
 * test-signing, a code-signing certificate, and a host willing to
 * reboot. */

#pragma subsystem(driver)
#pragma entrypoint(DriverEntry)

#pragma dylib(ntoskrnl, "ntoskrnl.exe")
/* No imports needed for this skeleton. Real drivers add e.g.
 * `#pragma binding(ntoskrnl::IoCreateDevice, "IoCreateDevice")`
 * here. */

typedef long  NTSTATUS;
typedef void *PVOID;

/* NTSTATUS = severity / facility / code triple; 0 means
 * "no error, informational severity, facility = null". */
#define STATUS_SUCCESS ((NTSTATUS)0)

/* UNICODE_STRING: length (bytes) + maximum length (bytes) +
 * buffer. `Length` excludes the null terminator. */
struct UNICODE_STRING {
    unsigned short  Length;
    unsigned short  MaximumLength;
    unsigned short *Buffer;
};

/* DRIVER_OBJECT prefix up to `DriverUnload`. The remaining
 * header fields (major function dispatch table, fast I/O
 * dispatch, etc.) are zero-initialised by the kernel; that is
 * correct for a driver with no devices. The field offsets in
 * the kernel's `_DRIVER_OBJECT` are stable across Windows
 * versions. */
struct DRIVER_OBJECT {
    char _header_pad[0x68];
    void (*DriverUnload)(struct DRIVER_OBJECT *DriverObject);
    /* DriverInit / DriverStartIo / DriverName / etc. follow. */
};

/* DRIVER_UNLOAD callback. Invoked by the SCM (or other
 * reference-holder) when the driver is requested to unload.
 * Must release every reference the driver allocated; this
 * skeleton allocates nothing. */
static void DriverUnload(struct DRIVER_OBJECT *DriverObject) {
    (void)DriverObject;
}

NTSTATUS DriverEntry(struct DRIVER_OBJECT *DriverObject,
                     struct UNICODE_STRING *RegistryPath) {
    (void)RegistryPath;
    /* Registering DRIVER_UNLOAD makes the driver stoppable via
     * `sc stop`. Without it the kernel pins the driver for the
     * lifetime of the boot. */
    DriverObject->DriverUnload = &DriverUnload;
    return STATUS_SUCCESS;
}

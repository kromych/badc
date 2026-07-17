// Regression: <sys/auxv.h> exposes getauxval() (glibc binding) and, on aarch64,
// the HWCAP_* / HWCAP2_* CPU-feature bit names that portable runtime code tests
// to select an accelerated path -- e.g. probing AES / PMULL / SHA2 before
// dispatching crypto, the way a cpuinfo routine does. A missing name parses as
// an unknown identifier (a compile failure), and the bits at position >= 32 must
// widen to unsigned long rather than overflow a 32-bit shift.

#include <sys/auxv.h>

int main(void) {
    unsigned long caps = 0, caps2 = 0;
#ifdef __linux__
    // The binding must resolve and accept the AT_* selectors; the returned mask
    // is host-specific, so it is exercised, not asserted.
    caps = getauxval(AT_HWCAP);
    caps2 = getauxval(AT_HWCAP2);
#endif
    (void)caps;
    (void)caps2;
#if defined(__aarch64__)
    // Bit positions fixed by the kernel uapi (arch/arm64 asm/hwcap.h).
    if (HWCAP_FP      != (1UL << 0))  return 1;
    if (HWCAP_ASIMD   != (1UL << 1))  return 2;
    if (HWCAP_AES     != (1UL << 3))  return 3;
    if (HWCAP_PMULL   != (1UL << 4))  return 4;
    if (HWCAP_SHA1    != (1UL << 5))  return 5;
    if (HWCAP_SHA2    != (1UL << 6))  return 6;
    if (HWCAP_CRC32   != (1UL << 7))  return 7;
    if (HWCAP_ATOMICS != (1UL << 8))  return 8;
    if (HWCAP_SHA3    != (1UL << 17)) return 9;
    if (HWCAP_SHA512  != (1UL << 21)) return 10;
    if (HWCAP_GCS     != (1UL << 32)) return 11; // past bit 31: needs a wide shift
    if (HWCAP2_SVE2   != (1UL << 1))  return 12;
    if (HWCAP2_SME2   != (1UL << 37)) return 13;

    // A realistic dispatch fold over the accelerated-crypto bits.
    unsigned long crypto = caps & (HWCAP_AES | HWCAP_PMULL | HWCAP_SHA2);
    (void)crypto;
#endif
    return 0;
}

// MSVC's instruction intrinsics through <intrin.h>, run for their effect:
// `__cpuid` leaf 0 gives a maximum leaf and a printable vendor string,
// `__rdtsc` does not run backwards, the TEB's self pointer and last-error
// field read the same through gs or x18 as through memory, the barriers
// and hints execute, and on arm64 the CRC32 instructions give the check
// values of "123456789" and FPCR reads back what is written to it. Each
// failed check sets its bit; off the PE targets the unit checks nothing.

#ifdef _WIN32
#include <intrin.h>

#if defined(__aarch64__)
static const char check[] = "123456789";

static unsigned le(int at, int n) {
    unsigned v = 0;
    for (int i = n - 1; i >= 0; i--)
        v = v << 8 | (unsigned char)check[at + i];
    return v;
}
#endif

int main(void) {
    int r = 0;
#if defined(__x86_64__)
    int info[4];
    __cpuid(info, 0);
    if (info[0] < 1) r |= 1;
    for (int i = 1; i < 4; i++)
        for (int k = 0; k < 4; k++) {
            unsigned ch = ((unsigned)info[i] >> (8 * k)) & 0xff;
            if (ch < 0x20 || ch > 0x7e) r |= 2;
        }
    __cpuidex(info, 0, 0);
    if (info[0] < 1) r |= 1;
    unsigned long long t0 = __rdtsc();
    _mm_pause();
    __nop();
    if (__rdtsc() < t0) r |= 4;
    unsigned long long teb = __readgsqword(0x30);
    if (teb == 0 || *(unsigned long long *)(teb + 0x30) != teb) r |= 8;
    if (__readgsdword(0x30) != (unsigned long)teb || __readgsbyte(0x30) != (unsigned char)teb)
        r |= 8;
    __writegsdword(0x68, 1234);
    if (__readgsdword(0x68) != 1234 || *(unsigned long *)(teb + 0x68) != 1234) r |= 16;
#else
    unsigned long long teb = __getReg(18);
    if (teb == 0 || __readx18qword(0x30) != teb || *(unsigned long long *)(teb + 0x30) != teb)
        r |= 8;
    if (__readx18dword(0x30) != (unsigned long)teb || __readx18byte(0x30) != (unsigned char)teb)
        r |= 8;
    __writex18dword(0x68, 4321);
    if (__readx18dword(0x68) != 4321 || *(unsigned long *)(teb + 0x68) != 4321) r |= 16;
    __dmb(_ARM64_BARRIER_ISH);
    __dsb(_ARM64_BARRIER_SY);
    __isb(_ARM64_BARRIER_SY);
    __yield();
    __sev();
    __nop();
    __sevl();
    __wfe();
    unsigned crc = ~0u, crcc = ~0u;
    for (int i = 0; i < 9; i++) {
        crc = __crc32b(crc, check[i]);
        crcc = __crc32cb(crcc, check[i]);
    }
    if (~crc != 0xCBF43926u || ~crcc != 0xE3069283u) r |= 32;
    crc = __crc32w(~0u, le(0, 4));
    crc = __crc32h(crc, le(4, 2));
    crc = __crc32h(crc, le(6, 2));
    if (~__crc32b(crc, check[8]) != 0xCBF43926u) r |= 64;
    crcc = __crc32cd(~0u, (unsigned long long)le(4, 4) << 32 | le(0, 4));
    if (~__crc32cb(crcc, check[8]) != 0xE3069283u) r |= 64;
    long long fpcr = _ReadStatusReg(ARM64_SYSREG(3, 3, 4, 4, 0));
    _WriteStatusReg(ARM64_SYSREG(3, 3, 4, 4, 0), fpcr);
    if (_ReadStatusReg(ARM64_SYSREG(3, 3, 4, 4, 0)) != fpcr) r |= 128;
#endif
    return r;
}
#else
int main(void) { return 0; }
#endif

// The MSVC runtime's record of the instruction set the processor and the OS
// support, which code compiled for that runtime reads: `__isa_available`
// holds the highest level of <isa_availability.h>, `__isa_enabled` one bit
// per level from SSE2 up. A level follows its CPUID feature flags and, for
// the AVX levels, the state components XCR0 enables (SDM vol. 1, 13.3).
// AVX512 is the subset `/arch:AVX512` targets: F, CD, BW, DQ and VL.

#if defined(_WIN32) && defined(__x86_64__)
#include <intrin.h>

int __isa_available = 0;
int __isa_enabled = 0;

static int __c5_isa_init(void) {
    int r[4], leaf7[4] = {0};
    __cpuid(r, 0);
    if (r[0] >= 7)
        __cpuidex(leaf7, 7, 0);
    __cpuid(r, 1);
    unsigned ecx = (unsigned)r[2], edx = (unsigned)r[3], ebx7 = (unsigned)leaf7[1];
    unsigned long long xcr0 = (ecx >> 27 & 1) ? _xgetbv(0) : 0;
    unsigned avx512 = 1u << 16 | 1u << 17 | 1u << 28 | 1u << 30 | 1u << 31;
    int avx = (ecx >> 28 & 1) && (xcr0 & 6) == 6;
    int avx2 = avx && (ebx7 >> 5 & 1);
    int level[7] = {
        [1] = edx >> 26 & 1,
        [2] = ecx >> 20 & 1,
        [3] = avx,
        [4] = ebx7 >> 9 & 1,
        [5] = avx2,
        [6] = avx2 && (ebx7 & avx512) == avx512 && (xcr0 & 0xe6) == 0xe6,
    };
    for (int i = 1; i < 7; i++) {
        if (level[i]) {
            __isa_enabled |= 1 << i;
            __isa_available = i;
        }
    }
    return 0;
}

// A C initializer, ahead of every unit's own.
#pragma section(".CRT$XIB", read)
__declspec(allocate(".CRT$XIB")) int (*__c5_isa_init_entry)(void) = __c5_isa_init;
#endif

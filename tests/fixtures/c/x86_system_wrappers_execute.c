// gcc's and clang's wrappers over the x86 system builtins on an x86-64
// target: _mm_sfence (<xmmintrin.h>), _mm_lfence and _mm_mfence
// (<emmintrin.h>), _xgetbv (<immintrin.h>), __rdtscp, __readeflags and
// __writeeflags (<x86intrin.h>), with the builtins __builtin_ia32_rdtscp
// and __builtin_ia32_writeeflags_u64 under them. On the PE targets the
// names are MSVC intrinsics too, which <intrin.h> leaves to the wrappers.
// The fences execute, XCR0 holds the x87 and SSE state bits once CPUID
// reports OSXSAVE, rdtscp stores IA32_TSC_AUX where CPUID reports it, and
// the ID flag (RFLAGS bit 21), which user code may toggle, reads back as
// written. Elsewhere the builtins are not provided.

#ifdef __x86_64__
#if !__has_builtin(__builtin_ia32_rdtscp) || !__has_builtin(__builtin_ia32_writeeflags_u64)
#error "the x86 system builtins are not provided"
#endif

#include <x86intrin.h>
#ifdef _WIN32
#include <intrin.h>
#endif

static void cpuid(unsigned leaf, unsigned r[4]) {
    unsigned a = leaf, b, c = 0, d;
    __asm__ __volatile__("cpuid" : "+a"(a), "=b"(b), "+c"(c), "=d"(d));
    r[0] = a, r[1] = b, r[2] = c, r[3] = d;
}

int main(void) {
    _mm_sfence();
    _mm_lfence();
    _mm_mfence();
    unsigned r[4];
    cpuid(1, r);
    if ((r[2] & (1u << 27)) && (_xgetbv(0) & 3) != 3)
        return 1;
    cpuid(0x80000000u, r);
    if (r[0] >= 0x80000001u) {
        cpuid(0x80000001u, r);
        if (r[3] & (1u << 27)) {
            unsigned aux = 0xdeadbeef, aux2 = 0xdeadbeef;
            unsigned long long t0 = __rdtscp(&aux), t1 = __builtin_ia32_rdtscp(&aux2);
            if (aux == 0xdeadbeef || aux2 == 0xdeadbeef || (t0 == 0 && t1 == 0))
                return 2;
        }
    }
    unsigned long long flags = __readeflags();
    if (!(flags & 0x2) || !(flags & 0x200) || (flags & 0x400))
        return 3;
    __writeeflags(flags ^ (1ull << 21));
    unsigned long long toggled = __readeflags();
    __builtin_ia32_writeeflags_u64(flags);
    if (((toggled ^ flags) & (1ull << 21)) == 0 || ((__readeflags() ^ flags) & (1ull << 21)))
        return 4;
    return 0;
}
#else
#if __has_builtin(__builtin_ia32_rdtscp) || __has_builtin(__builtin_ia32_writeeflags_u64)
#error "an x86 builtin outside x86"
#endif
int main(void) {
    return 0;
}
#endif

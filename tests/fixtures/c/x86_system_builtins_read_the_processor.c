// gcc's and clang's x86 system-instruction builtins on an x86-64 target:
// the fences and the spin hint execute, the timestamp counter reads, XCR0
// has the x87 and SSE state bits an x86-64 OS enables once CPUID reports
// OSXSAVE, and RFLAGS has its fixed bit 1 and the interrupt flag set and the
// direction flag clear, as user code always runs. Elsewhere the builtins are
// not provided.

#ifdef __x86_64__
#if !__has_builtin(__builtin_ia32_sfence) || !__has_builtin(__builtin_ia32_xgetbv) || \
    !__has_builtin(__builtin_ia32_readeflags_u64)
#error "the x86 system builtins are not provided"
#endif

// CPUID leaf 1's ecx, read directly.
static unsigned int cpuid1_ecx(void) {
    unsigned int a = 1, b, c = 0, d;
    __asm__ __volatile__("cpuid" : "+a"(a), "=b"(b), "+c"(c), "=d"(d));
    return c;
}

int main(void) {
    __builtin_ia32_sfence();
    __builtin_ia32_lfence();
    __builtin_ia32_mfence();
    __builtin_ia32_pause();
    unsigned long long t0 = __builtin_ia32_rdtsc(), t1 = __builtin_ia32_rdtsc();
    if (t0 == 0 && t1 == 0)
        return 1;
    if ((cpuid1_ecx() & (1u << 27)) && (__builtin_ia32_xgetbv(0) & 3) != 3)
        return 3;
    unsigned long long flags = __builtin_ia32_readeflags_u64();
    if (!(flags & 0x2) || !(flags & 0x200) || (flags & 0x400))
        return 4;
    return 0;
}
#else
#if __has_builtin(__builtin_ia32_rdtsc)
#error "an x86 builtin outside x86"
#endif
int main(void) {
    return 0;
}
#endif

// CLFLUSHOPT, PREFETCHW and FXSAVE / FXRSTOR through <immintrin.h>, and
// BMI1's double-underscore spellings: a write-back and a prefetch leave
// memory as it is, FXSAVE stores the process's default x87 control word
// (double precision on Windows, extended elsewhere), MXCSR and a nonzero
// MXCSR_MASK, and FXRSTOR of that area restores them. Each group sets its
// bit on a mismatch; off x86-64 the unit checks nothing.

#ifdef __x86_64__
#include <immintrin.h>

static unsigned char area[512] __attribute__((aligned(16)));
#ifdef _WIN32
#define FCW 0x027f
#else
#define FCW 0x037f
#endif

static unsigned word(int at, int n) {
    unsigned v = 0;
    for (int i = n - 1; i >= 0; i--)
        v = v << 8 | area[at + i];
    return v;
}

int main(void) {
    int r = 0;
    volatile int x = 5;
    _mm_clflushopt((void *)&x);
    _m_prefetchw((void *)&x);
    if (x != 5)
        r |= 1;
    _fxsave(area);
    if (word(0, 2) != FCW || (word(24, 4) & 0xffc0) != 0x1f80 || word(28, 4) == 0)
        r |= 2;
    _fxrstor(area);
    if ((_mm_getcsr() & 0xffc0) != 0x1f80)
        r |= 4;
    if (__andn_u32(0xf0, 0xff) != 0x0f || __blsi_u32(12) != 4 || __blsmsk_u64(8) != 15 ||
        __blsr_u64(12) != 8 || _tzcnt_u16(0x80) != 7 || __tzcnt_u32(0) != 32 ||
        __tzcnt_u64(0) != 64)
        r |= 8;
    return r;
}
#else
int main(void) { return 0; }
#endif

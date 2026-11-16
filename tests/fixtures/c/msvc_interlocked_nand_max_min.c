// MSVC's _InterlockedNand / Max / Min / UMax / UMin families, `_interlockedadd`
// and winnt.h's Acquire / Release / NoFence spellings: each yields the prior
// value (the sum for the add forms) and stores ~(old & v), the greater or the
// lesser value, signed or not as the family's type is.
#ifdef _WIN32
#include <intrin.h>
#include <windows.h>

int main(void)
{
    volatile long l = 5;
    volatile unsigned long u = 5;
    volatile char c = -3;
    volatile unsigned short us = 40000;
    volatile __int64 q = -7;
    if (_InterlockedMax(&l, 9) != 5 || l != 9 || _InterlockedMax(&l, -1) != 9 || l != 9)
        return 1;
    if (_InterlockedMin(&l, -4) != 9 || l != -4)
        return 2;
    if (_InterlockedUMax(&u, 0xFFFFFFF0u) != 5 || u != 0xFFFFFFF0u)
        return 3;
    if (_InterlockedUMin(&u, 7) != 0xFFFFFFF0u || u != 7)
        return 4;
    if (_InterlockedMax8(&c, -5) != -3 || c != -3 || _InterlockedMin8(&c, -100) != -3 || c != -100)
        return 5;
    if (_InterlockedUMax16(&us, 30000) != 40000 || us != 40000)
        return 6;
    if (_InterlockedNand(&l, 6) != -4 || l != ~(-4 & 6))
        return 7;
    if (_InterlockedNand64(&q, 3) != -7 || q != ~(-7LL & 3))
        return 8;
    if (_InterlockedMax64(&q, 1LL << 40) != ~(-7LL & 3) || q != 1LL << 40)
        return 9;
    volatile LONG a = 5;
    volatile LONG64 b = 7;
    if (_interlockedadd(&a, 3) != 8 || a != 8 || _interlockedadd64(&b, 4) != 11 || b != 11)
        return 10;
    if (InterlockedIncrementAcquire(&a) != 9 || InterlockedDecrementRelease(&a) != 8)
        return 11;
    if (InterlockedExchangeAddNoFence(&a, 2) != 8 || a != 10)
        return 12;
    if (InterlockedCompareExchangeAcquire64(&b, 1, 11) != 11 || b != 1)
        return 13;
    if (InterlockedOrRelease(&a, 1) != 10 || a != 11 || InterlockedAddAcquire64(&b, 5) != 6)
        return 14;
    return 0;
}
#else
int main(void)
{
    return 0;
}
#endif

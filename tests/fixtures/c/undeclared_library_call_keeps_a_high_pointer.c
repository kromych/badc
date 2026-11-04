// A call to a C library function the unit has not declared, with a
// `#pragma binding` of the name in scope (msvc_compat.h binds malloc and
// free): the binding declares nothing, so the call takes the prototype of
// the header declaring the function. Its result is a pointer, not an `int`
// (C99 6.5.2.2p5), and the address malloc returns from above 4 GiB survives
// the conversion to an integer. The free address space below 4 GiB is
// reserved first, so the heap's large block has to come from above it.
// WIN32_LEAN_AND_MEAN keeps <stdlib.h> out of <windows.h>, as in the SDK.
// Elsewhere the program exits 0.

#ifdef _WIN32
#define WIN32_LEAN_AND_MEAN
#include <windows.h>

#define FOUR_GIB 0x100000000ULL
#define GRANULE 0x10000ULL

static void reserve_below_4gib(void)
{
    unsigned long long at = GRANULE;
    MEMORY_BASIC_INFORMATION mbi;
    while (at < FOUR_GIB && VirtualQuery((void *)at, &mbi, sizeof mbi)) {
        unsigned long long base = (unsigned long long)mbi.BaseAddress;
        unsigned long long end = base + mbi.RegionSize;
        unsigned long long lo = (base + GRANULE - 1) & ~(GRANULE - 1);
        unsigned long long hi = end < FOUR_GIB ? end : FOUR_GIB;
        if (mbi.State == MEM_FREE && lo < hi)
            VirtualAlloc((void *)lo, hi - lo, MEM_RESERVE, PAGE_NOACCESS);
        at = end;
    }
}

int main(void)
{
    if (sizeof malloc(1) != sizeof(void *))
        return 4;
    reserve_below_4gib();
    unsigned long long size = 16ULL << 20;
    unsigned long long at = (unsigned long long)malloc(size);
    if (!at)
        return 1;
    if (at < FOUR_GIB)
        return 2;
    char *p = (char *)at;
    p[0] = 'a';
    p[size - 1] = 'z';
    int ok = p[0] == 'a' && p[size - 1] == 'z';
    free(p);
    return ok ? 0 : 3;
}
#else
int main(void)
{
    return 0;
}
#endif

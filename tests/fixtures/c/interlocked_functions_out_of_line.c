// MSVC's `_Interlocked*` functions called out of line, as cl calls them on
// arm64 where it does not expand the intrinsic: `#pragma function` makes
// each a call, which the compiler runtime's definitions satisfy. An
// operation returns the prior value, an increment or decrement the new
// one. Exits 0 when every result holds; elsewhere the unit checks nothing.

#if defined(_WIN32) && defined(__aarch64__)
#pragma function(_InterlockedCompareExchange, _InterlockedCompareExchange_nf)
#pragma function(_InterlockedCompareExchange_rel, _InterlockedExchange8_acq)
#pragma function(_InterlockedExchangeAdd_nf, _InterlockedIncrement64_rel)
#pragma function(_InterlockedOr16_acq, _InterlockedCompareExchangePointer_acq)
long _InterlockedCompareExchange(long volatile *, long, long);
long _InterlockedCompareExchange_nf(long volatile *, long, long);
long _InterlockedCompareExchange_rel(long volatile *, long, long);
char _InterlockedExchange8_acq(char volatile *, char);
long _InterlockedExchangeAdd_nf(long volatile *, long);
long long _InterlockedIncrement64_rel(long long volatile *);
short _InterlockedOr16_acq(short volatile *, short);
void *_InterlockedCompareExchangePointer_acq(void *volatile *, void *, void *);

int main(void) {
    static volatile long l = 5;
    static volatile char c = 'a';
    static volatile long long q = 41;
    static volatile short s = 0x10;
    static void *volatile p;
    if (_InterlockedCompareExchange(&l, 7, 5) != 5 || l != 7) return 1;
    if (_InterlockedCompareExchange_nf(&l, 9, 5) != 7 || l != 7) return 2;
    if (_InterlockedCompareExchange_rel(&l, 9, 7) != 7 || l != 9) return 3;
    if (_InterlockedExchange8_acq(&c, 'b') != 'a' || c != 'b') return 4;
    if (_InterlockedExchangeAdd_nf(&l, 3) != 9 || l != 12) return 5;
    if (_InterlockedIncrement64_rel(&q) != 42 || q != 42) return 6;
    if (_InterlockedOr16_acq(&s, 0x01) != 0x10 || s != 0x11) return 7;
    if (_InterlockedCompareExchangePointer_acq(&p, (void *)&q, 0) != 0 || p != &q) return 8;
    return 0;
}
#else
int main(void) { return 0; }
#endif

// MSVC's `_Interlocked*` functions on arm64, out of line. cl calls them as
// functions where it does not expand the intrinsic, and the MSVC runtime
// defines them; pulled into an image only when an object names one. The
// plain form is sequentially consistent, `_acq` acquires, `_rel` releases
// and `_nf` (no fence) is relaxed. An operation returns the destination's
// prior value; `_InterlockedIncrement*` and `_InterlockedDecrement*` the
// new one.

#if defined(_WIN32) && defined(__aarch64__)

#define __C5_ORDERS(F, ...)                                                    \
    F(, __ATOMIC_SEQ_CST, __ATOMIC_SEQ_CST, __VA_ARGS__)                       \
    F(_acq, __ATOMIC_ACQUIRE, __ATOMIC_ACQUIRE, __VA_ARGS__)                   \
    F(_rel, __ATOMIC_RELEASE, __ATOMIC_RELAXED, __VA_ARGS__)                   \
    F(_nf, __ATOMIC_RELAXED, __ATOMIC_RELAXED, __VA_ARGS__)

#define __C5_CMPXCHG(SUF, ORDER, FAIL, NAME, T)                                \
    _Pragma(__C5_STR(function(NAME##SUF)))                                     \
    T NAME##SUF(T volatile *d, T x, T c) {                                     \
        __atomic_compare_exchange_n(d, &c, x, 0, ORDER, FAIL);                 \
        return c;                                                              \
    }
#define __C5_XCHG(SUF, ORDER, FAIL, NAME, T)                                   \
    _Pragma(__C5_STR(function(NAME##SUF)))                                     \
    T NAME##SUF(T volatile *d, T v) { return __atomic_exchange_n(d, v, ORDER); }
#define __C5_FETCH(SUF, ORDER, FAIL, NAME, OP, T)                              \
    _Pragma(__C5_STR(function(NAME##SUF)))                                     \
    T NAME##SUF(T volatile *d, T v) { return __atomic_fetch_##OP(d, v, ORDER); }
#define __C5_STEP(SUF, ORDER, FAIL, NAME, OP, T)                               \
    _Pragma(__C5_STR(function(NAME##SUF)))                                     \
    T NAME##SUF(T volatile *d) { return __atomic_##OP##_fetch(d, 1, ORDER); }
#define __C5_STR(x) #x

#define __C5_WIDTHS(F, NAME, ...)                                              \
    __C5_ORDERS(F, NAME##8, __VA_ARGS__ char)                                  \
    __C5_ORDERS(F, NAME##16, __VA_ARGS__ short)                                \
    __C5_ORDERS(F, NAME, __VA_ARGS__ long)                                     \
    __C5_ORDERS(F, NAME##64, __VA_ARGS__ long long)

__C5_WIDTHS(__C5_CMPXCHG, _InterlockedCompareExchange, )
__C5_WIDTHS(__C5_XCHG, _InterlockedExchange, )
__C5_WIDTHS(__C5_FETCH, _InterlockedExchangeAdd, add, )
__C5_WIDTHS(__C5_FETCH, _InterlockedAnd, and, )
__C5_WIDTHS(__C5_FETCH, _InterlockedOr, or, )
__C5_WIDTHS(__C5_FETCH, _InterlockedXor, xor, )
__C5_ORDERS(__C5_STEP, _InterlockedIncrement16, add, short)
__C5_ORDERS(__C5_STEP, _InterlockedIncrement, add, long)
__C5_ORDERS(__C5_STEP, _InterlockedIncrement64, add, long long)
__C5_ORDERS(__C5_STEP, _InterlockedDecrement16, sub, short)
__C5_ORDERS(__C5_STEP, _InterlockedDecrement, sub, long)
__C5_ORDERS(__C5_STEP, _InterlockedDecrement64, sub, long long)
__C5_ORDERS(__C5_CMPXCHG, _InterlockedCompareExchangePointer, void *)
__C5_ORDERS(__C5_XCHG, _InterlockedExchangePointer, void *)

#endif

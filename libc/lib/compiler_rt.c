// Compiler runtime helpers provided on demand, mirroring the subset of
// libgcc / compiler-rt that badc-emitted code never needs but objects from
// other toolchains reference. The native-link driver pulls this object into
// the link only when one of its symbols is left undefined, so a pure-badc
// image carries none of it.
//
// AArch64 outline atomics (GCC `-moutline-atomics`, the default on many
// aarch64 toolchains): instead of emitting an LSE instruction or an LL/SC
// loop inline, the compiler calls `__aarch64_<op><size>_<order>`. Each helper
// here wraps the corresponding atomic builtin. badc's atomic lowering saves
// the general-purpose scratch it uses, so the emitted body clobbers only
// x0/x1/x2, x16/x17 and the flags -- within the registers the outline-atomics
// calling convention permits a helper to clobber.
//
// `__atomic_*` memory-order arguments (C11 / GCC): 0 relaxed, 2 acquire,
// 3 release, 4 acq_rel. A compare-exchange failure order drops the release
// side (0 for relaxed/release, 2 for acquire/acq_rel).

#ifdef __aarch64__

typedef unsigned char __bcrt_u8;
typedef unsigned short __bcrt_u16;
typedef unsigned int __bcrt_u32;
typedef unsigned long __bcrt_u64;

#define BCRT_LDADD(sz, T, ord, mo) \
    T __aarch64_ldadd##sz##_##ord(T v, T *p) { return __atomic_fetch_add(p, v, mo); }
#define BCRT_LDCLR(sz, T, ord, mo) \
    T __aarch64_ldclr##sz##_##ord(T v, T *p) { return __atomic_fetch_and(p, ~v, mo); }
#define BCRT_LDEOR(sz, T, ord, mo) \
    T __aarch64_ldeor##sz##_##ord(T v, T *p) { return __atomic_fetch_xor(p, v, mo); }
#define BCRT_LDSET(sz, T, ord, mo) \
    T __aarch64_ldset##sz##_##ord(T v, T *p) { return __atomic_fetch_or(p, v, mo); }
#define BCRT_SWP(sz, T, ord, mo) \
    T __aarch64_swp##sz##_##ord(T v, T *p) { return __atomic_exchange_n(p, v, mo); }
#define BCRT_CAS(sz, T, ord, mo, fmo)                              \
    T __aarch64_cas##sz##_##ord(T c, T n, T *p) {                  \
        __atomic_compare_exchange_n(p, &c, n, 0, mo, fmo);         \
        return c;                                                  \
    }

#define BCRT_SIZES(MAC, ord, mo) \
    MAC(1, __bcrt_u8, ord, mo)   \
    MAC(2, __bcrt_u16, ord, mo)  \
    MAC(4, __bcrt_u32, ord, mo)  \
    MAC(8, __bcrt_u64, ord, mo)

#define BCRT_ORDERS(MAC)      \
    BCRT_SIZES(MAC, relax, 0) \
    BCRT_SIZES(MAC, acq, 2)   \
    BCRT_SIZES(MAC, rel, 3)   \
    BCRT_SIZES(MAC, acq_rel, 4)

BCRT_ORDERS(BCRT_LDADD)
BCRT_ORDERS(BCRT_LDCLR)
BCRT_ORDERS(BCRT_LDEOR)
BCRT_ORDERS(BCRT_LDSET)
BCRT_ORDERS(BCRT_SWP)

#define BCRT_CAS_SIZES(ord, mo, fmo) \
    BCRT_CAS(1, __bcrt_u8, ord, mo, fmo)   \
    BCRT_CAS(2, __bcrt_u16, ord, mo, fmo)  \
    BCRT_CAS(4, __bcrt_u32, ord, mo, fmo)  \
    BCRT_CAS(8, __bcrt_u64, ord, mo, fmo)

BCRT_CAS_SIZES(relax, 0, 0)
BCRT_CAS_SIZES(acq, 2, 2)
BCRT_CAS_SIZES(rel, 3, 0)
BCRT_CAS_SIZES(acq_rel, 4, 2)

#endif // __aarch64__

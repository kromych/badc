// stdatomic.h -- C11 (7.17) atomic operations.
//
// The non-`_explicit` atomic operations (`atomic_load`, `atomic_store`,
// `atomic_exchange`, `atomic_fetch_add` / `sub` / `and` / `or` / `xor`,
// `atomic_compare_exchange_strong`) are compiler builtins, declared
// below via `#pragma intrinsic` and lowered at the call site with
// seq_cst order. The `_explicit` forms and the fences are the
// `__atomic_*` builtins, which take the order operand. This header also
// provides the rest of the 7.17 surface: the `memory_order`
// enumeration, the lock-free and flag types, and the atomic typedefs.
//
// Each operation is atomic against concurrent access when the object is
// a naturally-aligned 1-, 2-, 4- or 8-byte scalar; a wider one is
// rejected at compile time. Load and store carry the order named
// (7.17.1; `consume` is acquire): on aarch64 a relaxed access is a plain
// `ldr` / `str`, an acquire or seq_cst load `ldar` and a release or
// seq_cst store `stlr`; on x86-64 a load is a plain `mov` for every
// order, a relaxed or release store a plain `mov` and a seq_cst store
// `xchg`. The read-modify-write forms lower on x86-64 to `lock xadd`
// (add, and sub with the operand negated), `xchg` (exchange, implicitly
// locked), a `lock cmpxchg` retry loop (and / or / xor) and `lock
// cmpxchg` (compare-exchange), and on aarch64 to an `ldaxr` / `stlxr`
// retry loop: the seq_cst sequence whatever order they name.
// `atomic_flag_test_and_set` is the byte-wide exchange and
// `atomic_flag_clear` the byte-wide store.

#pragma once

#include <stdint.h>
#include <stddef.h>

#pragma intrinsic("atomic_load")
#pragma intrinsic("atomic_store")
#pragma intrinsic("atomic_exchange")
#pragma intrinsic("atomic_fetch_add")
#pragma intrinsic("atomic_fetch_sub")
#pragma intrinsic("atomic_fetch_and")
#pragma intrinsic("atomic_fetch_or")
#pragma intrinsic("atomic_fetch_xor")
#pragma intrinsic("atomic_compare_exchange_strong")

typedef enum memory_order {
    memory_order_relaxed = 0,
    memory_order_consume = 1,
    memory_order_acquire = 2,
    memory_order_release = 3,
    memory_order_acq_rel = 4,
    memory_order_seq_cst = 5
} memory_order;

// 7.17.4 fences. The thread fence is `dmb ish` on aarch64 (`dmb ishld`
// for acquire) and, for seq_cst, `mfence` on x86-64, whose weaker
// thread fences are compiler barriers, as the signal fence is on both.
// A relaxed fence is nothing (7.17.4.1p4, 7.17.4.2p2).
#define atomic_thread_fence(order) __atomic_thread_fence(order)
#define atomic_signal_fence(order) __atomic_signal_fence(order)

#define kill_dependency(y) (y)

// 7.17.2 initialization. 7.17.2.2 requires no synchronization of
// `atomic_init`, so it is the relaxed store.
#define ATOMIC_VAR_INIT(value) (value)
#define atomic_init(obj, value) __atomic_store_n((obj), (value), memory_order_relaxed)

// 7.17.5 lock-free property. Naturally-aligned scalars are lock-free.
#define ATOMIC_BOOL_LOCK_FREE 2
#define ATOMIC_CHAR_LOCK_FREE 2
#define ATOMIC_CHAR16_T_LOCK_FREE 2
#define ATOMIC_CHAR32_T_LOCK_FREE 2
#define ATOMIC_WCHAR_T_LOCK_FREE 2
#define ATOMIC_SHORT_LOCK_FREE 2
#define ATOMIC_INT_LOCK_FREE 2
#define ATOMIC_LONG_LOCK_FREE 2
#define ATOMIC_LLONG_LOCK_FREE 2
#define ATOMIC_POINTER_LOCK_FREE 2

// 7.17.6 atomic integer types.
typedef _Atomic(_Bool) atomic_bool;
typedef _Atomic(char) atomic_char;
typedef _Atomic(signed char) atomic_schar;
typedef _Atomic(unsigned char) atomic_uchar;
typedef _Atomic(short) atomic_short;
typedef _Atomic(unsigned short) atomic_ushort;
typedef _Atomic(int) atomic_int;
typedef _Atomic(unsigned int) atomic_uint;
typedef _Atomic(long) atomic_long;
typedef _Atomic(unsigned long) atomic_ulong;
typedef _Atomic(long long) atomic_llong;
typedef _Atomic(unsigned long long) atomic_ullong;
typedef _Atomic(int_least16_t) atomic_char16_t;
typedef _Atomic(int_least32_t) atomic_char32_t;
typedef _Atomic(wchar_t) atomic_wchar_t;
typedef _Atomic(int_least8_t) atomic_int_least8_t;
typedef _Atomic(uint_least8_t) atomic_uint_least8_t;
typedef _Atomic(int_least16_t) atomic_int_least16_t;
typedef _Atomic(uint_least16_t) atomic_uint_least16_t;
typedef _Atomic(int_least32_t) atomic_int_least32_t;
typedef _Atomic(uint_least32_t) atomic_uint_least32_t;
typedef _Atomic(int_least64_t) atomic_int_least64_t;
typedef _Atomic(uint_least64_t) atomic_uint_least64_t;
typedef _Atomic(int_fast8_t) atomic_int_fast8_t;
typedef _Atomic(uint_fast8_t) atomic_uint_fast8_t;
typedef _Atomic(int_fast16_t) atomic_int_fast16_t;
typedef _Atomic(uint_fast16_t) atomic_uint_fast16_t;
typedef _Atomic(int_fast32_t) atomic_int_fast32_t;
typedef _Atomic(uint_fast32_t) atomic_uint_fast32_t;
typedef _Atomic(int_fast64_t) atomic_int_fast64_t;
typedef _Atomic(uint_fast64_t) atomic_uint_fast64_t;
typedef _Atomic(intptr_t) atomic_intptr_t;
typedef _Atomic(uintptr_t) atomic_uintptr_t;
typedef _Atomic(size_t) atomic_size_t;
typedef _Atomic(ptrdiff_t) atomic_ptrdiff_t;
typedef _Atomic(intmax_t) atomic_intmax_t;
typedef _Atomic(uintmax_t) atomic_uintmax_t;

// 7.17.7 operations. The non-`_explicit` forms are c5 builtins; the
// `_explicit` forms pass their order operand(s) to the `__atomic_*`
// builtins. `atomic_compare_exchange_weak` is the strong form.
#define atomic_load_explicit(obj, order) __atomic_load_n((obj), (order))
#define atomic_store_explicit(obj, desired, order) __atomic_store_n((obj), (desired), (order))
#define atomic_exchange_explicit(obj, desired, order) \
    __atomic_exchange_n((obj), (desired), (order))
#define atomic_compare_exchange_strong_explicit(obj, expected, desired, succ, fail) \
    __atomic_compare_exchange_n((obj), (expected), (desired), 0, (succ), (fail))
#define atomic_compare_exchange_weak_explicit(obj, expected, desired, succ, fail) \
    __atomic_compare_exchange_n((obj), (expected), (desired), 1, (succ), (fail))
#define atomic_compare_exchange_weak(obj, expected, desired) \
    atomic_compare_exchange_strong((obj), (expected), (desired))
#define atomic_fetch_add_explicit(obj, arg, order) __atomic_fetch_add((obj), (arg), (order))
#define atomic_fetch_sub_explicit(obj, arg, order) __atomic_fetch_sub((obj), (arg), (order))
#define atomic_fetch_or_explicit(obj, arg, order) __atomic_fetch_or((obj), (arg), (order))
#define atomic_fetch_and_explicit(obj, arg, order) __atomic_fetch_and((obj), (arg), (order))
#define atomic_fetch_xor_explicit(obj, arg, order) __atomic_fetch_xor((obj), (arg), (order))

// 7.17.8 atomic flag. A minimal `_Bool` cell exercised through the
// integer atomics.
typedef struct atomic_flag {
    _Atomic(_Bool) _Value;
} atomic_flag;

#define ATOMIC_FLAG_INIT { 0 }

#define atomic_flag_test_and_set_explicit(obj, order) \
    __atomic_exchange_n(&(obj)->_Value, 1, (order))
#define atomic_flag_test_and_set(obj) atomic_exchange(&(obj)->_Value, 1)
#define atomic_flag_clear_explicit(obj, order) __atomic_store_n(&(obj)->_Value, 0, (order))
#define atomic_flag_clear(obj) atomic_store(&(obj)->_Value, 0)

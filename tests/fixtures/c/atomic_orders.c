/* Every atomic read-modify-write, compare-exchange, load and store under
   each memory order it takes (C11 7.17.7), and each at every object width
   with a value whose sign bit is set, checking what each yields and what
   it leaves. A 64-bit value is `long long`: `long` is 32 bits under
   LLP64. The exit code is the line of the first mismatch. */

#include <stdatomic.h>

#define CHECK(c)             \
    do {                     \
        if (!(c))            \
            return __LINE__; \
    } while (0)

#define RELAXED __ATOMIC_RELAXED
#define CONSUME __ATOMIC_CONSUME
#define ACQUIRE __ATOMIC_ACQUIRE
#define RELEASE __ATOMIC_RELEASE
#define ACQ_REL __ATOMIC_ACQ_REL
#define SEQ_CST __ATOMIC_SEQ_CST

/* The read-modify-writes of order `MO` on `x`, of type `T`, from `V`:
   the prior or new value each yields and the value each leaves, then
   the same operations with the result unread. */
#define RMW(T, V, MO)                                                              \
    x = (V);                                                                       \
    CHECK(__atomic_fetch_add(&x, (T)3, MO) == (T)(V) && x == (T)((V) + 3));        \
    x = (V);                                                                       \
    CHECK(__atomic_fetch_sub(&x, (T)3, MO) == (T)(V) && x == (T)((V) - 3));        \
    x = (V);                                                                       \
    CHECK(__atomic_fetch_and(&x, (T)6, MO) == (T)(V) && x == (T)((V) & 6));        \
    x = (V);                                                                       \
    CHECK(__atomic_fetch_or(&x, (T)6, MO) == (T)(V) && x == (T)((V) | 6));         \
    x = (V);                                                                       \
    CHECK(__atomic_fetch_xor(&x, (T)6, MO) == (T)(V) && x == (T)((V) ^ 6));        \
    x = (V);                                                                       \
    CHECK(__atomic_exchange_n(&x, (T)9, MO) == (T)(V) && x == (T)9);               \
    x = (V);                                                                       \
    CHECK(__atomic_add_fetch(&x, (T)3, MO) == (T)((V) + 3) && x == (T)((V) + 3));  \
    x = (V);                                                                       \
    CHECK(__atomic_sub_fetch(&x, (T)3, MO) == (T)((V) - 3) && x == (T)((V) - 3));  \
    x = (V);                                                                       \
    CHECK(__atomic_and_fetch(&x, (T)6, MO) == (T)((V) & 6) && x == (T)((V) & 6));  \
    x = (V);                                                                       \
    CHECK(__atomic_or_fetch(&x, (T)6, MO) == (T)((V) | 6) && x == (T)((V) | 6));   \
    x = (V);                                                                       \
    CHECK(__atomic_xor_fetch(&x, (T)6, MO) == (T)((V) ^ 6) && x == (T)((V) ^ 6));  \
    x = (V);                                                                       \
    __atomic_fetch_add(&x, (T)3, MO);                                              \
    __atomic_fetch_sub(&x, (T)1, MO);                                              \
    CHECK(x == (T)((V) + 2));                                                      \
    x = (V);                                                                       \
    __atomic_fetch_and(&x, (T)14, MO);                                             \
    __atomic_fetch_or(&x, (T)1, MO);                                               \
    __atomic_fetch_xor(&x, (T)3, MO);                                              \
    CHECK(x == (T)((((V) & 14) | 1) ^ 3));                                         \
    x = (V);                                                                       \
    __atomic_exchange_n(&x, (T)5, MO);                                             \
    CHECK(x == (T)5);

/* The compare-exchanges of orders `S` / `F` on `x` from `V`: a match
   stores and leaves the comparand, a mismatch stores nothing and writes
   the prior value back, through a local comparand and one in memory. */
#define CAS(T, V, S, F)                                                                \
    x = (V);                                                                           \
    e = (V);                                                                           \
    CHECK(__atomic_compare_exchange_n(&x, &e, (T)9, 0, S, F) && x == (T)9 && e == (T)(V)); \
    x = (V);                                                                           \
    e = (T)((V) + 1);                                                                  \
    CHECK(!__atomic_compare_exchange_n(&x, &e, (T)9, 0, S, F) && x == (T)(V) && e == (T)(V)); \
    x = (V);                                                                           \
    e = (T)((V) + 1);                                                                  \
    CHECK(!__atomic_compare_exchange_n(&x, &e, (T)9, 1, S, F) && x == (T)(V) && e == (T)(V)); \
    x = (V);                                                                           \
    *pe = (V);                                                                         \
    CHECK(__atomic_compare_exchange_n(&x, pe, (T)9, 0, S, F) && x == (T)9 && *pe == (T)(V)); \
    x = (V);                                                                           \
    *pe = (T)((V) + 1);                                                                \
    CHECK(!__atomic_compare_exchange_n(&x, pe, (T)9, 0, S, F) && x == (T)(V) && *pe == (T)(V));

/* Loads and stores of every order they take, and the `__sync` forms,
   which are full barriers but `__sync_lock_test_and_set`, an acquire. */
#define LOAD_STORE_SYNC(T, V)                                                      \
    __atomic_store_n(&x, (T)(V), RELAXED);                                         \
    CHECK(__atomic_load_n(&x, RELAXED) == (T)(V));                                 \
    __atomic_store_n(&x, (T)((V) + 1), RELEASE);                                   \
    CHECK(__atomic_load_n(&x, CONSUME) == (T)((V) + 1));                           \
    CHECK(__atomic_load_n(&x, ACQUIRE) == (T)((V) + 1));                           \
    __atomic_store_n(&x, (T)(V), SEQ_CST);                                         \
    CHECK(__atomic_load_n(&x, SEQ_CST) == (T)(V));                                 \
    CHECK(__sync_fetch_and_add(&x, (T)3) == (T)(V) && x == (T)((V) + 3));          \
    CHECK(__sync_sub_and_fetch(&x, (T)3) == (T)(V) && x == (T)(V));                \
    CHECK(__sync_fetch_and_xor(&x, (T)6) == (T)(V) && x == (T)((V) ^ 6));          \
    x = (V);                                                                       \
    CHECK(__sync_val_compare_and_swap(&x, (T)(V), (T)9) == (T)(V) && x == (T)9);   \
    CHECK(__sync_val_compare_and_swap(&x, (T)(V), (T)8) == (T)9 && x == (T)9);     \
    CHECK(__sync_bool_compare_and_swap(&x, (T)9, (T)(V)) && x == (T)(V));          \
    CHECK(!__sync_bool_compare_and_swap(&x, (T)9, (T)8) && x == (T)(V));           \
    CHECK(__sync_lock_test_and_set(&x, (T)7) == (T)(V) && x == (T)7);              \
    __sync_lock_release(&x);                                                       \
    CHECK(x == 0);

/* Every order on a `T` object: the read-modify-writes under each of the
   six, the compare-exchanges under success / failure pairs that name each
   and merge a release with an acquire. */
#define EVERY_ORDER(NAME, T, V)                  \
    static int NAME(void) {                      \
        static T x;                              \
        static T mem;                            \
        T e;                                     \
        T *pe = &mem;                            \
        RMW(T, V, RELAXED)                       \
        RMW(T, V, CONSUME)                       \
        RMW(T, V, ACQUIRE)                       \
        RMW(T, V, RELEASE)                       \
        RMW(T, V, ACQ_REL)                       \
        RMW(T, V, SEQ_CST)                       \
        CAS(T, V, RELAXED, RELAXED)              \
        CAS(T, V, CONSUME, CONSUME)              \
        CAS(T, V, ACQUIRE, ACQUIRE)              \
        CAS(T, V, RELEASE, RELAXED)              \
        CAS(T, V, ACQ_REL, ACQUIRE)              \
        CAS(T, V, SEQ_CST, SEQ_CST)              \
        CAS(T, V, RELEASE, ACQUIRE)              \
        LOAD_STORE_SYNC(T, V)                    \
        return 0;                                \
    }

/* Every width and signedness under one order each. */
#define ONE_ORDER(NAME, T, V, MO, FAIL)          \
    static int NAME(void) {                      \
        static T x;                              \
        static T mem;                            \
        T e;                                     \
        T *pe = &mem;                            \
        RMW(T, V, MO)                            \
        CAS(T, V, MO, FAIL)                      \
        LOAD_STORE_SYNC(T, V)                    \
        return 0;                                \
    }

ONE_ORDER(int_ops, int, -70000, SEQ_CST, ACQUIRE)
EVERY_ORDER(llong_ops, long long, -5000000000LL)
ONE_ORDER(schar_ops, signed char, -3, SEQ_CST, SEQ_CST)
ONE_ORDER(uchar_ops, unsigned char, 250, ACQUIRE, RELAXED)
ONE_ORDER(short_ops, short, -300, RELEASE, RELAXED)
ONE_ORDER(ushort_ops, unsigned short, 65000, ACQ_REL, ACQUIRE)
ONE_ORDER(uint_ops, unsigned, 4000000000u, RELAXED, RELAXED)
ONE_ORDER(ullong_ops, unsigned long long, 0x9000000000000000ULL, CONSUME, CONSUME)

/* A pointer object, the C11 generic functions on `_Atomic` objects, and
   the flag operations. */
static int other_ops(void) {
    static int cells[2];
    static int *p;
    static atomic_int ai;
    static atomic_llong al;
    static atomic_flag flag = ATOMIC_FLAG_INIT;
    static unsigned char byte;
    int *e;
    int ie;
    long long le;

    p = &cells[0];
    e = &cells[0];
    CHECK(__atomic_compare_exchange_n(&p, &e, &cells[1], 0, ACQ_REL, ACQUIRE) && p == &cells[1]);
    CHECK(!__atomic_compare_exchange_n(&p, &e, &cells[0], 0, SEQ_CST, RELAXED) && e == &cells[1]);
    CHECK(__atomic_exchange_n(&p, &cells[0], RELEASE) == &cells[1] && p == &cells[0]);

    atomic_init(&ai, 10);
    CHECK(atomic_fetch_add(&ai, 5) == 10 && atomic_load(&ai) == 15);
    CHECK(atomic_fetch_sub_explicit(&ai, 3, memory_order_release) == 15);
    CHECK(atomic_fetch_or_explicit(&ai, 64, memory_order_acquire) == 12);
    CHECK(atomic_fetch_and_explicit(&ai, 72, memory_order_acq_rel) == 76);
    CHECK(atomic_fetch_xor_explicit(&ai, 1, memory_order_relaxed) == 72);
    CHECK(atomic_exchange_explicit(&ai, -1, memory_order_consume) == 73);
    ie = -1;
    CHECK(atomic_compare_exchange_strong(&ai, &ie, 4) && atomic_load(&ai) == 4);
    CHECK(!atomic_compare_exchange_weak_explicit(&ai, &ie, 5, memory_order_acquire,
                                                 memory_order_relaxed) &&
          ie == 4);
    atomic_store_explicit(&al, -5000000000LL, memory_order_release);
    le = -5000000000LL;
    CHECK(atomic_compare_exchange_strong_explicit(&al, &le, 7, memory_order_seq_cst,
                                                  memory_order_seq_cst) &&
          atomic_load_explicit(&al, memory_order_acquire) == 7);

    CHECK(!atomic_flag_test_and_set_explicit(&flag, memory_order_acquire));
    CHECK(atomic_flag_test_and_set(&flag));
    atomic_flag_clear_explicit(&flag, memory_order_release);
    CHECK(!atomic_flag_test_and_set(&flag));
    atomic_flag_clear(&flag);
    CHECK(!__atomic_test_and_set(&byte, RELAXED) && __atomic_test_and_set(&byte, SEQ_CST));
    __atomic_clear(&byte, RELEASE);
    CHECK(byte == 0);
    return 0;
}

int main(void) {
    int r;

    if ((r = schar_ops()) || (r = uchar_ops()) || (r = short_ops()) || (r = ushort_ops()) ||
        (r = int_ops()) || (r = uint_ops()) || (r = llong_ops()) || (r = ullong_ops()) ||
        (r = other_ops()))
        return r;
    return 0;
}

// C11 <stdatomic.h> (7.17) layered on c5's atomic builtins, plus the
// `_Atomic(type-name)` specifier in every base-type position (plain
// declaration, typedef, struct field) and the C99 minimum-width /
// fastest-minimum-width stdint types the atomic typedefs rely on.

#include <stdatomic.h>
#include <stdint.h>

typedef _Atomic(int) my_atomic_int;

struct holder {
    _Atomic(long) counter;
    _Atomic int flag;
};

int main(void) {
    // Explicit-order operations (the order operand is accepted, dropped).
    atomic_int x = 0;
    atomic_store_explicit(&x, 5, memory_order_relaxed);
    if (atomic_load_explicit(&x, memory_order_acquire) != 5) return 1;
    if (atomic_fetch_add_explicit(&x, 10, memory_order_seq_cst) != 5) return 2;
    if (x != 15) return 3;

    int expected = 15;
    if (!atomic_compare_exchange_strong_explicit(
            &x, &expected, 99, memory_order_seq_cst, memory_order_relaxed))
        return 4;
    if (x != 99) return 5;

    atomic_thread_fence(memory_order_seq_cst);

    // The atomic flag.
    atomic_flag f = ATOMIC_FLAG_INIT;
    if (atomic_flag_test_and_set(&f) != 0) return 6;
    atomic_flag_clear(&f);

    // `_Atomic(T)` typedef and struct fields.
    my_atomic_int y = 0;
    atomic_store(&y, 42);
    if (atomic_load(&y) != 42) return 7;

    struct holder h;
    atomic_store(&h.counter, 100);
    atomic_fetch_add(&h.counter, 1);
    if (atomic_load(&h.counter) != 101) return 8;
    h.flag = 1;
    if (h.flag != 1) return 9;

    // C99 minimum-width / fastest-minimum-width integer types.
    int_least16_t a = 0x7fff;
    uint_fast32_t b = 0xffffffffu;
    if (sizeof(a) < 2 || a != 0x7fff) return 10;
    if (b != 0xffffffffu) return 11;
    if (INT_LEAST16_MAX != 32767) return 12;

    return 0;
}

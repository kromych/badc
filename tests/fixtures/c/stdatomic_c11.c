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
    // Explicit-order operations (the order operand selects the access).
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
    atomic_thread_fence(memory_order_acquire);
    atomic_thread_fence(memory_order_release);
    atomic_signal_fence(memory_order_seq_cst);

    // A floating atomic object moves its bits through the integer
    // access.
    _Atomic double d = 0.0;
    atomic_store_explicit(&d, 2.5, memory_order_release);
    if (atomic_load_explicit(&d, memory_order_acquire) != 2.5) return 13;
    _Atomic float g;
    atomic_init(&g, -1.25f);
    if (atomic_load(&g) != -1.25f) return 14;
    atomic_store(&g, 3.0f);
    if (g != 3.0f) return 15;

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

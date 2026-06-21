// C11 7.17.7 atomic read-modify-write and compare-exchange. Exercises
// every operator and both compare-exchange outcomes, including the
// 7.17.7.4 requirement that a failed exchange writes the current
// object value back into the expected operand. Single-threaded, so it
// checks the sequential semantics of the genuine atomic lowering.

#include <stdatomic.h>

int main(void) {
    _Atomic long x = 10;

    if (atomic_fetch_add(&x, 5) != 10 || x != 15) return 1;
    if (atomic_fetch_sub(&x, 3) != 15 || x != 12) return 2;
    if (atomic_fetch_and(&x, 0xF0) != 12 || x != 0) return 3;
    if (atomic_fetch_or(&x, 0x5) != 0 || x != 5) return 4;
    if (atomic_fetch_xor(&x, 0x6) != 5 || x != 3) return 5;
    if (atomic_exchange(&x, 99) != 3 || x != 99) return 6;

    long expected = 99;
    if (!atomic_compare_exchange_strong(&x, &expected, 7)) return 7;
    if (x != 7) return 8;

    // Mismatch: the result is 0, the object is unchanged, and the
    // expected operand receives the current value (C11 7.17.7.4).
    expected = 100;
    if (atomic_compare_exchange_strong(&x, &expected, 0)) return 9;
    if (x != 7 || expected != 7) return 10;

    // 32-bit width through a distinct object.
    _Atomic int y = 4;
    if (atomic_fetch_add(&y, 1) != 4 || y != 5) return 11;
    int ey = 5;
    if (!atomic_compare_exchange_strong(&y, &ey, -1)) return 12;
    if (y != -1) return 13;

    // 32-bit-width read-modify-write whose prior value is consumed. The
    // compare-exchange retry path seeds the prior value from a load; that
    // load and the result must be the element width, not a wider register,
    // or a high-half residue makes the returned value wrong.
    _Atomic int z = 12;
    if (atomic_fetch_and(&z, 0xF0) != 12 || z != 0) return 14;
    if (atomic_fetch_or(&z, 0x5) != 0 || z != 5) return 15;
    if (atomic_fetch_xor(&z, 0x6) != 5 || z != 3) return 16;

    return 0;
}

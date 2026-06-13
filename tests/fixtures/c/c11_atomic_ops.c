// C11 7.17 atomic generic functions. c5 recognizes these as
// compiler builtins (the <stdatomic.h> macros forward to them) and
// lowers each to load / store / read-modify-write on the pointee
// width of the first argument. A naturally-aligned scalar load and
// store is already atomic on the supported targets; the
// read-modify-write and compare-exchange forms are correct for a
// single thread but not yet inter-thread atomic. Values are
// asserted by return code so the result is independent of any
// tier's printf format-spec coverage.

#include <stdint.h>

int main(void) {
    uint32_t x = 100;

    if (atomic_load((_Atomic(uint32_t) *)&x) != 100) return 1;
    atomic_store((_Atomic(uint32_t) *)&x, 250);
    if (atomic_load((_Atomic(uint32_t) *)&x) != 250) return 2;

    // fetch_* return the prior value and apply the operator in place.
    if (atomic_fetch_add((_Atomic(uint32_t) *)&x, 5) != 250) return 3;
    if (x != 255) return 4;
    if (atomic_fetch_sub((_Atomic(uint32_t) *)&x, 50) != 255) return 5;
    if (x != 205) return 6;
    if (atomic_fetch_or((_Atomic(uint32_t) *)&x, 0xF00) != 205) return 7;
    if (x != (205 | 0xF00)) return 8;
    if (atomic_fetch_and((_Atomic(uint32_t) *)&x, 0xFF) != (205 | 0xF00)) return 9;
    if (x != ((205 | 0xF00) & 0xFF)) return 10;
    if (atomic_fetch_xor((_Atomic(uint32_t) *)&x, 0x0F) != 205) return 11;
    if (x != (205 ^ 0x0F)) return 12;

    // exchange yields the prior value and stores the new one.
    if (atomic_exchange((_Atomic(uint32_t) *)&x, 7) != (uint32_t)(205 ^ 0x0F)) return 13;
    if (x != 7) return 14;

    // compare_exchange_strong: success stores desired and yields 1.
    uint32_t expv = 7;
    if (atomic_compare_exchange_strong((_Atomic(uint32_t) *)&x, &expv, 99) != 1) return 15;
    if (x != 99) return 16;
    // Failure leaves the object, writes the current value through the
    // expected pointer, and yields 0.
    uint32_t expw = 5;
    if (atomic_compare_exchange_strong((_Atomic(uint32_t) *)&x, &expw, 1234) != 0) return 17;
    if (x != 99) return 18;
    if (expw != 99) return 19;

    // 8-bit width wraps within the byte.
    uint8_t y8 = 200;
    if (atomic_fetch_add((_Atomic(uint8_t) *)&y8, 100) != 200) return 20;
    if (y8 != (uint8_t)44) return 21;

    // 16- and 64-bit widths.
    uint16_t y16 = 40000;
    if (atomic_fetch_add((_Atomic(uint16_t) *)&y16, 30000) != 40000) return 22;
    if (y16 != (uint16_t)(70000)) return 23;

    uint64_t y64 = 0x1122334455667788ull;
    if (atomic_exchange((_Atomic(uint64_t) *)&y64, 1) != 0x1122334455667788ull) return 24;
    if (y64 != 1) return 25;

    return 0;
}

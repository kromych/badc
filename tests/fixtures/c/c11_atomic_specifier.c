// C11 6.7.2.4 atomic type specifier `_Atomic ( type-name )` and 6.7.3
// `_Atomic` type qualifier. c5 does not model atomicity, so both forms
// reduce to the unqualified inner type: storage, arithmetic, and
// pointer behaviour are identical to the same declaration without
// `_Atomic`. Verified by exact-value comparison so the result is
// independent of the printf format-spec coverage of any one tier.

#include <stdint.h>

int main(void) {
    // Specifier form on integer typedefs of each width.
    _Atomic(uint8_t) a = 200;
    _Atomic(uint16_t) b = 40000;
    _Atomic(uint32_t) c = 0x11223344u;
    _Atomic(uint64_t) d = 0x1122334455667788ull;

    if (a != 200) return 1;
    if (b != 40000) return 2;
    if (c != 0x11223344u) return 3;
    if (d != 0x1122334455667788ull) return 4;

    // Specifier form with an abstract pointer declarator inside the
    // parentheses; the cast spelling matches the declaration.
    _Atomic(uint8_t) *p = (_Atomic(uint8_t) *)&a;
    if (*p != 200) return 5;
    *p = 250;
    if (a != 250) return 6;

    // Qualifier form, alone and combined with other qualifiers and a
    // multi-word base type.
    _Atomic int q = -7;
    const _Atomic unsigned long r = 99;
    volatile _Atomic short s = 13;
    if (q != -7) return 7;
    if (r != 99) return 8;
    if (s != 13) return 9;

    // Qualifier form in a pointer's pointee.
    _Atomic int *qp = &q;
    *qp = 21;
    if (q != 21) return 10;

    return 0;
}

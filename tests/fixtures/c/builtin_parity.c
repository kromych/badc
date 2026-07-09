// GCC `__builtin_parity` / `__builtin_parityll`: 1 when the operand has an
// odd number of set bits, else 0 (used by QEMU's bitops.h). Returns 0 on
// success; a distinct non-zero code per failure.

int main(void) {
    if (__builtin_parity(0) != 0) {
        return 1;
    }
    if (__builtin_parity(1) != 1) {
        return 2;
    }
    if (__builtin_parity(3) != 0) {
        return 3;
    }
    if (__builtin_parity(0x7) != 1) {
        return 4;
    }
    if (__builtin_parity(0xffffffff) != 0) {
        return 5;
    }
    if (__builtin_parity(0x80000001) != 0) {
        return 6;
    }
    if (__builtin_parityll(0ULL) != 0) {
        return 7;
    }
    if (__builtin_parityll(0xffffffffffffffffULL) != 0) {
        return 8;
    }
    if (__builtin_parityll(0x8000000000000001ULL) != 0) {
        return 9;
    }
    if (__builtin_parityll(0x1ULL) != 1) {
        return 10;
    }
    // Runtime (non-constant) operands go through the same lowering.
    volatile unsigned v = 0x1234; // five set bits -> odd
    if (__builtin_parity(v) != 1) {
        return 11;
    }
    volatile unsigned long long w = 0xf0f0; // eight set bits -> even
    if (__builtin_parityll(w) != 0) {
        return 12;
    }
    return 0;
}

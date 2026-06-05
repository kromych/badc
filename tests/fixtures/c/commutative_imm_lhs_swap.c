// Locks the walker's commutative-Imm-lhs swap. `4 * i` and `K * x`
// shapes used to emit `Binop { lhs = Imm, rhs = x }`, forcing the
// constant to need its own SSA value (and register / spill). The
// peephole rewrites these to `BinopI { lhs = x, rhs_imm = K }` so
// the literal flows through the per-arch immediate-form opcode.
//
// The shape covers Add / Mul / And / Or / Xor / Eq / Ne. The
// ordered comparisons (Lt / Gt / Le / Ge and unsigned variants)
// stay on the register-rhs path because they are not commutative.

int main(void) {
    int n = 7;
    if (4 * n != 28) return 1;        // Mul, imm lhs
    if (3 + n != 10) return 2;        // Add, imm lhs
    if ((0xf0 & n) != 0) return 3;    // And, imm lhs (0xf0 & 7 == 0)
    if ((0x10 | n) != 0x17) return 4; // Or, imm lhs
    if ((0xff ^ n) != 0xf8) return 5; // Xor, imm lhs
    if ((1 == n) != 0) return 6;      // Eq, imm lhs
    if ((1 != n) != 1) return 7;      // Ne, imm lhs

    // Confirm the four ops stay on the register-rhs path when the
    // imm is on the lhs and the op is NOT commutative -- subtract
    // and the ordered relations.
    if ((10 - n) != 3) return 8;
    if (!(8 > n)) return 9;
    return 0;
}

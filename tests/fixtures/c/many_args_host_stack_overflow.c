// Calls a function with more parameters than the host ABI's
// integer arg-register bank. AAPCS64 has 8 int arg regs, SysV
// has 6, Win64 has 4 -- 11 declared parameters forces every
// host ABI to spill 3+ params onto the host stack at 8-byte
// stride. The callee's prologue must re-stripe that 8-byte run
// into the c5 cdecl 16-byte slots its body reads via `Op::Lea`.
//
// Returns 0 on success, non-zero (the failing slot's 1-based
// index) on mismatch. Locks in the host-stack-overflow restripe
// against silent regressions when the prologue shape changes.

int sum_eleven(int a, int b, int c, int d, int e, int f,
               int g, int h, int i, int j, int k) {
    if (a != 1)  return 1;
    if (b != 2)  return 2;
    if (c != 3)  return 3;
    if (d != 4)  return 4;
    if (e != 5)  return 5;
    if (f != 6)  return 6;
    if (g != 7)  return 7;
    if (h != 8)  return 8;
    if (i != 9)  return 9;
    if (j != 10) return 10;
    if (k != 11) return 11;
    return 0;
}

int main(void) {
    return sum_eleven(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11);
}

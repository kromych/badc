// A static `&&label` dispatch table driven across repeated calls: after
// the first call initializes the table, later calls take the once-guard
// skip path and must still dispatch through correct label addresses.
// The interpreter sums operands until halt; a second program re-enters
// the same function.

static int interp(const unsigned char *code) {
    static void *tbl[] = { &&op_add, &&op_sub, &&op_dup, &&op_halt };
    int acc = 0;
    int pc = 0;
    goto *tbl[code[pc++]];
op_add:
    acc += code[pc++];
    goto *tbl[code[pc++]];
op_sub:
    acc -= code[pc++];
    goto *tbl[code[pc++]];
op_dup:
    acc += acc;
    goto *tbl[code[pc++]];
op_halt:
    return acc;
}

int main(void) {
    // ADD 5, DUP, SUB 3, HALT => (5*2)-3 = 7
    static const unsigned char p1[] = { 0, 5, 2, 1, 3, 3 };
    // ADD 9, SUB 4, DUP, HALT => (9-4)*2 = 10
    static const unsigned char p2[] = { 0, 9, 1, 4, 2, 3 };
    if (interp(p1) != 7) return 1;
    if (interp(p2) != 10) return 2;
    if (interp(p1) != 7) return 3;
    return 0;
}

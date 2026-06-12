// GCC labels-as-values (computed goto): `&&label` yields a label's
// address as a `void *`, and `goto *expr` branches to it. The address
// table is populated at runtime; a small bytecode interpreter exercises
// forward dispatch, a back edge (the loop through OP_LOOP), and a direct
// `goto *p` on a scalar.

static int direct(int sel) {
    void *p = (sel == 0) ? &&A : &&B;
    goto *p;
A:
    return 10;
B:
    return 20;
}

// Run a tiny program: opcodes index a label table. The program computes
// (((0 + 5) - 2) + 4) and halts.
static int interp(int *prog) {
    void *tab[3];
    tab[0] = &&OP_ADD;
    tab[1] = &&OP_SUB;
    tab[2] = &&OP_HALT;
    int acc = 0, pc = 0;
    goto *tab[prog[pc++]];
OP_ADD:
    acc += prog[pc++];
    goto *tab[prog[pc++]];
OP_SUB:
    acc -= prog[pc++];
    goto *tab[prog[pc++]];
OP_HALT:
    return acc;
}

// A back edge: loop until n reaches the limit by jumping to the same
// label address each iteration.
static int loop_to(int limit) {
    void *tab[2];
    tab[0] = &&LOOP;
    tab[1] = &&DONE;
    int n = 0;
LOOP:
    n += 1;
    goto *tab[(n < limit) ? 0 : 1];
DONE:
    return n;
}

int main(void) {
    if (direct(0) != 10) return 1;
    if (direct(1) != 20) return 2;

    int prog[] = {0, 5, 1, 2, 0, 4, 2}; // ADD 5, SUB 2, ADD 4, HALT
    if (interp(prog) != 7) return 3;

    if (loop_to(5) != 5) return 4;
    if (loop_to(1) != 1) return 5;

    return 0;
}

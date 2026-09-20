/* Computed-goto interpreters whose locals live in registers across the
   dispatch: every `goto *` of a function is routed through one dispatch
   block, where a value live across it merges, and a label also entered by
   a direct edge merges its values in a phi of its own. Each interpreter is
   checked against a switch-dispatch twin and against fixed results; main
   returns 0 when every check passes. */

enum {
    OP_PUSH, OP_ADD, OP_SUB, OP_MUL, OP_DUP, OP_SWAP, OP_JNZ, OP_DEC,
    OP_INC2, OP_INC, OP_SUM4, OP_NOP1, OP_NOP2, OP_HALT, OP_COUNT
};

static long hits[OP_COUNT];

/* A stack machine. OP_INC2 falls into OP_INC with another `acc`, OP_NOP1
   and OP_NOP2 share a handler, and every dispatch counts its opcode. */
static long run(const long *code, long *stack) {
    static const void *const tab[OP_COUNT] = {
        &&op_push, &&op_add, &&op_sub, &&op_mul, &&op_dup, &&op_swap, &&op_jnz,
        &&op_dec, &&op_inc2, &&op_inc, &&op_sum4, &&op_nop1, &&op_nop2, &&op_halt,
    };
    long pc = 0, acc = 0, steps = 0, *sp = stack;
#define DISPATCH() do { long op_ = code[pc++]; hits[op_]++; steps++; goto *tab[op_]; } while (0)
    DISPATCH();
op_push:
    *sp++ = code[pc++];
    DISPATCH();
op_add:
    sp--;
    sp[-1] += sp[0];
    DISPATCH();
op_sub:
    sp--;
    sp[-1] -= sp[0];
    DISPATCH();
op_mul:
    sp--;
    sp[-1] *= sp[0];
    DISPATCH();
op_dup:
    sp[0] = sp[-1];
    sp++;
    DISPATCH();
op_swap: {
        long t = sp[-1];
        sp[-1] = sp[-2];
        sp[-2] = t;
    }
    DISPATCH();
op_jnz: {
        long target = code[pc++];
        if (sp[-1] != 0)
            pc = target;
    }
    DISPATCH();
op_dec:
    sp[-1]--;
    DISPATCH();
op_inc2:
    acc += 2;
op_inc:
    acc += 1;
    DISPATCH();
op_sum4:
    for (int i = 0; i < 4; i++)
        acc += code[pc + i] * (i + 1);
    pc += 4;
    DISPATCH();
op_nop1:
op_nop2:
    DISPATCH();
op_halt:
    return sp[-1] * 1000 + acc * 10 + steps;
#undef DISPATCH
}

static long run_switch(const long *code, long *stack) {
    long pc = 0, acc = 0, steps = 0, *sp = stack;
    for (;;) {
        long op = code[pc++];
        steps++;
        switch (op) {
        case OP_PUSH: *sp++ = code[pc++]; break;
        case OP_ADD: sp--; sp[-1] += sp[0]; break;
        case OP_SUB: sp--; sp[-1] -= sp[0]; break;
        case OP_MUL: sp--; sp[-1] *= sp[0]; break;
        case OP_DUP: sp[0] = sp[-1]; sp++; break;
        case OP_SWAP: { long t = sp[-1]; sp[-1] = sp[-2]; sp[-2] = t; } break;
        case OP_JNZ: { long target = code[pc++]; if (sp[-1] != 0) pc = target; } break;
        case OP_DEC: sp[-1]--; break;
        case OP_INC2: acc += 3; break;
        case OP_INC: acc += 1; break;
        case OP_SUM4:
            for (int i = 0; i < 4; i++)
                acc += code[pc + i] * (i + 1);
            pc += 4;
            break;
        case OP_NOP1: case OP_NOP2: break;
        default: return sp[-1] * 1000 + acc * 10 + steps;
        }
    }
}

/* Twelve counters live across the dispatch; on x86-64 some of the
   dispatch block's phis take frame slots. The label table is built at run
   time and one handler compares a label address. */
static long pressure(const unsigned char *code, int n) {
    void *tab[4];
    long a0 = 1, a1 = 2, a2 = 3, a3 = 4, a4 = 5, a5 = 6;
    long a6 = 7, a7 = 8, a8 = 9, a9 = 10, a10 = 11, a11 = 12;
    int pc = 0;
    tab[0] = &&op_a;
    tab[1] = &&op_b;
    tab[2] = &&op_c;
    tab[3] = &&op_end;
    goto *tab[code[pc++ % n]];
op_a:
    a0 += a11; a1 += a0; a2 += a1; a3 += a2; a4 ^= a3; a5 += a4;
    goto *tab[code[pc++ % n]];
op_b:
    a6 += a5; a7 -= a6; a8 += a7; a9 ^= a8; a10 += a9; a11 += a10;
    goto *tab[code[pc++ % n]];
op_c:
    if (tab[code[pc % n]] == &&op_end)
        a0 += 1000;
    a1 ^= a0; a3 += a2; a5 -= a4; a7 += a6; a9 -= a8; a11 ^= a10;
    goto *tab[code[pc++ % n]];
op_end:
    return a0 + 2 * a1 + 3 * a2 + 4 * a3 + 5 * a4 + 6 * a5 + 7 * a6 + 8 * a7 + 9 * a8 +
           10 * a9 + 11 * a10 + 12 * a11 + pc;
}

static long pressure_switch(const unsigned char *code, int n) {
    long a0 = 1, a1 = 2, a2 = 3, a3 = 4, a4 = 5, a5 = 6;
    long a6 = 7, a7 = 8, a8 = 9, a9 = 10, a10 = 11, a11 = 12;
    int pc = 0;
    for (;;) {
        switch (code[pc++ % n]) {
        case 0: a0 += a11; a1 += a0; a2 += a1; a3 += a2; a4 ^= a3; a5 += a4; break;
        case 1: a6 += a5; a7 -= a6; a8 += a7; a9 ^= a8; a10 += a9; a11 += a10; break;
        case 2:
            if (code[pc % n] == 3)
                a0 += 1000;
            a1 ^= a0; a3 += a2; a5 -= a4; a7 += a6; a9 -= a8; a11 ^= a10;
            break;
        default:
            return a0 + 2 * a1 + 3 * a2 + 4 * a3 + 5 * a4 + 6 * a5 + 7 * a6 + 8 * a7 +
                   9 * a8 + 10 * a9 + 11 * a10 + 12 * a11 + pc;
        }
    }
}

typedef struct { long v; long tag; } Value;

/* A struct local a handler replaces whole, and a label (`op_take`) the
   `op_skip` handler also enters by a direct `goto` with other values. */
static long records(const unsigned char *pc, const Value *vals) {
    static const void *const tab[] = { &&op_take, &&op_skip, &&op_end };
    Value top = { 0, 0 };
    long taken = 0, skipped = 0;
    goto *tab[*pc++];
op_skip:
    skipped++;
    if (*pc == 0) {
        pc++;
        taken += 100;
        goto op_take;
    }
    goto *tab[*pc++];
op_take: {
        Value x = vals[*pc++];
        if (x.tag > top.tag)
            top = x;
        taken++;
    }
    goto *tab[*pc++];
op_end:
    return top.v * 10000 + top.tag * 1000 + taken * 10 + skipped;
}

/* Recursion through a label in accumulator form. */
static long depth(const unsigned char *pc) {
    static const void *const tab[] = { &&op_in, &&op_out };
    goto *tab[*pc];
op_in:
    return (long)pc[1] + depth(pc + 2);
op_out:
    return 0;
}

/* One indirect branch; its label `b` is also entered directly with
   another `y`. */
static int single(int sel, int x) {
    void *p = sel ? &&a : &&b;
    int y = x;
    if (x > 100) {
        y = x * 2;
        goto b;
    }
    goto *p;
a:
    return y + 1;
b:
    return y + 2;
}

int main(void) {
    long stack[16];
    /* 5 3 SUM4(1 2 3 4) INC2 INC NOP1 NOP2 then count down 3..0 with a DUP
       and an ADD per turn. */
    static const long prog[] = {
        OP_PUSH, 5, OP_PUSH, 3, OP_SUM4, 1, 2, 3, 4, OP_INC2, OP_INC, OP_NOP1, OP_NOP2,
        OP_MUL, OP_PUSH, 3,
        /* 16: */ OP_DEC, OP_SWAP, OP_DUP, OP_ADD, OP_SWAP, OP_JNZ, 16,
        OP_SWAP, OP_PUSH, 7, OP_SUB, OP_HALT,
    };
    long got = run(prog, stack);
    if (got != run_switch(prog, stack))
        return 1;
    if (got != 113371)
        return 2;
    long total = 0;
    for (int op = 0; op < OP_COUNT; op++)
        total += hits[op];
    if (total != 31 || hits[OP_JNZ] != 3 || hits[OP_SUM4] != 1 || hits[OP_HALT] != 1)
        return 3;

    static const unsigned char pcode[] = { 0, 1, 2, 0, 0, 1, 2, 1, 0, 2, 3 };
    long p = pressure(pcode, (int)sizeof pcode);
    if (p != pressure_switch(pcode, (int)sizeof pcode))
        return 4;
    if (p != -4894)
        return 5;

    static const Value vals[] = { { 7, 1 }, { 9, 3 }, { 4, 2 }, { 8, 5 } };
    static const unsigned char rcode[] = { 0, 0, 1, 0, 2, 1, 1, 0, 1, 0, 3, 2 };
    long r = records(rcode, vals);
    if (r != 87043)
        return 6;

    static const unsigned char dcode[] = { 0, 4, 0, 5, 0, 6, 1 };
    if (depth(dcode) != 15)
        return 7;

    if (single(1, 5) != 6 || single(0, 5) != 7 || single(1, 200) != 402)
        return 8;
    return 0;
}

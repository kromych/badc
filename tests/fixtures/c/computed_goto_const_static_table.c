// A `&&label` dispatch table declared `const` in each spelling that makes
// the storage const-qualified: `const T *const []`, `T *const []`, and a
// non-pointer element type. The elements are not link-time constants, so
// the declaration fills the storage with stores at run time -- the object
// must stay writable however it is qualified. Repeated calls also exercise
// the once-guard byte, which sits past the array and has to travel with
// it.

static int interp_ptr_const(const unsigned char *code) {
    static const void *const tbl[] = {&&op_add, &&op_sub, &&op_dup, &&op_halt};
    int acc = 0, pc = 0;
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

static int interp_decl_const(const unsigned char *code) {
    static void *const tbl[] = {&&op_add, &&op_sub, &&op_dup, &&op_halt};
    int acc = 0, pc = 0;
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

static int interp_long(const unsigned char *code) {
    static const long long tbl[] = {(long long)&&op_add, (long long)&&op_sub,
                                   (long long)&&op_dup, (long long)&&op_halt};
    int acc = 0, pc = 0;
    goto *(void *)tbl[code[pc++]];
op_add:
    acc += code[pc++];
    goto *(void *)tbl[code[pc++]];
op_sub:
    acc -= code[pc++];
    goto *(void *)tbl[code[pc++]];
op_dup:
    acc += acc;
    goto *(void *)tbl[code[pc++]];
op_halt:
    return acc;
}

// `int *const *p` qualifies the pointee pointer, not `p`: writing `p` is
// well defined and its storage must stay writable.
static int a = 1, b = 2;
static int *const pa = &a;
static int *const pb = &b;
static int *const *p = &pa;

int main(void) {
    // ADD 5, DUP, SUB 3, HALT => (5*2)-3 = 7
    static const unsigned char p1[] = {0, 5, 2, 1, 3, 3};
    // ADD 9, SUB 4, DUP, HALT => (9-4)*2 = 10
    static const unsigned char p2[] = {0, 9, 1, 4, 2, 3};
    if (interp_ptr_const(p1) != 7) return 1;
    if (interp_ptr_const(p2) != 10) return 2;
    if (interp_ptr_const(p1) != 7) return 3;
    if (interp_decl_const(p1) != 7) return 4;
    if (interp_decl_const(p2) != 10) return 5;
    if (interp_long(p1) != 7) return 6;
    if (interp_long(p2) != 10) return 7;
    if (**p != 1) return 8;
    p = &pb;
    if (**p != 2) return 9;
    return 0;
}

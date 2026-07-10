// GCC array range designator `[a ... b] = value` in an array initializer
// fills every element in the inclusive range with the value. Covers a
// constant-data range, a range that interleaves with single designators
// and positional entries, a label-address range (the computed-goto
// dispatch-table shape, which fills the slots with runtime stores), and a
// struct-array range whose value carries relocations (function pointers) --
// a real-world I/O-dispatch table shape. Asserted by return code.

static const int ct[16] = { [0] = 1, 2, [4 ... 9] = 7, [12 ... 15] = 9 };

static int op_read(void) { return 11; }
static int op_write(void) { return 22; }
struct Ops {
    int (*read)(void);
    int (*write)(void);
    int id;
};
// Every element in [0, 1] gets the same value, including its function-pointer
// relocations; [2]/[3] are single designators.
static const struct Ops ops[4] = {
    [0 ... 1] = { .read = op_read, .write = op_write, .id = 7 },
    [2] = { .read = op_write, .write = op_read, .id = 9 },
    [3] = { .read = op_read, .write = op_read, .id = 3 },
};

static int check_struct(void) {
    for (int i = 0; i < 2; i++) {
        if (ops[i].read() != 11 || ops[i].write() != 22 || ops[i].id != 7) return 20 + i;
    }
    if (ops[2].read() != 22 || ops[2].write() != 11 || ops[2].id != 9) return 22;
    if (ops[3].read() != 11 || ops[3].write() != 11 || ops[3].id != 3) return 23;
    return 0;
}

// C99 6.7.8p7 compound designator `[N].field = v` overrides one field of an
// element already filled by the range -- a real-world per-variant override
// shape. Covers a scalar field (.id) and a pointer field (.read), each
// keeping the range template's other fields.
static const struct Ops ops2[2] = {
    [0 ... 1] = { .read = op_read, .write = op_write, .id = 5 },
    [0].id = 100,
    [1].read = op_write,
};

static int check_override(void) {
    if (ops2[0].read() != 11 || ops2[0].write() != 22 || ops2[0].id != 100) return 30;
    if (ops2[1].read() != 22 || ops2[1].write() != 22 || ops2[1].id != 5) return 31;
    return 0;
}

static int check_const(void) {
    if (ct[0] != 1) return 1;
    if (ct[1] != 2) return 2;        // positional after [0]
    if (ct[2] != 0) return 3;        // gap stays zero
    if (ct[4] != 7 || ct[9] != 7) return 4;
    if (ct[3] != 0 || ct[10] != 0) return 5; // outside the range
    if (ct[12] != 9 || ct[15] != 9) return 6;
    return 0;
}

static int dispatch(int op) {
    static const void *const tbl[8] = { &&L0, &&L1, [2 ... 7] = &&Ldef };
    goto *(void *)tbl[op];
L0:
    return 100;
L1:
    return 200;
Ldef:
    return 999;
}

int main(void) {
    int rc = check_const();
    if (rc) return rc;
    rc = check_struct();
    if (rc) return rc;
    rc = check_override();
    if (rc) return rc;
    if (dispatch(0) != 100) return 10;
    if (dispatch(1) != 200) return 11;
    if (dispatch(2) != 999) return 12;
    if (dispatch(5) != 999) return 13;
    if (dispatch(7) != 999) return 14;
    return 0;
}

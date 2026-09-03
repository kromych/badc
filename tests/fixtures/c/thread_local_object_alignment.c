// C99 6.2.8 / C11 6.7.5: an object with thread storage duration sits on a
// boundary suitable for its type. The thread-local block carries no
// per-object placement record -- unlike `.data`, whose objects the writer
// places from the recorded alignment -- so the reservation offset is the
// placement and has to take the object's own alignment. The single-byte
// objects between the wide ones keep the running offset off every 16-byte
// boundary. Returns 0, distinct non-zero per failure.
//
// TODO: a file-scope `_Thread_local` object of a type wider than 8 bytes is
// still placed on the 8-byte boundary, so the checks here stay at block
// scope.

struct s16 {
    long a, b;
} __attribute__((aligned(16)));

static int misaligned(const void *p, unsigned long want) {
    return ((unsigned long)p & (want - 1)) != 0;
}

static int block_scope_boundaries(void) {
    static __thread char pad0;
    static __thread double d;
    static __thread char pad1;
    static __thread struct s16 wide;
    static __thread char pad2;
    static __thread long long ll;
    static __thread char pad3;
    static __thread struct s16 wide2;

    if (misaligned(&d, 8)) return 1;
    if (misaligned(&wide, 16)) return 2;
    if (misaligned(&ll, 8)) return 3;
    if (misaligned(&wide2, 16)) return 4;

    d = 1.5;
    wide.a = 3;
    wide.b = 4;
    ll = 5;
    wide2.a = 6;
    wide2.b = 7;
    pad0 = 1;
    pad1 = 2;
    pad2 = 3;
    pad3 = 4;
    if (d != 1.5 || ll != 5) return 5;
    if (wide.a + wide.b + wide2.a + wide2.b != 20) return 6;
    if (pad0 + pad1 + pad2 + pad3 != 10) return 7;
    return 0;
}

static int wide_array_boundary(void) {
    static __thread char pad;
    static __thread struct s16 rows[3];

    if (misaligned(rows, 16)) return 8;
    if (misaligned(&rows[1], 16)) return 9;
    rows[2].a = 8;
    pad = 1;
    if (rows[2].a + pad != 9) return 10;
    return 0;
}

int main(void) {
    int rc = block_scope_boundaries();
    if (rc) return rc;
    return wide_array_boundary();
}

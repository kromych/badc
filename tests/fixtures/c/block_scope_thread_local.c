// C11 6.7.1: a block-scope `static _Thread_local` object (or the GNU
// `static __thread` spelling) has thread storage duration -- it lives in the
// TLS block (.tdata / .tbss), one instance per thread, persisting across
// calls like a `static`. Single-threaded here, so the values accumulate.

static int counter(void) {
    static _Thread_local int c;
    return ++c;
}

static long array_and_struct(void) {
    static __thread char buf[64];
    static __thread struct {
        long a, b;
    } q;
    buf[3] = 5;
    q.a = 9;
    q.b = 11;
    return buf[3] + q.a + q.b;
}

static int with_bool(void) {
    static __thread int reentered;
    if (reentered) {
        return 0;
    }
    reentered = 1;
    return 1;
}

int main(void) {
    if (counter() != 1) return 1;
    if (counter() != 2) return 2; // persists across calls
    if (counter() != 3) return 3;
    if (array_and_struct() != 25) return 4; // 5 + 9 + 11
    if (with_bool() != 1) return 5;
    if (with_bool() != 0) return 6; // reentered stays set
    return 0;
}

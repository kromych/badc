// An `asm goto` runs, on the edge to each of its labels, the cleanup
// functions a `goto` to that label would, and none on its fall-through;
// an edge that leaves a block ends the lifetimes of its objects and
// reaches the label. Exits 0, or the number of the first failed check.

static char trace[16];
static int n;
static void rec(char c) {
    trace[n++] = c;
    trace[n] = 0;
}
static void c_a(int *p) {
    (void)p;
    rec('a');
}
static void c_b(int *p) {
    (void)p;
    rec('b');
}
#define CL(f) __attribute__((cleanup(f)))

static int checks, failed;
static void expect_true(int ok) {
    checks++;
    if (!ok && !failed)
        failed = checks;
}
static void expect(const char *want) {
    int i = 0;
    while (trace[i] && trace[i] == want[i])
        i++;
    expect_true(trace[i] == want[i]);
    n = 0;
    trace[0] = 0;
}

#if defined(__x86_64__) || defined(_M_X64)
#define TO_OUT "cmpl $1, %0; je %l[out]"
#define TO_OUT_OR_MID "cmpl $1, %0; je %l[out]; cmpl $2, %0; je %l[mid]"
#elif defined(__aarch64__) || defined(_M_ARM64)
#define TO_OUT "cmp %w0, #1; b.eq %l[out]"
#define TO_OUT_OR_MID "cmp %w0, #1; b.eq %l[out]; cmp %w0, #2; b.eq %l[mid]"
#endif

// Label `out` leaves both scopes, `mid` only the inner one.
static void by_asm(int x) {
    {
        int a CL(c_a) = 0;
        {
            int b CL(c_b) = 0;
            (void)a, (void)b;
#ifdef TO_OUT_OR_MID
            __asm__ goto(TO_OUT_OR_MID : : "r"(x) : : out, mid);
#else
            if (x == 1)
                goto out;
            if (x == 2)
                goto mid;
#endif
            rec('-');
        }
    mid:
        rec('.');
    }
out:
    rec('|');
}

// The edge leaves a block whose array ends its lifetime there.
static int sink(char *p) {
    return p[0];
}
static int plain(int x) {
    int r;
    {
        char buf[64];
        buf[0] = (char)x;
        r = sink(buf);
#ifdef TO_OUT
        __asm__ goto(TO_OUT : : "r"(x) : : out);
#else
        if (x == 1)
            goto out;
#endif
        r += 10;
    }
    {
        char other[64];
        other[0] = 20;
        r += sink(other);
    }
out:
    return r;
}

int main(void) {
    by_asm(0);
    expect("-b.a|");
    by_asm(1);
    expect("ba|");
    by_asm(2);
    expect("b.a|");
    expect_true(plain(1) == 1);
    expect_true(plain(0) == 30);
    return failed;
}

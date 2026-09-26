// Jumps to one label run the cleanup functions of the scopes they leave
// once each, however many jumps leave the same scopes: gotos and `asm goto`
// edges from one scope, jumps from a block with storage of its own beside
// jumps from its parent, jumps whose cleanup lists differ, and jumps out of
// a variable-length array's scope, which release its storage. Exits 0, or
// the number of the first failed check.

#include <stdint.h>

static char trace[32];
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
#elif defined(__aarch64__) || defined(_M_ARM64)
#define TO_OUT "cmp %w0, #1; b.eq %l[out]"
#endif

// Three gotos and two `asm goto` edges leave one scope for `out`.
static int many(int k) {
    {
        int a CL(c_a) = 0;
        (void)a;
        if (k == 1)
            goto out;
        if (k == 2)
            goto out;
        if (k == 3)
            goto out;
#ifdef TO_OUT
        __asm__ goto(TO_OUT : : "r"(k - 3) : : out);
        __asm__ goto(TO_OUT : : "r"(k - 4) : : out);
#else
        if (k == 4)
            goto out;
        if (k == 5)
            goto out;
#endif
        rec('-');
    }
    rec('.');
    return 0;
out:
    rec('|');
    return k;
}

// The jumps from the block holding `arr` leave one scope more than the
// jumps beside the block.
static int sink(int *p) {
    return p[0] + p[1];
}
static int nested(int k) {
    int r = 0;
    {
        int a CL(c_a) = 0;
        (void)a;
        if (k == 1)
            goto out;
        {
            int arr[2] = {k, 1};
            r = sink(arr);
            if (k == 2)
                goto out;
            if (k == 3)
                goto out;
        }
        if (k == 4)
            goto out;
        rec('-');
    }
    return r;
out:
    rec('|');
    return r + 10;
}

// The first goto precedes `b`, the other two follow it.
static void lists(int k) {
    {
        int a CL(c_a) = 0;
        if (k == 1)
            goto out;
        int b CL(c_b) = 0;
        (void)a, (void)b;
        if (k == 2)
            goto out;
        if (k == 3)
            goto out;
        rec('-');
    }
out:
    rec('|');
}

// Every iteration places the array at one address, whichever way it left
// the previous one.
static int vla(int m, int k) {
    uintptr_t first = 0;
    int moved = 0;
    for (int i = 0; i < 4; i++) {
        {
            int a CL(c_a) = 0;
            char v[m];
            v[0] = (char)i;
            if (!first)
                first = (uintptr_t)v;
            else if ((uintptr_t)v != first)
                moved = 1;
            (void)a;
            if (k == 1 && (i & 1))
                goto next;
            if (k == 1)
                goto next;
            rec('-');
        }
    next:
        rec('.');
    }
    return moved;
}

int main(void) {
    expect_true(many(0) == 0);
    expect("-a.");
    for (int k = 1; k <= 5; k++) {
        expect_true(many(k) == k);
        expect("a|");
    }
    static const int want[] = {1, 10, 13, 14, 15};
    expect_true(nested(0) == want[0]);
    expect("-a");
    for (int k = 1; k <= 4; k++) {
        expect_true(nested(k) == want[k]);
        expect("a|");
    }
    lists(0);
    expect("-ba|");
    lists(1);
    expect("a|");
    lists(2);
    expect("ba|");
    lists(3);
    expect("ba|");
    expect_true(vla(16, 0) == 0);
    expect("-a.-a.-a.-a.");
    expect_true(vla(16, 1) == 0);
    expect("a.a.a.a.");
    return failed;
}

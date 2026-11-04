/* Returns that leave the same `__attribute__((cleanup))` scopes run their
   cleanup calls once, on each path, in reverse declaration order, after
   the returned value is evaluated (C's scope-exit order, as gcc runs
   them). Returns from different depths and returns running different
   cleanup lists, void and struct returns, and returns from a loop. */

static char log_buf[64];
static int log_len;

static void note(char c) { log_buf[log_len++] = c; }
static void undo_a(int *p) { note('a'); *p = -1; }
static void undo_b(int *p) { note('b'); *p = -2; }
static void undo_c(int *p) { (void)p; note('c'); }

static int same(const char *want) {
    int i;
    for (i = 0; want[i]; i++) {
        if (i >= log_len || log_buf[i] != want[i]) return 0;
    }
    return i == log_len;
}

/* The value read before the cleanup overwrites it. */
__attribute__((noinline)) static int three(int a, int b) {
    int m __attribute__((cleanup(undo_a))) = 7;
    if (a) return m + 1;
    if (b) return m + 2;
    if (a + b > 3) return 3;
    return m;
}

/* Two cleanup lists: returns after `n` run b then a. */
__attribute__((noinline)) static int two_lists(int k) {
    int m __attribute__((cleanup(undo_a))) = 1;
    if (k == 0) return 10;
    int n __attribute__((cleanup(undo_b))) = 2;
    if (k == 1) return m + n;
    if (k == 2) return 20;
    return n * 10;
}

/* A return in a nested scope runs the inner cleanup too. */
__attribute__((noinline)) static int nested(int k) {
    int m __attribute__((cleanup(undo_a))) = 1;
    {
        int i __attribute__((cleanup(undo_c))) = 5;
        if (k == 0) return i;
        if (k == 1) return i + m;
    }
    if (k == 2) return 30;
    return 40;
}

__attribute__((noinline)) static void void_returns(int k, int *out) {
    int m __attribute__((cleanup(undo_b))) = 0;
    if (k == 0) {
        *out = 1;
        return;
    }
    if (k == 1) {
        *out = 2;
        return;
    }
    *out = 3 + m;
}

struct pair { long x, y, z; };

__attribute__((noinline)) static struct pair pairs(int k) {
    int m __attribute__((cleanup(undo_a))) = 4;
    struct pair p = { 1, 2, 3 };
    if (k == 0) return p;
    p.x = m;
    if (k == 1) return p;
    p.y = m * 2;
    return p;
}

__attribute__((noinline)) static int looped(int n) {
    int m __attribute__((cleanup(undo_c))) = 0;
    for (int i = 0; i < 10; i++) {
        if (i == n) return i * 3;
        if (i * i > 50) return 99;
    }
    return m;
}

#define CHECK(expr, want, trace, code)                                      \
    do {                                                                    \
        log_len = 0;                                                        \
        if ((expr) != (want) || !same(trace)) return code;                  \
    } while (0)

int main(void) {
    int out = 0;
    struct pair p;
    CHECK(three(1, 0), 8, "a", 1);
    CHECK(three(0, 1), 9, "a", 2);
    CHECK(three(0, 0), 7, "a", 3);
    CHECK(two_lists(0), 10, "a", 4);
    CHECK(two_lists(1), 3, "ba", 5);
    CHECK(two_lists(2), 20, "ba", 6);
    CHECK(two_lists(3), 20, "ba", 7);
    CHECK(nested(0), 5, "ca", 8);
    CHECK(nested(1), 6, "ca", 9);
    CHECK(nested(2), 30, "ca", 10);
    CHECK(nested(3), 40, "ca", 11);
    log_len = 0;
    void_returns(0, &out);
    if (out != 1 || !same("b")) return 12;
    log_len = 0;
    void_returns(1, &out);
    if (out != 2 || !same("b")) return 13;
    log_len = 0;
    void_returns(2, &out);
    if (out != 3 || !same("b")) return 14;
    log_len = 0;
    p = pairs(0);
    if (p.x != 1 || p.y != 2 || p.z != 3 || !same("a")) return 15;
    log_len = 0;
    p = pairs(1);
    if (p.x != 4 || p.y != 2 || !same("a")) return 16;
    log_len = 0;
    p = pairs(2);
    if (p.x != 4 || p.y != 8 || !same("a")) return 17;
    CHECK(looped(4), 12, "c", 18);
    CHECK(looped(20), 99, "c", 19);
    return 0;
}

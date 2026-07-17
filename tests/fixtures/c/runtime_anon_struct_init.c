/* Runtime (non-constant) initializer path for anonymous aggregate members.
   Before the initializer engine was unified the runtime struct walker had
   no anonymous-struct handling and ignored a flexible member's grouping;
   the constant path did. Values come from parameters so the initializer is
   not all compile-time constant and the runtime store path is taken. */

struct with_anon_struct {
    int a;
    struct {
        void *p;
        unsigned long n;
    };
    int b;
};

struct with_anon_union {
    int tag;
    union {
        void *ptr;
        long word;
    };
};

struct nested {
    int a;
    struct with_anon_struct inner;
};

static int check_anon_struct(void *p, unsigned long n) {
    /* positional brace on the flattened anon-struct region */
    struct with_anon_struct s1 = { .a = 1, { p, n }, .b = 7 };
    /* flattened members named directly as designators */
    struct with_anon_struct s2 = { .a = 2, .p = p, .n = n, .b = 8 };
    if (s1.a != 1 || s1.p != p || s1.n != n || s1.b != 7) return 1;
    if (s2.a != 2 || s2.p != p || s2.n != n || s2.b != 8) return 2;
    return 0;
}

static int check_anon_union(void *p) {
    struct with_anon_union u = { .tag = 3, .ptr = p };
    return (u.tag == 3 && u.ptr == p) ? 0 : 3;
}

static int check_nested(void *p, unsigned long n) {
    struct nested nn = { .a = 9, .inner = { .a = 4, { p, n }, .b = 5 } };
    return (nn.a == 9 && nn.inner.a == 4 && nn.inner.p == p
            && nn.inner.n == n && nn.inner.b == 5) ? 0 : 4;
}

int main(void) {
    int x = 0;
    int r;
    if ((r = check_anon_struct(&x, 16))) return r;
    if ((r = check_anon_union(&x))) return r;
    if ((r = check_nested(&x, 24))) return r;
    return 0;
}

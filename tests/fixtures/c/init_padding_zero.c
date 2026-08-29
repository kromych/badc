// A partially initialized automatic struct or union holds zero in its
// padding and in the bytes past the initialized member, whatever shape
// the initializer takes: a constant brace list, a runtime one that names
// every member, a runtime one that omits members, a designated one, an
// empty one, a compound literal, and the copy a by-value argument makes.
// Static storage is C99 6.7.8p10; the automatic cases are what
// `-fzero-init-padding-bits=all` names and what is emitted without it.
// A callee writes 0xAA over the stack region the objects occupy first,
// so an unwritten byte reads back as 0xAA. The exit code is the OR of
// every padding byte seen, 0 when all are zero.

struct S {
    char c;
    int i;
};

union U {
    char c;
    long long l;
};

struct T {
    char c;
    int i;
    char d;
    short e;
};

__attribute__((noinline)) static void dirty(void) {
    volatile unsigned char buf[2048];
    unsigned i;
    for (i = 0; i < sizeof buf; i++) {
        buf[i] = 0xAA;
    }
}

__attribute__((noinline)) static unsigned or_bytes(const void *p, const unsigned char *at,
                                                   unsigned n) {
    const volatile unsigned char *b = p;
    unsigned i, acc = 0;
    for (i = 0; i < n; i++) {
        acc |= b[at[i]];
    }
    return acc;
}

static const unsigned char s_pad[] = {1, 2, 3};
static const unsigned char u_pad[] = {1, 2, 3, 4, 5, 6, 7};
static const unsigned char t_pad[] = {1, 2, 3, 9};
// The union's tail ends at its own size, so the probe length follows
// `sizeof` rather than the offset table's length.
#define U_PAD_LEN ((unsigned)(sizeof(union U) - 1))

__attribute__((noinline)) static unsigned struct_const(void) {
    struct S s = {1};
    return or_bytes(&s, s_pad, sizeof s_pad);
}

__attribute__((noinline)) static unsigned struct_runtime(int v) {
    struct S s = {(char)v, v};
    return or_bytes(&s, s_pad, sizeof s_pad);
}

__attribute__((noinline)) static unsigned struct_runtime_partial(int v) {
    struct T t = {(char)v};
    return or_bytes(&t, t_pad, sizeof t_pad);
}

__attribute__((noinline)) static unsigned struct_designated(int v) {
    struct T t = {.e = (short)v};
    return or_bytes(&t, t_pad, sizeof t_pad);
}

__attribute__((noinline)) static unsigned struct_empty(void) {
    struct T t = {};
    return or_bytes(&t, t_pad, sizeof t_pad);
}

__attribute__((noinline)) static unsigned union_const(void) {
    union U u = {1};
    return or_bytes(&u, u_pad, U_PAD_LEN);
}

__attribute__((noinline)) static unsigned union_runtime(int v) {
    union U u = {(char)v};
    return or_bytes(&u, u_pad, U_PAD_LEN);
}

__attribute__((noinline)) static unsigned compound_literal(int v) {
    struct S *p = &(struct S){(char)v, v};
    return or_bytes(p, s_pad, sizeof s_pad);
}

__attribute__((noinline)) static unsigned by_value(struct S s) {
    return or_bytes(&s, s_pad, sizeof s_pad);
}

__attribute__((noinline)) static unsigned struct_by_value(int v) {
    struct S s = {(char)v, v};
    return by_value(s);
}

static struct S st = {1};
static union U ut = {1};

int main(void) {
    unsigned acc = 0;
    dirty();
    acc |= struct_const();
    dirty();
    acc |= struct_runtime(1);
    dirty();
    acc |= struct_runtime_partial(1);
    dirty();
    acc |= struct_designated(1);
    dirty();
    acc |= struct_empty();
    dirty();
    acc |= union_const();
    dirty();
    acc |= union_runtime(1);
    dirty();
    acc |= compound_literal(1);
    dirty();
    acc |= struct_by_value(1);
    acc |= or_bytes(&st, s_pad, sizeof s_pad);
    acc |= or_bytes(&ut, u_pad, U_PAD_LEN);
    return (int)acc;
}

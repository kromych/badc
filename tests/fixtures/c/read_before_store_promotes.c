// A local some path reads before any store holds an indeterminate value
// there (C99 6.2.4p5, 6.7.8p10), so it promotes like any other: the
// unwritten path merges an undefined value, and a read no store reaches
// is one. Every result below is read on a path that stores it first. A
// parameter cell and a call's result hold values no store in the body
// writes, and still read them. Returns 0 when every result matches.

struct one {
    int a;
};

__attribute__((noinline)) static int maybe(int k) {
    int x;
    if (k)
        x = 1;
    return k ? x : 2;
}

// The self-initialization that silences -Wuninitialized.
__attribute__((noinline)) static int self_init(int k) {
    int x = x;
    x = k + 1;
    return x;
}

__attribute__((noinline)) static double fp_maybe(int k) {
    double d;
    if (k)
        d = 1.5;
    return k ? d : 2.5;
}

__attribute__((noinline)) static float f32_maybe(int k) {
    float f;
    if (k)
        f = 0.25f;
    return k ? f : 0.5f;
}

__attribute__((noinline)) static short narrow_maybe(int k) {
    short s;
    if (k)
        s = -3;
    return k ? s : 7;
}

__attribute__((noinline)) static unsigned char u8_maybe(int k) {
    unsigned char c;
    if (k)
        c = 200;
    return k ? c : 9;
}

// The first iteration reads `last` only after the guard the store sets up.
__attribute__((noinline)) static int loop_first(int n) {
    int last, sum = 0, i;
    for (i = 0; i < n; i++) {
        if (i > 0)
            sum += last;
        last = i * 2;
    }
    return sum;
}

// The store sits in an operand of `||`: the merge after it is reached by
// the path that skipped it, which returns before reading `dist`.
static unsigned short next[16] = {0, 9, 9, 0, 5, 7, 0, 2};
__attribute__((noinline)) static unsigned probe(unsigned pos, unsigned max_dist, unsigned p) {
    unsigned dist, n;
    for (;;) {
        n = next[p];
        if ((!n) || ((dist = (unsigned short)(pos - n)) > max_dist))
            return 0;
        p = n & 0xf;
        if (p == 9)
            break;
    }
    return dist;
}

// The self-initialization idiom in a loop body: each iteration's `t` is a
// new object whose first read precedes its store.
__attribute__((noinline)) static unsigned long self_loop(unsigned long n) {
    unsigned long acc = 0, i;
    for (i = 0; i < n; i++) {
        unsigned long t = t;
        t = i * 3;
        acc += t;
    }
    return acc;
}

static inline int helper(int k) {
    int y;
    if (k > 2)
        y = k * 10;
    return k > 2 ? y : -1;
}

__attribute__((noinline)) static int inlined(int k) {
    return helper(k) + helper(k + 3);
}

// `j` arrives on the stack under every supported convention.
__attribute__((noinline)) static long stack_arg(long a, long b, long c, long d, long e, long f,
                                                long g, long h, long i, long j) {
    return j - a + b - b + c - c + d - d + e - e + f - f + g - g + h - h + i - i;
}

__attribute__((noinline)) static struct one make(int k) {
    struct one r;
    r.a = k * 2;
    return r;
}

__attribute__((noinline)) static int field_of_result(int k) {
    return make(k).a + 1;
}

int main(void) {
    if (maybe(1) != 1 || maybe(0) != 2)
        return 1;
    if (self_init(4) != 5)
        return 2;
    if (fp_maybe(1) != 1.5 || fp_maybe(0) != 2.5)
        return 3;
    if (f32_maybe(1) != 0.25f || f32_maybe(0) != 0.5f)
        return 4;
    if (narrow_maybe(1) != -3 || narrow_maybe(0) != 7)
        return 5;
    if (u8_maybe(1) != 200 || u8_maybe(0) != 9)
        return 6;
    if (loop_first(5) != 12)
        return 7;
    if (probe(20, 30, 1) != 11 || probe(20, 5, 1) != 0 || probe(20, 30, 3) != 0)
        return 8;
    if (self_loop(4) != 18)
        return 9;
    if (inlined(1) != 39 || inlined(3) != 90)
        return 10;
    if (stack_arg(1, 2, 3, 4, 5, 6, 7, 8, 9, 40) != 39)
        return 11;
    if (field_of_result(20) != 41)
        return 12;
    return 0;
}

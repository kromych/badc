// A zero-length array is array-shaped with a zero element count (a GNU
// extension the kernel uses for permanently empty tables). Reading it as
// an rvalue must yield the object's address, not a load of its storage
// (C99 6.3.2.1p3) -- the object occupies no bytes, so a load reads
// whatever follows it. Both spellings count: an explicit `[0]` and a
// deferred size resolved by an empty initializer. Matches GCC and clang
// on x86-64 and aarch64; returns 0, distinct non-zero per failure.

struct e {
    int a;
};

static struct e s_brace[] = {};
static int i_brace[] = {};
static struct e s_zero[0];
static int i_zero[0];
static int guard = 0x5a;

static const void *pass(const void *p) { return p; }

int main(void) {
    if (sizeof s_brace != 0 || sizeof i_brace != 0) {
        return 1;
    }
    // TODO: a file-scope `T x[0];` with no initializer is still completed
    // to one element, so its `sizeof` is the element size rather than 0.
    if ((const void *)s_brace != (const void *)&s_brace) {
        return 2;
    }
    if ((const void *)i_brace != (const void *)&i_brace) {
        return 3;
    }
    if ((const void *)s_zero != (const void *)&s_zero) {
        return 4;
    }
    if ((const void *)i_zero != (const void *)&i_zero) {
        return 5;
    }
    // Passed as an argument the decay must produce the same address.
    if (pass(s_brace) != (const void *)&s_brace) {
        return 6;
    }
    if (pass(i_brace) != (const void *)&i_brace) {
        return 7;
    }
    if (guard != 0x5a) {
        return 8;
    }
    return 0;
}

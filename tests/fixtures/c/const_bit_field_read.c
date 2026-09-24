// A bit-field of a `const` object with static storage reads back its
// value in a constant expression, converted to the field's type (C99
// 6.7.2.1p10), as gcc and clang fold it: sign-extended for a signed field,
// zero-extended for an unsigned one, 0 or 1 for `_Bool`, across a 64-bit
// storage unit and in a packed layout.

static const struct {
    int s : 5;
    unsigned u : 7;
    _Bool b : 1;
    unsigned long long wide : 40;
} f = {-3, 100, 1, 0xabcdef0123ull};

static const struct __attribute__((packed)) {
    char c;
    unsigned p : 12;
    int q : 4;
} packed = {1, 0xabc, -2};

int s = f.s;
unsigned u = f.u;
int b = f.b;
unsigned long long wide = f.wide;
unsigned p = packed.p;
int q = packed.q;
long from_field = f.u + 1;

int main(void)
{
    static int block = f.s * 2;
    if (s != -3 || u != 100 || b != 1 || wide != 0xabcdef0123ull) return 1;
    if (p != 0xabc || q != -2) return 2;
    if (from_field != 101 || block != -6) return 3;
    return 0;
}

// C99 6.7.2.2p4: each enumerated type is compatible with the integer type
// its definition chose and with no other enumerated type, so `_Generic`
// tells two enums of one integer type apart, a block-scope tag declares a
// type of its own, and the values load, store, convert, pass and return
// as that integer type: a negative one signed, a packed one in one byte and
// a wide one in eight. Each check exits with its own code; success returns
// 0.

typedef unsigned int a_int;

enum A { A1, A2, A3 };
enum B { B1, B2 };
enum N { N1 = -2, N2 };
typedef enum A OuterA;

struct S {
    enum B b;
    enum A a;
    enum N n : 4;
};

#define WHICH(e) (_Generic((e), enum A: 1, default: 0) | _Generic((e), enum B: 2, default: 0) \
    | _Generic((e), a_int: 4, default: 0))

static enum N twice(enum N n) { return (enum N)(n * 2); }

static int classify(enum A a) {
    switch (a) {
    case A1: return 10;
    case A2: return 20;
    default: return 30;
    }
}

enum W { W1 = 0x100000000LL, W2 };
enum __attribute__((packed)) P { P1 = 200, P2 };
static enum W next_w(enum W w) { return (enum W)(w + 1); }

int main(void) {
    enum A as[3] = {A1, A2, A3};
    enum A *pa = as;
    enum B b = B2;
    struct S s = {B2, A3, N1};
    a_int u = 7;
    if (WHICH(as[0]) != 5 || WHICH(b) != 6 || WHICH(u) != 7 || WHICH(as[0] + 0) != 7) return 1;
    {
        enum A { Z1 = 9 } inner = Z1;
        if (WHICH(inner) != 5 || _Generic(inner, OuterA: 1, default: 0) != 0 || inner != 9) return 2;
    }
    if (pa[2] != A3 || *(pa + 1) != A2 || &as[2] - pa != 2 || pa + 1 != &as[1]) return 3;
    *++pa = A3;
    if (as[1] != A3 || sizeof as != 3 * sizeof(int)) return 4;
    if (s.b != B2 || s.a != A3 || s.n != N1) return 5;
    if (twice(N1) != -4 || N1 >= 0 || (int)(enum N)-1 != N2) return 6;
    s.n = twice(N2);
    if (s.n != -2 || classify(A2) != 20 || classify((enum A)7) != 30) return 7;
    b = (enum B)as[0];
    if (b != B1 || -as[2] != -2 || (as[2] << 1) != 4) return 8;
    {
        enum W w = W1;
        enum P p = P2;
        if (sizeof w != 8 || next_w(w) != W2 || (unsigned long long)w != 0x100000000ULL) return 9;
        if (sizeof p != 1 || p != 201 || (int)p - 1 != P1) return 10;
    }
    return 0;
}

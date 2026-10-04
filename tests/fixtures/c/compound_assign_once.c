// C99 6.5.16.2p3: `E1 op= E2` evaluates `E1` once and performs
// `E1 op E2` in the type the usual arithmetic conversions give it
// (6.3.1.8), then converts the result to the type of `E1`. Members and
// bit-fields are reached through object expressions with side effects,
// which must happen once; the operands are integers, floating values
// and `__int128` values, the objects include `_Bool` and `__int128`.
// The value of the assignment is the one the object then holds. Each
// check exits with its own code; success returns 0.

struct S {
    int f;
    unsigned u;
    int c : 7;
    unsigned b : 5;
    long long w : 40;
    _Bool t : 1;
    double d;
};

struct W {
    __int128 z : 100;
};

static struct S a[4];
static struct W ws;
static volatile struct S vs;
static int calls;

static struct S *get(void) {
    calls++;
    return &a[1];
}

static int once_through_pointers(void) {
    struct S *p = a;
    p++->c += 1;
    if (p != a + 1 || a[0].c != 1) return 1;
    p = a;
    (p++->f) += 5;
    if (p != a + 1 || a[0].f != 5) return 2;
    p = a;
    a[0].b = 3;
    (p++->b) *= 3;
    if (p != a + 1 || a[0].b != 9) return 3;
    calls = 0;
    get()->c += 1;
    get()->b <<= 1;
    (get()->u) *= 3;
    get()->w -= 1;
    get()->d += 1;
    get()->t |= 1;
    if (calls != 6) return 4;
    return 0;
}

static int common_type(void) {
    // `(unsigned)-3 / 2u` is 0x7ffffffe, which the 7-bit field holds as -2.
    a[0].c = -3;
    a[0].c /= 2u;
    if (a[0].c != -2) return 5;
    a[0].c = -3;
    a[0].c %= 5u;
    if (a[0].c != 3) return 6;
    // A floating operand computes in double and converts to the field.
    a[0].c = 3;
    a[0].c *= 1.5;
    if (a[0].c != 4) return 7;
    a[0].t = 0;
    a[0].t += 0.25;
    if (a[0].t != 1) return 8;
    a[0].b = 30;
    a[0].b -= 0.5;
    if (a[0].b != 29) return 9;
    // A float operand keeps the operation in float (FLT_EVAL_METHOD 0).
    int i = 16777217;
    i += 0.0f;
    if (i != 16777216) return 10;
    unsigned long long big = 0xc000000000000000ull;
    big /= 2.0;
    if (big != 0x6000000000000000ull) return 11;
    _Bool flag = 0;
    flag += 0.25;
    if (flag != 1) return 12;
    __int128 x = 1;
    x -= 0.5;
    if (x != 0) return 13;
    x = -7;
    x /= 2.0;
    if (x != -3) return 14;
    ws.z = 3;
    ws.z *= 1.5;
    if (ws.z != 4) return 15;
    return 0;
}

static int assignment_value(void) {
    a[2].w = (1LL << 39) - 1;
    if ((a[2].w += 1) != -(1LL << 39)) return 16;
    if (++a[2].w != -(1LL << 39) + 1) return 17;
    a[2].c = 63;
    if (++a[2].c != -64 || a[2].c != -64) return 18;
    vs.c = 60;
    if ((vs.c += 10) != -58) return 19;
    vs.b = 31;
    if (++vs.b != 0 || vs.b != 0) return 20;
    if ((a[2].t += 2) != 1) return 21;
    return 0;
}

// An `__int128` operand makes the operation 128-bit; the result then
// narrows to the lvalue, and `_Bool` tests the whole of it.
static int int128_operand(void) {
    __int128 big = (__int128)1 << 64;
    int v = 5;
    v += big;
    if (v != 5) return 22;
    v = 50;
    v /= big;
    if (v != 0) return 23;
    a[3].c = -3;
    a[3].c *= (__int128)3;
    if (a[3].c != -9) return 24;
    _Bool flag = 0;
    flag += big;
    if (flag != 1) return 25;
    a[3].t = 0;
    a[3].t |= big;
    if (a[3].t != 1) return 26;
    return 0;
}

int main(void) {
    int r = once_through_pointers();
    if (r) return r;
    r = common_type();
    if (r) return r;
    r = assignment_value();
    if (r) return r;
    return int128_operand();
}

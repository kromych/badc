// A Microsoft x64 function calls a System V function pointer that is also
// an argument; the System V marshal loads the first struct's second
// eightbyte into rsi (AMD64 psABI 3.2.3), and main keeps c2 live across it.
#define NOINLINE __attribute__((noinline))
#define SV __attribute__((sysv_abi))
typedef unsigned long long u64;
typedef void (*GP)(void);
struct s2 { u64 a, b; };
static u64 rec[8];
static GP rec_p;
static volatile u64 gv[8] = {11, 22, 33, 44, 55, 66, 77, 88};

typedef u64 (SV *F)(struct s2, GP, u64, struct s2, struct s2, unsigned, u64);
NOINLINE SV u64 callee(struct s2 x0, GP x1, u64 x2, struct s2 x3, struct s2 x4, unsigned x5, u64 x6) {
    rec[0] = x0.a * 3 + x0.b;
    rec_p = x1;
    rec[2] = x2;
    rec[3] = x3.a * 3 + x3.b;
    rec[4] = x4.a * 3 + x4.b;
    rec[5] = x5;
    rec[6] = x6;
    return 8;
}
NOINLINE u64 caller(double c0, u64 c1, u64 c2, u64 c3, u64 c4, u64 c5, u64 c6, u64 c7, F f) {
    return f((struct s2){c4 + 1, 2}, (GP)f, c5 * 9 + 2, (struct s2){c2 + 1, 5},
             (struct s2){c7 + 1, 6}, (unsigned)(c2 * 2 + 5), 79020ULL);
}

int main(void) {
    double c0 = (double)gv[0] + 0.5;
    u64 c1 = gv[1] + 1, c2 = gv[2] + 2, c3 = gv[3] + 3, c4 = gv[4] + 4;
    u64 c5 = gv[5] + 5, c6 = gv[6] + 6, c7 = gv[7] + 7;
    int bad = 0;
    if (caller(c0, c1, c2, c3, c4, c5, c6, c7, callee) != 8) bad |= 1;
    if (rec[0] != (c4 + 1) * 3 + 2 || rec_p != (GP)callee || rec[2] != c5 * 9 + 2) bad |= 2;
    if (rec[3] != (c2 + 1) * 3 + 5) bad |= 4;
    if (rec[4] != (c7 + 1) * 3 + 6 || rec[6] != 79020) bad |= 8;
    if (rec[5] != (unsigned)(c2 * 2 + 5)) bad |= 16;
    return bad;
}

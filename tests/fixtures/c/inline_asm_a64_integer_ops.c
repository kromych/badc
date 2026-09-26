// AArch64 integer instructions on register operands: moves, arithmetic with
// immediate, shifted and extended operands, logic, shifts, multiplies,
// divides, bit operations and bitfield moves, at both register widths. Each
// result is checked against the value C computes; exits 0, or the number of
// the first mismatch; 0 on other architectures.

typedef unsigned long long u64;
typedef long long i64;
typedef unsigned int u32;

static volatile u64 in[] = {0x0123456789abcdefull, 0xfedcba9876543210ull, 5, 3, 0x80000000u, 7};

#define OP1(t, x, a) __asm__(t : "=r"(x) : "r"(a))
#define OP2(t, x, a, b) __asm__(t : "=r"(x) : "r"(a), "r"(b))
#define OP3(t, x, a, b, c) __asm__(t : "=r"(x) : "r"(a), "r"(b), "r"(c))
#define INS1(t, x, a) __asm__(t : "+r"(x) : "r"(a))

static int check(int n, u64 got, u64 want) { return got == want ? 0 : n; }

int main(void)
{
#if !defined(__aarch64__)
    return 0;
#else
    u64 a = in[0], b = in[1], five = in[2], three = in[3], sign = in[4], seven = in[5];
    u32 wa = (u32)a, wb = (u32)b;
    u64 x;
    u32 w;
    int r = 0;

    x = a; OP2("add %0, %1, %2, lsl #4", x, a, b); r = r ? r : check(1, x, a + (b << 4));
    x = a; OP2("sub %0, %1, %2, lsr #8", x, a, b); r = r ? r : check(2, x, a - (b >> 8));
    x = a; OP2("add %0, %1, %w2, sxtw #2", x, a, sign); r = r ? r : check(3, x, a + ((u64)(i64)(int)(u32)sign << 2));
    x = a; OP1("add %0, %1, #0x123", x, a); r = r ? r : check(4, x, a + 0x123);
    x = a; OP1("sub %0, %1, #1, lsl #12", x, a); r = r ? r : check(5, x, a - 0x1000);
    w = wa; OP2("add %w0, %w1, %w2", w, wa, wb); r = r ? r : check(6, w, wa + wb);
    x = a; OP2("and %0, %1, %2", x, a, b); r = r ? r : check(7, x, a & b);
    x = a; OP2("orr %0, %1, %2, ror #12", x, a, b); r = r ? r : check(8, x, a | ((b >> 12) | (b << 52)));
    x = a; OP2("eor %0, %1, %2, asr #3", x, a, b); r = r ? r : check(9, x, a ^ (u64)((i64)b >> 3));
    x = a; OP2("bic %0, %1, %2", x, a, b); r = r ? r : check(10, x, a & ~b);
    x = a; OP2("orn %0, %1, %2", x, a, b); r = r ? r : check(11, x, a | ~b);
    x = a; OP2("eon %0, %1, %2", x, a, b); r = r ? r : check(12, x, a ^ ~b);
    x = a; OP1("and %0, %1, #0xff00ff00ff00ff00", x, a); r = r ? r : check(13, x, a & 0xff00ff00ff00ff00ull);
    x = a; OP1("orn %0, xzr, %1", x, a); r = r ? r : check(14, x, ~a);
    x = a; OP1("neg %0, %1", x, a); r = r ? r : check(15, x, 0 - a);
    x = a; OP1("lsl %0, %1, #7", x, a); r = r ? r : check(16, x, a << 7);
    x = a; OP1("lsr %0, %1, #9", x, a); r = r ? r : check(17, x, a >> 9);
    x = b; OP1("asr %0, %1, #5", x, b); r = r ? r : check(18, x, (u64)((i64)b >> 5));
    x = a; OP1("ror %0, %1, #16", x, a); r = r ? r : check(19, x, (a >> 16) | (a << 48));
    x = a; OP2("lsl %0, %1, %2", x, a, five); r = r ? r : check(20, x, a << 5);
    w = wb; OP2("asr %w0, %w1, %w2", w, wb, three); r = r ? r : check(21, w, (u32)((int)wb >> 3));
    x = a; OP2("mul %0, %1, %2", x, a, b); r = r ? r : check(22, x, a * b);
    x = a; OP3("madd %0, %1, %2, %3", x, a, b, five); r = r ? r : check(23, x, five + a * b);
    x = a; OP3("msub %0, %1, %2, %3", x, a, b, five); r = r ? r : check(24, x, five - a * b);
    x = a; OP2("smull %0, %w1, %w2", x, sign, seven); r = r ? r : check(25, x, (u64)((i64)(int)(u32)sign * 7));
    x = a; OP2("umull %0, %w1, %w2", x, sign, seven); r = r ? r : check(26, x, (u64)(u32)sign * 7);
    x = a; OP2("umulh %0, %1, %2", x, a, b); r = r ? r : check(27, x, (u64)(((unsigned __int128)a * b) >> 64));
    x = a; OP2("smulh %0, %1, %2", x, a, b); r = r ? r : check(28, x, (u64)(((__int128)(i64)a * (i64)b) >> 64));
    x = a; OP2("udiv %0, %1, %2", x, a, seven); r = r ? r : check(29, x, a / 7);
    x = a; OP2("sdiv %0, %1, %2", x, b, seven); r = r ? r : check(30, x, (u64)((i64)b / 7));
    x = a; OP2("udiv %0, %1, %2", x, a, 0ull); r = r ? r : check(31, x, 0);
    x = a; OP1("clz %0, %1", x, five); r = r ? r : check(32, x, 61);
    w = wa; OP1("clz %w0, %w1", w, five); r = r ? r : check(33, w, 29);
    x = a; OP1("cls %0, %1", x, b); r = r ? r : check(34, x, 6);
    x = a; OP1("rbit %0, %1", x, five); r = r ? r : check(35, x, 0xa000000000000000ull);
    x = a; OP1("rev %0, %1", x, a); r = r ? r : check(36, x, 0xefcdab8967452301ull);
    w = wa; OP1("rev %w0, %w1", w, wa); r = r ? r : check(37, w, 0xefcdab89u);
    x = a; OP1("rev16 %0, %1", x, a); r = r ? r : check(38, x, 0x23016745ab89efcdull);
    x = a; OP1("rev32 %0, %1", x, a); r = r ? r : check(39, x, 0x67452301efcdab89ull);
    x = a; OP1("ubfx %0, %1, #8, #12", x, a); r = r ? r : check(40, x, (a >> 8) & 0xfff);
    x = a; OP1("sbfx %0, %1, #60, #4", x, b); r = r ? r : check(41, x, (u64)(i64)-1);
    x = a; OP1("ubfiz %0, %1, #4, #8", x, a); r = r ? r : check(42, x, (a & 0xff) << 4);
    x = a; OP1("sbfiz %0, %1, #4, #4", x, a); r = r ? r : check(43, x, (u64)((i64)-1 << 4));
    x = a; INS1("bfi %0, %1, #8, #8", x, five); r = r ? r : check(44, x, (a & ~0xff00ull) | (5 << 8));
    x = a; INS1("bfxil %0, %1, #4, #8", x, b); r = r ? r : check(45, x, (a & ~0xffull) | ((b >> 4) & 0xff));
    x = a; OP1("sxtw %0, %w1", x, sign); r = r ? r : check(46, x, 0xffffffff80000000ull);
    w = wa; OP1("uxtb %w0, %w1", w, wa); r = r ? r : check(47, w, wa & 0xff);
    x = a; OP1("sxth %0, %w1", x, 0x8001ull); r = r ? r : check(48, x, 0xffffffffffff8001ull);
    x = a; OP2("extr %0, %1, %2, #16", x, a, b); r = r ? r : check(49, x, (b >> 16) | (a << 48));
    x = 0; OP1("movz %0, #0x1234, lsl #16\n\tmovk %0, #0x5678", x, a); r = r ? r : check(50, x, 0x12345678);
    x = 0; OP1("movn %0, #0", x, a); r = r ? r : check(51, x, (u64)(i64)-1);
    x = 0; OP1("mov %0, #-2", x, a); r = r ? r : check(52, x, (u64)(i64)-2);
    x = 0; OP1("mov %w0, #-2", x, a); r = r ? r : check(53, x, 0xfffffffeu);
    x = 0; OP1("mov %0, %1\n\tnop\n\tdmb ish", x, a); r = r ? r : check(54, x, a);
    x = a; OP1("mvn %0, %1", x, a); r = r ? r : check(55, x, ~a);
    w = wa; OP1("mvn %w0, %w1", w, wa); r = r ? r : check(56, w, ~wa);
    x = a; OP1("mvn %0, %1, lsl #4", x, a); r = r ? r : check(57, x, ~(a << 4));
    w = wa; OP1("mvn %w0, %w1, ror #3", w, wa); r = r ? r : check(58, w, ~((wa >> 3) | (wa << 29)));
    x = a; OP1("mvn %0, %1, asr #63", x, b); r = r ? r : check(59, x, ~(u64)((i64)b >> 63));
    w = wa; OP1("mvn %w0, %w1, lsr #17", w, wa); r = r ? r : check(60, w, ~(wa >> 17));
    return r;
#endif
}

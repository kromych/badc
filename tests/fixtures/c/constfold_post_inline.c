// Post-inline constant folding: constant arguments substituted into
// static helpers leave Extend(Imm) / Binop(Imm, Imm) chains that the
// mid-end folder must evaluate exactly as the interpreter and the
// unoptimized build do. Every folded arm is exercised: wrapping
// unsigned add/mul (C99 6.2.5p9), signed/unsigned shifts including
// counts 64 and 65 (6.5.7p3 leaves those undefined; the
// implementation pins the masked native semantics), the full
// comparison set, unsigned division/modulo extremes, C99 6.5.5p6
// truncated signed division, callee-narrows extends (6.3.1.3), and
// the rotate idiom. Exit 0 when every computed value matches its
// literal.

typedef unsigned long long u64;
typedef long long i64;

static u64 add_u(u64 a, u64 b) { return a + b; }
static u64 mul_u(u64 a, u64 b) { return a * b; }
static i64 sub_i(i64 a, i64 b) { return a - b; }
static u64 shl_u(u64 x, int c) { return x << c; }
static u64 shr_u(u64 x, int c) { return x >> c; }
static i64 shr_i(i64 x, int c) { return x >> c; }
static u64 div_u(u64 a, u64 b) { return a / b; }
static u64 mod_u(u64 a, u64 b) { return a % b; }
static i64 div_i(i64 a, i64 b) { return a / b; }
static i64 mod_i(i64 a, i64 b) { return a % b; }
static u64 ror_u(u64 x, int c) { return (x >> c) | (x << (64 - c)); }
static int lt_i(i64 a, i64 b) { return a < b; }
static int gt_i(i64 a, i64 b) { return a > b; }
static int le_i(i64 a, i64 b) { return a <= b; }
static int ge_i(i64 a, i64 b) { return a >= b; }
static int lt_u(u64 a, u64 b) { return a < b; }
static int gt_u(u64 a, u64 b) { return a > b; }
static int le_u(u64 a, u64 b) { return a <= b; }
static int ge_u(u64 a, u64 b) { return a >= b; }
static int eq_i(i64 a, i64 b) { return a == b; }
static int ne_i(i64 a, i64 b) { return a != b; }
static i64 sext8(signed char v) { return v; }
static i64 sext16(short v) { return v; }
static i64 sext32(int v) { return v; }

int main(void) {
    // Constant-on-constant folds (both operands substituted).
    if (add_u(0xffffffffffffffffULL, 2) != 1) return 1;
    if (mul_u(0xffffffffffffffffULL, 3) != 0xfffffffffffffffdULL) return 2;
    if (sub_i(-5, 9223372036854775807LL) != 9223372036854775804LL) return 3;
    if (shl_u(0x0123456789abcdefULL, 4) != 0x123456789abcdef0ULL) return 4;
    if (shl_u(0x0123456789abcdefULL, 64) != 0x0123456789abcdefULL) return 5;
    if (shl_u(0x0123456789abcdefULL, 65) != 0x02468acf13579bdeULL) return 6;
    if (shr_u(0x0123456789abcdefULL, 3) != 0x002468acf13579bdULL) return 7;
    if (shr_u(0x8000000000000000ULL, 63) != 1) return 8;
    if (shr_i(-8, 1) != -4) return 9;
    if (shr_i(-1, 63) != -1) return 10;
    if (div_u(0xffffffffffffffffULL, 3) != 0x5555555555555555ULL) return 11;
    if (mod_u(0xffffffffffffffffULL, 7) != 1) return 12;
    if (div_u(0x8000000000000000ULL, 0xffffffffffffffffULL) != 0) return 13;
    if (mod_u(0x8000000000000000ULL, 0xffffffffffffffffULL) != 0x8000000000000000ULL) return 14;
    if (div_i(-7, 2) != -3) return 15;
    if (mod_i(-7, 2) != -1) return 16;
    if (div_i(7, -2) != -3) return 17;
    if (mod_i(7, -2) != 1) return 18;
    if (ror_u(0x0123456789abcdefULL, 7) != 0xde02468acf13579bULL) return 19;
    if (!lt_i(-2, 1) || lt_i(1, -2)) return 20;
    if (!gt_i(1, -2) || gt_i(-2, 1)) return 21;
    if (!le_i(3, 3) || le_i(4, 3)) return 22;
    if (!ge_i(3, 3) || ge_i(3, 4)) return 23;
    if (!lt_u(1, 0xffffffffffffffffULL) || lt_u(0xffffffffffffffffULL, 1)) return 24;
    if (!gt_u(0xffffffffffffffffULL, 1) || gt_u(1, 0xffffffffffffffffULL)) return 25;
    if (!le_u(5, 5) || le_u(6, 5)) return 26;
    if (!ge_u(5, 5) || ge_u(5, 6)) return 27;
    if (!eq_i(-1, -1) || eq_i(-1, 1)) return 28;
    if (!ne_i(-1, 1) || ne_i(-1, -1)) return 29;
    // Callee-narrows Extend(Imm) folds, including a truncating
    // conversion (6.3.1.3p3, implementation-defined: two's-complement
    // wrap).
    if (sext8(-100) != -100) return 30;
    if (sext8(511) != -1) return 31;
    if (sext16(-30000) != -30000) return 32;
    if (sext16(0x18000) != -32768) return 33;
    if (sext32(-2000000000) != -2000000000) return 34;
    if (sext32(0xf80000000LL) != -2147483648LL) return 35;
    // Immediate-operand rewrites over a runtime value: rhs-imm form
    // and the commuted / mirrored lhs-imm form must agree with the
    // literal expectations for the known seed.
    volatile u64 seed = 0x0123456789abcdefULL;
    u64 x = seed;
    if (5 + x != 0x0123456789abcdf4ULL) return 36;
    if (x + 5 != 0x0123456789abcdf4ULL) return 37;
    if (!(100 < x)) return 38;
    if (100 > x) return 39;
    if (!(0xffffffffffffffffULL >= x)) return 40;
    if (ror_u(x, 7) != 0xde02468acf13579bULL) return 41;
    if (shl_u(x, 65) != 0x02468acf13579bdeULL) return 42;
    volatile i64 sneg = -8;
    if (shr_i(sneg, 1) != -4) return 43;
    return 0;
}

// GCC bit-count builtins __builtin_clz / ctz / popcount and their
// 64-bit ll forms. These are compiler builtins (no header), lowered to
// a portable shift / mask sequence. Values at zero are undefined in GCC
// and not exercised here. Results asserted against hand-computed values
// so the fixture needs no formatted output (it runs on the interpreter,
// which does not implement the printf width/hex conversions).

static int eq(int a, int b) { return a == b; }

int main(void) {
    // clz: leading zeros in 32 bits.
    if (!eq(__builtin_clz(1u), 31)) return 1;
    if (!eq(__builtin_clz(0x80000000u), 0)) return 2;
    if (!eq(__builtin_clz(0x10000u), 15)) return 3;
    if (!eq(__builtin_clz(0xffffffffu), 0)) return 4;

    // ctz: trailing zeros in 32 bits.
    if (!eq(__builtin_ctz(1u), 0)) return 5;
    if (!eq(__builtin_ctz(0x80000000u), 31)) return 6;
    if (!eq(__builtin_ctz(0x10000u), 16)) return 7;
    if (!eq(__builtin_ctz(0x40000000u), 30)) return 8;

    // popcount: set bits in 32 bits.
    if (!eq(__builtin_popcount(0u), 0)) return 9;
    if (!eq(__builtin_popcount(0xffffffffu), 32)) return 10;
    if (!eq(__builtin_popcount(0x0f0f0f0fu), 16)) return 11;
    if (!eq(__builtin_popcount(0x7u), 3)) return 12;

    // 64-bit forms.
    if (!eq(__builtin_clzll(1ull), 63)) return 13;
    if (!eq(__builtin_clzll(0x8000000000000000ull), 0)) return 14;
    if (!eq(__builtin_clzll(0x100000000ull), 31)) return 15;
    if (!eq(__builtin_ctzll(1ull), 0)) return 16;
    if (!eq(__builtin_ctzll(0x8000000000000000ull), 63)) return 17;
    if (!eq(__builtin_ctzll(0x100000000ull), 32)) return 18;
    if (!eq(__builtin_popcountll(0xffffffffffffffffull), 64)) return 19;
    if (!eq(__builtin_popcountll(0xdeadbeefcafeull), 35)) return 20;

    // A non-constant operand exercises the runtime path (the constant
    // cases above may fold at compile time).
    volatile unsigned r = 0x00ff00ffu;
    if (!eq(__builtin_popcount(r), 16)) return 21;
    if (!eq(__builtin_clz(r), 8)) return 22;
    if (!eq(__builtin_ctz(r), 0)) return 23;
    return 0;
}

// A floating constant every reader of which takes it in a floating
// register is built in that register: +0.0 by a zeroing move, a value the
// 8-bit FMOV immediate holds by that immediate -- its double and float
// patterns differ -- a pattern one integer move builds by that move and a
// transfer, and the rest by a load of a read-only literal. Each check
// reaches one form through one reader: arithmetic, a comparison, a fused
// multiply-add, a store, a call argument, a return, a phi, a loop, a value
// kept across calls. -0.0 stays negative, a float constant keeps its
// single-precision pattern, and literals of equal bits but different
// widths stay apart. Asserted by return code.

typedef unsigned long long u64;
typedef unsigned int u32;

volatile double vone = 1.0;
volatile float vonef = 1.0f;
volatile int vsel = 1;
double dsink[4];
float fsink[4];

__attribute__((noinline)) static double pass(double x) { return x; }
__attribute__((noinline)) static float passf(float x) { return x; }
__attribute__((noinline)) static double mix(double a, float b, double c) {
    return a * 4.0 + (double)b + c;
}

static u64 dbits(double d) {
    union { double d; u64 u; } v;
    v.d = d;
    return v.u;
}

static u32 fbits(float f) {
    union { float f; u32 u; } v;
    v.f = f;
    return v.u;
}

__attribute__((noinline)) static double ret_milli(void) { return 0.001; }
__attribute__((noinline)) static double ret_hundred(void) { return 100.0; }
__attribute__((noinline)) static float ret_tenth_f(void) { return 0.1f; }
__attribute__((noinline)) static double ret_neg_zero(void) { return -0.0; }
__attribute__((noinline)) static double pick(int c) { return c ? 2.5 : 0.001; }
__attribute__((noinline)) static float pickf(int c) { return c ? -0.25f : 3.14159f; }

__attribute__((noinline)) static void store_all(void) {
    dsink[0] = 0.0;
    dsink[1] = -0.0;
    dsink[2] = 1.5;
    dsink[3] = 0.3;
    fsink[0] = 0.0f;
    fsink[1] = -2.5f;
    fsink[2] = 1e6f;
    fsink[3] = 0.1f;
}

// Constants read inside a loop that calls out: kept in registers the call
// preserves, or reloaded after it.
__attribute__((noinline)) static double loop_calls(int n) {
    double acc = 0.0;
    for (int i = 0; i < n; i++) {
        acc = acc * 0.5 + pass(0.25);
        if (pass(acc) == 0.001)
            return -1.0;
    }
    return acc;
}

int main(void) {
    double one = vone;
    float onef = vonef;

    // Zeros: the sign survives each form.
    double z = one * 0.0;
    double nz = one * -0.0;
    if (dbits(z) != 0 || 1.0 / z <= 0.0) return 1;
    if (dbits(nz) != 0x8000000000000000ull || 1.0 / nz >= 0.0) return 2;
    if (dbits(ret_neg_zero()) != 0x8000000000000000ull) return 3;
    if (fbits(onef * -0.0f) != 0x80000000u) return 4;

    // FMOV immediates, both precisions.
    if (one * 2.5 != 2.5 || dbits(one * -2.5) != 0xC004000000000000ull) return 5;
    if (one * 31.0 - 0.125 != 30.875) return 6;
    if (onef * 2.5f != 2.5f || fbits(onef * -0.25f) != 0xBE800000u) return 7;
    if (onef * 0.125f + 1.0f != 1.125f) return 8;

    // One integer move, then a transfer.
    if (ret_hundred() != 100.0 || one * 100.0 != 100.0) return 9;
    if (dbits(one * 1024.0) != 0x4090000000000000ull) return 10;

    // Literals: doubles, floats, and one of each width with shared bits.
    if (ret_milli() != 0.001 || one * 0.001 != 0.001) return 11;
    if (dbits(pass(0.1)) != 0x3FB999999999999Aull) return 12;
    if (fbits(ret_tenth_f()) != 0x3DCCCCCDu || passf(0.1f) != 0.1f) return 13;
    if (dbits(one * 3.141592653589793) != 0x400921FB54442D18ull) return 14;
    if (fbits(onef * 3.14159f) != 0x40490FD0u) return 15;
    if (fbits(onef * 1e6f) != 0x49742400u || dbits(one * 1e6) != 0x412E848000000000ull) return 16;
    if (dbits(pass(0x3DCCCCCDp-1074)) != 0x3DCCCCCDull || fbits(passf(0.1f)) != 0x3DCCCCCDu)
        return 26;

    // Phis.
    if (pick(vsel) != 2.5 || pick(!vsel) != 0.001) return 17;
    if (pickf(vsel) != -0.25f || fbits(pickf(!vsel)) != 0x40490FD0u) return 18;

    // Arguments of both precisions and a fused multiply-add.
    if (mix(0.5, 0.75f, 0.001) != 2.75 + pass(0.001)) return 19;
    if (((one * 0.5 + 0.25) * one + 0.125) * one != 0.875) return 20;

    // Stores.
    store_all();
    if (dbits(dsink[0]) != 0 || dbits(dsink[1]) != 0x8000000000000000ull) return 21;
    if (dsink[2] != 1.5 || dbits(dsink[3]) != 0x3FD3333333333333ull) return 22;
    if (fbits(fsink[0]) != 0 || fsink[1] != -2.5f) return 23;
    if (fbits(fsink[2]) != 0x49742400u || fbits(fsink[3]) != 0x3DCCCCCDu) return 24;

    // A loop that calls out.
    if (loop_calls(3) != 0.4375) return 25;
    return 0;
}

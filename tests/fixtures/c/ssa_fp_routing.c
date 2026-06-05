// SSA-emit regression for the x86_64 floating-point routing.
// Exercises every FP path the SSA emit now covers:
//   - Inst::Binop with BinOp::Fadd / Fsub / Fmul / Fdiv (addsd /
//     subsd / mulsd / divsd)
//   - Inst::Binop with BinOp::Feq / Fne / Flt / Fgt / Fle / Fge
//     (ucomisd + setcc)
//   - Inst::Fneg (xorpd against the sign-bit mask)
//   - Inst::FpCast IntToFp (cvtsi2sd) and FpToInt (cvttsd2si)
//   - LoadKind::F32 (movss + cvtss2sd) and StoreKind::F32
//     (cvtsd2ss + movss)
//   - Place::FpReg arg placement to xmm0..xmm7 and the xmm0
//     return bridge.

#include <stdio.h>

static double fadd(double a, double b) { return a + b; }
static double fsub(double a, double b) { return a - b; }
static double fmul(double a, double b) { return a * b; }
static double fdiv(double a, double b) { return a / b; }
static double fneg(double a) { return -a; }
static int feq(double a, double b) { return a == b; }
static int fne(double a, double b) { return a != b; }
static int flt(double a, double b) { return a <  b; }
static int fgt(double a, double b) { return a >  b; }
static int fle(double a, double b) { return a <= b; }
static int fge(double a, double b) { return a >= b; }
static double itof(int i) { return (double)i; }
static int ftoi(double a) { return (int)a; }

static double round_through_f32(double x) {
    float f = (float)x;
    return (double)f;
}

int main(void) {
    if (fadd(1.5, 2.25) != 3.75) return 1;
    if (fsub(5.0, 1.5) != 3.5) return 2;
    if (fmul(2.5, 4.0) != 10.0) return 3;
    if (fdiv(15.0, 4.0) != 3.75) return 4;
    if (fneg(2.5) != -2.5) return 5;
    if (fneg(-7.0) != 7.0) return 6;
    if (!feq(1.0, 1.0)) return 7;
    if (feq(1.0, 2.0)) return 8;
    if (!fne(1.0, 2.0)) return 9;
    if (fne(1.0, 1.0)) return 10;
    if (!flt(1.0, 2.0)) return 11;
    if (flt(2.0, 1.0)) return 12;
    if (!fgt(2.0, 1.0)) return 13;
    if (fgt(1.0, 2.0)) return 14;
    if (!fle(1.0, 1.0)) return 15;
    if (!fle(1.0, 2.0)) return 16;
    if (fle(2.0, 1.0)) return 17;
    if (!fge(1.0, 1.0)) return 18;
    if (!fge(2.0, 1.0)) return 19;
    if (fge(1.0, 2.0)) return 20;
    if (itof(42) != 42.0) return 21;
    if (itof(-3) != -3.0) return 22;
    if (ftoi(3.75) != 3) return 23;
    if (ftoi(-3.75) != -3) return 24;
    // f32 round-trip: 0.1 in f32 is the nearest representable
    // binary value, which differs from f64's 0.1 by less than
    // 1e-7. The exact value the cvtsd2ss + cvtss2sd round-trip
    // produces is 0.10000000149011612.
    if (round_through_f32(0.1) == 0.1) return 25;
    if (round_through_f32(2.0) != 2.0) return 26;
    return 0;
}

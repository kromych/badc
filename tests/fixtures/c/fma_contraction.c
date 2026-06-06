// Fused multiply-add contraction (C99 6.5p8 / FP_CONTRACT). At -O the
// `a*b + c` / `a*b - c` / `c - a*b` shapes lower to a single fused
// instruction (one rounding); at -O0 they keep two separate rounds.
// All values here are exact in IEEE 754, so the result is identical
// under either rounding and the fixture passes at both optimization
// levels and against the VM reference.

// Explicit C99 7.12.13.1 fma / fmaf lower to the fused node directly
// (declared self-contained here so the fixture pulls in no platform
// libm bindings).
#pragma intrinsic("fma")
#pragma intrinsic("fmaf")
double fma(double x, double y, double z);
float fmaf(float x, float y, float z);

double dmadd(double a, double b, double c) { return a * b + c; }
double dmsub(double a, double b, double c) { return a * b - c; }
double dnmadd(double a, double b, double c) { return c - a * b; }

float fmadd_(float a, float b, float c) { return a * b + c; }
float fmsub_(float a, float b, float c) { return a * b - c; }
float fnmadd_(float a, float b, float c) { return c - a * b; }

int main() {
    // 2 * 3 + 4 = 10 ; 2 * 3 - 4 = 2 ; 4 - 2 * 3 = -2.
    if (dmadd(2.0, 3.0, 4.0) != 10.0) return 1;
    if (dmsub(2.0, 3.0, 4.0) != 2.0) return 2;
    if (dnmadd(2.0, 3.0, 4.0) != -2.0) return 3;

    if (fmadd_(2.0f, 3.0f, 4.0f) != 10.0f) return 4;
    if (fmsub_(2.0f, 3.0f, 4.0f) != 2.0f) return 5;
    if (fnmadd_(2.0f, 3.0f, 4.0f) != -2.0f) return 6;

    // Fractional but still exact: 0.5 * 0.25 + 0.125 = 0.25.
    if (dmadd(0.5, 0.25, 0.125) != 0.25) return 7;
    if (fmadd_(0.5f, 0.25f, 0.125f) != 0.25f) return 8;

    // Explicit fma / fmaf -- always fused (single rounding), even at
    // -O0, since the call itself names the fused operation.
    if (fma(2.0, 3.0, 4.0) != 10.0) return 9;
    if (fma(0.5, 0.25, 0.125) != 0.25) return 10;
    if (fmaf(2.0f, 3.0f, 4.0f) != 10.0f) return 11;
    // Integer arguments take the usual conversion to the FP operand
    // type (C99 6.3.1.4).
    if (fma(2, 3, 4) != 10.0) return 12;

    return 0;
}

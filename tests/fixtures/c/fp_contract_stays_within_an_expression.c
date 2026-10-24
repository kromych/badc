// C99 6.5p8: a floating expression may be contracted, a*b+c evaluated with
// one rounding, but only within one expression. An assignment, a return
// and a call's argument convert as if by assignment and end it, and
// `#pragma STDC FP_CONTRACT OFF` (7.12.2) forbids contraction until the end
// of its compound statement. With a = 1 + 2^-30 and c = 1 + 2^-29, a*a - c
// is 0 rounded twice and 2^-60 contracted. Returns 0.
volatile double va = 1.0 + 0x1p-30, vc = 1.0 + 0x1p-29;
volatile float vt = 3.0f;

static float stored(float t) { float x = 0.1f * t; return x - 0.3f; }
static double across(double a, double c) { double p = a * a; return p - c; }
static double square(double a) { return a * a; }
static double through_call(double a, double c) { return square(a) - c; }
static double within(double a, double c) { return a * a - c; }
static double compound(double a, double c) { double r = -c; r += a * a; return r; }
static double off(double a, double c) {
#pragma STDC FP_CONTRACT OFF
    return a * a - c;
}

int main(void) {
    double a = va, c = vc;
    if (stored(vt) != 0.0f)
        return 1;
    if (across(a, c) != 0.0 || through_call(a, c) != 0.0)
        return 2;
    if (off(a, c) != 0.0)
        return 3;
    double w = within(a, c), r = compound(a, c);
    if ((w != 0.0 && w != 0x1p-60) || (r != 0.0 && r != 0x1p-60))
        return 4;
    return 0;
}

/* A float parameter occupying an earlier FP-bank argument register than a
   following double must survive entry: materializing the parameters is a
   parallel copy within the FP bank, so one parameter's home d-register may
   be another's incoming argument register. The entry FP batch sequences the
   copy and breaks any cycle, matching native and clang behaviour. */

static float pick_first(float a, double b) {
    return a;
}
static double sum4(float a, double b, float c, double d) {
    return a + b + c + d;
}
static double dbl_then_float(double a, float b) {
    return a * 10.0 + b;
}

int main(void) {
    if (pick_first(2.5f, 4.5) != 2.5f) {
        return 1;
    }
    if (sum4(1.0f, 2.0, 3.0f, 4.0) != 10.0) {
        return 2;
    }
    if (dbl_then_float(5.0, 6.0f) != 56.0) {
        return 3;
    }
    return 0;
}

/* A float parameter occupying an earlier FP-bank argument register than a
   following double must survive entry: materializing the parameters is a
   parallel copy within the FP bank, so one parameter's home d-register may
   be another's incoming argument register. The entry FP batch sequences the
   copy and breaks any cycle, matching native and clang behaviour. */

static float pick_first(float a, double b) {
    return a;
}
static double pick_second(double a, float b) {
    return b;
}

int main(void) {
    if (pick_first(2.5f, 4.5) != 2.5f) {
        return 1;
    }
    if (pick_second(8.5, 6.5f) != 6.5f) {
        return 2;
    }
    return 0;
}

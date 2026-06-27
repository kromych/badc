/* Floating-point parameters are materialized from their incoming FP
   argument registers, which stay live from entry until each ParamRef
   reads them. When a float occupies an earlier FP-bank argument register
   than a following double, one parameter's destination may be another's
   incoming register; the allocator keeps each ParamRef off a later
   same-bank ParamRef's incoming register, and the entry FP batch
   sequences the copy and breaks any cycle, matching native and clang. */

static float pick_first(float a, double b) {
    return a;
}
static double pick_second(double a, float b) {
    return b;
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
    if (pick_second(8.5, 6.5f) != 6.5f) {
        return 2;
    }
    if (sum4(1.0f, 2.0, 3.0f, 4.0) != 10.0) {
        return 3;
    }
    if (dbl_then_float(5.0, 6.0f) != 56.0) {
        return 4;
    }
    return 0;
}

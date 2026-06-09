// A `float` global initializer stores the f32 bit pattern, not the low
// four bytes of the f64 constant (which are zero for many values).
// `double` keeps the full f64 pattern. Integer and suffixed constants
// convert to the floating value (C99 6.7.8p11 / 6.3.1.4).

float fa = 1.0;     // double constant narrowed to f32
float fb = 1.0f;
float fc = 2.5;
float fd = 1;       // int constant converted to float
float fe = 1.0l;    // long-double constant narrowed to f32
double da = 1.0f;
double db = 2.5;
double dc = 3;

static int near(double x, double target) {
    double d = x - target;
    return d < 0.001 && d > -0.001;
}

int main(void) {
    if (!near(fa, 1.0)) return 1;
    if (!near(fb, 1.0)) return 2;
    if (!near(fc, 2.5)) return 3;
    if (!near(fd, 1.0)) return 4;
    if (!near(fe, 1.0)) return 5;
    if (!near(da, 1.0)) return 6;
    if (!near(db, 2.5)) return 7;
    if (!near(dc, 3.0)) return 8;
    return 0;
}

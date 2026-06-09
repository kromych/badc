// Unary `+` on a numeric literal is the identity in a constant
// initializer (C99 6.5.3.3p2); a `+0.7` array element must not fall
// through to the integer path and store zero. A parameter that shares
// its function's name shadows the function inside the body (C99 6.2.1),
// so the name refers to the parameter's value.

double dv[] = { -0.7, +0.7, +1, -2 };
int iv[] = { +5, -3, +0, 7 };

static int near(double x, double t) {
    double d = x - t;
    return d < 0.001 && d > -0.001;
}

int f(int f) {
    return f;
}

int main(void) {
    if (!near(dv[0], -0.7)) return 1;
    if (!near(dv[1], 0.7)) return 2;
    if (!near(dv[2], 1.0)) return 3;
    if (!near(dv[3], -2.0)) return 4;
    if (iv[0] != 5 || iv[1] != -3 || iv[2] != 0 || iv[3] != 7) return 5;

    if (f(0) != 0) return 6;
    if (f(42) != 42) return 7;

    return 0;
}

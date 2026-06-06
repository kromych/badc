// Multiply-add-heavy numerical kernels that exercise FMA contraction
// (C99 6.5p8 / FP_CONTRACT) at -O: Horner polynomial evaluation, a
// dense matrix product inner loop, and a fourth-order Runge-Kutta
// step. Results are checked with a tolerance so the fixture passes
// under both the single-rounding fused form (-O) and the two-rounding
// separate form (-O0), and against the VM reference at each level.

static int approx_eq(double a, double b) {
    double d = a - b;
    if (d < 0.0) {
        d = -d;
    }
    return d < 1e-9;
}

// p(x) = c0 + c1*x + c2*x^2 + c3*x^3 + c4*x^4 evaluated as nested
// `acc = acc*x + c[i]`, the canonical multiply-add recurrence.
static double horner(const double *c, int n, double x) {
    double acc = c[n - 1];
    int i;
    for (i = n - 2; i >= 0; i--) {
        acc = acc * x + c[i];
    }
    return acc;
}

// C[i][j] = sum_k A[i][k] * B[k][j], the dense-matmul inner product
// that accumulates a running multiply-add.
static double dot3(const double a[3][3], const double b[3][3], int i, int j) {
    double s = 0.0;
    int k;
    for (k = 0; k < 3; k++) {
        s = s + a[i][k] * b[k][j];
    }
    return s;
}

// One classical RK4 step of dy/dx = y (closed form y = y0 * e^h).
static double rk4_step(double y, double h) {
    double k1 = y;
    double k2 = y + (h * 0.5) * k1;
    double k3 = y + (h * 0.5) * k2;
    double k4 = y + h * k3;
    return y + (h / 6.0) * (k1 + 2.0 * k2 + 2.0 * k3 + k4);
}

int main() {
    // Horner: p(x) = 1 + 2x + 3x^2 + 4x^3 + 5x^4 at x = 2 -> 129.
    double coef[5];
    coef[0] = 1.0;
    coef[1] = 2.0;
    coef[2] = 3.0;
    coef[3] = 4.0;
    coef[4] = 5.0;
    if (!approx_eq(horner(coef, 5, 2.0), 129.0)) {
        return 1;
    }
    // Same polynomial at x = 0 is just the constant term.
    if (!approx_eq(horner(coef, 5, 0.0), 1.0)) {
        return 2;
    }

    // Matrix product of A and the 3x3 identity returns A unchanged.
    double a[3][3];
    double id[3][3];
    int i;
    int j;
    for (i = 0; i < 3; i++) {
        for (j = 0; j < 3; j++) {
            a[i][j] = (double)(i * 3 + j + 1);
            id[i][j] = (i == j) ? 1.0 : 0.0;
        }
    }
    for (i = 0; i < 3; i++) {
        for (j = 0; j < 3; j++) {
            if (!approx_eq(dot3(a, id, i, j), a[i][j])) {
                return 3;
            }
        }
    }
    // A specific product element: row 1 of A . column 2 of A.
    // A = [[1,2,3],[4,5,6],[7,8,9]]; (A*A)[1][2] = 4*3+5*6+6*9 = 96.
    if (!approx_eq(dot3(a, a, 1, 2), 96.0)) {
        return 4;
    }

    // RK4 integrating dy/dx = y from x=0 to x=1 in 16 steps, y(0)=1.
    // The exact value is e; RK4 at this step count is well within the
    // tolerance below.
    double y = 1.0;
    double h = 1.0 / 16.0;
    int s;
    for (s = 0; s < 16; s++) {
        y = rk4_step(y, h);
    }
    double e = 2.718281828459045;
    double diff = y - e;
    if (diff < 0.0) {
        diff = -diff;
    }
    if (diff > 1e-6) {
        return 5;
    }

    return 0;
}

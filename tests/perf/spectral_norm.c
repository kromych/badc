// Spectral norm of the infinite matrix A(i,j) = 1/((i+j)(i+j+1)/2 + i + 1),
// estimated by the power method on its leading N x N block: ten rounds of
// v <- A^T A u and u <- A^T A v from u = 1, then sqrt(u.v / v.v). Each
// product evaluates every element afresh through a small helper, so the
// fixture exercises inlining of that call, the integer-to-double
// conversion and the division it feeds, and a serial floating-point sum
// in the inner loop, which is not reassociated without a fast-math flag.
//
// The 100 x 100 estimate is checked against its nine-decimal value
// 1.274219991, and the N x N estimate against its own, 1.274224152.

#include <math.h>
#include <stdio.h>
#include "bench_clock.h"

#define N 2000
#define NORM_100 1.274219991
#define NORM_N 1.274224152

static double u[N], v[N], tmp[N];

static double a_elem(int i, int j) {
    return 1.0 / ((i + j) * (i + j + 1) / 2 + i + 1);
}

static void mul_a(const double *x, double *y, int n) {
    for (int i = 0; i < n; i++) {
        double s = 0.0;
        for (int j = 0; j < n; j++) {
            s += a_elem(i, j) * x[j];
        }
        y[i] = s;
    }
}

static void mul_at(const double *x, double *y, int n) {
    for (int i = 0; i < n; i++) {
        double s = 0.0;
        for (int j = 0; j < n; j++) {
            s += a_elem(j, i) * x[j];
        }
        y[i] = s;
    }
}

static void mul_ata(const double *x, double *y, int n) {
    mul_a(x, tmp, n);
    mul_at(tmp, y, n);
}

static double spectral_norm(int n) {
    for (int i = 0; i < n; i++) {
        u[i] = 1.0;
    }
    for (int k = 0; k < 10; k++) {
        mul_ata(u, v, n);
        mul_ata(v, u, n);
    }
    double uv = 0.0, vv = 0.0;
    for (int i = 0; i < n; i++) {
        uv += u[i] * v[i];
        vv += v[i] * v[i];
    }
    return sqrt(uv / vv);
}

int main(void) {
    double small = spectral_norm(100);

    double t0 = bench_ms();
    double norm = spectral_norm(N);
    double t1 = bench_ms();

    printf("spectral_norm(%d) = %.9f in %.2f ms\n", N, norm, t1 - t0);

    if (fabs(small - NORM_100) > 1e-9 || fabs(norm - NORM_N) > 1e-9) {
        printf("WRONG: expected %.9f for 100 and %.9f for %d\n", NORM_100, NORM_N, N);
        return 1;
    }
    return 0;
}

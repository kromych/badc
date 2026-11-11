// Polynomial evaluation for the perf table: the degree-15 Taylor polynomial
// of exp, sum of x^k / k! for k = 0..15, over COUNT points in [-0.5, 0.5],
// REPS times by Horner's rule and REPS times by Estrin's scheme. Horner's
// rule is one chain of fifteen dependent multiply-adds; Estrin's scheme
// pairs the coefficients into a tree of depth four over x, x^2, x^4, and
// x^8, which shortens the chain at the cost of three squarings. Exercises
// floating-point register allocation for sixteen coefficients held across
// the loop, the inlining of both evaluators, the latency of a serial
// dependency chain against independent operations, and a serial sum.
//
// Every point is checked against libm's exp and between the two schemes,
// and each sum against REPS times the sum of exp over the points.

#include <math.h>
#include <stdio.h>
#include "bench_clock.h"

#define DEGREE 15
#define COUNT 4096
#define REPS 10000

static double coef[DEGREE + 1];
static double xs[COUNT];

static double horner(const double *c, double x) {
    return c[0] + x * (c[1] + x * (c[2] + x * (c[3] + x * (c[4] + x * (c[5] + x * (c[6]
         + x * (c[7] + x * (c[8] + x * (c[9] + x * (c[10] + x * (c[11] + x * (c[12]
         + x * (c[13] + x * (c[14] + x * c[15]))))))))))))));
}

// Both evaluators spell out the sixteen coefficients of DEGREE == 15.
static double estrin(const double *c, double x) {
    double x2 = x * x;
    double x4 = x2 * x2;
    double x8 = x4 * x4;
    double p0 = c[0] + c[1] * x, p1 = c[2] + c[3] * x;
    double p2 = c[4] + c[5] * x, p3 = c[6] + c[7] * x;
    double p4 = c[8] + c[9] * x, p5 = c[10] + c[11] * x;
    double p6 = c[12] + c[13] * x, p7 = c[14] + c[15] * x;
    double q0 = p0 + p1 * x2, q1 = p2 + p3 * x2;
    double q2 = p4 + p5 * x2, q3 = p6 + p7 * x2;
    double r0 = q0 + q1 * x4, r1 = q2 + q3 * x4;
    return r0 + r1 * x8;
}

int main(void) {
    coef[0] = 1.0;
    for (int k = 1; k <= DEGREE; k++) {
        coef[k] = coef[k - 1] / k;
    }
    double ref_sum = 0.0;
    int bad = 0;
    for (int i = 0; i < COUNT; i++) {
        double x = (i + 0.5) / COUNT - 0.5;
        double ref = exp(x), h = horner(coef, x), e = estrin(coef, x);
        xs[i] = x;
        ref_sum += ref;
        bad |= fabs(h - ref) > 1e-14 * ref || fabs(e - h) > 1e-14 * ref;
    }

    double t0 = bench_ms();
    double h_sum = 0.0;
    for (int r = 0; r < REPS; r++) {
        for (int i = 0; i < COUNT; i++) {
            h_sum += horner(coef, xs[i]);
        }
    }
    double e_sum = 0.0;
    for (int r = 0; r < REPS; r++) {
        for (int i = 0; i < COUNT; i++) {
            e_sum += estrin(coef, xs[i]);
        }
    }
    double t1 = bench_ms();

    printf("horner deg %d x %d points x %d reps sums=%.9e,%.9e in %.2f ms\n", DEGREE, COUNT, REPS,
           h_sum, e_sum, t1 - t0);

    double expect = REPS * ref_sum;
    if (bad || fabs(h_sum - expect) > 1e-8 * expect || fabs(e_sum - expect) > 1e-8 * expect) {
        printf("WRONG: expected both sums near %.9e and every point within 1e-14 of exp\n",
               expect);
        return 1;
    }
    return 0;
}

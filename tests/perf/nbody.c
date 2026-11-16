// Five-body gravitational integration for the perf table: the Sun and the
// four outer planets in heliocentric units (AU, years, solar masses
// scaled by 4*pi^2), advanced by a symplectic Euler step of dt = 0.01
// after the Sun's velocity is set to cancel the system's momentum.
// Exercises floating-point register allocation across a nested pair loop,
// loads and stores through an array of structs, and the latency of
// sqrt and division in the inverse-cube distance term.
//
// The total energy before and after the run must match, to the nine
// decimals printed, what this integration produces for STEPS steps in
// double precision; contracting the multiply-adds or not leaves those
// decimals unchanged.

#include <math.h>
#include <stdio.h>
#include "bench_clock.h"

#define STEPS 5000000
#define NBODIES 5
#define PI 3.141592653589793
#define SOLAR_MASS (4.0 * PI * PI)
#define DAYS_PER_YEAR 365.24
#define ENERGY_BEFORE (-0.169075164)
#define ENERGY_AFTER (-0.169083134)

struct body {
    double x, y, z;
    double vx, vy, vz;
    double mass;
};

static struct body bodies[NBODIES] = {
    {0.0, 0.0, 0.0, 0.0, 0.0, 0.0, SOLAR_MASS},
    {4.84143144246472090e+00, -1.16032004402742839e+00, -1.03622044471123109e-01,
     1.66007664274403694e-03 * DAYS_PER_YEAR, 7.69901118419740425e-03 * DAYS_PER_YEAR,
     -6.90460016972063023e-05 * DAYS_PER_YEAR, 9.54791938424326609e-04 * SOLAR_MASS},
    {8.34336671824457987e+00, 4.12479856412430479e+00, -4.03523417114321381e-01,
     -2.76742510726862411e-03 * DAYS_PER_YEAR, 4.99852801234917238e-03 * DAYS_PER_YEAR,
     2.30417297573763929e-05 * DAYS_PER_YEAR, 2.85885980666130812e-04 * SOLAR_MASS},
    {1.28943695621391310e+01, -1.51111514016986312e+01, -2.23307578892655734e-01,
     2.96460137564761618e-03 * DAYS_PER_YEAR, 2.37847173959480950e-03 * DAYS_PER_YEAR,
     -2.96589568540237556e-05 * DAYS_PER_YEAR, 4.36624404335156298e-05 * SOLAR_MASS},
    {1.53796971148509165e+01, -2.59193146099879641e+01, 1.79258772950371181e-01,
     2.68067772490389322e-03 * DAYS_PER_YEAR, 1.62824170038242295e-03 * DAYS_PER_YEAR,
     -9.51592254519715870e-05 * DAYS_PER_YEAR, 5.15138902046611451e-05 * SOLAR_MASS},
};

static void offset_momentum(struct body *b, int n) {
    double px = 0.0, py = 0.0, pz = 0.0;
    for (int i = 0; i < n; i++) {
        px += b[i].vx * b[i].mass;
        py += b[i].vy * b[i].mass;
        pz += b[i].vz * b[i].mass;
    }
    b[0].vx = -px / SOLAR_MASS;
    b[0].vy = -py / SOLAR_MASS;
    b[0].vz = -pz / SOLAR_MASS;
}

static double energy(const struct body *b, int n) {
    double e = 0.0;
    for (int i = 0; i < n; i++) {
        e += 0.5 * b[i].mass * (b[i].vx * b[i].vx + b[i].vy * b[i].vy + b[i].vz * b[i].vz);
        for (int j = i + 1; j < n; j++) {
            double dx = b[i].x - b[j].x;
            double dy = b[i].y - b[j].y;
            double dz = b[i].z - b[j].z;
            e -= b[i].mass * b[j].mass / sqrt(dx * dx + dy * dy + dz * dz);
        }
    }
    return e;
}

static void advance(struct body *b, int n, double dt) {
    for (int i = 0; i < n; i++) {
        struct body *bi = &b[i];
        for (int j = i + 1; j < n; j++) {
            struct body *bj = &b[j];
            double dx = bi->x - bj->x;
            double dy = bi->y - bj->y;
            double dz = bi->z - bj->z;
            double d2 = dx * dx + dy * dy + dz * dz;
            double mag = dt / (d2 * sqrt(d2));
            double mi = bi->mass * mag;
            double mj = bj->mass * mag;
            bi->vx -= dx * mj;
            bi->vy -= dy * mj;
            bi->vz -= dz * mj;
            bj->vx += dx * mi;
            bj->vy += dy * mi;
            bj->vz += dz * mi;
        }
    }
    for (int i = 0; i < n; i++) {
        b[i].x += dt * b[i].vx;
        b[i].y += dt * b[i].vy;
        b[i].z += dt * b[i].vz;
    }
}

int main(void) {
    offset_momentum(bodies, NBODIES);
    double e0 = energy(bodies, NBODIES);

    double t0 = bench_ms();
    for (int s = 0; s < STEPS; s++) {
        advance(bodies, NBODIES, 0.01);
    }
    double t1 = bench_ms();

    double e1 = energy(bodies, NBODIES);
    printf("nbody %d steps e0=%.9f e1=%.9f in %.2f ms\n", STEPS, e0, e1, t1 - t0);

    if (fabs(e0 - ENERGY_BEFORE) > 1e-9 || fabs(e1 - ENERGY_AFTER) > 1e-9) {
        printf("WRONG: expected e0=%.9f e1=%.9f\n", ENERGY_BEFORE, ENERGY_AFTER);
        return 1;
    }
    return 0;
}

/* End-to-end smoke driver for KISS FFT. The first real FP
 * exerciser in the demo set: every scenario runs through
 * `kiss_fft` / `kiss_fftr` (the real-only fast variant) and
 * compares against either a closed-form expectation or a
 * forward+inverse round-trip, with a tolerance threshold tight
 * enough to catch a genuine arithmetic regression without
 * tripping on rounding noise.
 *
 * Bake-in like the sqlite / miniz drivers: every reference
 * value lives next to its assertion so the runner is one
 * `python smoke.py` invocation away from green-or-red. */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <string.h>

#include "kiss_fft.h"
#include "kiss_fftr.h"

#define N 16

static int near_eq(double a, double b, double eps) {
    double d = a - b;
    if (d < 0) d = -d;
    return d <= eps;
}

/* Scenario 1 -- impulse: in[0] = 1, all other bins 0. The
 * forward FFT of an impulse is a flat unit spectrum: every
 * output bin has r=1, i=0. Catches any breakage in twiddle
 * factors, butterflies, or the FP libm boundary. */
static int scenario_impulse(void) {
    kiss_fft_cfg fwd = kiss_fft_alloc(N, 0, NULL, NULL);
    if (!fwd) { fprintf(stderr, "kiss_fft_alloc failed\n"); return 1; }
    kiss_fft_cpx in[N], out[N];
    int i;
    for (i = 0; i < N; i++) { in[i].r = 0; in[i].i = 0; }
    in[0].r = 1.0f;
    kiss_fft(fwd, in, out);

    int bad = 0;
    for (i = 0; i < N; i++) {
        if (!near_eq(out[i].r, 1.0, 1e-5)) bad++;
        if (!near_eq(out[i].i, 0.0, 1e-5)) bad++;
    }
    free(fwd);
    if (bad != 0) {
        fprintf(stderr, "kissfft smoke: impulse FFT has %d bad components\n", bad);
        return 1;
    }
    printf("impulse OK\n");
    return 0;
}

/* Scenario 2 -- forward + inverse round-trip. Filling the
 * input with a deterministic mixed signal (a few sin terms +
 * a constant) and round-tripping it must recover the original
 * within tolerance. kissfft's inverse needs scaling by 1/N
 * (per the upstream API contract). Catches FP arithmetic
 * stability across both directions. */
static int scenario_roundtrip(void) {
    kiss_fft_cfg fwd = kiss_fft_alloc(N, 0, NULL, NULL);
    kiss_fft_cfg inv = kiss_fft_alloc(N, 1, NULL, NULL);
    if (!fwd || !inv) { fprintf(stderr, "kiss_fft_alloc failed\n"); return 1; }
    kiss_fft_cpx in[N], spec[N], back[N];
    int i;
    for (i = 0; i < N; i++) {
        double t = (double)i / (double)N;
        in[i].r = (float)(0.7 + sin(2.0 * 3.141592653589793 * t)
                                + 0.3 * sin(6.0 * 3.141592653589793 * t));
        in[i].i = 0.0f;
    }
    kiss_fft(fwd, in, spec);
    kiss_fft(inv, spec, back);

    int bad = 0;
    for (i = 0; i < N; i++) {
        double r = (double)back[i].r / (double)N;
        double j = (double)back[i].i / (double)N;
        if (!near_eq(r, in[i].r, 1e-4)) bad++;
        if (!near_eq(j, 0.0,     1e-4)) bad++;
    }
    free(fwd);
    free(inv);
    if (bad != 0) {
        fprintf(stderr, "kissfft smoke: round-trip has %d mismatches\n", bad);
        return 1;
    }
    printf("roundtrip OK\n");
    return 0;
}

/* Scenario 3 -- real-only forward FFT. kiss_fftr packs an
 * N-real input into N/2+1 complex outputs (half-spectrum,
 * Hermitian-symmetric). For a single-frequency sine wave at
 * bin k, only `out[k]` carries meaningful magnitude (~N/2)
 * and the imaginary part is the dominant component (sine is
 * odd). Catches anything that breaks the kiss_fftr scrambling
 * pass on top of the underlying complex FFT. */
static int scenario_real_sine(void) {
    kiss_fftr_cfg fwd = kiss_fftr_alloc(N, 0, NULL, NULL);
    if (!fwd) { fprintf(stderr, "kiss_fftr_alloc failed\n"); return 1; }
    kiss_fft_scalar in[N];
    kiss_fft_cpx out[N / 2 + 1];
    int k = 3;
    int i;
    for (i = 0; i < N; i++) {
        double t = (double)i / (double)N;
        in[i] = (kiss_fft_scalar)sin(2.0 * 3.141592653589793 * (double)k * t);
    }
    kiss_fftr(fwd, in, out);

    /* Dominant bin should be at index `k` with magnitude ~ N/2 in the
     * imaginary component (sine -> imag, cosine -> real). Other bins
     * should be near zero. */
    int bad = 0;
    for (i = 0; i <= N / 2; i++) {
        double mag = sqrt((double)out[i].r * out[i].r
                          + (double)out[i].i * out[i].i);
        if (i == k) {
            if (!near_eq(mag, (double)N / 2.0, 0.05)) bad++;
        } else {
            if (mag > 0.05) bad++;
        }
    }
    free(fwd);
    if (bad != 0) {
        fprintf(stderr, "kissfft smoke: real-sine has %d bad bins\n", bad);
        return 1;
    }
    printf("real-sine OK\n");
    return 0;
}

int main(int argc, char **argv) {
    (void)argc;
    (void)argv;
    if (scenario_impulse() != 0) return 1;
    if (scenario_roundtrip() != 0) return 1;
    if (scenario_real_sine() != 0) return 1;
    printf("kissfft smoke: all scenarios green\n");
    return 0;
}

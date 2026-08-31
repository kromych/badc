// The body-size cap has to weigh the code the emit issues for a callee
// once this pass has spliced into that callee, not the body as it
// stands. A helper that measures small only because its own calls are
// still calls costs its caller the whole transitive body, once per call
// site, and the candidacy fixpoint then expands the copies it just made.
//
// `mix` is well under the default cap of 64 on its own and calls four
// `step_*` helpers that are each under it as well; together they are far
// over it. Each `step_*` folds into `mix`, and `mix` stays out of line.

static volatile unsigned long long seed = 3;

#define STEP(name, k)                                                                              \
    static unsigned long long name(unsigned long long x) {                                         \
        unsigned long long a = x * (k) + 1;                                                        \
        unsigned long long b = a ^ (a >> 2);                                                       \
        unsigned long long c = b + (b << 3);                                                       \
        unsigned long long d = c ^ (c >> 5);                                                       \
        unsigned long long e = d + (d << 7);                                                       \
        unsigned long long f = e ^ (e >> 11);                                                      \
        unsigned long long g = f + (f << 13);                                                      \
        return g ^ (g >> 17);                                                                      \
    }

STEP(step_a, 3)
STEP(step_b, 5)
STEP(step_c, 7)
STEP(step_d, 11)

static unsigned long long mix(unsigned long long x) {
    return step_a(x) + step_b(x + 1) + step_c(x + 2) + step_d(x + 3);
}

int main(void) {
    unsigned long long s = mix(seed) + mix(seed + 1) + mix(seed + 2) + mix(seed + 3);
    return s == 0x00000001AC628ADCULL ? 0 : 1;
}

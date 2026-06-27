/* A single-block leaf helper called from a loop body. The caller's
   loop-carried values become phis under mem2reg, so before phi-bearing
   callers were allowed to inline, `mix` stayed an out-of-line call
   across the loop. The flat splice keeps the loop-head phi block ids
   fixed and the value-remap fixpoint resolves each phi's back-edge
   incoming, so `mix` inlines into the loop body. The digest is checked
   against a value computed off-line to lock the result. */

static unsigned mix(unsigned x, unsigned y, unsigned z) {
    return (x & y) ^ (~x & z);
}

static unsigned digest(const unsigned *w, int n) {
    unsigned a = 0x6a09e667u;
    unsigned b = 0xbb67ae85u;
    unsigned c = 0x3c6ef372u;
    for (int i = 0; i < n; i++) {
        unsigned t = mix(a, b, c) + w[i];
        c = b;
        b = a;
        a = t;
    }
    return a ^ b ^ c;
}

int main(void) {
    unsigned w[8] = {1, 2, 3, 4, 5, 6, 7, 8};
    return digest(w, 8) == 0xff6fffefu ? 0 : 1;
}

// C99 6.8.5.3p1 admits both `declaration` and `expression` as
// the for-init. The parser dual-emit captured the
// expression-init shape into `Stmt::For.init` but left the
// declaration-init path setting `init: None` on the AST: the
// bytecode tier still emitted the init op-sequence, but the
// walker, reading the AST snapshot, never saw the counter
// declaration. The counter then carried over from any prior
// loop, so a nested for-loop body inside an outer loop ran
// against a stale upper-loop counter and the inner loop body
// silently turned into a no-op on every outer iteration past
// the first.
//
// Surfaced by monocypher's `sha512_compress`: the outer
// `FOR(i, 1, 5)` and inner `FOR(j, 0, 16)` both expand to
// `for (size_t var = N; var < M; var++)`. Without the init
// walk the inner `j` kept the previous iteration's exit
// value (16), the inner body executed zero times on outer
// iterations 2..5, and the SHA-512 digest didn't match the
// FIPS 180-2 vector.

#include <stdio.h>

int run(void) {
    int sum = 0;
    for (int i = 1; i < 5; i++) {
        for (int j = 0; j < 16; j++) {
            sum += i * 100 + j;
        }
    }
    return sum;
}

int main(void) {
    // Each outer iteration contributes 16 * i * 100 + (0+1+...+15)
    // = 1600 * i + 120; outer i = 1..4, so expected =
    // (1600*1+120) + (1600*2+120) + (1600*3+120) + (1600*4+120)
    // = 1600 * 10 + 4 * 120 = 16000 + 480 = 16480.
    if (run() != 16480) return 1;
    return 0;
}

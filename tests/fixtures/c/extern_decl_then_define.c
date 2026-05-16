// C99 6.9.2 / 6.2.2: an `extern T x;` declaration leaves the
// defining declaration to a later (possibly in the same TU)
// `T x = ...;`. The two must merge into one symbol with the
// defining decl's storage; mishandling the merge collapses
// every following defining decl to the same `.data` offset.
//
// Surface shape from BearSSL's `src/inner.h` +
// `src/hash/sha2small.c`:
//
//     // inner.h
//     extern const uint32_t br_sha224_IV[];
//     extern const uint32_t br_sha256_IV[];
//     // sha2small.c
//     const uint32_t br_sha224_IV[8] = { 0xC1059ED8, ... };
//     const uint32_t br_sha256_IV[8] = { 0x6A09E667, ... };
//
// Without distinct storage for each defining decl, both names
// resolve to the same bytes and SHA-224 produces the SHA-256
// digest.
//
// Returns 0 only when every check passes; each failure path
// returns a distinct nonzero code.

extern const unsigned int IV_A[];
extern const unsigned int IV_B[];

const unsigned int IV_A[8] = {
    0xC1059ED8u, 0x367CD507u, 0x3070DD17u, 0xF70E5939u,
    0xFFC00B31u, 0x68581511u, 0x64F98FA7u, 0xBEFA4FA4u
};
const unsigned int IV_B[8] = {
    0x6A09E667u, 0xBB67AE85u, 0x3C6EF372u, 0xA54FF53Au,
    0x510E527Fu, 0x9B05688Cu, 0x1F83D9ABu, 0x5BE0CD19u
};

int main(void) {
    if (IV_A == IV_B)           return 1;
    if (IV_A[0] != 0xC1059ED8u) return 2;
    if (IV_B[0] != 0x6A09E667u) return 3;
    if (IV_A[7] != 0xBEFA4FA4u) return 4;
    if (IV_B[7] != 0x5BE0CD19u) return 5;
    return 0;
}

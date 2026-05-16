// C99 6.9.2 / 6.2.2: an `extern T x;` declaration leaves the
// defining declaration to a later (possibly in the same TU)
// `T x = ...;`. The two must merge into one symbol with the
// defining decl's storage; mishandling the merge collapses
// every following defining decl to the same `.data` offset.
//
// Canonical shape (header declares the public name as an
// extern array, the implementation .c file defines it):
//
//     // header
//     extern const uint32_t IV_A[];
//     extern const uint32_t IV_B[];
//     // implementation
//     const uint32_t IV_A[8] = { ... };
//     const uint32_t IV_B[8] = { ... };
//
// Without distinct storage for each defining decl, both names
// resolve to the same bytes.
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

// Same shape but for a non-array global: a previous extern-only
// decl of a struct global allocates `sizeof(T)` bytes at
// `sym.val`; code emitted in the same TU that references
// `&v` (e.g. another function's body) bakes that offset in.
// The defining `T v = { ... }` MUST therefore reuse that
// storage so the baked-in references read the initialised
// bytes -- a fresh allocation would leave the original offset
// pointing at zeros.
typedef struct vtbl { unsigned int desc; void *init; } vtbl;
extern const vtbl V;
const vtbl V = { 0xA5A5A5A5u, (void *)0xDEADBEEFu };
static const vtbl *peek_via_extern(void) { return &V; }

int main(void) {
    if (IV_A == IV_B)           return 1;
    if (IV_A[0] != 0xC1059ED8u) return 2;
    if (IV_B[0] != 0x6A09E667u) return 3;
    if (IV_A[7] != 0xBEFA4FA4u) return 4;
    if (IV_B[7] != 0x5BE0CD19u) return 5;

    // `peek_via_extern` was parsed before the defining `V` was
    // seen, so its body references the extern's offset. The
    // initialised bytes must land at the same offset.
    if (peek_via_extern() != &V)            return 6;
    if (peek_via_extern()->desc != 0xA5A5A5A5u) return 7;
    if (peek_via_extern()->init != (void *)0xDEADBEEFu) return 8;
    return 0;
}

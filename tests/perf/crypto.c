// In-memory crypto workload for the perf harness: repeated SHA-512
// hashing of a small buffer via the TweetNaCl primitives. The hot path
// is 64-bit integer mixing (adds, xors, rotations, shifts) with no I/O,
// so the wall-clock reflects the codegen of the compression loop rather
// than syscall or allocator behaviour. Self-times via clock_gettime and
// prints "in N ms".
//
// The TweetNaCl source is included directly so the fixture is a single
// translation unit, matching how the harness compiles each entry with
// one compiler invocation. crypto_hash expands to crypto_hash_sha512
// through the header pulled in by tweetnacl.c.
#include <stdint.h>
#include <stdio.h>
#include <time.h>

// Include the header explicitly: badc resolves quoted includes against
// the search path rather than the including file's directory, so the
// nested `#include "tweetnacl.h"` inside tweetnacl.c would otherwise be
// dropped. The header guard makes the redundant nested include a no-op.
#include "../../demos/tweetnacl/tweetnacl.h"
#include "../../demos/tweetnacl/tweetnacl.c"

// TweetNaCl declares randombytes extern for its key-generation paths.
// The SHA-512 path never calls it, but the symbol must resolve at link
// time for the whole translation unit.
void randombytes(unsigned char *x, unsigned long long n) {
    for (unsigned long long i = 0; i < n; i++) {
        x[i] = (unsigned char)i;
    }
}

#define HASH_ITERS 200000

int main(void) {
    unsigned char buf[128];
    for (int i = 0; i < 128; i++) {
        buf[i] = (unsigned char)(i * 31 + 7);
    }
    unsigned char hash[64];

    struct timespec t0, t1;
    clock_gettime(CLOCK_MONOTONIC, &t0);
    uint64_t acc = 0;
    for (int it = 0; it < HASH_ITERS; it++) {
        crypto_hash(hash, buf, sizeof buf);
        // Chain the output back into the input so the loop has a true
        // dependency and the optimizer can't hoist or drop iterations.
        buf[it & 0x7f] ^= hash[0];
        acc += hash[0];
    }
    clock_gettime(CLOCK_MONOTONIC, &t1);

    long secs = t1.tv_sec - t0.tv_sec;
    long nsecs = t1.tv_nsec - t0.tv_nsec;
    double ms = (double)secs * 1000.0 + (double)nsecs / 1000000.0;
    printf("sha512 x%d acc=%llu in %.2f ms\n", HASH_ITERS,
           (unsigned long long)acc, ms);
    return 0;
}

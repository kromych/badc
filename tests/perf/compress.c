// In-memory compression workload for the perf harness: repeated
// deflate round-trips (compress then decompress) of a fixed buffer via
// miniz. The hot path is the LZ match-finder and Huffman coder, a mix
// of byte shuffling, hash lookups, and bit packing with no I/O. Self-
// times via clock_gettime and prints "in N ms".
//
// The miniz amalgamation is included directly so the fixture is a
// single translation unit. The harness puts demos/miniz on the include
// search path so the nested `#include "miniz.h"` resolves.
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

#include "miniz.h"
#include "miniz.c"

#define BUF_LEN 16384
#define ITERS 3000

int main(void) {
    static unsigned char src[BUF_LEN];
    for (int i = 0; i < BUF_LEN; i++) {
        // Semi-compressible: a low-entropy pattern with some structure
        // so the match-finder and Huffman stages both do real work.
        src[i] = (unsigned char)((i * 73) ^ (i >> 3));
    }
    mz_ulong bound = mz_compressBound(BUF_LEN);
    unsigned char *comp = malloc(bound);
    static unsigned char dec[BUF_LEN];
    if (comp == NULL) {
        return 2;
    }

    struct timespec t0, t1;
    clock_gettime(CLOCK_MONOTONIC, &t0);
    uint64_t acc = 0;
    mz_ulong last_clen = 0;
    for (int it = 0; it < ITERS; it++) {
        mz_ulong clen = bound;
        if (mz_compress(comp, &clen, src, BUF_LEN) != MZ_OK) {
            return 3;
        }
        mz_ulong dlen = BUF_LEN;
        if (mz_uncompress(dec, &dlen, comp, clen) != MZ_OK) {
            return 4;
        }
        last_clen = clen;
        acc += clen + dec[it & (BUF_LEN - 1)];
        // Mutate the input so each iteration recompresses fresh data and
        // the loop carries a true dependency.
        src[it & (BUF_LEN - 1)] ^= (unsigned char)clen;
    }
    clock_gettime(CLOCK_MONOTONIC, &t1);

    // The decompressed buffer must match the input the last iteration
    // compressed; a mismatch means a miscompiled codec.
    if (memcmp(src, dec, BUF_LEN) != 0) {
        return 5;
    }

    long secs = t1.tv_sec - t0.tv_sec;
    long nsecs = t1.tv_nsec - t0.tv_nsec;
    double ms = (double)secs * 1000.0 + (double)nsecs / 1000000.0;
    printf("deflate x%d clen=%lu acc=%llu in %.2f ms\n", ITERS,
           (unsigned long)last_clen, (unsigned long long)acc, ms);
    free(comp);
    return 0;
}

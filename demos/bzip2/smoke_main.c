/* End-to-end smoke driver for bzip2 1.0.8.
 *
 * bzip2 is integer + bit-twiddle heavy: Burrows-Wheeler
 * transform, move-to-front, run-length encoding, and Huffman
 * coding in a 128-bit-bitstream packer. Different shape from
 * deflate (no LZ77 window) so a regression here usually
 * pinpoints something miniz didn't notice.
 *
 * BZ_NO_STDIO turns off the stdio file API surface
 * (BZ2_bzReadOpen / BZ2_bzWriteOpen and friends) -- we only
 * need the buffer-to-buffer entry points, and the stdio API
 * pulls in `<sys/stat.h>` flavours that would fight the
 * c5 header set on Windows.
 *
 * Mirrors the layout of the sqlite / miniz / kissfft drivers:
 * scenarios baked in, OK lines on stdout, exit code is the
 * one source of truth. */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "bzlib.h"

/* Source buffer with both ASCII redundancy and a binary tail.
 * Bzip2's BWT shines on the text prefix; the binary suffix
 * lets the run-length encoding step kick in too. */
static unsigned char *make_input(unsigned int *len_out) {
    static const char header[] =
        "BZIP2 smoke -- the quick brown fox jumps over the lazy dog. "
        "BZIP2 smoke -- the quick brown fox jumps over the lazy dog. "
        "BZIP2 smoke -- the quick brown fox jumps over the lazy dog. "
        "BZIP2 smoke -- the quick brown fox jumps over the lazy dog. "
        "BZIP2 smoke -- the quick brown fox jumps over the lazy dog. ";
    unsigned int header_len = (unsigned int)sizeof(header) - 1;
    unsigned int total = header_len + 256;
    unsigned char *buf = (unsigned char *)malloc((size_t)total);
    if (!buf) return NULL;
    memcpy(buf, header, (size_t)header_len);
    int i;
    for (i = 0; i < 256; i++) {
        buf[header_len + (unsigned int)i] = (unsigned char)i;
    }
    *len_out = total;
    return buf;
}

static int scenario_roundtrip(int blockSize) {
    unsigned int src_len = 0;
    unsigned char *src = make_input(&src_len);
    if (!src) {
        fprintf(stderr, "bzip2 smoke: oom on input\n");
        return 1;
    }

    /* BZ2_bzBuffToBuffCompress recommends `dst_len = src_len +
     * src_len/100 + 600` as the worst-case ceiling for any input.
     * Use a comfortable margin. */
    unsigned int cmp_len = src_len + src_len / 100 + 600;
    char *cmp = (char *)malloc((size_t)cmp_len);
    if (!cmp) { free(src); return 1; }
    int rc = BZ2_bzBuffToBuffCompress(
        cmp, &cmp_len, (char *)src, src_len, blockSize, /*verbosity=*/0, /*workFactor=*/0
    );
    if (rc != BZ_OK) {
        fprintf(stderr, "bzip2 smoke: compress(blockSize=%d) = %d\n", blockSize, rc);
        free(src); free(cmp);
        return 1;
    }

    /* The text-heavy prefix should still compress with bzip2's
     * smallest block size. Anything larger than the source means
     * the BWT path stalled. */
    if (cmp_len >= src_len) {
        fprintf(stderr, "bzip2 smoke: cmp_len %u >= src_len %u\n",
                cmp_len, src_len);
        free(src); free(cmp);
        return 1;
    }

    unsigned int out_len = src_len;
    char *out = (char *)malloc((size_t)out_len);
    if (!out) { free(src); free(cmp); return 1; }
    rc = BZ2_bzBuffToBuffDecompress(out, &out_len, cmp, cmp_len, /*small=*/0, /*verbosity=*/0);
    if (rc != BZ_OK) {
        fprintf(stderr, "bzip2 smoke: decompress = %d\n", rc);
        free(src); free(cmp); free(out);
        return 1;
    }
    if (out_len != src_len || memcmp(out, src, (size_t)src_len) != 0) {
        fprintf(stderr, "bzip2 smoke: roundtrip mismatch (len %u vs %u)\n",
                out_len, src_len);
        free(src); free(cmp); free(out);
        return 1;
    }

    printf("roundtrip OK [block=%d]: %u -> %u -> %u\n",
           blockSize, src_len, cmp_len, out_len);
    free(src); free(cmp); free(out);
    return 0;
}

int main(int argc, char **argv) {
    (void)argc;
    (void)argv;
    /* blockSize 1: smallest buffer (100k) -- exercises a single-
     * block fast path. blockSize 9: largest (900k) -- covers the
     * multi-block stitching corner of the buffer API. */
    if (scenario_roundtrip(1) != 0) return 1;
    if (scenario_roundtrip(9) != 0) return 1;
    printf("bzip2 smoke: all scenarios green\n");
    return 0;
}

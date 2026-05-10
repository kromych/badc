/* End-to-end smoke driver for the miniz amalgamation. Built on
 * top of the upstream ``compress`` / ``uncompress`` / CRC32 /
 * Adler32 entry points -- the same surface zlib exposes -- so
 * each scenario maps to a public miniz API and a hand-coded
 * reference. The intent is regression coverage for c5 codegen
 * (integer + bit-twiddle heavy), not for miniz itself.
 *
 * Mirrors the layout of demos/sqlite3/smoke.py: the SQL is
 * baked into the test driver, the runner pipes nothing into
 * stdin, and a non-zero return code with a printed message
 * marks failure. Bake-in keeps every scenario hermetic and the
 * CI step a single "python smoke.py" invocation. */

#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "miniz.h"

/* Source buffer with both ASCII redundancy (compresses well)
 * and a binary tail (every byte 0..255 once) so the deflate
 * path exercises both run-length / lazy matches and raw
 * literal blocks. ~600 bytes -- plenty for a multi-block
 * stream. */
static unsigned char *make_input(unsigned long *len_out) {
    static const char header[] =
        "MINIZ smoke -- the quick brown fox jumps over the lazy dog. "
        "MINIZ smoke -- the quick brown fox jumps over the lazy dog. "
        "MINIZ smoke -- the quick brown fox jumps over the lazy dog. "
        "MINIZ smoke -- the quick brown fox jumps over the lazy dog. ";
    unsigned long header_len = (unsigned long)sizeof(header) - 1;
    unsigned long total = header_len + 256;
    unsigned char *buf = (unsigned char *)malloc((size_t)total);
    if (!buf) return NULL;
    memcpy(buf, header, (size_t)header_len);
    int i;
    for (i = 0; i < 256; i++) {
        buf[header_len + (unsigned long)i] = (unsigned char)i;
    }
    *len_out = total;
    return buf;
}

static int scenario_roundtrip(void) {
    unsigned long src_len = 0;
    unsigned char *src = make_input(&src_len);
    if (!src) {
        fprintf(stderr, "miniz smoke: oom on input\n");
        return 1;
    }

    /* compress(): zlib-stream output (CMF/FLG header + adler32
     * trailer). compressBound() gives the worst-case ceiling for
     * any input size -- a small constant overhead on top of
     * src_len, used to size the output scratch. */
    unsigned long cmp_len = compressBound(src_len);
    unsigned char *cmp = (unsigned char *)malloc((size_t)cmp_len);
    if (!cmp) { free(src); return 1; }
    int rc = compress(cmp, &cmp_len, src, src_len);
    if (rc != Z_OK) {
        fprintf(stderr, "miniz smoke: compress() = %d\n", rc);
        free(src); free(cmp);
        return 1;
    }

    /* Highly-redundant prefix means the compressor has to win
     * something on the input. Anything larger than the source
     * is a regression (would mean static-block fallback for
     * data that should match through the LZ77 window). */
    if (cmp_len >= src_len) {
        fprintf(stderr, "miniz smoke: cmp_len %lu >= src_len %lu\n",
                cmp_len, src_len);
        free(src); free(cmp);
        return 1;
    }

    unsigned long out_len = src_len;
    unsigned char *out = (unsigned char *)malloc((size_t)out_len);
    if (!out) { free(src); free(cmp); return 1; }
    rc = uncompress(out, &out_len, cmp, cmp_len);
    if (rc != Z_OK) {
        fprintf(stderr, "miniz smoke: uncompress() = %d\n", rc);
        free(src); free(cmp); free(out);
        return 1;
    }
    if (out_len != src_len || memcmp(out, src, (size_t)src_len) != 0) {
        fprintf(stderr, "miniz smoke: roundtrip mismatch (len %lu vs %lu)\n",
                out_len, src_len);
        free(src); free(cmp); free(out);
        return 1;
    }

    printf("roundtrip OK: %lu -> %lu -> %lu\n", src_len, cmp_len, out_len);
    free(src); free(cmp); free(out);
    return 0;
}

/* CRC32 / Adler32 of the canonical "123456789" string against
 * RFC-published reference values. miniz's CRC32 uses a slice-by-
 * 8 inner loop (heavy on `>> 8` shifts and 32-bit table loads);
 * c5 used to mis-mask the high half on unsigned shifts (gh #20),
 * so this guards both the new arithmetic surface and the
 * library-vs-c5 ABI handoff. */
static int scenario_checksums(void) {
    static const unsigned char canon[] = {'1','2','3','4','5','6','7','8','9'};
    /* CRC32 of "123456789" is 0xCBF43926; Adler32 is 0x091E01DE.
     * Both come from RFC 1950 / 3309 and don't change. */
    mz_ulong crc = mz_crc32(MZ_CRC32_INIT, canon, sizeof(canon));
    mz_ulong adler = mz_adler32(MZ_ADLER32_INIT, canon, sizeof(canon));
    if (crc != 0xCBF43926UL) {
        fprintf(stderr, "miniz smoke: crc32 = 0x%08lx, want 0xCBF43926\n", crc);
        return 1;
    }
    if (adler != 0x091E01DEUL) {
        fprintf(stderr, "miniz smoke: adler32 = 0x%08lx, want 0x091E01DE\n", adler);
        return 1;
    }
    printf("checksums OK: crc=0x%08lx adler=0x%08lx\n", crc, adler);
    return 0;
}

int main(int argc, char **argv) {
    (void)argc;
    (void)argv;
    if (scenario_roundtrip() != 0) return 1;
    if (scenario_checksums() != 0) return 1;
    printf("miniz smoke: all scenarios green\n");
    return 0;
}

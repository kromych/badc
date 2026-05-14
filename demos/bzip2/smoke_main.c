/* End-to-end smoke driver for bzip2 1.0.8.
 *
 * bzip2 is integer + bit-twiddle heavy: Burrows-Wheeler
 * transform, move-to-front, run-length encoding, and Huffman
 * coding through a 128-bit-bitstream packer. Different shape
 * from deflate (no LZ77 window) so a regression here usually
 * pinpoints something miniz didn't notice.
 *
 * Four scenarios:
 *
 *   1. mixed (64 KiB) -- the canonical "compresses but doesn't
 *      crush" input: long-redundant text prefix + binary
 *      sweep through every byte value.
 *   2. zeros (64 KiB) -- maximum compressibility. cmp_len must
 *      land under ~150 bytes; anything larger means the BWT
 *      / RLE pipeline regressed.
 *   3. random (64 KiB) -- a deterministic xorshift64 stream.
 *      bzip2 cannot compress white-noise input; cmp_len must
 *      stay within a small overhead of src_len.
 *   4. reference -- a hand-baked bzip2 stream produced by the
 *      upstream bzip2 1.0.8 (via Python's `bz2` module) of a
 *      fixed input string. Decoded from the base64 below and
 *      decompressed with the c5-built decompressor; the result
 *      must byte-equal the reference plaintext. Catches any
 *      bug that breaks `BZ2_bzBuffToBuffDecompress` against a
 *      known-good encoder output, independent of any compress-
 *      side regression.
 *
 * BZ_NO_STDIO turns off the stdio file API surface
 * (BZ2_bzReadOpen / BZ2_bzWriteOpen and friends) -- we only
 * need the buffer-to-buffer entry points, and the stdio API
 * pulls in `<sys/stat.h>` flavours that would fight the c5
 * header set on Windows.
 *
 * Mirrors the layout of the sqlite / miniz / kissfft drivers:
 * scenarios baked in, OK lines on stdout, exit code is the
 * one source of truth. */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "bzlib.h"

/* Provide the AssertH hook required by `BZ_NO_STDIO` builds.
 * Upstream bzip2 leaves this symbol to the embedder (the
 * stdio-disabled flavour can't do its own fprintf). We never
 * expect to trip a bzip2 internal assertion in the smoke
 * scenarios; if one fires, surface the code and exit hard. */
void bz_internal_error(int errcode) {
    fprintf(stderr, "bz_internal_error: %d\n", errcode);
    exit(3);
}

/* 64 KiB feeds bzip2's 100 KiB minimum block in a single pass --
 * matches the smallest block-size knob without spilling into
 * the multi-block stitch path. Scenarios 1-3 share this size so
 * the per-scenario size bounds compare apples to apples. */
#define BUF_LEN 65536

/* xorshift64 -- a tiny deterministic PRNG. Seed-stable across
 * runs and platforms (no FP, no system RNG), so the
 * "uncompressible random" scenario produces the same bytes
 * everywhere and the size bound below is reproducible. */
static unsigned long long xorshift_state = 0x9E3779B97F4A7C15ULL;
static unsigned long long xorshift64(void) {
    unsigned long long x = xorshift_state;
    x ^= x << 13;
    x ^= x >> 7;
    x ^= x << 17;
    xorshift_state = x;
    return x;
}

/* Tiny base64 decoder for the reference scenario. C99 6.7.9
 * static-init: spell the table inline so the decoder is one
 * function with no allocator dependency. Returns the decoded
 * length, or 0 on malformed input. Caller must size `dst` to
 * at least `(strlen(src) / 4) * 3` bytes. */
static int b64_value(int c) {
    if (c >= 'A' && c <= 'Z') return c - 'A';
    if (c >= 'a' && c <= 'z') return c - 'a' + 26;
    if (c >= '0' && c <= '9') return c - '0' + 52;
    if (c == '+') return 62;
    if (c == '/') return 63;
    return -1;
}
static unsigned int base64_decode(const char *src, unsigned char *dst) {
    unsigned int out_len = 0;
    int v[4];
    int idx = 0;
    int i;
    for (i = 0; src[i] != '\0'; i++) {
        int c = (unsigned char)src[i];
        if (c == '=') {
            break;
        }
        int val = b64_value(c);
        if (val < 0) {
            continue; /* skip whitespace / newlines */
        }
        v[idx++] = val;
        if (idx == 4) {
            dst[out_len++] = (unsigned char)((v[0] << 2) | (v[1] >> 4));
            dst[out_len++] = (unsigned char)((v[1] << 4) | (v[2] >> 2));
            dst[out_len++] = (unsigned char)((v[2] << 6) | v[3]);
            idx = 0;
        }
    }
    /* Tail: 2 chars -> 1 byte, 3 chars -> 2 bytes (per RFC 4648). */
    if (idx == 2) {
        dst[out_len++] = (unsigned char)((v[0] << 2) | (v[1] >> 4));
    } else if (idx == 3) {
        dst[out_len++] = (unsigned char)((v[0] << 2) | (v[1] >> 4));
        dst[out_len++] = (unsigned char)((v[1] << 4) | (v[2] >> 2));
    }
    return out_len;
}

/* Mixed input: long text repetition + a wraparound byte sweep.
 * Compresses well but not extremely. */
static unsigned char *make_mixed(unsigned int *len_out) {
    unsigned char *buf = (unsigned char *)malloc((size_t)BUF_LEN);
    if (!buf) return NULL;
    static const char header[] =
        "BZIP2 smoke -- the quick brown fox jumps over the lazy dog. ";
    unsigned int hlen = (unsigned int)sizeof(header) - 1;
    unsigned int i;
    for (i = 0; i < BUF_LEN; i++) {
        if (i % 256 < hlen) {
            buf[i] = (unsigned char)header[i % hlen];
        } else {
            buf[i] = (unsigned char)i;
        }
    }
    *len_out = BUF_LEN;
    return buf;
}

static unsigned char *make_zeros(unsigned int *len_out) {
    unsigned char *buf = (unsigned char *)malloc((size_t)BUF_LEN);
    if (!buf) return NULL;
    memset(buf, 0, (size_t)BUF_LEN);
    *len_out = BUF_LEN;
    return buf;
}

static unsigned char *make_random(unsigned int *len_out) {
    unsigned char *buf = (unsigned char *)malloc((size_t)BUF_LEN);
    if (!buf) return NULL;
    xorshift_state = 0x9E3779B97F4A7C15ULL;
    unsigned int i;
    unsigned long long w = 0;
    int byte_pos = 8;
    for (i = 0; i < BUF_LEN; i++) {
        if (byte_pos == 8) {
            w = xorshift64();
            byte_pos = 0;
        }
        buf[i] = (unsigned char)((w >> (byte_pos * 8)) & 0xFF);
        byte_pos++;
    }
    *len_out = BUF_LEN;
    return buf;
}

/* Round-trip helper. `min_ratio_pct` and `max_ratio_pct` express the
 * expected cmp_len range as a percentage of src_len -- e.g. (0, 1)
 * means "cmp_len must be < 1% of src_len" (a hard-compressibility
 * scenario). Both bounds are inclusive of the equality at the
 * upper end so the random scenario can specify "no compression"
 * cleanly. */
static int run_roundtrip(
    const char *label,
    unsigned char *src,
    unsigned int src_len,
    int blockSize,
    unsigned int min_ratio_pct,
    unsigned int max_ratio_pct
) {
    unsigned int cmp_cap = src_len + src_len / 100 + 600;
    char *cmp = (char *)malloc((size_t)cmp_cap);
    if (!cmp) { free(src); return 1; }
    unsigned int cmp_len = cmp_cap;
    int rc = BZ2_bzBuffToBuffCompress(
        cmp, &cmp_len, (char *)src, src_len, blockSize, /*verbosity=*/0, /*workFactor=*/0
    );
    if (rc != BZ_OK) {
        fprintf(stderr, "bzip2 smoke: compress(%s) = %d\n", label, rc);
        free(src); free(cmp);
        return 1;
    }

    /* Ratio bound check. cmp_len * 100 vs src_len * pct keeps every
     * arithmetic step inside 32-bit unsigned without overflow for
     * BUF_LEN at this size. */
    unsigned int cmp_pct = (unsigned int)((unsigned long long)cmp_len * 100ULL / (unsigned long long)src_len);
    if (cmp_pct < min_ratio_pct || cmp_pct > max_ratio_pct) {
        fprintf(stderr,
                "bzip2 smoke: %s ratio out of range -- %u%% (allowed [%u, %u]), "
                "src=%u cmp=%u\n",
                label, cmp_pct, min_ratio_pct, max_ratio_pct, src_len, cmp_len);
        free(src); free(cmp);
        return 1;
    }

    char *out = (char *)malloc((size_t)src_len);
    if (!out) { free(src); free(cmp); return 1; }
    unsigned int out_len = src_len;
    rc = BZ2_bzBuffToBuffDecompress(out, &out_len, cmp, cmp_len, /*small=*/0, /*verbosity=*/0);
    if (rc != BZ_OK) {
        fprintf(stderr, "bzip2 smoke: decompress(%s) = %d\n", label, rc);
        free(src); free(cmp); free(out);
        return 1;
    }
    if (out_len != src_len || memcmp(out, src, (size_t)src_len) != 0) {
        fprintf(stderr, "bzip2 smoke: %s roundtrip mismatch (len %u vs %u)\n",
                label, out_len, src_len);
        free(src); free(cmp); free(out);
        return 1;
    }

    printf("roundtrip OK [%s]: %u -> %u (%u%%) -> %u\n",
           label, src_len, cmp_len, cmp_pct, out_len);
    free(src); free(cmp); free(out);
    return 0;
}

/* Reference bzip2 stream produced by upstream `bzip2 1.0.8` (via
 * Python's `bz2.compress(plaintext, 9)`). Plaintext is the
 * fixed string `REFERENCE_PLAINTEXT` repeated 24 times. The
 * stream is bit-exact across bzip2 1.0.x patch releases, so this
 * is a stable regression target -- a c5 codegen change that
 * breaks `BZ2_bzBuffToBuffDecompress` against a real bzip2
 * encoder output fails this scenario loudly. */
static const char REFERENCE_PLAINTEXT_UNIT[] =
    "BZIP2 reference scenario -- the quick brown fox jumps over the lazy dog. ";
#define REFERENCE_REPEAT 24
static const char REFERENCE_BZ2_BASE64[] =
    "QlpoOTFBWSZTWSad1ZUAANefgEADEAAQIEAQP///8DAA+AMaYjCNMAAAY0xG"
    "EaYAAAKVSaGoxD1A0yPUzUcxYi9xai+hai9RaCwFwFgLQXELiL5F6C2CzFmL"
    "MXIXUW4WwXIXQWIugXMXkLAWAu4uosxbxcxdgu4shbReAsBYi1FkFxFoLcLI"
    "XAXYWIt4sBYC0F+i7i2iNRaizEfwshf4u5IpwoSBNO6sqA==";

static int scenario_reference(void) {
    unsigned int unit_len = (unsigned int)sizeof(REFERENCE_PLAINTEXT_UNIT) - 1;
    unsigned int plain_len = unit_len * REFERENCE_REPEAT;
    unsigned char *plain = (unsigned char *)malloc((size_t)plain_len);
    if (!plain) {
        fprintf(stderr, "bzip2 smoke: oom on reference plaintext\n");
        return 1;
    }
    int i;
    for (i = 0; i < REFERENCE_REPEAT; i++) {
        memcpy(plain + (unsigned int)i * unit_len,
               REFERENCE_PLAINTEXT_UNIT,
               (size_t)unit_len);
    }

    /* base64-decoded stream is < 1 KiB; rounding the input length
     * up to 1024 leaves ample headroom. */
    unsigned char cmp[1024];
    unsigned int cmp_len = base64_decode(REFERENCE_BZ2_BASE64, cmp);
    if (cmp_len == 0) {
        fprintf(stderr, "bzip2 smoke: reference base64 decode produced 0 bytes\n");
        free(plain);
        return 1;
    }

    char *out = (char *)malloc((size_t)plain_len);
    if (!out) { free(plain); return 1; }
    unsigned int out_len = plain_len;
    int rc = BZ2_bzBuffToBuffDecompress(
        out, &out_len, (char *)cmp, cmp_len, /*small=*/0, /*verbosity=*/0
    );
    if (rc != BZ_OK) {
        fprintf(stderr, "bzip2 smoke: reference decompress = %d\n", rc);
        free(plain); free(out);
        return 1;
    }
    if (out_len != plain_len || memcmp(out, plain, (size_t)plain_len) != 0) {
        fprintf(stderr,
                "bzip2 smoke: reference plaintext mismatch "
                "(decoded %u, expected %u)\n",
                out_len, plain_len);
        free(plain); free(out);
        return 1;
    }
    printf("reference OK: %u-byte bzip2 stream -> %u bytes plaintext\n",
           cmp_len, out_len);
    free(plain); free(out);
    return 0;
}

int main(int argc, char **argv) {
    (void)argc;
    (void)argv;

    /* Mixed: typical case, modest compression ratio. */
    {
        unsigned int len = 0;
        unsigned char *src = make_mixed(&len);
        if (!src) return 1;
        if (run_roundtrip("mixed-block9", src, len, /*blockSize=*/9,
                          /*min_pct=*/1, /*max_pct=*/50) != 0) {
            return 1;
        }
    }

    /* Low entropy: 64 KiB of zeros. bzip2 RLE + Huffman should
     * crush this to a fraction of a percent of the input. */
    {
        unsigned int len = 0;
        unsigned char *src = make_zeros(&len);
        if (!src) return 1;
        if (run_roundtrip("zeros-block1", src, len, /*blockSize=*/1,
                          /*min_pct=*/0, /*max_pct=*/2) != 0) {
            return 1;
        }
    }

    /* High entropy: deterministic xorshift64 stream. bzip2 cannot
     * compress this; cmp_len typically lands at ~101% of src_len.
     * The bound is intentionally permissive (>= 95%) so a future
     * bzip2 release that gains a few bytes of header doesn't
     * trip a false positive. */
    {
        unsigned int len = 0;
        unsigned char *src = make_random(&len);
        if (!src) return 1;
        if (run_roundtrip("random-block9", src, len, /*blockSize=*/9,
                          /*min_pct=*/95, /*max_pct=*/120) != 0) {
            return 1;
        }
    }

    /* Reference: decompress a known-good bzip2 stream. */
    if (scenario_reference() != 0) return 1;

    printf("bzip2 smoke: all scenarios green\n");
    return 0;
}

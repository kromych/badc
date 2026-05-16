/* End-to-end smoke driver for TweetNaCl 20140427.
 *
 * TweetNaCl is the auditable C implementation of NaCl: Salsa20,
 * Poly1305, X25519, Ed25519, SHA-512, HMAC-SHA-512 in ~700 lines
 * with no architecture-specific code. The library expects the
 * embedder to provide `randombytes(u8 *, u64)`; the smoke driver
 * supplies a deterministic xorshift64 stream so every scenario
 * reproduces bit-for-bit across runs and platforms.
 *
 * Five scenarios:
 *
 *   1. SHA-512 of "abc" -- FIPS 180-2 / RFC 4634 test vector
 *      (the digest is published; bit-for-bit match required).
 *   2. crypto_secretbox / open -- Salsa20-Poly1305 AEAD round
 *      trip with a fixed key + nonce.
 *   3. crypto_box / open -- X25519 + Salsa20-Poly1305 round
 *      trip between two deterministically-seeded keypairs.
 *   4. crypto_sign / open -- Ed25519 round trip on a fixed
 *      message with a deterministically-seeded keypair.
 *   5. RFC 8032 Ed25519 test vector 1 -- derives the keypair
 *      from the published 32-byte seed, asserts the public key
 *      matches the published value byte-for-byte, signs the
 *      empty message, asserts the signature matches the
 *      published 64-byte value. The strongest correctness
 *      gate: any drift in scalar arithmetic or SHA-512
 *      breaks this scenario loudly.
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "tweetnacl.h"

/* tweetnacl.c references this symbol with external linkage.
 * Seed-stable xorshift64 keeps the stream identical across
 * runs and platforms; the seed is loaded from a buffer the
 * driver controls so the RFC 8032 scenario can pin the
 * Ed25519 seed exactly. */
static unsigned long long randombytes_state = 0x9E3779B97F4A7C15ULL;
static const unsigned char *randombytes_seed_buf = 0;
static unsigned long long randombytes_seed_buf_len = 0;
static unsigned long long randombytes_seed_buf_pos = 0;

static unsigned long long xorshift64(void) {
    unsigned long long x = randombytes_state;
    x ^= x << 13;
    x ^= x >> 7;
    x ^= x << 17;
    randombytes_state = x;
    return x;
}

void randombytes(unsigned char *dst, unsigned long long len) {
    unsigned long long i;
    for (i = 0; i < len; i++) {
        if (randombytes_seed_buf_pos < randombytes_seed_buf_len) {
            dst[i] = randombytes_seed_buf[randombytes_seed_buf_pos++];
        } else {
            dst[i] = (unsigned char)(xorshift64() & 0xFFu);
        }
    }
}

static void hex_to_bytes(const char *hex, unsigned char *out, unsigned int n) {
    unsigned int i;
    for (i = 0; i < n; i++) {
        unsigned int hi = (unsigned int)hex[i * 2];
        unsigned int lo = (unsigned int)hex[i * 2 + 1];
        hi = (hi >= 'a') ? (hi - 'a' + 10) : (hi >= 'A' ? hi - 'A' + 10 : hi - '0');
        lo = (lo >= 'a') ? (lo - 'a' + 10) : (lo >= 'A' ? lo - 'A' + 10 : lo - '0');
        out[i] = (unsigned char)((hi << 4) | lo);
    }
}

static int memequal(const unsigned char *a, const unsigned char *b, unsigned int n) {
    return memcmp(a, b, (size_t)n) == 0;
}

static int scenario_sha512(void) {
    /* FIPS 180-2 / RFC 4634 test vector: SHA-512("abc"). */
    static const char expected_hex[] =
        "ddaf35a193617abacc417349ae20413112e6fa4e89a97ea20a9eeee64b55d39a"
        "2192992a274fc1a836ba3c23a3feebbd454d4423643ce80e2a9ac94fa54ca49f";
    unsigned char expected[64];
    hex_to_bytes(expected_hex, expected, 64);

    unsigned char digest[crypto_hash_BYTES];
    static const unsigned char msg[] = { 'a', 'b', 'c' };
    if (crypto_hash(digest, msg, (unsigned long long)sizeof(msg)) != 0) {
        fprintf(stderr, "tweetnacl smoke: crypto_hash failed\n");
        return 1;
    }
    if (!memequal(digest, expected, 64)) {
        fprintf(stderr, "tweetnacl smoke: SHA-512 digest mismatch\n");
        return 1;
    }
    printf("hash OK [sha512-abc]: 64-byte digest matches FIPS 180-2 vector\n");
    return 0;
}

static int scenario_secretbox(void) {
    unsigned char key[crypto_secretbox_KEYBYTES];
    unsigned char nonce[crypto_secretbox_NONCEBYTES];
    unsigned int i;
    for (i = 0; i < crypto_secretbox_KEYBYTES; i++) key[i] = (unsigned char)(i + 1);
    for (i = 0; i < crypto_secretbox_NONCEBYTES; i++) nonce[i] = (unsigned char)(0x80 ^ i);

    /* crypto_secretbox requires the first ZEROBYTES of the
     * plaintext to be zero; the same shape is required on
     * decrypt for BOXZEROBYTES. Allocate one buffer with the
     * pad and one trailing payload. */
    static const char payload[] = "Squeamish ossifrage smashes pufferfish at noon.";
    unsigned int payload_len = (unsigned int)sizeof(payload);  /* includes the trailing NUL */
    unsigned int total_len = crypto_secretbox_ZEROBYTES + payload_len;
    unsigned char *plain = (unsigned char *)malloc((size_t)total_len);
    unsigned char *cipher = (unsigned char *)malloc((size_t)total_len);
    unsigned char *out = (unsigned char *)malloc((size_t)total_len);
    if (!plain || !cipher || !out) {
        fprintf(stderr, "tweetnacl smoke: oom secretbox\n");
        free(plain); free(cipher); free(out);
        return 1;
    }
    memset(plain, 0, (size_t)total_len);
    memcpy(plain + crypto_secretbox_ZEROBYTES, payload, (size_t)payload_len);

    if (crypto_secretbox(cipher, plain, (unsigned long long)total_len, nonce, key) != 0) {
        fprintf(stderr, "tweetnacl smoke: crypto_secretbox failed\n");
        free(plain); free(cipher); free(out);
        return 1;
    }
    if (crypto_secretbox_open(out, cipher, (unsigned long long)total_len, nonce, key) != 0) {
        fprintf(stderr, "tweetnacl smoke: crypto_secretbox_open failed\n");
        free(plain); free(cipher); free(out);
        return 1;
    }
    if (memcmp(plain, out, (size_t)total_len) != 0) {
        fprintf(stderr, "tweetnacl smoke: secretbox round-trip mismatch\n");
        free(plain); free(cipher); free(out);
        return 1;
    }
    printf("aead OK [secretbox]: %u-byte payload round trip\n", payload_len);
    free(plain); free(cipher); free(out);
    return 0;
}

static int scenario_box(void) {
    randombytes_state = 0x123456789ABCDEF0ULL;
    randombytes_seed_buf = 0;
    randombytes_seed_buf_len = 0;
    randombytes_seed_buf_pos = 0;

    unsigned char alice_pk[crypto_box_PUBLICKEYBYTES];
    unsigned char alice_sk[crypto_box_SECRETKEYBYTES];
    unsigned char bob_pk[crypto_box_PUBLICKEYBYTES];
    unsigned char bob_sk[crypto_box_SECRETKEYBYTES];
    if (crypto_box_keypair(alice_pk, alice_sk) != 0) return 1;
    if (crypto_box_keypair(bob_pk, bob_sk) != 0) return 1;

    unsigned char nonce[crypto_box_NONCEBYTES];
    unsigned int i;
    for (i = 0; i < crypto_box_NONCEBYTES; i++) nonce[i] = (unsigned char)(i ^ 0x5A);

    static const char payload[] = "Hello via X25519+Salsa20-Poly1305.";
    unsigned int payload_len = (unsigned int)sizeof(payload);
    unsigned int total_len = crypto_box_ZEROBYTES + payload_len;
    unsigned char *plain = (unsigned char *)malloc((size_t)total_len);
    unsigned char *cipher = (unsigned char *)malloc((size_t)total_len);
    unsigned char *out = (unsigned char *)malloc((size_t)total_len);
    if (!plain || !cipher || !out) {
        free(plain); free(cipher); free(out);
        return 1;
    }
    memset(plain, 0, (size_t)total_len);
    memcpy(plain + crypto_box_ZEROBYTES, payload, (size_t)payload_len);

    if (crypto_box(cipher, plain, (unsigned long long)total_len, nonce, bob_pk, alice_sk) != 0) {
        fprintf(stderr, "tweetnacl smoke: crypto_box failed\n");
        free(plain); free(cipher); free(out);
        return 1;
    }
    if (crypto_box_open(out, cipher, (unsigned long long)total_len, nonce, alice_pk, bob_sk) != 0) {
        fprintf(stderr, "tweetnacl smoke: crypto_box_open failed\n");
        free(plain); free(cipher); free(out);
        return 1;
    }
    if (memcmp(plain, out, (size_t)total_len) != 0) {
        fprintf(stderr, "tweetnacl smoke: box round-trip mismatch\n");
        free(plain); free(cipher); free(out);
        return 1;
    }
    printf("aead OK [box]: %u-byte payload Alice->Bob round trip\n", payload_len);
    free(plain); free(cipher); free(out);
    return 0;
}

static int scenario_sign(void) {
    randombytes_state = 0xDEADBEEFCAFEBABEULL;
    randombytes_seed_buf = 0;
    randombytes_seed_buf_len = 0;
    randombytes_seed_buf_pos = 0;

    unsigned char pk[crypto_sign_PUBLICKEYBYTES];
    unsigned char sk[crypto_sign_SECRETKEYBYTES];
    if (crypto_sign_keypair(pk, sk) != 0) return 1;

    static const char msg[] = "Cryptographically signed by Ed25519.";
    unsigned int msg_len = (unsigned int)sizeof(msg);
    unsigned long long sm_len = 0;
    unsigned char *sm = (unsigned char *)malloc((size_t)(msg_len + crypto_sign_BYTES));
    unsigned char *out = (unsigned char *)malloc((size_t)(msg_len + crypto_sign_BYTES));
    if (!sm || !out) { free(sm); free(out); return 1; }

    if (crypto_sign(sm, &sm_len, (const unsigned char *)msg, (unsigned long long)msg_len, sk) != 0) {
        fprintf(stderr, "tweetnacl smoke: crypto_sign failed\n");
        free(sm); free(out); return 1;
    }
    unsigned long long out_len = 0;
    if (crypto_sign_open(out, &out_len, sm, sm_len, pk) != 0) {
        fprintf(stderr, "tweetnacl smoke: crypto_sign_open failed\n");
        free(sm); free(out); return 1;
    }
    if (out_len != (unsigned long long)msg_len ||
        memcmp(out, msg, (size_t)msg_len) != 0) {
        fprintf(stderr, "tweetnacl smoke: sign round-trip mismatch\n");
        free(sm); free(out); return 1;
    }
    printf("sign OK [ed25519-roundtrip]: %u-byte message verified\n", msg_len);
    free(sm); free(out); return 0;
}

static int scenario_rfc8032(void) {
    /* RFC 8032 Section 7.1, test vector 1: an empty message
     * signed with a known 32-byte seed. The signature is
     * deterministic for Ed25519, so a single byte of drift
     * in scalar arithmetic or SHA-512 collapses this test. */
    static const char seed_hex[] =
        "9d61b19deffd5a60ba844af492ec2cc44449c5697b326919703bac031cae7f60";
    static const char expected_pk_hex[] =
        "d75a980182b10ab7d54bfed3c964073a0ee172f3daa62325af021a68f707511a";
    static const char expected_sig_hex[] =
        "e5564300c360ac729086e2cc806e828a84877f1eb8e5d974d873e065224901555f"
        "b8821590a33bacc61e39701cf9b46bd25bf5f0595bbe24655141438e7a100b";

    unsigned char seed[32];
    unsigned char expected_pk[32];
    unsigned char expected_sig[64];
    hex_to_bytes(seed_hex, seed, 32);
    hex_to_bytes(expected_pk_hex, expected_pk, 32);
    hex_to_bytes(expected_sig_hex, expected_sig, 64);

    /* Feed the seed into the keypair via the randombytes hook. */
    randombytes_state = 0;
    randombytes_seed_buf = seed;
    randombytes_seed_buf_len = 32;
    randombytes_seed_buf_pos = 0;

    unsigned char pk[crypto_sign_PUBLICKEYBYTES];
    unsigned char sk[crypto_sign_SECRETKEYBYTES];
    if (crypto_sign_keypair(pk, sk) != 0) {
        fprintf(stderr, "tweetnacl smoke: RFC 8032 keypair derive failed\n");
        return 1;
    }
    if (!memequal(pk, expected_pk, 32)) {
        fprintf(stderr, "tweetnacl smoke: RFC 8032 public key mismatch\n");
        return 1;
    }

    unsigned char sm[crypto_sign_BYTES];
    unsigned long long sm_len = 0;
    if (crypto_sign(sm, &sm_len, (const unsigned char *)"", 0, sk) != 0) {
        fprintf(stderr, "tweetnacl smoke: RFC 8032 sign failed\n");
        return 1;
    }
    if (sm_len != (unsigned long long)crypto_sign_BYTES) {
        fprintf(stderr,
                "tweetnacl smoke: RFC 8032 signed-message length %llu, want %d\n",
                sm_len, (int)crypto_sign_BYTES);
        return 1;
    }
    /* crypto_sign emits signature || message; the leading 64
     * bytes are the Ed25519 signature. */
    if (!memequal(sm, expected_sig, 64)) {
        fprintf(stderr, "tweetnacl smoke: RFC 8032 signature mismatch\n");
        return 1;
    }
    /* Verify the same signature against the published pk. */
    unsigned char out[crypto_sign_BYTES];
    unsigned long long out_len = 0;
    if (crypto_sign_open(out, &out_len, sm, sm_len, pk) != 0) {
        fprintf(stderr, "tweetnacl smoke: RFC 8032 verify failed\n");
        return 1;
    }
    if (out_len != 0) {
        fprintf(stderr, "tweetnacl smoke: RFC 8032 verify produced %llu-byte message, want 0\n", out_len);
        return 1;
    }
    printf("sign OK [ed25519-rfc8032]: empty-message signature matches vector 1, verifies\n");
    return 0;
}

int main(int argc, char **argv) {
    (void)argc;
    (void)argv;

    if (scenario_sha512()    != 0) return 1;
    if (scenario_rfc8032()   != 0) return 1;
    if (scenario_secretbox() != 0) return 1;
    if (scenario_box()       != 0) return 1;
    if (scenario_sign()      != 0) return 1;

    printf("tweetnacl smoke: all scenarios green\n");
    return 0;
}

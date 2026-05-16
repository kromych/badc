/* End-to-end smoke driver for BearSSL 0.6 (focused subset).
 *
 * Vendored subset covers SHA-2 small (SHA-224 / SHA-256),
 * HMAC, and HKDF. The TLS record layer, X.509 minimal
 * validator, and AES hardware variants are tracked as later
 * milestones.
 *
 * Four scenarios:
 *
 *   1. SHA-256(`"abc"`) -- FIPS 180-2 / RFC 4634 vector.
 *   2. SHA-224(`"abc"`) -- FIPS 180-2 vector (28-byte digest).
 *   3. HMAC-SHA-256 RFC 4231 test case 1 -- 32-byte MAC for
 *      `"Hi There"` keyed with 20 bytes of `0x0b`.
 *   4. HKDF-SHA-256 RFC 5869 test case 1 -- expand a fixed
 *      IKM / salt / info triple to 42 bytes of OKM.
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "bearssl_hash.h"
#include "bearssl_hmac.h"
#include "bearssl_kdf.h"

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

static int scenario_sha256(void) {
    static const char expected_hex[] =
        "ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad";
    unsigned char expected[32];
    hex_to_bytes(expected_hex, expected, 32);

    unsigned char digest[32];
    br_sha256_context ctx;
    br_sha256_init(&ctx);
    br_sha256_update(&ctx, "abc", 3);
    br_sha256_out(&ctx, digest);
    if (!memequal(digest, expected, 32)) {
        fprintf(stderr, "bearssl smoke: SHA-256 digest mismatch\n");
        return 1;
    }
    printf("hash OK [sha256-abc]: 32-byte digest matches FIPS 180-2 vector\n");
    return 0;
}

static int scenario_sha224(void) {
    static const char expected_hex[] =
        "23097d223405d8228642a477bda255b32aadbce4bda0b3f7e36c9da7";
    unsigned char expected[28];
    hex_to_bytes(expected_hex, expected, 28);

    unsigned char digest[28];
    br_sha224_context ctx;
    br_sha224_init(&ctx);
    br_sha224_update(&ctx, "abc", 3);
    br_sha224_out(&ctx, digest);
    if (!memequal(digest, expected, 28)) {
        fprintf(stderr, "bearssl smoke: SHA-224 digest mismatch\n");
        return 1;
    }
    printf("hash OK [sha224-abc]: 28-byte digest matches FIPS 180-2 vector\n");
    return 0;
}

static int scenario_hmac_sha256(void) {
    /* RFC 4231 Section 4.2 test case 1: key = 20 bytes of
     * 0x0b, message = "Hi There", expected 32-byte MAC. */
    static const char expected_hex[] =
        "b0344c61d8db38535ca8afceaf0bf12b881dc200c9833da726e9376c2e32cff7";
    unsigned char expected[32];
    hex_to_bytes(expected_hex, expected, 32);

    unsigned char key[20];
    unsigned int i;
    for (i = 0; i < 20; i++) key[i] = 0x0b;

    br_hmac_key_context kc;
    br_hmac_context hc;
    br_hmac_key_init(&kc, &br_sha256_vtable, key, 20);
    br_hmac_init(&hc, &kc, 0);
    br_hmac_update(&hc, "Hi There", 8);
    unsigned char mac[32];
    size_t mac_len = br_hmac_out(&hc, mac);
    if (mac_len != 32) {
        fprintf(stderr, "bearssl smoke: HMAC-SHA-256 length %zu, want 32\n", mac_len);
        return 1;
    }
    if (!memequal(mac, expected, 32)) {
        fprintf(stderr, "bearssl smoke: HMAC-SHA-256 mismatch\n");
        return 1;
    }
    printf("mac OK [hmac-sha256]: 32-byte MAC matches RFC 4231 test case 1\n");
    return 0;
}

static int scenario_hkdf_sha256(void) {
    /* RFC 5869 Section A.1 test case 1. */
    static const char ikm_hex[]  = "0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b";
    static const char salt_hex[] = "000102030405060708090a0b0c";
    static const char info_hex[] = "f0f1f2f3f4f5f6f7f8f9";
    static const char expected_hex[] =
        "3cb25f25faacd57a90434f64d0362f2a2d2d0a90cf1a5a4c5db02d56ecc4c5bf"
        "34007208d5b887185865";

    unsigned char ikm[22];
    unsigned char salt[13];
    unsigned char info[10];
    unsigned char expected[42];
    hex_to_bytes(ikm_hex,  ikm,  22);
    hex_to_bytes(salt_hex, salt, 13);
    hex_to_bytes(info_hex, info, 10);
    hex_to_bytes(expected_hex, expected, 42);

    br_hkdf_context ctx;
    br_hkdf_init(&ctx, &br_sha256_vtable, salt, sizeof(salt));
    br_hkdf_inject(&ctx, ikm, sizeof(ikm));
    br_hkdf_flip(&ctx);
    unsigned char okm[42];
    br_hkdf_produce(&ctx, info, sizeof(info), okm, 42);

    if (!memequal(okm, expected, 42)) {
        fprintf(stderr, "bearssl smoke: HKDF-SHA-256 OKM mismatch\n");
        return 1;
    }
    printf("kdf OK [hkdf-sha256]: 42-byte OKM matches RFC 5869 test case 1\n");
    return 0;
}

int main(int argc, char **argv) {
    (void)argc;
    (void)argv;

    if (scenario_sha256()      != 0) return 1;
    if (scenario_sha224()      != 0) return 1;
    if (scenario_hmac_sha256() != 0) return 1;
    if (scenario_hkdf_sha256() != 0) return 1;

    printf("bearssl smoke: all scenarios green\n");
    return 0;
}

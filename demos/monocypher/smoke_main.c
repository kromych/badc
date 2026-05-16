/* End-to-end smoke driver for Monocypher 4.0.2.
 *
 * Monocypher is a modern self-contained crypto library:
 * Chacha20, Poly1305, X25519, EdDSA over Curve25519, BLAKE2b,
 * Argon2i. The default `crypto_eddsa_*` family uses BLAKE2b as
 * its internal hash; the optional `crypto_ed25519_*` family
 * uses SHA-512 and matches RFC 8032 byte-for-byte. The smoke
 * exercises both: the default AEAD + X25519 + BLAKE2b path
 * from the core, and the optional SHA-512 + Ed25519 path from
 * the RFC 8032 module.
 *
 * Five scenarios:
 *
 *   1. SHA-512 of "abc" -- FIPS 180-2 / RFC 4634 test vector
 *      (published 64-byte digest).
 *   2. BLAKE2b of "abc" -- RFC 7693 / upstream BLAKE2 test
 *      vector (published 64-byte digest).
 *   3. RFC 8032 Ed25519 test vector 1 -- the published 32-byte
 *      seed produces the published 32-byte public key, the
 *      empty-message signature matches the published 64 bytes
 *      and verifies. The strongest correctness gate.
 *   4. crypto_aead_lock / unlock -- Chacha20-Poly1305 round
 *      trip with a fixed key + nonce + 47-byte payload.
 *   5. crypto_x25519 -- Diffie-Hellman shared secret derivation
 *      between two deterministic keypairs. Both sides must
 *      arrive at the same 32-byte raw shared secret.
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "monocypher.h"
#include "monocypher-ed25519.h"

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
    static const char expected_hex[] =
        "ddaf35a193617abacc417349ae20413112e6fa4e89a97ea20a9eeee64b55d39a"
        "2192992a274fc1a836ba3c23a3feebbd454d4423643ce80e2a9ac94fa54ca49f";
    unsigned char expected[64];
    hex_to_bytes(expected_hex, expected, 64);

    unsigned char digest[64];
    static const unsigned char msg[] = { 'a', 'b', 'c' };
    crypto_sha512(digest, msg, sizeof(msg));
    if (!memequal(digest, expected, 64)) {
        fprintf(stderr, "monocypher smoke: SHA-512 digest mismatch\n");
        return 1;
    }
    printf("hash OK [sha512-abc]: 64-byte digest matches FIPS 180-2 vector\n");
    return 0;
}

static int scenario_blake2b(void) {
    /* RFC 7693 Appendix A: BLAKE2b-512 of "abc". */
    static const char expected_hex[] =
        "ba80a53f981c4d0d6a2797b69f12f6e94c212f14685ac4b74b12bb6fdbffa2d1"
        "7d87c5392aab792dc252d5de4533cc9518d38aa8dbf1925ab92386edd4009923";
    unsigned char expected[64];
    hex_to_bytes(expected_hex, expected, 64);

    unsigned char digest[64];
    static const unsigned char msg[] = { 'a', 'b', 'c' };
    crypto_blake2b(digest, 64, msg, sizeof(msg));
    if (!memequal(digest, expected, 64)) {
        fprintf(stderr, "monocypher smoke: BLAKE2b digest mismatch\n");
        return 1;
    }
    printf("hash OK [blake2b-abc]: 64-byte digest matches RFC 7693 vector\n");
    return 0;
}

static int scenario_rfc8032(void) {
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

    /* crypto_ed25519_key_pair derives the keypair from a 32-byte
     * seed; the secret_key buffer holds the 64-byte concatenation
     * `seed || public_key`. The seed is consumed (wiped) and the
     * public_key out parameter is filled. */
    unsigned char sk[64];
    unsigned char pk[32];
    unsigned char seed_copy[32];
    memcpy(seed_copy, seed, 32);
    crypto_ed25519_key_pair(sk, pk, seed_copy);
    if (!memequal(pk, expected_pk, 32)) {
        fprintf(stderr, "monocypher smoke: RFC 8032 public key mismatch\n");
        return 1;
    }
    unsigned char sig[64];
    crypto_ed25519_sign(sig, sk, (const unsigned char *)"", 0);
    if (!memequal(sig, expected_sig, 64)) {
        fprintf(stderr, "monocypher smoke: RFC 8032 signature mismatch\n");
        return 1;
    }
    if (crypto_ed25519_check(sig, pk, (const unsigned char *)"", 0) != 0) {
        fprintf(stderr, "monocypher smoke: RFC 8032 verify failed\n");
        return 1;
    }
    printf("sign OK [ed25519-rfc8032]: empty-message signature matches vector 1, verifies\n");
    return 0;
}

static int scenario_aead(void) {
    unsigned char key[32];
    unsigned char nonce[24];
    unsigned int i;
    for (i = 0; i < 32; i++) key[i]   = (unsigned char)(i + 1);
    for (i = 0; i < 24; i++) nonce[i] = (unsigned char)(0x80 ^ i);

    static const unsigned char ad[]    = { 'h', 'd', 'r' };
    static const unsigned char plain[] =
        "Squeamish ossifrage smashes pufferfish at noon.";
    const unsigned int plain_len = (unsigned int)sizeof(plain);

    unsigned char cipher[256];
    unsigned char mac[16];
    unsigned char out[256];
    crypto_aead_lock(cipher, mac, key, nonce, ad, sizeof(ad), plain, plain_len);
    if (crypto_aead_unlock(out, mac, key, nonce, ad, sizeof(ad), cipher, plain_len) != 0) {
        fprintf(stderr, "monocypher smoke: aead_unlock failed\n");
        return 1;
    }
    if (memcmp(plain, out, plain_len) != 0) {
        fprintf(stderr, "monocypher smoke: aead round-trip mismatch\n");
        return 1;
    }
    printf("aead OK [chacha20-poly1305]: %u-byte payload round trip\n", plain_len);
    return 0;
}

static int scenario_x25519(void) {
    unsigned char alice_sk[32];
    unsigned char bob_sk[32];
    unsigned int i;
    for (i = 0; i < 32; i++) alice_sk[i] = (unsigned char)(i + 1);
    for (i = 0; i < 32; i++) bob_sk[i]   = (unsigned char)(0xff - i);

    unsigned char alice_pk[32];
    unsigned char bob_pk[32];
    crypto_x25519_public_key(alice_pk, alice_sk);
    crypto_x25519_public_key(bob_pk,   bob_sk);

    unsigned char shared_a[32];
    unsigned char shared_b[32];
    crypto_x25519(shared_a, alice_sk, bob_pk);
    crypto_x25519(shared_b, bob_sk,   alice_pk);
    if (!memequal(shared_a, shared_b, 32)) {
        fprintf(stderr, "monocypher smoke: X25519 shared-secret mismatch\n");
        return 1;
    }
    printf("dh OK [x25519]: Alice and Bob derive equal shared secret\n");
    return 0;
}

int main(int argc, char **argv) {
    (void)argc;
    (void)argv;

    if (scenario_sha512()   != 0) return 1;
    if (scenario_blake2b()  != 0) return 1;
    if (scenario_rfc8032()  != 0) return 1;
    if (scenario_aead()     != 0) return 1;
    if (scenario_x25519()   != 0) return 1;

    printf("monocypher smoke: all scenarios green\n");
    return 0;
}

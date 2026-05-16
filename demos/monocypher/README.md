# monocypher

MonoCypher is Loup Vaillant's modern auditable crypto library:
Chacha20, Poly1305, X25519, EdDSA over Curve25519, BLAKE2b,
Argon2i, plus an optional SHA-512 + RFC 8032 Ed25519 module.
Two-file core (`monocypher.c`, `monocypher.h`) with no external
deps; the optional module adds two more files for the SHA-512
families.

Pinned at upstream tag `4.0.2`. Pulled through the badc
vendor-deps mirror -- see [`setup.py`](setup.py).

## Vendored surface

* `monocypher.c` / `monocypher.h` -- core. AEAD lock / unlock,
  BLAKE2b, X25519, default EdDSA (BLAKE2b-based), Argon2i,
  Elligator2.
* `monocypher-ed25519.c` / `monocypher-ed25519.h` -- optional.
  SHA-512, HMAC-SHA-512, HKDF, and RFC 8032 Ed25519 sign /
  verify. Required for the RFC 8032 vector in the smoke.

## Smoke scenarios

[`smoke.py`](smoke.py) builds the two TUs + the driver through
badc in four flavours (amalgamation + separate-TU compile, each
at `-O` and no-`-O`), plus an archive flavour, and runs each
binary. Five scenarios:

| Scenario              | What it asserts                                                                                              |
|-----------------------|--------------------------------------------------------------------------------------------------------------|
| SHA-512(`"abc"`)      | FIPS 180-2 / RFC 4634 vector: digest matches the published 64-byte answer bit-for-bit.                       |
| BLAKE2b(`"abc"`)      | RFC 7693 Appendix A vector: 64-byte digest matches the published answer bit-for-bit.                         |
| RFC 8032 Ed25519 v1   | Derived from the published 32-byte seed; public key matches, empty-message signature matches, verify passes. |
| `crypto_aead_lock`    | Chacha20-Poly1305 AEAD round trip on a fixed key + nonce + 47-byte payload with a 3-byte AD.                 |
| `crypto_x25519`       | Diffie-Hellman shared secret between two deterministic keypairs; both sides converge on the same 32 bytes.   |

The RFC 8032 scenario is the strongest correctness gate: any
drift in the Curve25519 scalar arithmetic, the Edwards-curve
add / double, or SHA-512 collapses the signature against the
published 64-byte value.

## Layout

* `setup.py` -- fetch the vendored tar.gz from the badc
  vendor-deps release and extract the four source files flat
  into the demo dir; idempotent.
* `smoke.py` -- compile + run the five-scenario driver in the
  four build flavours, gated against the expected output
  lines. Returns 0 only when every flavour passes every
  scenario.
* `smoke_main.c` -- the driver (deterministic keys, scenarios,
  expected outputs).
* `monocypher.{c,h}` and `monocypher-ed25519.{c,h}` -- vendored
  upstream (gitignored out of band; `setup.py` is the source of
  truth for what they are).

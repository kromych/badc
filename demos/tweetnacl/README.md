# tweetnacl

TweetNaCl is the auditable C implementation of the NaCl
cryptographic primitives: Salsa20, Poly1305, X25519, Ed25519,
SHA-512, HMAC-SHA-512. The entire library is two files
(`tweetnacl.c`, `tweetnacl.h`) totalling ~700 lines, with no
architecture-specific code and no external dependencies beyond
a host-supplied `randombytes(u8 *, u64)`.

Pinned at upstream's `20140427` release (the only canonical
release; no later snapshot exists). Pulled through the badc
vendor-deps mirror -- see [`setup.py`](setup.py).

## Vendored surface

* `tweetnacl.c` -- the implementation.
* `tweetnacl.h` -- the public API: every NaCl primitive macro
  resolves through this header to the `_tweet`-suffixed entry
  point in the `.c`.

The driver under `smoke_main.c` supplies a deterministic
`randombytes` so every scenario reproduces bit-for-bit across
runs and platforms.

## Smoke scenarios

[`smoke.py`](smoke.py) builds tweetnacl + the driver through
badc in four flavours (amalgamation + separate-TU compile, each
at `-O` and no-`-O`), plus an archive flavour, and runs each
binary. Five scenarios:

| Scenario              | What it asserts                                                                                              |
|-----------------------|--------------------------------------------------------------------------------------------------------------|
| SHA-512(`"abc"`)      | FIPS 180-2 / RFC 4634 vector: digest matches the published 64-byte answer bit-for-bit.                       |
| RFC 8032 Ed25519 v1   | Derived from the published 32-byte seed; public key matches, empty-message signature matches, verify passes. |
| `crypto_secretbox`    | Salsa20-Poly1305 AEAD round trip on a fixed key + nonce.                                                     |
| `crypto_box`          | X25519 + Salsa20-Poly1305 round trip between two deterministically-seeded keypairs.                          |
| `crypto_sign`         | Ed25519 sign + verify round trip on a deterministic keypair.                                                 |

The RFC 8032 scenario is the strongest correctness gate: any
drift in the Curve25519 scalar arithmetic, the Edwards-curve
add / double, or SHA-512 collapses the signature bit-for-bit
against the published 64-byte value.

## Layout

* `setup.py` -- fetch the vendored tar.gz from the badc
  vendor-deps release and extract `tweetnacl.c` + `tweetnacl.h`
  flat into the demo dir; idempotent.
* `smoke.py` -- compile + run the five-scenario driver in the
  four build flavours, gated against the expected output
  lines. Returns 0 only when every flavour passes every
  scenario.
* `smoke_main.c` -- the driver (deterministic `randombytes`,
  scenarios, expected outputs).
* `tweetnacl.c`, `tweetnacl.h` -- vendored upstream
  (gitignored out of band; `setup.py` is the source of truth
  for what they are).

# bearssl

BearSSL is Thomas Pornin's full TLS 1.0-1.2 stack in portable
C99: no malloc, no asm, no external deps. The vendored set
under `demos/bearssl/` is a curated subset (hash + MAC + KDF
primitives plus the codec / int helpers they pull in); the
full upstream tree carries ~300 .c files including AES
hardware-accelerated variants (`aes_x86ni`, `aes_pwr8`), the
TLS record-layer state machines, and an X.509 minimal
validator.

Pinned at upstream's `0.6` release. Pulled through the badc
vendor-deps mirror -- see [`setup.py`](setup.py).

## Bringup status

The vendoring infrastructure is in place; `setup.py` fetches
the focused subset from the vendor-deps mirror. Bringup
through badc surfaces a c5 codegen gap that gates the smoke:

* **`const uint32_t IV[]` arrays of equal length alias** --
  `br_sha224_IV[0]` and `br_sha256_IV[0]` both read as
  `0x6a09e667` after init, so SHA-224 produces the SHA-256
  digest. Reproduces in both the amalgamated and multi-TU
  builds. Tracked separately.

The smoke harness, public-API driver (SHA-224 / SHA-256 / HMAC
/ HKDF), and CI gate land alongside the const-array aliasing
fix.

Already-closed gaps that the BearSSL bringup surfaced:

* **Preprocessor 64-bit literal support (C99 6.10.1p4).**
  `((ULONG_MAX >> 31) >> 31) == 3` (BearSSL's 64-bit host
  probe in `src/inner.h`) requires (a) parsing the bare
  `18446744073709551615` literal in a `#if` expression and (b)
  using logical right shift on bit-pattern values. Regression:
  `preprocessor_uint64_literal.c`.
* **`&func` in static initializers (C99 6.3.2.1p4).**
  Upstream BearSSL spells vtable entries as
  `(void (*)(...))&br_sha224_init`. The bare-identifier form
  was already accepted; the `&`-prefixed form now routes
  through the same code-reloc path.

## Layout

* `setup.py` -- fetch the vendored tar.gz from the badc
  vendor-deps release and extract the curated subset
  (`inc/*`, `src/inner.h`, `src/config.h`, the hash / mac /
  kdf / codec / int .c files); idempotent.
* `inc/*.h`, `src/**/*.c`, `src/inner.h`, `src/config.h` --
  vendored upstream (gitignored out of band; `setup.py` is
  the source of truth for what they are).

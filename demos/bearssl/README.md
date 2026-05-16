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

## Smoke scenarios

[`smoke.py`](smoke.py) builds the focused BearSSL set + a
hand-written driver through badc in four flavours (amalgamation
+ separate-TU compile, each at `-O` and no-`-O`), plus an
archive flavour, and runs each binary. Four scenarios:

| Scenario              | What it asserts                                                                                              |
|-----------------------|--------------------------------------------------------------------------------------------------------------|
| SHA-256(`"abc"`)      | FIPS 180-2 / RFC 4634 vector: digest matches the published 32-byte answer.                                   |
| SHA-224(`"abc"`)      | FIPS 180-2 vector: 28-byte digest matches the published answer.                                              |
| HMAC-SHA-256 (RFC 4231) | Test case 1: 20-byte key (`0x0b * 20`), message `"Hi There"`, 32-byte MAC matches the published value.       |
| HKDF-SHA-256 (RFC 5869) | Test case 1: 42-byte OKM derived from the published IKM / salt / info matches the reference bit-for-bit.    |

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
* **Extern + def merge for non-array globals (C99 6.9.2).**
  An earlier `extern const T v;` allocates storage at `sym.val`;
  any in-TU code emitted before the defining `const T v = { ... };`
  bakes that offset into its bytecode. The merge must REUSE that
  storage so the defining initializer lands at the same offset.
  Deferred-size array externs (`extern T x[];`) still allocate
  fresh because the extern path leaves them without storage.
  Regression: `extern_decl_then_define.c`.

## Layout

* `setup.py` -- fetch the vendored tar.gz from the badc
  vendor-deps release and extract the curated subset
  (`inc/*`, `src/inner.h`, `src/config.h`, the hash / mac /
  kdf / codec / int .c files); idempotent.
* `inc/*.h`, `src/**/*.c`, `src/inner.h`, `src/config.h` --
  vendored upstream (gitignored out of band; `setup.py` is
  the source of truth for what they are).

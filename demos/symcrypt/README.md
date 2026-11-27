# SymCrypt

Microsoft's SymCrypt 103.13.0 cryptographic library built with badc
through SymCrypt's own CMake, and checked by SymCrypt's own unit test.

```sh
cargo build --release --features full
python3 demos/symcrypt/smoke.py
```

`setup.py` fetches GitHub's archive of the `v103.13.0` tag from the
vendor-deps mirror (sha256-pinned). The smoke configures a fresh build tree
under `.cache/build-<arch>` with badc as `CMAKE_C_COMPILER` and the host C++
compiler as `CMAKE_CXX_COMPILER`, checks that every C unit in the compile
database is badc's, builds, and runs `symcryptunittest noperftests`: the
known-answer tests, error cases and cross-implementation checks of every
algorithm, from the hashes and block-cipher modes through RSA, DH, DSA,
the elliptic curves, ML-KEM, ML-DSA, LMS and XMSS. The unit test is C++
compiled by the host compiler and linked against the badc-built static
library, so the library's ABI is checked from the other side too.

## Configuration

Every switch is one of SymCrypt's own options:

| option | value | why |
|---|---|---|
| `SYMCRYPT_USE_ASM` | on | badc assembles the assembly SymCrypt generates, in GNU syntax for aarch64 and in Intel syntax for x86_64 |
| `SYMCRYPT_FIPS_BUILD` | off | needs the jitterentropy submodule, which the archive does not carry |
| `SYMCRYPT_BUILD_MODULES`, `SYMCRYPT_SYMCRUST` | off | the unit test links the static library and the C ML-KEM |

`CMAKE_C_FLAGS` is `-fgnuc-version=4.7.0 -Wno-incompatible-pointer-types`.
CMake gives a GNU C compiler a C11 mode from version 4.7, and the project
requires C11; badc's default claim is 4.3.0. The library initializes
`void (*)(void *)` members with functions taking a structure pointer, which
gcc 16 and clang 23 reject as badc does unless the diagnostic is off.

## Measured

On the Linux boxes (`badc` 146 C units and 11 assembly units on x86_64,
145 and 3 on aarch64; the build includes the C++ unit test):

| target | build | unit test |
|---|---|---|
| x86_64, 12 jobs | 112 s | 380 s |
| aarch64, 2 jobs | 51 s | 227 s |

The portable C code the x86_64 build took before its assembly assembled
ran the unit test in 955 s, 860 s of it RSA, DH and DSA, whose bignum
arithmetic the assembly carries. The build takes one job per CPU,
bounded by 2 GB of available memory per job for the C++ units
(`BADC_SYMCRYPT_JOBS` overrides). On aarch64 the run uses the NEON,
AES, PMULL and SHA-256 instruction paths the box reports.

Linux only: SymCrypt's macOS configuration fixes the compiler to clang,
and its Windows one is MSVC with MASM.

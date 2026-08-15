// CommonCrypto/CommonRandom.h -- the CommonCrypto random-byte source.
// macOS only. Prototype matches the macOS SDK header of the same name;
// libSystem exports the symbol.
//
// The rest of CommonCrypto -- the digest, HMAC, cryptor, key-derivation
// and keywrap headers the CommonCrypto.h umbrella gathers -- is not
// bundled, so the umbrella is not either.

#pragma once

#include <CommonCrypto/CommonCryptoError.h>
#include <sys/types.h>

#ifdef __APPLE__

typedef CCCryptorStatus CCRNGStatus;

#pragma dylib(libc, "/usr/lib/libSystem.B.dylib")
#pragma binding(libc::CCRandomGenerateBytes, "_CCRandomGenerateBytes")

// Returns kCCSuccess when `count` bytes were written to `bytes`.
CCRNGStatus CCRandomGenerateBytes(void *bytes, size_t count);

#endif

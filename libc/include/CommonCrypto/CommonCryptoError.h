// CommonCrypto/CommonCryptoError.h -- CommonCrypto status codes. macOS
// only. Values match the macOS SDK header of the same name.

#pragma once

#include <stdint.h>

#ifdef __APPLE__

enum {
    kCCSuccess = 0,
    kCCParamError = -4300,
    kCCBufferTooSmall = -4301,
    kCCMemoryFailure = -4302,
    kCCAlignmentError = -4303,
    kCCDecodeError = -4304,
    kCCUnimplemented = -4305,
    kCCOverflow = -4306,
    kCCRNGFailure = -4307,
    kCCUnspecifiedError = -4308,
    kCCCallSequenceError = -4309,
    kCCKeySizeError = -4310,
    kCCInvalidKey = -4311
};

typedef int32_t CCStatus;
typedef int32_t CCCryptorStatus;

#endif

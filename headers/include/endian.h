// endian.h -- byte order constants and host/network conversion macros
// (glibc/BSD). Every supported target is little-endian, so the le* forms are
// identity and the be* forms reverse bytes.

#pragma once

#define __LITTLE_ENDIAN    1234
#define __BIG_ENDIAN       4321
#define __PDP_ENDIAN       3412
#define __BYTE_ORDER       __LITTLE_ENDIAN
#define __FLOAT_WORD_ORDER __BYTE_ORDER

#define LITTLE_ENDIAN __LITTLE_ENDIAN
#define BIG_ENDIAN    __BIG_ENDIAN
#define PDP_ENDIAN    __PDP_ENDIAN
#define BYTE_ORDER    __BYTE_ORDER

#define htobe16(x) __builtin_bswap16(x)
#define htole16(x) ((unsigned short)(x))
#define be16toh(x) __builtin_bswap16(x)
#define le16toh(x) ((unsigned short)(x))

#define htobe32(x) __builtin_bswap32(x)
#define htole32(x) ((unsigned int)(x))
#define be32toh(x) __builtin_bswap32(x)
#define le32toh(x) ((unsigned int)(x))

#define htobe64(x) __builtin_bswap64(x)
#define htole64(x) ((unsigned long long)(x))
#define be64toh(x) __builtin_bswap64(x)
#define le64toh(x) ((unsigned long long)(x))

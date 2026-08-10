/* glibc's <byteswap.h>, which the macOS SDK has no equivalent of.
 * scripts/mod/modpost.h includes it.
 */
#ifndef _BADC_HOSTCOMPAT_BYTESWAP_H
#define _BADC_HOSTCOMPAT_BYTESWAP_H

#include <libkern/OSByteOrder.h>

#define bswap_16(x) OSSwapInt16(x)
#define bswap_32(x) OSSwapInt32(x)
#define bswap_64(x) OSSwapInt64(x)

#endif

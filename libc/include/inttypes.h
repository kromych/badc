// inttypes.h -- fixed-width integer formatting macros and helpers.
//
// C99 7.8 layers `<inttypes.h>` on top of `<stdint.h>`: same
// fixed-width typedefs plus the `PRIx<N>` / `SCNx<N>` printf and
// scanf conversion specifiers and a small intmax_t-arithmetic
// surface (`imaxabs`, `imaxdiv`, `strtoimax`, `strtoumax`).
//
// The width-suffixed macros expand to conversion-specifier strings.
// The 64-bit, greatest-width, pointer-width and fastest 16- and 32-bit
// ones take the length modifier of the type the target gives the
// typedef, which the compiler predefines with the types.
#pragma once

#include <stdint.h>
// 7.8.2.3 / 7.8.2.4 route through the `long long` conversions in
// <stdlib.h>, as wide as intmax_t on every target.
#include <stdlib.h>

// 7.8.1 -- printf conversion specifiers.

#define PRId8      "d"
#define PRId16     "d"
#define PRId32     "d"
#define PRId64     __INT64_FMTd__
#define PRIdLEAST8  "d"
#define PRIdLEAST16 "d"
#define PRIdLEAST32 "d"
#define PRIdLEAST64 __INT64_FMTd__
#define PRIdFAST8   "d"
#define PRIdFAST16  __INT_FAST16_FMTd__
#define PRIdFAST32  __INT_FAST32_FMTd__
#define PRIdFAST64  __INT64_FMTd__
#define PRIdMAX    __INTMAX_FMTd__
#define PRIdPTR    __INTPTR_FMTd__

#define PRIi8      "i"
#define PRIi16     "i"
#define PRIi32     "i"
#define PRIi64     __INT64_FMTi__
#define PRIiLEAST8  "i"
#define PRIiLEAST16 "i"
#define PRIiLEAST32 "i"
#define PRIiLEAST64 __INT64_FMTi__
#define PRIiFAST8   "i"
#define PRIiFAST16  __INT_FAST16_FMTi__
#define PRIiFAST32  __INT_FAST32_FMTi__
#define PRIiFAST64  __INT64_FMTi__
#define PRIiMAX    __INTMAX_FMTi__
#define PRIiPTR    __INTPTR_FMTi__

#define PRIo8      "o"
#define PRIo16     "o"
#define PRIo32     "o"
#define PRIo64     __UINT64_FMTo__
#define PRIoLEAST8  "o"
#define PRIoLEAST16 "o"
#define PRIoLEAST32 "o"
#define PRIoLEAST64 __UINT64_FMTo__
#define PRIoFAST8   "o"
#define PRIoFAST16  __UINT_FAST16_FMTo__
#define PRIoFAST32  __UINT_FAST32_FMTo__
#define PRIoFAST64  __UINT64_FMTo__
#define PRIoMAX    __UINTMAX_FMTo__
#define PRIoPTR    __UINTPTR_FMTo__

#define PRIu8      "u"
#define PRIu16     "u"
#define PRIu32     "u"
#define PRIu64     __UINT64_FMTu__
#define PRIuLEAST8  "u"
#define PRIuLEAST16 "u"
#define PRIuLEAST32 "u"
#define PRIuLEAST64 __UINT64_FMTu__
#define PRIuFAST8   "u"
#define PRIuFAST16  __UINT_FAST16_FMTu__
#define PRIuFAST32  __UINT_FAST32_FMTu__
#define PRIuFAST64  __UINT64_FMTu__
#define PRIuMAX    __UINTMAX_FMTu__
#define PRIuPTR    __UINTPTR_FMTu__

#define PRIx8      "x"
#define PRIx16     "x"
#define PRIx32     "x"
#define PRIx64     __UINT64_FMTx__
#define PRIxLEAST8  "x"
#define PRIxLEAST16 "x"
#define PRIxLEAST32 "x"
#define PRIxLEAST64 __UINT64_FMTx__
#define PRIxFAST8   "x"
#define PRIxFAST16  __UINT_FAST16_FMTx__
#define PRIxFAST32  __UINT_FAST32_FMTx__
#define PRIxFAST64  __UINT64_FMTx__
#define PRIxMAX    __UINTMAX_FMTx__
#define PRIxPTR    __UINTPTR_FMTx__

#define PRIX8      "X"
#define PRIX16     "X"
#define PRIX32     "X"
#define PRIX64     __UINT64_FMTX__
#define PRIXLEAST8  "X"
#define PRIXLEAST16 "X"
#define PRIXLEAST32 "X"
#define PRIXLEAST64 __UINT64_FMTX__
#define PRIXFAST8   "X"
#define PRIXFAST16  __UINT_FAST16_FMTX__
#define PRIXFAST32  __UINT_FAST32_FMTX__
#define PRIXFAST64  __UINT64_FMTX__
#define PRIXMAX    __UINTMAX_FMTX__
#define PRIXPTR    __UINTPTR_FMTX__

// 7.8.1 -- scanf conversion specifiers. Same shape as the PRI*
// macros above: c5's per-width storage maps directly onto the
// standard scanf length modifiers.

#define SCNd8      "hhd"
#define SCNd16     "hd"
#define SCNd32     "d"
#define SCNd64     __INT64_FMTd__
#define SCNdLEAST8  "hhd"
#define SCNdLEAST16 "hd"
#define SCNdLEAST32 "d"
#define SCNdLEAST64 __INT64_FMTd__
#define SCNdFAST8   "hhd"
#define SCNdFAST16  __INT_FAST16_FMTd__
#define SCNdFAST32  __INT_FAST32_FMTd__
#define SCNdFAST64  __INT64_FMTd__
#define SCNdMAX    __INTMAX_FMTd__
#define SCNdPTR    __INTPTR_FMTd__

#define SCNi8      "hhi"
#define SCNi16     "hi"
#define SCNi32     "i"
#define SCNi64     __INT64_FMTi__
#define SCNiLEAST8  "hhi"
#define SCNiLEAST16 "hi"
#define SCNiLEAST32 "i"
#define SCNiLEAST64 __INT64_FMTi__
#define SCNiFAST8   "hhi"
#define SCNiFAST16  __INT_FAST16_FMTi__
#define SCNiFAST32  __INT_FAST32_FMTi__
#define SCNiFAST64  __INT64_FMTi__
#define SCNiMAX    __INTMAX_FMTi__
#define SCNiPTR    __INTPTR_FMTi__

#define SCNo8      "hho"
#define SCNo16     "ho"
#define SCNo32     "o"
#define SCNo64     __UINT64_FMTo__
#define SCNoLEAST8  "hho"
#define SCNoLEAST16 "ho"
#define SCNoLEAST32 "o"
#define SCNoLEAST64 __UINT64_FMTo__
#define SCNoFAST8   "hho"
#define SCNoFAST16  __UINT_FAST16_FMTo__
#define SCNoFAST32  __UINT_FAST32_FMTo__
#define SCNoFAST64  __UINT64_FMTo__
#define SCNoMAX    __UINTMAX_FMTo__
#define SCNoPTR    __UINTPTR_FMTo__

#define SCNu8      "hhu"
#define SCNu16     "hu"
#define SCNu32     "u"
#define SCNu64     __UINT64_FMTu__
#define SCNuLEAST8  "hhu"
#define SCNuLEAST16 "hu"
#define SCNuLEAST32 "u"
#define SCNuLEAST64 __UINT64_FMTu__
#define SCNuFAST8   "hhu"
#define SCNuFAST16  __UINT_FAST16_FMTu__
#define SCNuFAST32  __UINT_FAST32_FMTu__
#define SCNuFAST64  __UINT64_FMTu__
#define SCNuMAX    __UINTMAX_FMTu__
#define SCNuPTR    __UINTPTR_FMTu__

#define SCNx8      "hhx"
#define SCNx16     "hx"
#define SCNx32     "x"
#define SCNx64     __UINT64_FMTx__
#define SCNxLEAST8  "hhx"
#define SCNxLEAST16 "hx"
#define SCNxLEAST32 "x"
#define SCNxLEAST64 __UINT64_FMTx__
#define SCNxFAST8   "hhx"
#define SCNxFAST16  __UINT_FAST16_FMTx__
#define SCNxFAST32  __UINT_FAST32_FMTx__
#define SCNxFAST64  __UINT64_FMTx__
#define SCNxMAX    __UINTMAX_FMTx__
#define SCNxPTR    __UINTPTR_FMTx__

// 7.8.2 -- intmax_t arithmetic helpers. imaxabs / imaxdiv reduce to a
// sign test and the / and % operators (the quotient truncates toward
// zero per 6.5.5p6); strtoimax / strtoumax forward to the long long
// conversions, which intmax_t matches in width.

typedef struct {
    intmax_t quot;
    intmax_t rem;
} imaxdiv_t;

static inline intmax_t imaxabs(intmax_t j) {
    return j < 0 ? -j : j;
}
static inline imaxdiv_t imaxdiv(intmax_t numer, intmax_t denom) {
    imaxdiv_t r;
    r.quot = numer / denom;
    r.rem = numer % denom;
    return r;
}
static inline intmax_t strtoimax(const char *nptr, char **endptr, int base) {
    return strtoll((char *)nptr, endptr, base);
}
static inline uintmax_t strtoumax(const char *nptr, char **endptr, int base) {
    return strtoull((char *)nptr, endptr, base);
}

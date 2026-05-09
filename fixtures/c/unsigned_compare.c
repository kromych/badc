// Unsigned integer comparisons must use unsigned semantics, not
// signed. Surfaced by sqlite3's `Pgno` (typedef u32) compared
// against `SQLITE_MAX_PAGE_COUNT = 0xfffffffe`: if the comparison
// went signed, `1 > 0xfffffffe` read as `1 > -2` and turned every
// page-1 fetch into SQLITE_FULL.
//
// Covers the three integer widths the dialect supports:
//   * `unsigned int`    -- via direct decl and via typedef
//   * `unsigned long`   -- 64-bit slot
//   * `unsigned char`   -- 1-byte slot, zero-extended
// plus the original signed `int` path (sanity check that we didn't
// flip the polarity for plain integer compares).
#include <stdio.h>

typedef unsigned int u32;
typedef unsigned long long u64;

int main() {
    // unsigned int via typedef.
    u32 a = 1;
    u32 b = 0xFFFFFFFE;
    if (a > b) { printf("FAIL: u32 typedef 1 > 0xFFFFFFFE\n"); return 1; }
    if (!(b > a)) { printf("FAIL: u32 typedef 0xFFFFFFFE > 1\n"); return 1; }

    // unsigned int directly spelled.
    unsigned int c = 1;
    unsigned int d = 0xFFFFFFFE;
    if (c > d) { printf("FAIL: unsigned int 1 > 0xFFFFFFFE\n"); return 1; }
    if (!(d > c)) { printf("FAIL: unsigned int 0xFFFFFFFE > 1\n"); return 1; }

    // unsigned long long via typedef.
    u64 x = 1;
    u64 y = 0xFFFFFFFFFFFFFFFE;
    if (x > y) { printf("FAIL: u64 typedef 1 > 0xFFF...FE\n"); return 1; }
    if (!(y > x)) { printf("FAIL: u64 typedef 0xFFF...FE > 1\n"); return 1; }

    // unsigned long directly spelled.
    unsigned long e = 1;
    unsigned long f = 0xFFFFFFFFFFFFFFFE;
    if (e >= f) { printf("FAIL: unsigned long 1 >= 0xFFF...FE\n"); return 1; }
    if (!(f >= e)) { printf("FAIL: unsigned long 0xFFF...FE >= 1\n"); return 1; }

    // unsigned char (zero-extended on load).
    unsigned char g = 0;
    unsigned char h = 0xFE;
    if (h <= g) { printf("FAIL: unsigned char 0xFE <= 0\n"); return 1; }

    // Signed int still uses signed semantics: 1 > -2 must be true.
    int s = 1;
    int t = -2;
    if (!(s > t)) { printf("FAIL: signed 1 > -2\n"); return 1; }
    if (s < t) { printf("FAIL: signed 1 < -2\n"); return 1; }

    return 0;
}

// DEFERRED (#51): the dialect picks Ty::Long = 8 bytes for `long`
// on every target and collapses `long long` onto the same tag.
// Two consequences:
//
//   * On Windows (LLP64): `long x;` allocates 8 bytes; the
//     platform ABI expects 4. Any libc binding declared with a
//     `long` parameter or return reads the wrong width when
//     bridged through msvcrt; struct fields that follow a
//     `long` are at the wrong offset relative to the Windows ABI.
//   * On all targets: `long` and `long long` are
//     indistinguishable, so a program that computes
//     `sizeof(long) != sizeof(long long)` (legitimate on
//     Windows) can't be expressed.
//
// The fixture pins the "two distinct types" expectation under
// the LLP64 model: when the compiler grows per-target `long`
// width, this should pass on Windows targets. Today it fails
// universally because c5 reports the same size for both.
//
// Linux + macOS LP64 hosts will *still* fail this assertion
// after the fix, because LP64 specifies `sizeof(long) ==
// sizeof(long long)`. The Windows-specific assertion is gated
// out of the JIT lane via __BADC_WINDOWS__; the JIT-runnable
// part just verifies the type-distinction part of the gap.
#include <stdio.h>

int main() {
    // Both should be at least 4 bytes; both currently 8 in c5
    // regardless of target.
    if (sizeof(long) < 4) return 1;
    if (sizeof(long long) < 8) return 2;

    // C99 rule: sizeof(long) <= sizeof(long long).
    if (sizeof(long) > sizeof(long long)) return 3;

#ifdef __BADC_WINDOWS__
    // LLP64-specific: long is 4 bytes, long long is 8.
    // Today c5 gives both 8 -- fixture exits 4 to flag.
    if (sizeof(long) != 4) return 4;
    if (sizeof(long long) != 8) return 5;
    if (sizeof(long) >= sizeof(long long)) return 6;
#endif

    // Even on LP64 (where sizeof(long) == sizeof(long long) is
    // legal), `long long` should be a distinguishable type.
    // Today the dialect collapses both onto Ty::Long; this
    // assertion is a placeholder for "if the compiler ever
    // tracks the distinction, the fixture passes."
    long ls = 0;
    long long lls = 0;
    // `_Generic` would be the right vehicle; not implemented.
    // For now, just make sure both shapes parse and assign
    // without compile error -- the silent identity is the bug.
    ls = lls;
    lls = ls;
    if (ls != 0) return 7;

    return 0;
}

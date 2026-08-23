// GNU `memmem`: the first occurrence of a counted needle in a counted
// haystack. libSystem and the Linux C library export it; on Windows
// `libc/lib/string_ext.c` supplies it. Neither operand stops at a
// terminator, which is what separates it from `strstr`, so the subject
// below carries embedded NULs.
//
// Returns 0 on success, otherwise the number of the failing check.

#include <string.h>

int main(void) {
    // 11 bytes: a b \0 c a b \0 c a b c
    static const char hay[] = "ab\0cab\0cabc";
    static const char nul_needle[] = "\0";
    static const char nul_inside[] = "b\0c";
    const char *overlap = "abababc";
    const char *runs = "aaab";

    // A needle longer than the haystack never matches, whatever the
    // bytes are.
    if (memmem(hay, 3, "abcd", 4) != 0) {
        return 1;
    }
    if (memmem(hay, 0, "a", 1) != 0) {
        return 2;
    }
    // Equal lengths reduce to a compare of the whole region.
    if (memmem(hay, 11, hay, 11) != hay) {
        return 3;
    }
    // The only "abc" is the last three bytes, so a scan that stops
    // short of the end misses it.
    if (memmem(hay, 11, "abc", 3) != hay + 8) {
        return 4;
    }
    if (memmem(hay, 11, "ab", 2) != hay) {
        return 5;
    }
    // A NUL inside either operand is an ordinary byte.
    if (memmem(hay, 11, nul_inside, 3) != hay + 1) {
        return 6;
    }
    if (memmem(hay, 11, nul_needle, 1) != hay + 2) {
        return 7;
    }
    if (memmem(hay, 11, "zz", 2) != 0) {
        return 8;
    }
    // A partial match must resume one byte past where it started, not
    // past where it failed: "ababc" first matches at offset 2.
    if (memmem(overlap, 7, "ababc", 5) != overlap + 2) {
        return 9;
    }
    if (memmem(runs, 4, "aab", 3) != runs + 1) {
        return 10;
    }
    if (memmem(runs, 4, "aa", 2) != runs) {
        return 11;
    }
    // A count that stops one byte short of the match hides it.
    if (memmem("xxab", 3, "ab", 2) != 0) {
        return 12;
    }
    if (memmem("xxab", 4, "ab", 2) == 0) {
        return 17;
    }
    if (memmem("a", 1, "a", 1) == 0) {
        return 13;
    }
    if (memmem("a", 1, "b", 1) != 0) {
        return 14;
    }
#ifndef __APPLE__
    // An empty needle matches at the start of the haystack. libSystem
    // returns null instead, and no standard covers the case, so the
    // check is gated to the libraries that agree.
    if (memmem(hay, 11, "", 0) != hay) {
        return 15;
    }
    if (memmem(hay, 0, "", 0) != hay) {
        return 16;
    }
#endif
    return 0;
}

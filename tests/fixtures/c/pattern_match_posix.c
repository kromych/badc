// POSIX pattern matching through <fnmatch.h> and <regex.h>.
//
// The flag values and the regex_t / regmatch_t layouts are ABI: the
// BSD-derived libc and glibc number FNM_PATHNAME / FNM_NOESCAPE and
// REG_NEWLINE / REG_NOSUB the other way round from each other, and
// regoff_t is 64-bit on the former, int on the latter. The cases below
// are the ones all three implementations agree on -- the two platform
// libraries and badc's own engine -- so a header that swapped a pair or
// mis-sized a struct fails here rather than at some caller's corner case.
//
// Returns 0 on success, otherwise 1 + the index of the first failing
// case (fnmatch cases first, then regex).

#include <fnmatch.h>
#include <regex.h>
#include <stddef.h>

struct fnm_case {
    const char *pat;
    const char *str;
    int flags;
    int match;
};

static const struct fnm_case FNM_CASES[] = {
    {"*", "foo", 0, 1},
    {"*", "", 0, 1},
    {"", "", 0, 1},
    {"", "a", 0, 0},
    {"*", "foo/bar", 0, 1},
    {"*", "foo/bar", FNM_PATHNAME, 0},
    {"*/*", "foo/bar", FNM_PATHNAME, 1},
    {"*/*", "foo/bar/baz", FNM_PATHNAME, 0},
    {"foo/*", "foo/bar", FNM_PATHNAME, 1},
    {"?", "/", FNM_PATHNAME, 0},
    {"a?c", "a/c", FNM_PATHNAME, 0},
    {".*", ".foo", FNM_PERIOD, 1},
    {"*", ".foo", FNM_PERIOD, 0},
    {"*", ".foo", 0, 1},
    {"?foo", ".foo", FNM_PERIOD, 0},
    {"a/*", "a/.b", FNM_PERIOD | FNM_PATHNAME, 0},
    {"a/*", "a/.b", FNM_PERIOD, 1},
    {"a/.*", "a/.b", FNM_PERIOD | FNM_PATHNAME, 1},
    {"[abc]", "b", 0, 1},
    {"[abc]", "d", 0, 0},
    {"[!abc]", "d", 0, 1},
    {"[^abc]", "d", 0, 1},
    {"[a-c]", "d", 0, 0},
    {"[]abc]", "]", 0, 1},
    {"[a-]", "-", 0, 1},
    {"[[:digit:]]", "7", 0, 1},
    {"[[:alpha:]]", "1", 0, 0},
    {"[[:upper:]]", "a", 0, 0},
    {"[[:bogus:]]", "a", 0, 0},
    {"[.]foo", ".foo", FNM_PERIOD, 0},
    {"[a-[.c.]]", "b", 0, 1},
    {"[[.a.]-c]", "b", 0, 1},
    {"[a-[.]", "b", 0, 0},
    {"[/]", "/", FNM_PATHNAME, 0},
    {"[!/]", "/", FNM_PATHNAME, 0},
    {"[a-z]", "Q", FNM_CASEFOLD, 1},
    {"[A-Z]", "q", FNM_CASEFOLD, 1},
    {"ABC", "abc", FNM_CASEFOLD, 1},
    {"abc", "ABC", FNM_CASEFOLD, 1},
    {"a\\*c", "a*c", 0, 1},
    {"a\\*c", "abc", 0, 0},
    {"a\\*c", "a\\bc", FNM_NOESCAPE, 1},
    {"\\[", "[", 0, 1},
    {"foo", "foo/bar", FNM_LEADING_DIR, 1},
    {"foo", "foobar", FNM_LEADING_DIR, 0},
    {"foo/*", "foo/bar/baz", FNM_LEADING_DIR | FNM_PATHNAME, 1},
    {"*a*b", "xaybzb", 0, 1},
    {"a*b*c", "axxbyyc", 0, 1},
    {"a*b*c", "axxbyy", 0, 0},
    {"*.[ch]", "foo.c", 0, 1},
    {"*.[ch]", "foo.o", 0, 0},
    {"__ksymtab_*", "__ksymtab_foo", 0, 1},
    {"*.mod.c", "drivers/net/e1000.mod.c", 0, 1},
    {".text.*", ".text.unlikely", 0, 1},
    {"__*init", "__meminit", 0, 1},
};

struct rx_case {
    const char *pat;
    int cflags;
    const char *str;
    int eflags;
    int rc;  // 0 match, 1 no match
    int so, eo;
    int g1so, g1eo;
};

#define RX_E REG_EXTENDED
#define RX_I REG_ICASE
#define RX_N REG_NEWLINE

static const struct rx_case RX_CASES[] = {
    {"abc", RX_E, "xxabcyy", 0, 0, 2, 5, -1, -1},
    {"abc", RX_E, "abd", 0, 1, 0, 0, 0, 0},
    {"a.c", RX_E, "abc", 0, 0, 0, 3, -1, -1},
    {"a.c", RX_E, "ac", 0, 1, 0, 0, 0, 0},
    {"ab*c", RX_E, "ac", 0, 0, 0, 2, -1, -1},
    {"ab+c", RX_E, "abbc", 0, 0, 0, 4, -1, -1},
    {"ab+c", RX_E, "ac", 0, 1, 0, 0, 0, 0},
    {"a|ab", RX_E, "ab", 0, 0, 0, 2, -1, -1},
    {"(a|ab)(c|bcd)", RX_E, "abcd", 0, 0, 0, 4, 0, 1},
    {"(a*)(b*)", RX_E, "aabb", 0, 0, 0, 4, 0, 2},
    {"^abc", RX_E, "abc", 0, 0, 0, 3, -1, -1},
    {"^abc", RX_E, "xabc", 0, 1, 0, 0, 0, 0},
    {"abc$", RX_E, "abcx", 0, 1, 0, 0, 0, 0},
    {"^$", RX_E, "", 0, 0, 0, 0, -1, -1},
    {"^abc", RX_E, "abc", REG_NOTBOL, 1, 0, 0, 0, 0},
    {"abc$", RX_E, "abc", REG_NOTEOL, 1, 0, 0, 0, 0},
    {"a{2}", RX_E, "aaa", 0, 0, 0, 2, -1, -1},
    {"a{2,3}", RX_E, "aaaa", 0, 0, 0, 3, -1, -1},
    {"a{0,1}b", RX_E, "b", 0, 0, 0, 1, -1, -1},
    {"[abc]+", RX_E, "xbcay", 0, 0, 1, 4, -1, -1},
    {"[^abc]+", RX_E, "abcxyz", 0, 0, 3, 6, -1, -1},
    {"[[:digit:]]+", RX_E, "ab123cd", 0, 0, 2, 5, -1, -1},
    {"[]]", RX_E, "]", 0, 0, 0, 1, -1, -1},
    {"a[.]b", RX_E, "axb", 0, 1, 0, 0, 0, 0},
    {"ABC", RX_E | RX_I, "xabcx", 0, 0, 1, 4, -1, -1},
    {"[a-z]+", RX_E | RX_I, "ABC", 0, 0, 0, 3, -1, -1},
    {"(ab)+", RX_E, "ababab", 0, 0, 0, 6, 4, 6},
    {"(a|b)*c", RX_E, "ababc", 0, 0, 0, 5, 3, 4},
    {"a\\.b", RX_E, "a.b", 0, 0, 0, 3, -1, -1},
    {"a\\.b", RX_E, "axb", 0, 1, 0, 0, 0, 0},
    {"a.c", RX_E | RX_N, "a\nc", 0, 1, 0, 0, 0, 0},
    {"^b", RX_E | RX_N, "a\nb", 0, 0, 2, 3, -1, -1},
    {"a$", RX_E | RX_N, "a\nb", 0, 0, 0, 1, -1, -1},
    {"abc", 0, "xabcy", 0, 0, 1, 4, -1, -1},
    {"a*b", 0, "aaab", 0, 0, 0, 4, -1, -1},
    {"a\\{2,3\\}", 0, "aaaa", 0, 0, 0, 3, -1, -1},
    {"\\(ab\\)\\1", 0, "abab", 0, 0, 0, 4, 0, 2},
    {"a+b", 0, "a+b", 0, 0, 0, 3, -1, -1},
    {"a?b", 0, "a?b", 0, 0, 0, 3, -1, -1},
    {"*a", 0, "*a", 0, 0, 0, 2, -1, -1},
    {"a$b", 0, "a$b", 0, 0, 0, 3, -1, -1},
    {"[[:upper:]]\\{2\\}", 0, "aABc", 0, 0, 1, 3, -1, -1},
    {"USB", RX_E | RX_I, "CONFIG_USB_STORAGE", 0, 0, 7, 10, -1, -1},
    {"^CONFIG_", RX_E | RX_I, "CONFIG_X86", 0, 0, 0, 7, -1, -1},
    {"net.*driver", RX_E | RX_I, "NET_VENDOR_DRIVER", 0, 0, 0, 17, -1, -1},
    {"(usb|scsi)", RX_E | RX_I, "SCSI_MOD", 0, 0, 0, 4, 0, 4},
    {"e1000e?", RX_E | RX_I, "E1000E", 0, 0, 0, 6, -1, -1},
};

int main(void) {
    int i;
    int n = (int)(sizeof FNM_CASES / sizeof FNM_CASES[0]);
    int m = (int)(sizeof RX_CASES / sizeof RX_CASES[0]);

    // The two flags the two platform libraries number the other way round
    // must stay distinct, and the GNU spelling must alias the right one.
    if (FNM_PATHNAME == FNM_NOESCAPE || FNM_FILE_NAME != FNM_PATHNAME) {
        return 200;
    }
    if (REG_NEWLINE == REG_NOSUB || FNM_NOMATCH != 1 || REG_NOMATCH != 1) {
        return 201;
    }
    if (sizeof(regmatch_t) != 2 * sizeof(regoff_t)) {
        return 202;
    }

    for (i = 0; i < n; i++) {
        int got = fnmatch(FNM_CASES[i].pat, FNM_CASES[i].str, FNM_CASES[i].flags) == 0;
        if (got != FNM_CASES[i].match) {
            return 1 + i;
        }
    }

    for (i = 0; i < m; i++) {
        regex_t re;
        regmatch_t pm[2];
        int rc;
        if (regcomp(&re, RX_CASES[i].pat, RX_CASES[i].cflags) != 0) {
            return 1 + n + i;
        }
        pm[0].rm_so = -2;
        pm[0].rm_eo = -2;
        pm[1].rm_so = -2;
        pm[1].rm_eo = -2;
        rc = regexec(&re, RX_CASES[i].str, 2, pm, RX_CASES[i].eflags) == 0 ? 0 : 1;
        if (rc != RX_CASES[i].rc) {
            regfree(&re);
            return 1 + n + i;
        }
        if (rc == 0 &&
            ((int)pm[0].rm_so != RX_CASES[i].so || (int)pm[0].rm_eo != RX_CASES[i].eo ||
             (int)pm[1].rm_so != RX_CASES[i].g1so || (int)pm[1].rm_eo != RX_CASES[i].g1eo)) {
            regfree(&re);
            return 1 + n + i;
        }
        regfree(&re);
    }
    return 0;
}

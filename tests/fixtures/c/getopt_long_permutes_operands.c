// The option parsers over a fresh argument vector each, the scan restarted
// by setting optind to 0, which glibc, the BSD parsers and mingw-w64's all
// take: clustered short options with required and optional arguments; long
// options abbreviated, with `=` or the next argument, and one storing
// through its flag; getopt_long moving the operand it passes over behind
// the options and `--`; a leading `:` returning ':' for a missing argument;
// getopt_long_only taking `-name` as a long option and `-a` as a short one.
// getopt itself stops at the first operand except in glibc, which permutes.

#include <getopt.h>
#include <string.h>
#include <unistd.h>

static int flag;
static const struct option longs[] = {
    {"alpha", no_argument, 0, 'A'},
    {"beta", required_argument, 0, 'B'},
    {"gamma", optional_argument, 0, 'G'},
    {"flag", no_argument, &flag, 7},
    {0, 0, 0, 0},
};

int main(void) {
    char a0[] = "prog", a1[] = "-ab", a2[] = "one", a3[] = "file", a4[] = "--be",
         a5[] = "two", a6[] = "--gamma=3", a7[] = "-cfour", a8[] = "--flag", a9[] = "--",
         a10[] = "-z";
    char *av[] = {a0, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, 0};
    char b0[] = "prog", b1[] = "-x", b2[] = "-b";
    char *bv[] = {b0, b1, b2, 0};
    char c0[] = "prog", c1[] = "-alpha", c2[] = "-beta=v", c3[] = "-a";
    char *cv[] = {c0, c1, c2, c3, 0};
    char d0[] = "prog", d1[] = "-a", d2[] = "-bx", d3[] = "op", d4[] = "-a";
    char *dv[] = {d0, d1, d2, d3, d4, 0};
    const char *s = "ab:c::";
    int idx = -1;

    opterr = 0;
    optind = 0;
    if (getopt_long(11, av, s, longs, &idx) != 'a')
        return 1;
    if (getopt_long(11, av, s, longs, &idx) != 'b' || strcmp(optarg, "one"))
        return 2;
    if (getopt_long(11, av, s, longs, &idx) != 'B' || strcmp(optarg, "two") || idx != 1)
        return 3;
    if (getopt_long(11, av, s, longs, &idx) != 'G' || strcmp(optarg, "3") || idx != 2)
        return 4;
    if (getopt_long(11, av, s, longs, &idx) != 'c' || strcmp(optarg, "four"))
        return 5;
    if (getopt_long(11, av, s, longs, &idx) != 0 || flag != 7 || idx != 3)
        return 6;
    if (getopt_long(11, av, s, longs, &idx) != -1 || optind != 9)
        return 7;
    if (strcmp(av[8], "--") || strcmp(av[9], "file") || strcmp(av[10], "-z"))
        return 8;

    optind = 0;
    if (getopt_long(3, bv, ":ab:", longs, 0) != '?' || optopt != 'x')
        return 9;
    if (getopt_long(3, bv, ":ab:", longs, 0) != ':' || optopt != 'b' || optind != 3)
        return 10;

    optind = 0;
    if (getopt_long_only(4, cv, "a", longs, &idx) != 'A' || idx != 0)
        return 11;
    if (getopt_long_only(4, cv, "a", longs, &idx) != 'B' || strcmp(optarg, "v"))
        return 12;
    if (getopt_long_only(4, cv, "a", longs, &idx) != 'a')
        return 13;
    if (getopt_long_only(4, cv, "a", longs, &idx) != -1 || optind != 4)
        return 14;

    // The BSD getopt takes 0 for the program name: a completed scan
    // restarts at 1 on every parser.
    optind = 1;
    if (getopt(5, dv, "ab:") != 'a')
        return 15;
    if (getopt(5, dv, "ab:") != 'b' || strcmp(optarg, "x"))
        return 16;
#ifdef __linux__
    if (getopt(5, dv, "ab:") != 'a' || getopt(5, dv, "ab:") != -1 || optind != 4)
        return 17;
#else
    if (getopt(5, dv, "ab:") != -1 || optind != 3)
        return 17;
#endif
    return 0;
}

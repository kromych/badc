// C99 7.19.6.1p8 converts an infinity or a NaN to "[-]inf" or "[-]infinity" /
// "[-]nan" or "[-]NAN" in every floating conversion, and the # flag affects
// only finite values. ucrtbase mangles the words when the # flag meets an
// empty fraction -- "%#.0e" of INFINITY prints "i.nf", "%#.0f" of -INFINITY
// prints "-.inf" and "%#.0a" of -INFINITY prints "-0x.inf" -- and marks an
// indeterminate NaN "(ind)", so the fixture pins the corrected spellings
// (libc/lib/printf_ext.c rewrites them on Windows; glibc prints them
// natively, so the fixture runs unchanged on every target).

#include <math.h>
#include <stdio.h>
#include <string.h>

static const struct { const char *fmt; double v; const char *want; } cases[] = {
    {"%#.0e", INFINITY, "inf"},
    {"%#.0e", -INFINITY, "-inf"},
    {"%#.0E", -INFINITY, "-INF"},
    {"%#.0f", -INFINITY, "-inf"},
    {"%#.0a", -INFINITY, "-inf"},
    {"%#.0A", -INFINITY, "-INF"},
    {"%#.0e", (double)NAN, "nan"},
    {"%#.0e", -(double)NAN, "-nan"},
    {"%#.0f", -(double)NAN, "-nan"},
    {"%#.0a", -(double)NAN, "-nan"},
    // Spellings the target library already gets right stay untouched, and a
    // finite value keeps both the # decimal point and its #.0 rounding.
    {"%e", INFINITY, "inf"},
    {"%f", -(double)NAN, "-nan"},
    {"%#.3e", INFINITY, "inf"},
    {"%#.0e", 1.5, "2.e+00"},
};

int main() {
    char b[64];
    int bad = 0;
    for (size_t i = 0; i < sizeof cases / sizeof *cases; i++) {
        (void)snprintf(b, sizeof b, cases[i].fmt, cases[i].v);
        if (strcmp(b, cases[i].want) != 0) {
            fprintf(stderr, "%s: got \"%s\", want \"%s\"\n", cases[i].fmt, b,
                    cases[i].want);
            bad++;
        }
    }
    return bad;
}

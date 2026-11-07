// C99 7.19.6.1p8 converts an infinity or a NaN to "[-]inf" / "[-]nan" in
// every floating conversion and gives # no say over either. ucrtbase mangles
// the word when # meets the empty fraction -- "%#.0e" of INFINITY prints
// "i.nf" -- so the conversion drops # (and the 0 flag, which p9 already
// excludes) from such a directive and lets ucrtbase print the word itself,
// keeping its own "(ind)" suffix, width, sign flags, %n and return counts.
// This runs on the PE targets, where the mangling exists; glibc agrees.

#include <math.h>
#include <stdio.h>
#include <string.h>
#include <wchar.h>

static int bad;

static void narrow(const char *fmt, double v, const char *want) {
    char b[64];
    int n = snprintf(b, sizeof b, fmt, v);
    if (strcmp(b, want) != 0 || n != (int)strlen(want)) {
        fprintf(stderr, "%s: got \"%s\" (%d), want \"%s\"\n", fmt, b, n, want);
        bad++;
    }
}

// C99 7.21.6.1p8 fixes only the word: the sign of a NaN and any
// (n-char-sequence) after it are the library's to choose.
static void narrow_nan(const char *fmt, double v) {
    char b[64];
    const char *word = b;
    (void)snprintf(b, sizeof b, fmt, v);
    if (*word == '-')
        word++;
    if (strncmp(word, "nan", 3) != 0 || (word[3] != 0 && word[3] != '(')) {
        fprintf(stderr, "%s: got \"%s\", want [-]nan[(n-char-sequence)]\n", fmt, b);
        bad++;
    }
}

static void wide(const wchar_t *fmt, double v, const wchar_t *want) {
    wchar_t b[64];
    int n = swprintf(b, 64, fmt, v);
    if (wcscmp(b, want) != 0 || n != (int)wcslen(want)) {
        fprintf(stderr, "wide %ls: got \"%ls\" (%d), want \"%ls\"\n", fmt, b, n, want);
        bad++;
    }
}

int main() {
    char b[64];
    int n;

    // Every # spelling of an infinity, in the case of its conversion.
    narrow("%#.0e", INFINITY, "inf");
    narrow("%#.0e", -INFINITY, "-inf");
    narrow("%#.0E", INFINITY, "INF");
    narrow("%#.0E", -INFINITY, "-INF");
    narrow("%#.0f", INFINITY, "inf");
    narrow("%#.0f", -INFINITY, "-inf");
    narrow("%#.0F", -INFINITY, "-INF");
    narrow("%#.0a", INFINITY, "inf");
    narrow("%#.0a", -INFINITY, "-inf");
    narrow("%#.0A", INFINITY, "INF");
    narrow("%#.0A", -INFINITY, "-INF");
    narrow("%#.0Le", INFINITY, "inf");
    narrow("%#.0Le", -INFINITY, "-inf");
    narrow("%#.0g", INFINITY, "inf");
    narrow("%#.0g", -INFINITY, "-inf");

    // The field width keeps its own padding, the - flag its side, and the
    // sign flags their sign.
    narrow("%#10.0f|", -INFINITY, "      -inf|");
    narrow("%#-10.0f|", -INFINITY, "-inf      |");
    narrow("%#+.0f", INFINITY, "+inf");
    narrow("%# .0f", INFINITY, " inf");
    narrow("%#+10.0e|", -INFINITY, "      -inf|");
    narrow("%#010.0f|", -INFINITY, "      -inf|");

    // A NaN keeps only the word C99 pins.
    narrow_nan("%#.0e", (double)NAN);
    narrow_nan("%#.0e", -(double)NAN);
    narrow_nan("%#.0f", (double)NAN);
    narrow_nan("%#.0a", -(double)NAN);

    // User text and %s arguments are not text to rewrite: neither the words
    // nor anything that looks like them may be touched.
    n = snprintf(b, sizeof b, "%s", "john.anderson@example.com");
    if (strcmp(b, "john.anderson@example.com") != 0 || n != 25) {
        fprintf(stderr, "user text: \"%s\" (%d)\n", b, n);
        bad++;
    }
    n = snprintf(b, sizeof b, "%s|%s", "WIKI.NFO", "i.nf");
    if (strcmp(b, "WIKI.NFO|i.nf") != 0 || n != 13) {
        fprintf(stderr, "user words: \"%s\" (%d)\n", b, n);
        bad++;
    }
    n = snprintf(b, sizeof b, "%d%#.0e%s%#.0f", 7, INFINITY, "x", -INFINITY);
    if (strcmp(b, "7infx-inf") != 0 || n != 9) {
        fprintf(stderr, "mixed: \"%s\" (%d)\n", b, n);
        bad++;
    }

    // The count a size-then-format caller reads is the corrected one.
    n = snprintf(NULL, 0, "%#.0e", INFINITY);
    if (n != 3) {
        fprintf(stderr, "size-then-format: %d\n", n);
        bad++;
    }
    {
        int k = 0;
        n = snprintf(b, sizeof b, "%#5.0e%n", INFINITY, &k);
        if (strcmp(b, "  inf") != 0 || n != 5 || k != 5) {
            fprintf(stderr, "width and count: \"%s\" (%d) %d\n", b, n, k);
            bad++;
        }
    }

    // A finite value keeps both the # decimal point and its rounding.
    narrow("%#.0e", 1.5, "2.e+00");
    narrow("%#.3e", INFINITY, "inf");

    // The wide family goes through the same walk.
    wide(L"%#.0e", INFINITY, L"inf");
    wide(L"%#.0f", -INFINITY, L"-inf");
    wide(L"%#.0A", -INFINITY, L"-INF");
    wide(L"%#10.0f|", -INFINITY, L"      -inf|");
    wide(L"%#-10.0a|", -INFINITY, L"-inf      |");
    {
        wchar_t w[64];
        int k = swprintf(w, 64, L"%ls%#.0e", L"i.nf", INFINITY);
        if (wcscmp(w, L"i.nfinf") != 0 || k != 7) {
            fprintf(stderr, "wide mixed: \"%ls\" (%d)\n", w, k);
            bad++;
        }
    }
    // A directive the walk does not model (the MSVC %I64 length) ends it,
    // and the edits found so far stand: nothing regresses.
    {
        wchar_t w[64];
        int k = swprintf(w, 64, L"%#.0e %I64d", INFINITY, 1LL);
        if (wcscmp(w, L"inf 1") != 0 || k != 5) {
            fprintf(stderr, "wide unknown modifier: \"%ls\" (%d)\n", w, k);
            bad++;
        }
    }

    return bad;
}

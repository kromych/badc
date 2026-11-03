// The three-argument tokenizers keep their position in the caller's
// pointer (C99 7.24.4.5.7 wcstok, POSIX strtok_r, and on Windows the
// CRT's strtok_s and wcstok_s), so two tokenizations of two strings
// interleave: a single hidden state would hand the second string's
// tokens to the first. Runs of delimiters are skipped and the pointer is
// written by the first call. On Windows a null context gives wcstok the
// runtime's own state, as the UCRT's does. The exit code is the line of
// the first mismatch.

#include <string.h>
#include <wchar.h>

#define CHECK(c)             \
    do {                     \
        if (!(c))            \
            return __LINE__; \
    } while (0)

static int same(const wchar_t *t, const wchar_t *want)
{
    return t && wcscmp(t, want) == 0;
}

static int wide(wchar_t *(*tok)(wchar_t *, const wchar_t *, wchar_t **))
{
    wchar_t a[] = L",,a b,,c ";
    wchar_t b[] = L"x  y,z";
    wchar_t *pa = 0, *pb = 0;
    CHECK(same(tok(a, L" ,", &pa), L"a") && pa);
    CHECK(same(tok(b, L" ,", &pb), L"x") && pb);
    CHECK(same(tok(0, L" ,", &pa), L"b"));
    CHECK(same(tok(0, L" ,", &pb), L"y"));
    CHECK(same(tok(0, L" ,", &pa), L"c"));
    CHECK(same(tok(0, L" ,", &pb), L"z"));
    CHECK(tok(0, L" ,", &pa) == 0);
    CHECK(tok(0, L" ,", &pb) == 0);
    wchar_t empty[] = L" , ";
    wchar_t *pe = 0;
    CHECK(tok(empty, L" ,", &pe) == 0);
    return 0;
}

static int narrow(char *(*tok)(char *, const char *, char **))
{
    char a[] = ",,a b,,c ";
    char b[] = "x  y,z";
    char *pa = 0, *pb = 0;
    CHECK(strcmp(tok(a, " ,", &pa), "a") == 0 && pa);
    CHECK(strcmp(tok(b, " ,", &pb), "x") == 0 && pb);
    CHECK(strcmp(tok(0, " ,", &pa), "b") == 0);
    CHECK(strcmp(tok(0, " ,", &pb), "y") == 0);
    CHECK(strcmp(tok(0, " ,", &pa), "c") == 0);
    CHECK(strcmp(tok(0, " ,", &pb), "z") == 0);
    CHECK(tok(0, " ,", &pa) == 0);
    CHECK(tok(0, " ,", &pb) == 0);
    return 0;
}

static wchar_t *call_wcstok(wchar_t *s, const wchar_t *d, wchar_t **p)
{
    return wcstok(s, d, p);
}

static char *call_strtok_r(char *s, const char *d, char **p)
{
    return strtok_r(s, d, p);
}

int main(void)
{
    int line;
    if ((line = wide(call_wcstok)) || (line = wide(wcstok)) || (line = narrow(call_strtok_r)))
        return line;
#ifdef _WIN32
    if ((line = wide(wcstok_s)) || (line = narrow(strtok_s)))
        return line;
    wchar_t s[] = L"p q";
    CHECK(same(wcstok(s, L" ", 0), L"p"));
    CHECK(same(wcstok(0, L" ", 0), L"q"));
    CHECK(wcstok(0, L" ", 0) == 0);
#endif
    return 0;
}

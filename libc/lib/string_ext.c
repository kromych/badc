// String routines <string.h> declares for every target but only some C
// libraries export: GNU `strchrnul` / `memrchr` / `explicit_bzero`,
// which neither libSystem nor msvcrt has, and POSIX `strndup`, GNU
// `memmem` and C99's three-argument `wcstok`, which msvcrt has not. Each
// block is gated to the targets
// with no definition
// to bind, so elsewhere this file compiles to nothing. The native-link
// driver offers it like an archive member, so an image that calls none
// of these carries none of it.

#include <stdlib.h>
#include <string.h>

#ifndef __linux__

// Unlike `strchr`, an absent `c` yields the terminating NUL rather than
// a null pointer; a search for '\0' finds that same NUL.
char *strchrnul(const char *s, int c) {
    char want = (char)c;
    const char *p = s;
    while (*p && *p != want) {
        p++;
    }
    return (char *)p;
}

// `memchr` scanning backward from the end of the region.
void *memrchr(const void *s, int c, size_t n) {
    const unsigned char *p = (const unsigned char *)s;
    unsigned char want = (unsigned char)c;
    while (n > 0) {
        n--;
        if (p[n] == want) {
            return (void *)(p + n);
        }
    }
    return 0;
}

void explicit_bzero(void *s, size_t n) {
    // Volatile: the stores must survive even though the caller never
    // reads the buffer back.
    volatile unsigned char *p = (volatile unsigned char *)s;
    size_t i = 0;
    while (i < n) {
        p[i] = 0;
        i++;
    }
}

#endif

#ifdef _WIN32
#include <windows.h>

// POSIX.1-2008 7.24.1.4: copy at most `n` bytes and NUL-terminate.
char *strndup(const char *s, size_t n) {
    size_t len = 0;
    char *p;
    while (len < n && s[len]) {
        len++;
    }
    p = malloc(len + 1);
    if (p) {
        memcpy(p, s, len);
        p[len] = 0;
    }
    return p;
}

// GNU `memmem`. A needle longer than the haystack never matches. For
// an empty needle this follows the Linux C library and returns the
// haystack; libSystem returns null there, and no standard covers the
// case. The compare is open-coded rather than routed through `memcmp`,
// whose c5 prototype narrows the length to `int`.
void *memmem(const void *haystack, size_t haystacklen,
             const void *needle, size_t needlelen) {
    const unsigned char *h = (const unsigned char *)haystack;
    const unsigned char *n = (const unsigned char *)needle;
    size_t i;
    if (needlelen == 0) {
        return (void *)haystack;
    }
    if (needlelen > haystacklen) {
        return 0;
    }
    for (i = 0; i + needlelen <= haystacklen; i++) {
        size_t k = 0;
        while (k < needlelen && h[i + k] == n[k]) {
            k++;
        }
        if (k == needlelen) {
            return (void *)(h + i);
        }
    }
    return 0;
}

// C99 7.24.4.5.7: the position lives in `*ptr`. msvcrt.dll's `wcstok`
// export is the two-argument form. As in the UCRT, a null `ptr` takes a
// per-thread position, which `_wcstok` (the two-argument form) shares; it
// is a TlsAlloc slot, which a program the JIT runs can use too.
static volatile LONG wcstok_slot = (LONG)TLS_OUT_OF_INDEXES;

static wchar_t *tokenize(wchar_t *s, const wchar_t *delim, wchar_t **ptr);

wchar_t *wcstok(wchar_t *s, const wchar_t *delim, wchar_t **ptr) {
    DWORD slot = (DWORD)wcstok_slot;
    wchar_t *position, *token;
    if (ptr) {
        return tokenize(s, delim, ptr);
    }
    if (slot == TLS_OUT_OF_INDEXES) {
        DWORD fresh = TlsAlloc();
        LONG had = InterlockedCompareExchange(&wcstok_slot, (LONG)fresh, (LONG)slot);
        if (had != (LONG)slot) {
            TlsFree(fresh);
            fresh = (DWORD)had;
        }
        slot = fresh;
    }
    position = (wchar_t *)TlsGetValue(slot);
    token = tokenize(s, delim, &position);
    TlsSetValue(slot, position);
    return token;
}

static wchar_t *tokenize(wchar_t *s, const wchar_t *delim, wchar_t **ptr) {
    wchar_t *end;
    if (!s) {
        s = *ptr;
        if (!s) {
            return 0;
        }
    }
    s += wcsspn(s, delim);
    if (!*s) {
        *ptr = s;
        return 0;
    }
    end = s + wcscspn(s, delim);
    if (*end) {
        *end++ = 0;
    }
    *ptr = end;
    return s;
}

wchar_t *_wcstok(wchar_t *s, const wchar_t *delim) {
    return wcstok(s, delim, 0);
}

#endif

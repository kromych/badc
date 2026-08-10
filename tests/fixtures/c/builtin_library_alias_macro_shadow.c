// A `__builtin_<fn>` name is the builtin whatever the translation unit
// defines the library name `<fn>` to be. The fortified string headers
// rely on it: they define a `strlen` macro whose constant arm calls
// `__builtin_strlen`, so a builtin that re-expanded through the macro
// would collapse the construct.

#include <stdlib.h>
#include <string.h>

extern unsigned long __fortify_strlen(const char *p);

#define __is_constexpr(x) \
    (sizeof(int) == sizeof(*(8 ? ((void *) ((long) (x) * 0l)) : (int *) 8)))

#define strlen(p)                                              \
    __builtin_choose_expr(__is_constexpr(__builtin_strlen(p)), \
        __builtin_strlen(p), __fortify_strlen(p))

// The siblings, each shadowed by a macro of a different value so a
// captured builtin is visible in the result rather than merely slower.
#define abs(x) 0
#define labs(x) 0
#define llabs(x) 0
#define memcmp(a, b, n) 1
#define memchr(s, c, n) ((void *) 0)
#define strcmp(a, b) 1
#define strncmp(a, b, n) 1
#define strchr(s, c) ((char *) 0)
#define strrchr(s, c) ((char *) 0)
#define strstr(h, n) ((char *) 0)
#define strpbrk(s, a) ((char *) 0)
#define strspn(s, a) 0
#define strcspn(s, a) 0
#define strcpy(d, s) ((char *) 0)
#define strncpy(d, s, n) ((char *) 0)
#define strcat(d, s) ((char *) 0)
#define strncat(d, s, n) ((char *) 0)
#define malloc(n) ((void *) 0)
#define calloc(n, m) ((void *) 0)
#define realloc(p, n) ((void *) 0)
#define free(p) ((void) 0)

// The constant arms the kernel's MODULE_INFO shape depends on.
_Static_assert(sizeof("GPL") - 1 == __builtin_strlen("GPL"), "embedded NUL");
_Static_assert(__builtin_strlen("abcd") == 4, "literal length");
_Static_assert(__builtin_strcmp("ab", "ab") == 0, "equal literals");
_Static_assert(__builtin_strncmp("abx", "aby", 2) == 0, "counted prefix");
_Static_assert(__builtin_memcmp("ab", "ab", 2) == 0, "equal bytes");
_Static_assert(__builtin_abs(-6) == 6, "int absolute value");
_Static_assert(__builtin_labs(-7L) == 7L, "long absolute value");
_Static_assert(__builtin_llabs(-8LL) == 8LL, "long long absolute value");

static int fortify_calls;

unsigned long __fortify_strlen(const char *p)
{
    unsigned long n = 0;
    while (p[n])
        n++;
    fortify_calls++;
    return n;
}

static const char text[] = "hello";
static char buf[8];

int main(void)
{
    const char *p = text;

    // A literal argument folds, so the macro's constant arm is chosen
    // and no fortify call happens.
    if (strlen("GPL") != 3) return 1;
    if (fortify_calls != 0) return 2;
    // A runtime argument picks the macro's other arm: the shadowing
    // macro is still in force for the library spelling.
    if (strlen(p) != 5) return 3;
    if (fortify_calls != 1) return 4;
    // The builtin spelling reaches the library function instead.
    if (__builtin_strlen(p) != 5) return 5;
    if (fortify_calls != 1) return 6;

    if (abs(-3) != 0 || __builtin_abs(-3) != 3) return 7;
    if (labs(-3L) != 0 || __builtin_labs(-3L) != 3L) return 8;
    if (llabs(-3LL) != 0 || __builtin_llabs(-3LL) != 3LL) return 9;

    if (memcmp(text, text, 5) != 1 || __builtin_memcmp(text, p, 5) != 0) return 10;
    if (memchr(text, 'e', 5) != 0 || __builtin_memchr(p, 'e', 5) != text + 1) return 11;
    if (strcmp(text, text) != 1 || __builtin_strcmp(text, p) != 0) return 12;
    if (strncmp(text, text, 5) != 1 || __builtin_strncmp(text, p, 5) != 0) return 13;
    if (strchr(text, 'l') != 0 || __builtin_strchr(p, 'l') != text + 2) return 14;
    if (strrchr(text, 'l') != 0 || __builtin_strrchr(p, 'l') != text + 3) return 15;
    if (strstr(text, "ll") != 0 || __builtin_strstr(p, "ll") != text + 2) return 16;
    if (strpbrk(text, "lo") != 0 || __builtin_strpbrk(p, "lo") != text + 2) return 17;
    if (strspn(text, "hel") != 0 || __builtin_strspn(p, "hel") != 4) return 18;
    if (strcspn(text, "lo") != 0 || __builtin_strcspn(p, "lo") != 2) return 19;

    if (strcpy(buf, text) != 0) return 20;
    if (__builtin_strcpy(buf, p) != buf || buf[4] != 'o') return 21;
    buf[0] = 0;
    if (__builtin_strncpy(buf, p, 3) != buf || buf[2] != 'l') return 22;
    buf[3] = 0;
    if (__builtin_strcat(buf, "x") != buf || buf[3] != 'x') return 23;
    if (__builtin_strncat(buf, "yz", 1) != buf || buf[4] != 'y') return 24;
    if (strncpy(buf, text, 3) != 0 || strcat(buf, "x") != 0) return 25;
    if (strncat(buf, "y", 1) != 0) return 26;

    if (malloc(8) != 0 || calloc(2, 4) != 0) return 27;
    {
        char *q = __builtin_malloc(8);
        if (!q) return 28;
        q[0] = 'a';
        q = __builtin_realloc(q, 16);
        if (!q || q[0] != 'a') return 29;
        __builtin_free(q);
        q = __builtin_calloc(2, 4);
        if (!q || q[0] != 0) return 30;
        if (realloc(q, 16) != 0) return 31;
        __builtin_free(q);
        free(q);
    }
    return 0;
}

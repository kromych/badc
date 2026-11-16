/* C17 library interfaces the platform C libraries may lack: <uchar.h>'s
 * conversions (7.28.1), MB_LEN_MAX and the <stdint.h> limits (5.2.4.2.1,
 * 7.20.3), timespec_get (7.27.2.5), aligned_alloc (7.22.3.1) and
 * quick_exit / at_quick_exit (7.22.4.3, 7.22.4.7). */
#include <errno.h>
#include <limits.h>
#include <locale.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <uchar.h>
#include <wchar.h>

static int order[3], n;
static void h1(void) { order[n++] = 1; }
static void h2(void) { order[n++] = 2; }
static void last(void) { _Exit(order[0] == 2 && order[1] == 1 && n == 2 ? 0 : 20); }

static int ascii(void) {
    mbstate_t st;
    memset(&st, 0, sizeof st);
    char16_t c16;
    char32_t c32;
    char out[MB_LEN_MAX];
    if (mbrtoc16(&c16, "A", 1, &st) != 1 || c16 != 'A') return 30;
    if (mbrtoc32(&c32, "z", 1, &st) != 1 || c32 != 'z') return 31;
    if (c16rtomb(out, u'q', &st) != 1 || out[0] != 'q') return 32;
    if (c32rtomb(out, U'r', &st) != 1 || out[0] != 'r') return 33;
    return 0;
}

static int utf8(void) {
    _Static_assert(MB_LEN_MAX >= 4, "MB_LEN_MAX");
    _Static_assert(WCHAR_MAX >= 0xFFFF && WINT_MAX >= 0xFFFF && SIG_ATOMIC_MAX >= 127, "limits");
    if (!setlocale(LC_CTYPE, "en_US.UTF-8") && !setlocale(LC_CTYPE, "C.UTF-8")) return 0;
    const char *s = "a\xc3\xa9\xf0\x9f\x98\x80";  /* a, U+00E9, U+1F600 */
    mbstate_t st; memset(&st, 0, sizeof st);
    char32_t c32; size_t r;
    if (mbrtoc32(&c32, s, 1, &st) != 1 || c32 != 'a') return 1;
    if (mbrtoc32(&c32, s + 1, 1, &st) != (size_t)-2) return 2;      /* split U+00E9 */
    if ((r = mbrtoc32(&c32, s + 2, 5, &st)) != 1 || c32 != 0xE9) return 3;
    if (mbrtoc32(&c32, s + 3, 4, &st) != 4 || c32 != 0x1F600) return 4;
    char16_t c16[2];
    memset(&st, 0, sizeof st);
    if (mbrtoc16(&c16[0], s + 3, 4, &st) != 4 || c16[0] != 0xD83D) return 5;
    if (mbrtoc16(&c16[1], s + 7, 0, &st) != (size_t)-3 || c16[1] != 0xDE00) return 6;
    char out[MB_LEN_MAX * 2]; size_t k;
    memset(&st, 0, sizeof st);
    if (c16rtomb(out, c16[0], &st) != 0) return 7;
    if ((k = c16rtomb(out, c16[1], &st)) != 4 || memcmp(out, s + 3, 4)) return 8;
    if (c32rtomb(out, 0xE9, &st) != 2 || memcmp(out, s + 1, 2)) return 9;
    if (c32rtomb(out, 0xD800, &st) != (size_t)-1) return 10;
    if (c16rtomb(out, 0xDC00, &st) != (size_t)-1) return 11;
    if (mbrtoc32(&c32, "", 1, &st) != 0 || c32 != 0) return 12;
    return 0;
}

int main(void) {
    int r = ascii();
    if (r || (r = utf8())) return r;
    struct timespec ts;
    if (timespec_get(&ts, TIME_UTC) != TIME_UTC || ts.tv_sec < 1700000000 || ts.tv_nsec < 0 || ts.tv_nsec >= 1000000000L) return 40;
    if (timespec_get(&ts, 0) != 0) return 41;
    void *p = aligned_alloc(16, 64);
    if (!p || (uintptr_t)p % 16) return 42;
    free(p);
    void *q = aligned_alloc(64, 128);
#ifdef _WIN32
    if (q || errno != EINVAL) return 44;
#else
    if (!q || (uintptr_t)q % 64) return 44;
    free(q);
#endif
    if (at_quick_exit(last) || at_quick_exit(h1) || at_quick_exit(h2)) return 43;
    quick_exit(30);
}
